/**
 * Agent Team — Dispatcher-only orchestrator with grid dashboard
 *
 * The primary Pi agent has NO codebase tools. It can ONLY delegate work
 * to specialist agents via the `dispatch_agent` tool. Each specialist
 * maintains its own Pi session for cross-invocation memory.
 *
 * Loads agent definitions from agents/*.md, .claude/agents/*.md, .pi/agents/*.md.
 * Teams are defined in .pi/agents/teams.yaml — on boot a select dialog lets
 * you pick which team to work with. Only team members are available for dispatch.
 *
 * Commands:
 *   /agents-team          — switch active team
 *   /agents-list          — list loaded agents
 *   /agents-grid N        — set column count (default 2)
 *
 * Usage: pi -e extensions/agent-team.ts
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { DynamicBorder } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { Container, SelectList, type SelectItem, Text, type AutocompleteItem, truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";
import { applyExtensionDefaults } from "../themeMap";
import { spawn, type ChildProcess } from "child_process";
import { readdirSync, readFileSync, existsSync, mkdirSync, unlinkSync } from "fs";
import { join, resolve } from "path";
import { homedir } from "os";

// ── Types ────────────────────────────────────────

interface AgentDef {
  name: string;
  description: string;
  tools: string;
  systemPrompt: string;
  file: string;
  package?: string;
}

interface AgentState {
  model: string;
  def: AgentDef;
  status: "idle" | "running" | "done" | "error";
  task: string;
  toolCount: number;
  elapsed: number;
  lastWork: string;
  contextPct: number;
  sessionFile: string | null;
  runCount: number;
  toolNames: string[];
  textChunks: string[];
  timer?: ReturnType<typeof setInterval>;
  proc?: ChildProcess;
}

// ── Display Name Helper ──────────────────────────

function displayName(name: string): string {
  return name.split("-").map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(" ");
}

// ── Teams YAML Parser ────────────────────────────

function parseTeamsYaml(raw: string): Record<string, string[]> {
  const teams: Record<string, string[]> = {};
  let current: string | null = null;
  for (const line of raw.split("\n")) {
    const teamMatch = line.match(/^(\S[^:]*):$/);
    if (teamMatch) {
      current = teamMatch[1].trim();
      teams[current] = [];
      continue;
    }
    const itemMatch = line.match(/^\s+-\s+(.+)$/);
    if (itemMatch && current) {
      teams[current].push(itemMatch[1].trim());
    }
  }
  return teams;
}

// ── Frontmatter Parser ───────────────────────────

function parseAgentFile(filePath: string): AgentDef | null {
  try {
    const raw = readFileSync(filePath, "utf-8");
    const match = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
    if (!match) return null;

    const frontmatter: Record<string, string> = {};
    for (const line of match[1].split("\n")) {
      const idx = line.indexOf(":");
      if (idx > 0) {
        frontmatter[line.slice(0, idx).trim()] = line.slice(idx + 1).trim();
      }
    }

    if (!frontmatter.name) return null;

    return {
      name: frontmatter.name,
      description: frontmatter.description || "",
      tools: frontmatter.tools || "read,grep,find,ls",
      systemPrompt: match[2].trim(),
      file: filePath,
      package: frontmatter.package || undefined,
    };
  } catch {
    return null;
  }
}

function scanAgentDirs(cwd: string): AgentDef[] {
  const dirs = [
    join(cwd, "agents"),
    join(cwd, ".claude", "agents"),
    join(homedir(), ".pi", "agent", "agents"),
  ];

  const agents: AgentDef[] = [];
  const seen = new Set<string>();

  for (const dir of dirs) {
    if (!existsSync(dir)) continue;
    try {
      for (const file of readdirSync(dir)) {
        if (!file.endsWith(".md")) continue;
        const fullPath = resolve(dir, file);
        const def = parseAgentFile(fullPath);
        if (def && !seen.has(def.name.toLowerCase())) {
          seen.add(def.name.toLowerCase());
          agents.push(def);
        }
      }
    } catch { }
  }

  return agents;
}

// ── Extension ────────────────────────────────────

export default function(pi: ExtensionAPI) {
  const agentStates: Map<string, AgentState> = new Map();
  let allAgentDefs: AgentDef[] = [];
  let teams: Record<string, string[]> = {};
  let activeTeamName = "";
  let gridCols = 2;
  let widgetCtx: any;
  let sessionDir = "";
  let contextWindow = 0;

  function loadAgents(cwd: string) {
    // Create session storage dir
    sessionDir = join(cwd, ".pi", "agent-sessions");
    if (!existsSync(sessionDir)) {
      mkdirSync(sessionDir, { recursive: true });
    }

    // Load all agent definitions
    allAgentDefs = scanAgentDirs(cwd);

    // Load teams from .pi/agents/teams.yaml
    const teamsPath = join(cwd, ".pi", "agents", "teams.yaml");
    if (existsSync(teamsPath)) {
      try {
        teams = parseTeamsYaml(readFileSync(teamsPath, "utf-8"));
      } catch {
        teams = {};
      }
    } else {
      teams = {};
    }

    // If no teams defined, create a default "all" team
    if (Object.keys(teams).length === 0) {
      teams = { all: allAgentDefs.map(d => d.name) };
    }
  }

  function activateTeam(teamName: string) {
    activeTeamName = teamName;
    const members = teams[teamName] || [];
    const defsByName = new Map(allAgentDefs.map(d => [d.name.toLowerCase(), d]));

    agentStates.clear();
    for (const member of members) {
      const def = defsByName.get(member.toLowerCase());
      if (!def) continue;
      const key = def.name.toLowerCase().replace(/\s+/g, "-");
      const sessionFile = join(sessionDir, `${key}.json`);
      agentStates.set(def.name.toLowerCase(), {
        model: "",
        def,
        status: "idle",
        task: "",
        toolCount: 0,
        elapsed: 0,
        lastWork: "",
        contextPct: 0,
        sessionFile: existsSync(sessionFile) ? sessionFile : null,
        runCount: 0,
        toolNames: [],
        textChunks: [],
      });
    }

    // Auto-size grid columns based on team size
    const size = agentStates.size;
    gridCols = size <= 3 ? size : size === 4 ? 2 : 3;
  }

  // ── Grid Rendering ───────────────────────────

  function renderCard(state: AgentState, colWidth: number, theme: any): string[] {
    const w = colWidth - 2;
    const truncate = (s: string, max: number) => s.length > max ? s.slice(0, max - 3) + "..." : s;

    const statusColor = state.status === "idle" ? "dim"
      : state.status === "running" ? "accent"
        : state.status === "done" ? "success" : "error";
    const statusIcon = state.status === "idle" ? "○"
      : state.status === "running" ? "●"
        : state.status === "done" ? "✓" : "✗";

    const name = displayName(state.def.name);
    const nameStr = theme.fg("accent", theme.bold(truncate(name, w)));
    const nameVisible = Math.min(name.length, w);

    const statusStr = `${statusIcon} ${state.status}`;
    const timeStr = state.status !== "idle" ? ` ${Math.round(state.elapsed / 1000)}s` : "";
    const statusLine = theme.fg(statusColor, statusStr + timeStr);
    const statusVisible = statusStr.length + timeStr.length;

    const modelStr = state.model
      ? theme.fg("dim", state.model.replace("moonshotai/", "").replace("deepseek/", ""))
      : "";
    const modelLine = modelStr;
    const modelVisible = modelStr ? visibleWidth(modelStr) : 0;

    // Context bar: 5 blocks + percent
    const filled = Math.ceil(state.contextPct / 20);
    const bar = "#".repeat(filled) + "-".repeat(5 - filled);
    const ctxStr = `[${bar}] ${Math.ceil(state.contextPct)}%`;
    const ctxLine = theme.fg("dim", ctxStr);
    const ctxVisible = ctxStr.length;

    const workRaw = state.task
      ? (state.lastWork || state.task)
      : state.def.description;
    const workText = truncate(workRaw, Math.min(50, w - 1));
    const workLine = theme.fg("muted", workText);
    const workVisible = workText.length;

    const top = "┌" + "─".repeat(w) + "┐";
    const bot = "└" + "─".repeat(w) + "┘";
    const border = (content: string, visLen: number) =>
      theme.fg("dim", "│") + content + " ".repeat(Math.max(0, w - visLen)) + theme.fg("dim", "│");

    return [
      theme.fg("dim", top),
      border(" " + nameStr, 1 + nameVisible),
      border(" " + statusLine, 1 + statusVisible),
      border(" " + modelLine, 1 + modelVisible),
      border(" " + ctxLine, 1 + ctxVisible),
      border(" " + workLine, 1 + workVisible),
      theme.fg("dim", bot),
    ];
  }

  function updateWidget() {
    if (!widgetCtx) return;

    widgetCtx.ui.setWidget("agent-team", (_tui: any, theme: any) => {
      const text = new Text("", 0, 1);

      return {
        render(width: number): string[] {
          if (agentStates.size === 0) {
            text.setText(theme.fg("dim", "No agents found. Add .md files to agents/"));
            return text.render(width);
          }

          const agents = Array.from(agentStates.values());
          const activeAgents = agents.filter(a => a.status !== "idle");
          const idleAgents = agents.filter(a => a.status === "idle");

          // All idle — show a single message
          if (activeAgents.length === 0) {
            text.setText(theme.fg("dim", "All agents idle — dispatch a task to wake one up"));
            return text.render(width);
          }

          const cols = Math.min(gridCols, activeAgents.length);
          const gap = 1;
          const colWidth = Math.floor((width - gap * (cols - 1)) / cols);
          const rows: string[][] = [];

          // Render full cards for active agents
          for (let i = 0; i < activeAgents.length; i += cols) {
            const rowAgents = activeAgents.slice(i, i + cols);
            const cards = rowAgents.map(a => renderCard(a, colWidth, theme));

            while (cards.length < cols) {
              cards.push(Array(7).fill(" ".repeat(colWidth)));
            }

            const cardHeight = cards[0].length;
            for (let line = 0; line < cardHeight; line++) {
              rows.push(cards.map(card => card[line] || ""));
            }
          }

          // Compact idle agent summary
          if (idleAgents.length > 0) {
            rows.push([]); // blank row separator
            const idleLine = idleAgents
              .map(a => theme.fg("dim", `${displayName(a.def.name)} (idle)`))
              .join(theme.fg("muted", " · "));
            rows.push([truncateToWidth(idleLine, width)]);
          }

          const output = rows.map(cols => cols.join(" ".repeat(gap)));
          text.setText(output.join("\n"));
          return text.render(width);
        },
        invalidate() {
          text.invalidate();
        },
      };
    });
  }

  // ── Resolve Agent Model ──────────────────────

  function resolveAgentModel(state: AgentState, parentModel: string): string {
    // 1. Try agent's own frontmatter model
    if (state.def.model) return state.def.model;

    // 2. Try agentOverrides from settings.json
    try {
      const settingsPath = join(homedir(), ".pi", "agent", "settings.json");
      if (existsSync(settingsPath)) {
        const settings = JSON.parse(readFileSync(settingsPath, "utf8"));
        const overrides = settings?.subagents?.agentOverrides || {};

        // Try dotted name first (package.name)
        const pkg = state.def.package;
        const name = state.def.name;
        if (pkg && overrides[`${pkg}.${name}`]) {
          return overrides[`${pkg}.${name}`].model || parentModel;
        }
        // Try plain name
        if (overrides[name]) {
          return overrides[name].model || parentModel;
        }
      }
    } catch {}

    // 3. Fall back to provided parent model
    return parentModel;
  }

  // ── Dispatch Agent (returns Promise) ─────────

  function dispatchAgent(
    agentName: string,
    task: string,
    ctx: any,
  ): Promise<{ output: string; exitCode: number; elapsed: number }> {
    const key = agentName.toLowerCase();
    const state = agentStates.get(key);
    if (!state) {
      return Promise.resolve({
        output: `Agent "${agentName}" not found. Available: ${Array.from(agentStates.values()).map(s => displayName(s.def.name)).join(", ")}`,
        exitCode: 1,
        elapsed: 0,
      });
    }

    if (state.status === "running") {
      return Promise.resolve({
        output: `Agent "${displayName(state.def.name)}" is already running. Wait for it to finish.`,
        exitCode: 1,
        elapsed: 0,
      });
    }

    state.status = "running";
    state.task = task;
    state.toolCount = 0;
    state.elapsed = 0;
    state.lastWork = "";
    state.runCount++;
    updateWidget();

    const startTime = Date.now();
    state.timer = setInterval(() => {
      state.elapsed = Date.now() - startTime;
      updateWidget();
    }, 1000);

    const parentModel = ctx.model
      ? `${ctx.model.provider}/${ctx.model.id}`
      : "openrouter/google/gemini-3-flash-preview";
    const model = resolveAgentModel(state, parentModel);
    state.model = model;

    // Session file for this agent
    const agentKey = state.def.name.toLowerCase().replace(/\s+/g, "-");
    const agentSessionFile = join(sessionDir, `${agentKey}.json`);

    // Build args — first run creates session, subsequent runs resume
    const args = [
      "--mode", "json",
      "-p",
      "--model", model,
      "--tools", state.def.tools,
      "--thinking", "off",
      "--append-system-prompt", state.def.systemPrompt,
      "--session", agentSessionFile,
    ];

    // Continue existing session if we have one
    if (state.sessionFile) {
      args.push("-c");
    }

    args.push(task);

    const textChunks: string[] = [];

    return new Promise((resolve) => {
      const proc = spawn("pi", args, {
        stdio: ["ignore", "pipe", "pipe"],
        env: { ...process.env },
      });

      let buffer = "";

      proc.stdout!.setEncoding("utf-8");
      proc.stdout!.on("data", (chunk: string) => {
        buffer += chunk;
        const lines = buffer.split("\n");
        buffer = lines.pop() || "";
        for (const line of lines) {
          if (!line.trim()) continue;
          try {
            const event = JSON.parse(line);
            if (event.type === "message_update") {
              const delta = event.assistantMessageEvent;
              if (delta?.type === "text_delta") {
                textChunks.push(delta.delta || "");
                state.textChunks.push(delta.delta || "");
                if (state.textChunks.length > 500) state.textChunks.shift();
                const full = textChunks.join("");
                const last = full.split("\n").filter((l: string) => l.trim()).pop() || "";
                state.lastWork = last;
                updateWidget();
              }
            } else if (event.type === "tool_execution_start") {
              state.toolCount++;
              state.toolNames.push((event as any).toolName || "");
              updateWidget();
            } else if (event.type === "message_end") {
              const msg = event.message;
              if (msg?.usage && contextWindow > 0) {
                state.contextPct = ((msg.usage.input || 0) / contextWindow) * 100;
                updateWidget();
              }
            } else if (event.type === "agent_end") {
              const msgs = event.messages || [];
              const last = [...msgs].reverse().find((m: any) => m.role === "assistant");
              if (last?.usage && contextWindow > 0) {
                state.contextPct = ((last.usage.input || 0) / contextWindow) * 100;
                updateWidget();
              }
            }
          } catch { }
        }
      });

      proc.stderr!.setEncoding("utf-8");
      proc.stderr!.on("data", () => { });

      state.proc = proc;

      proc.on("close", (code) => {
        state.proc = undefined;
        if (buffer.trim()) {
          try {
            const event = JSON.parse(buffer);
            if (event.type === "message_update") {
              const delta = event.assistantMessageEvent;
              if (delta?.type === "text_delta") textChunks.push(delta.delta || "");
            }
          } catch { }
        }

        clearInterval(state.timer);
        state.elapsed = Date.now() - startTime;
        state.status = code === 0 ? "done" : "error";

        // Mark session file as available for resume
        if (code === 0) {
          state.sessionFile = agentSessionFile;
        }

        const full = textChunks.join("");
        state.lastWork = full.split("\n").filter((l: string) => l.trim()).pop() || "";
        updateWidget();

        ctx.ui.notify(
          `${displayName(state.def.name)} ${state.status} in ${Math.round(state.elapsed / 1000)}s`,
          state.status === "done" ? "success" : "error"
        );

        resolve({
          output: full,
          exitCode: code ?? 1,
          elapsed: state.elapsed,
        });
      });

      proc.on("error", (err) => {
        state.proc = undefined;
        clearInterval(state.timer);
        state.status = "error";
        state.lastWork = `Error: ${err.message}`;
        updateWidget();
        resolve({
          output: `Error spawning agent: ${err.message}`,
          exitCode: 1,
          elapsed: Date.now() - startTime,
        });
      });
    });
  }

  // ── dispatch_agent Tool (registered at top level) ──

  pi.registerTool({
    name: "dispatch_agent",
    label: "Dispatch Agent",
    description: "Dispatch a task to a specialist agent. The agent will execute the task and return the result. Use the system prompt to see available agent names.",
    parameters: Type.Object({
      agent: Type.String({ description: "Agent name (case-insensitive)" }),
      task: Type.String({ description: "Task description for the agent to execute" }),
    }),

    async execute(_toolCallId, params, _signal, onUpdate, ctx) {
      const { agent, task } = params as { agent: string; task: string };

      try {
        if (onUpdate) {
          onUpdate({
            content: [{ type: "text", text: `Dispatching to ${agent}...` }],
            details: { agent, task, status: "dispatching" },
          });
        }

        const result = await dispatchAgent(agent, task, ctx);

        const truncated = result.output.length > 8000
          ? result.output.slice(0, 8000) + "\n\n... [truncated]"
          : result.output;

        const status = result.exitCode === 0 ? "done" : "error";
        const summary = `[${agent}] ${status} in ${Math.round(result.elapsed / 1000)}s`;

        return {
          content: [{ type: "text", text: `${summary}\n\n${truncated}` }],
          details: {
            agent,
            task,
            status,
            elapsed: result.elapsed,
            exitCode: result.exitCode,
            fullOutput: result.output,
          },
        };
      } catch (err: any) {
        return {
          content: [{ type: "text", text: `Error dispatching to ${agent}: ${err?.message || err}` }],
          details: { agent, task, status: "error", elapsed: 0, exitCode: 1, fullOutput: "" },
        };
      }
    },

    renderCall(args, theme) {
      const agentName = (args as any).agent || "?";
      const task = (args as any).task || "";
      const preview = task.length > 60 ? task.slice(0, 57) + "..." : task;
      return new Text(
        theme.fg("toolTitle", theme.bold("dispatch_agent ")) +
        theme.fg("accent", agentName) +
        theme.fg("dim", " — ") +
        theme.fg("muted", preview),
        0, 0,
      );
    },

    renderResult(result, options, theme) {
      const details = result.details as any;
      if (!details) {
        const text = result.content[0];
        return new Text(text?.type === "text" ? text.text : "", 0, 0);
      }

      // Streaming/partial result while agent is still running
      if (options.isPartial || details.status === "dispatching") {
        return new Text(
          theme.fg("accent", `● ${details.agent || "?"}`) +
          theme.fg("dim", " working..."),
          0, 0,
        );
      }

      const icon = details.status === "done" ? "✓" : "✗";
      const color = details.status === "done" ? "success" : "error";
      const elapsed = typeof details.elapsed === "number" ? Math.round(details.elapsed / 1000) : 0;
      const header = theme.fg(color, `${icon} ${details.agent}`) +
        theme.fg("dim", ` ${elapsed}s`);

      if (options.expanded && details.fullOutput) {
        const output = details.fullOutput.length > 4000
          ? details.fullOutput.slice(0, 4000) + "\n... [truncated]"
          : details.fullOutput;
        return new Text(header + "\n" + theme.fg("muted", output), 0, 0);
      }

      return new Text(header, 0, 0);
    },
  });

  // ── Kill Overlay ────────────────────────────

  function showKillOverlay(ctx: any, theme: any) {
    const running = Array.from(agentStates.values()).filter(a => a.status === "running");

    if (running.length === 0) {
      ctx.ui.notify("No agents running", "info");
      return;
    }

    if (running.length === 1) {
      const state = running[0];
      if (state.proc) state.proc.kill("SIGTERM");
      if (state.timer) clearInterval(state.timer);
      state.status = "idle";
      updateWidget();
      ctx.ui.notify(`${displayName(state.def.name)} interrupted`, "info");
      return;
    }

    // Multiple running — show SelectList overlay
    const items: SelectItem[] = running.map(a => ({
      value: a.def.name.toLowerCase(),
      label: displayName(a.def.name),
      description: `${a.task.slice(0, 60)} · ${Math.round(a.elapsed / 1000)}s`,
    }));

    ctx.ui.custom((tui, theme, _kb, done) => {
      const container = new Container();

      container.addChild(new DynamicBorder((s: string) => theme.fg("error", s)));
      container.addChild(new Text(theme.fg("error", theme.bold("Kill Agent")), 1, 0));

      const selectList = new SelectList(items, Math.min(items.length, 12), {
        selectedPrefix: (t: string) => theme.fg("error", t),
        selectedText: (t: string) => theme.fg("accent", t),
        description: (t: string) => theme.fg("muted", t),
        scrollInfo: (t: string) => theme.fg("dim", t),
        noMatch: (t: string) => theme.fg("warning", t),
      });
      selectList.onSelect = (item) => done(item.value);
      selectList.onCancel = () => done(null);
      container.addChild(selectList);

      container.addChild(new Text(theme.fg("dim", "j/k navigate · enter kill · esc cancel"), 1, 0));
      container.addChild(new DynamicBorder((s: string) => theme.fg("error", s)));

      return {
        render: (w: number) => container.render(w),
        invalidate: () => container.invalidate(),
        handleInput: (data: string) => {
          if (data === "j") data = "\x1b[B";
          if (data === "k") data = "\x1b[A";
          selectList.handleInput(data);
          tui.requestRender();
        },
      };
    }, { overlay: true })
      .then((result: string | null) => {
        if (!result) return;
        const state = agentStates.get(result);
        if (!state || state.status !== "running") return;
        if (state.proc) state.proc.kill("SIGTERM");
        if (state.timer) clearInterval(state.timer);
        state.status = "idle";
        updateWidget();
        ctx.ui.notify(`${displayName(state.def.name)} interrupted`, "info");
      });
  }

  // ── Commands ─────────────────────────────────

  pi.registerCommand("agents-team", {
    description: "Select a team to work with",
    handler: async (_args, ctx) => {
      widgetCtx = ctx;
      const teamNames = Object.keys(teams);
      if (teamNames.length === 0) {
        ctx.ui.notify("No teams defined in .pi/agents/teams.yaml", "warning");
        return;
      }

      const options = teamNames.map(name => {
        const members = teams[name].map(m => displayName(m));
        return `${name} — ${members.join(", ")}`;
      });

      const choice = await ctx.ui.select("Select Team", options);
      if (choice === undefined) return;

      const idx = options.indexOf(choice);
      const name = teamNames[idx];
      activateTeam(name);
      updateWidget();
      ctx.ui.setStatus("agent-team", `Team: ${name} (${agentStates.size})`);
      ctx.ui.notify(`Team: ${name} — ${Array.from(agentStates.values()).map(s => displayName(s.def.name)).join(", ")}`, "info");
    },
  });

  pi.registerCommand("agents-list", {
    description: "List all loaded agents",
    handler: async (_args, _ctx) => {
      widgetCtx = _ctx;
      const names = Array.from(agentStates.values())
        .map(s => {
          const session = s.sessionFile ? "resumed" : "new";
          return `${displayName(s.def.name)} (${s.status}, ${session}, runs: ${s.runCount}): ${s.def.description}`;
        })
        .join("\n");
      _ctx.ui.notify(names || "No agents loaded", "info");
    },
  });

  pi.registerCommand("agents-inspect", {
    description: "Inspect an agent: /agents-inspect [<agent-name>]",
    handler: async (args, ctx) => {
      const query = (args || "").trim();

      if (query) {
        const agents = Array.from(agentStates.values());
        if (agents.length === 0) {
          ctx.ui.notify("No agents loaded", "warning");
          return;
        }
        const lower = query.toLowerCase();
        const target = agents.find(a => a.def.name.toLowerCase().includes(lower));
        if (!target) {
          const names = agents.map(a => displayName(a.def.name)).join(", ");
          ctx.ui.notify(`Agent "${query}" not found. Available: ${names}`, "error");
          return;
        }
        showInspectOverlay(target, ctx);
      } else {
        // No args — delegate to overlay which shows SelectList
        showInspectOverlay(ctx);
      }
    },
  });

  function showInspectOverlay(ctxOrTarget: AgentState | any, maybeCtx?: any): void {
    // Called with just ctx — show SelectList to pick an agent
    if (maybeCtx === undefined && !("def" in (ctxOrTarget || {}))) {
      const ctx = ctxOrTarget;
      const agents = Array.from(agentStates.values());

      if (agents.length === 0) {
        ctx.ui.notify("No agents loaded", "warning");
        return;
      }

      const items: SelectItem[] = agents.map(a => ({
        value: a.def.name.toLowerCase(),
        label: displayName(a.def.name),
        description: `${a.status} · ${a.toolCount} tools · ${a.runCount} runs`,
      }));

      ctx.ui.custom<string | null>((tui, theme, _kb, done) => {
        const container = new Container();

        container.addChild(new DynamicBorder((s: string) => theme.fg("accent", s)));
        container.addChild(new Text(theme.fg("accent", theme.bold("Inspect Agent")), 1, 0));

        const selectList = new SelectList(items, Math.min(items.length, 12), {
          selectedPrefix: (t: string) => theme.fg("accent", t),
          selectedText: (t: string) => theme.fg("accent", t),
          description: (t: string) => theme.fg("muted", t),
          scrollInfo: (t: string) => theme.fg("dim", t),
          noMatch: (t: string) => theme.fg("warning", t),
        });
        selectList.onSelect = (item) => done(item.value);
        selectList.onCancel = () => done(null);
        container.addChild(selectList);

        container.addChild(new Text(theme.fg("dim", "j/k navigate · enter inspect · esc cancel"), 1, 0));
        container.addChild(new DynamicBorder((s: string) => theme.fg("accent", s)));

        return {
          render: (w: number) => container.render(w),
          invalidate: () => container.invalidate(),
          handleInput: (data: string) => {
            if (data === "j") data = "\x1b[B";
            if (data === "k") data = "\x1b[A";
            selectList.handleInput(data);
            tui.requestRender();
          },
        };
      }, { overlay: true })
        .then((result: string | null) => {
          if (result) {
            const target = agents.find(a => a.def.name.toLowerCase() === result);
            if (target) showInspectOverlay(target, ctx);
          }
        });
      return;
    }

    // Called with (target, ctx)
    const target = ctxOrTarget as AgentState;
    const ctx = maybeCtx!;
    const name = displayName(target.def.name);
    const elapsed = target.elapsed ? `${Math.round(target.elapsed / 1000)}s` : "—";
    const contextBar = (pct: number) => {
      const filled = Math.ceil(pct / 20);
      return `${"#".repeat(filled)}${"-".repeat(5 - filled)} ${Math.ceil(pct)}%`;
    };

    // Prepare output lines for scrolling
    const rawOutput = target.textChunks.length > 0
      ? target.textChunks.join("")
      : (target.lastWork || "(no output)");
    const outputLines = rawOutput.split("\n");

    ctx.ui.custom((tui, theme, _kb, done) => {
      let scrollOffset = 0;
      let lastHeight = 40; // updated each render

      // Build the static header container (always visible)
      const headerContainer = new Container();

      headerContainer.addChild(new DynamicBorder((s: string) => theme.fg("accent", s)));
      headerContainer.addChild(new Text(theme.fg("accent", theme.bold(`Agent: ${name}`)), 1, 0));
      headerContainer.addChild(new Text("", 0, 0));

      const statusColor = target.status === "running" ? "accent"
        : target.status === "done" ? "success" : "error";
      headerContainer.addChild(new Text(theme.fg(statusColor, `Status: ${target.status}`), 1, 0));
      headerContainer.addChild(new Text(theme.fg("muted", `Task: ${target.task || "(none)"}`), 1, 0));
      headerContainer.addChild(new Text(theme.fg("dim", `Elapsed: ${elapsed}  ·  Tools: ${target.toolCount}  ·  Runs: ${target.runCount}`), 1, 0));
      headerContainer.addChild(new Text(theme.fg("dim", `Model: ${target.model || "(unknown)"}`), 1, 0));
      headerContainer.addChild(new Text(theme.fg("dim", `Session: ${target.sessionFile || "(none)"}`), 1, 0));
      headerContainer.addChild(new Text(theme.fg("dim", `Context: [${contextBar(target.contextPct)}]`), 1, 0));
      headerContainer.addChild(new Text("", 0, 0));

      // Tools called
      if (target.toolNames.length > 0) {
        const toolList = target.toolNames
          .filter(t => t)
          .map((t, i) => theme.fg("muted", `  ${i + 1}. ${t}`))
          .join("\n");
        headerContainer.addChild(new Text(theme.fg("accent", "Tools Called:"), 1, 0));
        headerContainer.addChild(new Text(toolList, 1, 0));
        headerContainer.addChild(new Text("", 0, 0));
      } else {
        headerContainer.addChild(new Text(theme.fg("dim", "No tools called yet."), 1, 0));
        headerContainer.addChild(new Text("", 0, 0));
      }

      headerContainer.addChild(new Text(theme.fg("accent", "Output:"), 1, 0));

      return {
        render: (w: number) => {
          lastHeight = w;
          const headerLines = headerContainer.render(w);
          const headerCount = headerLines.length;

          // Available lines for output: total width minus header minus scroll indicator minus bottom border/hint
          // Reserve: 1 for scroll indicator line, 1 for hint "j/k · ctrl+d/u · esc", 1 for bottom border
          const reservedBelow = 3;
          const viewportLines = Math.max(1, w - headerCount - reservedBelow);
          const totalOutputLines = outputLines.length;
          const maxScroll = Math.max(0, totalOutputLines - viewportLines);

          // Clamp scroll offset
          if (scrollOffset > maxScroll) scrollOffset = maxScroll;
          if (scrollOffset < 0) scrollOffset = 0;

          // Visible slice of output
          const visibleSlice = outputLines.slice(scrollOffset, scrollOffset + viewportLines);

          // Build render result: header + visible output + scroll indicator + hint + bottom border
          const result: string[] = [...headerLines];

          for (const line of visibleSlice) {
            result.push(theme.fg("muted", line));
          }

          // Pad if fewer output lines than viewport
          for (let i = visibleSlice.length; i < viewportLines; i++) {
            result.push("");
          }

          // Scroll indicator
          const currentLine = totalOutputLines > 0 ? scrollOffset + 1 : 0;
          const pct = totalOutputLines > 0 ? Math.round((scrollOffset / totalOutputLines) * 100) : 0;
          const indicator = totalOutputLines > 0
            ? `-- Line ${currentLine}/${totalOutputLines} (${pct}%) --`
            : "";
          result.push(theme.fg("dim", indicator));

          // Hint line
          result.push(theme.fg("dim", "j/k scroll · ctrl+d/u page · esc close"));

          // Bottom border
          result.push(theme.fg("accent", "─".repeat(w)));

          return result.slice(0, w);
        },
        invalidate: () => {
          headerContainer.invalidate();
        },
        handleInput: (data: string) => {
          if (data === "\x1b") {
            done(undefined);
            return;
          }
          if (data === "j") {
            scrollOffset++;
            tui.requestRender();
            return;
          }
          if (data === "k") {
            scrollOffset--;
            tui.requestRender();
            return;
          }
          if (data === "\x04") {
            // ctrl+d — scroll down half page
            const headerCount = headerContainer.render(lastHeight).length;
            const viewportLines = Math.max(1, lastHeight - headerCount - 3);
            scrollOffset += Math.floor(viewportLines / 2);
            tui.requestRender();
            return;
          }
          if (data === "\x15") {
            // ctrl+u — scroll up half page
            const headerCount = headerContainer.render(lastHeight).length;
            const viewportLines = Math.max(1, lastHeight - headerCount - 3);
            scrollOffset -= Math.floor(viewportLines / 2);
            tui.requestRender();
            return;
          }
        },
      };
    }, { overlay: true });
  }

  pi.registerCommand("agents-grid", {
    description: "Set grid columns: /agents-grid <1-6>",
    getArgumentCompletions: (prefix: string): AutocompleteItem[] | null => {
      const items = ["1", "2", "3", "4", "5", "6"].map(n => ({
        value: n,
        label: `${n} columns`,
      }));
      const filtered = items.filter(i => i.value.startsWith(prefix));
      return filtered.length > 0 ? filtered : items;
    },
    handler: async (args, _ctx) => {
      widgetCtx = _ctx;
      const n = parseInt(args?.trim() || "", 10);
      if (n >= 1 && n <= 6) {
        gridCols = n;
        _ctx.ui.notify(`Grid set to ${gridCols} columns`, "info");
        updateWidget();
      } else {
        _ctx.ui.notify("Usage: /agents-grid <1-6>", "error");
      }
    },
  });

  // ── Keybindings ──────────────────────────────

  pi.registerShortcut("ctrl+shift+k", {
    description: "Kill an agent",
    handler: async (ctx) => {
      showKillOverlay(ctx, ctx.ui.theme);
    },
  });

  // ── System Prompt Override ───────────────────

  pi.on("before_agent_start", async (_event, _ctx) => {
    // Build dynamic agent catalog from active team only
    const agentCatalog = Array.from(agentStates.values())
      .map(s => `### ${displayName(s.def.name)}\n**Dispatch as:** \`${s.def.name}\`\n${s.def.description}\n**Tools:** ${s.def.tools}`)
      .join("\n\n");

    const teamMembers = Array.from(agentStates.values()).map(s => displayName(s.def.name)).join(", ");

    return {
      systemPrompt: `You are a dispatcher agent. You coordinate specialist agents to accomplish tasks.
You do NOT have direct access to the codebase. You MUST delegate all work through
agents using the dispatch_agent tool.

## Active Team: ${activeTeamName}
Members: ${teamMembers}
You can ONLY dispatch to agents listed below. Do not attempt to dispatch to agents outside this team.

## How to Work
- Analyze the user's request and break it into clear sub-tasks
- Choose the right agent(s) for each sub-task
- Dispatch tasks using the dispatch_agent tool
- Review results and dispatch follow-up agents if needed
- If a task fails, try a different agent or adjust the task description
- Summarize the outcome for the user

## Rules
- NEVER try to read, write, or execute code directly — you have no such tools
- ALWAYS use dispatch_agent to get work done
- You can chain agents: use scout to explore, then builder to implement
- You can dispatch the same agent multiple times with different tasks
- Keep tasks focused — one clear objective per dispatch

## Agents

${agentCatalog}`,
    };
  });

  // ── Session Shutdown ─────────────────────────

  pi.on("session_shutdown", () => {
    for (const state of agentStates.values()) {
      if (state.proc && state.status === "running") {
        state.proc.kill("SIGTERM");
      }
    }
  });

  // ── Session Start ────────────────────────────

  pi.on("session_start", async (_event, _ctx) => {
    applyExtensionDefaults(__filename, _ctx);
    // Clear widgets from previous session
    if (widgetCtx) {
      widgetCtx.ui.setWidget("agent-team", undefined);
    }
    widgetCtx = _ctx;
    contextWindow = _ctx.model?.contextWindow || 0;

    // Wipe old agent session files so subagents start fresh
    const sessDir = join(_ctx.cwd, ".pi", "agent-sessions");
    if (existsSync(sessDir)) {
      for (const f of readdirSync(sessDir)) {
        if (f.endsWith(".json")) {
          try { unlinkSync(join(sessDir, f)); } catch { }
        }
      }
    }

    loadAgents(_ctx.cwd);

    // Default to first team — use /agents-team to switch
    const teamNames = Object.keys(teams);
    if (teamNames.length > 0) {
      activateTeam(teamNames[0]);
    }

    // Lock down to dispatcher-only (tool already registered at top level)
    pi.setActiveTools(["dispatch_agent"]);

    _ctx.ui.setStatus("agent-team", `Team: ${activeTeamName} (${agentStates.size})`);
    const members = Array.from(agentStates.values()).map(s => displayName(s.def.name)).join(", ");
    _ctx.ui.notify(
      `Team: ${activeTeamName} (${members})\n` +
      `Team sets loaded from: .pi/agents/teams.yaml\n\n` +
      `/agents-team          Select a team\n` +
      `/agents-list          List active agents and status\n` +
      `/agents-grid <1-6>    Set grid column count`,
      "info",
    );
    updateWidget();

    // Footer: model | team | context bar
    _ctx.ui.setFooter((_tui, theme, _footerData) => ({
      dispose: () => { },
      invalidate() { },
      render(width: number): string[] {
        const model = _ctx.model?.id || "no-model";
        const usage = _ctx.getContextUsage();
        const pct = usage?.percent ?? 0;
        const filled = Math.round(pct / 10);
        const bar = "#".repeat(filled) + "-".repeat(10 - filled);

        const left = theme.fg("dim", ` ${model}`) +
          theme.fg("muted", " · ") +
          theme.fg("accent", activeTeamName);
        const right = theme.fg("dim", `[${bar}] ${Math.round(pct)}% `);
        const pad = " ".repeat(Math.max(1, width - visibleWidth(left) - visibleWidth(right)));

        return [truncateToWidth(left + pad + right, width)];
      },
    }));
  });
}
