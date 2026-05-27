/**
 * Rich Footer Extension
 *
 * Auto-enabling footer showing a compact status bar:
 * - Context progress (colored blocks → token usage %)
 * - Token counts + cost (↑in ↓out $cost)
 * - Current git branch
 * - Model being used (with thinking level)
 * - Current working directory path
 * - LSP status
 * - Active skill(s)
 * - Streaming indicator (● when agent is busy)
 *
 * Toggle with /rich-footer  —  state persists across reloads.
 */

import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import type { ReadonlyFooterDataProvider, Theme, Skill } from "@earendil-works/pi-coding-agent";
import type { AssistantMessage } from "@earendil-works/pi-ai";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";
import * as path from "node:path";
import * as os from "node:os";

// ── Constants ───────────────────────────────────────────────────────────────

const STATE_ENTRY_TYPE = "rich-footer-state";
const BLOCK_COUNT = 7;
const BLOCK_FULL = "█";
const BLOCK_EMPTY = "░";

// ── State ───────────────────────────────────────────────────────────────────

interface FooterState {
	activeSkillNames: string[];
	lspEnabled: boolean;
	enabled: boolean;
	streaming: boolean;
	thinkingLevel: string;
}

// ── Helpers ─────────────────────────────────────────────────────────────────

/** Colored context-window fill bar: ████░░░ 57% */
function progressBar(percent: number | null, theme: Theme): string {
	if (percent === null) return "";
	const filled = Math.round((percent / 100) * BLOCK_COUNT);
	const empty = BLOCK_COUNT - filled;

	let color: "success" | "warning" | "error" = "success";
	if (percent > 80) color = "error";
	else if (percent > 50) color = "warning";

	return (
		theme.fg(color, BLOCK_FULL.repeat(filled)) +
		theme.fg("dim", BLOCK_EMPTY.repeat(empty)) +
		" " +
		theme.fg("dim", `${Math.round(percent)}%`)
	);
}

/** Shorten an absolute path for compact display. */
function shortPath(cwd: string, maxLen = 28): string {
	const home = os.homedir();
	let display = cwd.startsWith(home) ? "~" + cwd.slice(home.length) : cwd;
	if (display.length <= maxLen) return display;

	const parts = display.split(path.sep).filter(Boolean);
	const tail = parts.slice(-2);
	const head = parts[0] === "~" ? "~" : path.sep + parts[0];
	display = head + path.sep + "..." + path.sep + tail.join(path.sep);

	if (display.length > maxLen) {
		display = "..." + cwd.slice(-(maxLen - 3));
	}
	return display;
}

/** Human-readable token count: 1.2k, 0.8k, 99 */
function fmtTokens(n: number): string {
	if (n >= 1000) return `${(n / 1000).toFixed(1)}k`;
	return `${n}`;
}

/** Format cost in dollars. */
function fmtCost(n: number): string {
	return `$${n.toFixed(3)}`;
}

/** Thinking level → compact label. */
function thinkingLabel(level: string): string {
	switch (level) {
		case "off": return "";
		case "minimal": return "min";
		case "low": return "lo";
		case "medium": return "med";
		case "high": return "hi";
		case "xhigh": return "xhi";
		default: return "";
	}
}

// ── Footer installer ────────────────────────────────────────────────────────

/**
 * Install or replace the custom footer component.
 * Extracted so both session_start and the toggle command reuse the same logic.
 */
function installFooter(
	pi: ExtensionAPI,
	ctx: ExtensionContext,
	state: FooterState,
) {
	let requestRender: (() => void) | null = null;

	ctx.ui.setFooter((tui, theme, footerData) => {
		// Keep requestRender reachable from event handlers
		requestRender = () => tui.requestRender();
		// Ensure stale footer frames are invalidated on theme changes
		const unsubBranch = footerData.onBranchChange(() => tui.requestRender());

		return {
			dispose() {
				requestRender = null;
				unsubBranch();
			},
			invalidate() {
				tui.requestRender();
			},
			render(width: number): string[] {
				try {
					return doRender(width, theme, footerData, ctx, state);
				} catch {
					return [truncateToWidth(
						theme.fg("error", "footer error"),
						width,
					)];
				}
			},
		};
	});

	// Return a rerender trigger for event handlers that don't have tui access.
	return () => requestRender?.();
}

// ── Render logic (pure function, separated for clarity) ─────────────────────

function doRender(
	width: number,
	theme: Theme,
	footerData: ReadonlyFooterDataProvider,
	ctx: ExtensionContext,
	state: FooterState,
): string[] {
	const segments: string[] = [];

	// ── Streaming indicator ──────────────────────────────────────────
	if (state.streaming) {
		segments.push(theme.fg("accent", "●"));
	}

	// ── Context progress ─────────────────────────────────────────────
	const usage = ctx.getContextUsage();
	const pb = progressBar(usage?.percent ?? null, theme);
	if (pb) segments.push(pb);

	// ── Token counts + cost ──────────────────────────────────────────
	const { input, output, cost } = computeSessionUsage(ctx);
	if (input > 0 || output > 0) {
		segments.push(
			theme.fg("dim", `↑${fmtTokens(input)} ↓${fmtTokens(output)} ${fmtCost(cost)}`),
		);
	}

	// ── Git branch ───────────────────────────────────────────────────
	const branch = footerData.getGitBranch();
	if (branch) {
		segments.push(
			theme.fg("accent", "⎇ ") + theme.fg("muted", branch),
		);
	}

	// ── Model + thinking level ───────────────────────────────────────
	if (ctx.model) {
		const tl = thinkingLabel(state.thinkingLevel);
		const thinkingStr = tl ? theme.fg("accent", `[${tl}]`) : "";
		segments.push(
			theme.fg("dim", `${ctx.model.provider}/${ctx.model.id}`) + thinkingStr,
		);
	}

	// ── Path ─────────────────────────────────────────────────────────
	segments.push(theme.fg("dim", shortPath(ctx.cwd, 28)));

	// ── LSP ──────────────────────────────────────────────────────────
	const lspColor = state.lspEnabled ? "success" : "error";
	segments.push(
		theme.fg("dim", "LSP") + theme.fg(lspColor, state.lspEnabled ? " ✓" : " ✗"),
	);

	// ── Active skill ─────────────────────────────────────────────────
	if (state.activeSkillNames.length > 0) {
		const label = state.activeSkillNames.slice(0, 2).join(",");
		segments.push(
			theme.fg("dim", "skill ") + theme.fg("accent", label),
		);
	}

	// ── Assemble ─────────────────────────────────────────────────────
	const sep = theme.fg("dim", " │ ");
	let line = segments.join(sep);

	if (visibleWidth(line) > width) {
		for (let i = segments.length - 1; i >= 1; i--) {
			const candidate = segments.slice(0, i).join(sep);
			if (visibleWidth(candidate) <= width) {
				line = candidate;
				break;
			}
		}
	}

	return [truncateToWidth(line, width)];
}

/** Iterate session branch for token/cost totals across assistant messages. */
function computeSessionUsage(ctx: ExtensionContext): {
	input: number;
	output: number;
	cost: number;
} {
	let input = 0;
	let output = 0;
	let cost = 0;

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type === "message" && entry.message.role === "assistant") {
			const m = entry.message as AssistantMessage;
			input += m.usage.input;
			output += m.usage.output;
			cost += m.usage.cost.total;
		}
	}

	return { input, output, cost };
}

// ── Extension ───────────────────────────────────────────────────────────────

export default function (pi: ExtensionAPI) {
	const state: FooterState = {
		activeSkillNames: [],
		lspEnabled: true,
		enabled: true,
		streaming: false,
		thinkingLevel: "off",
	};

	let rerender: (() => void) | null = null;

	// ── Persist enabled state ────────────────────────────────────────────
	// Restore on reload
	pi.on("session_start", (_event, ctx) => {
		for (const entry of ctx.sessionManager.getEntries()) {
			if (entry.type === "custom" && entry.customType === STATE_ENTRY_TYPE) {
				const data = entry.data as { enabled?: boolean } | undefined;
				if (typeof data?.enabled === "boolean") {
					state.enabled = data.enabled;
				}
			}
		}
	});

	// Persist on shutdown
	pi.on("session_shutdown", () => {
		pi.appendEntry(STATE_ENTRY_TYPE, { enabled: state.enabled });
	});

	// ── Event listeners ─────────────────────────────────────────────────

	// Active skills: extract from system prompt options before each agent turn
	pi.on("before_agent_start", (event, _ctx) => {
		const skills: Skill[] | undefined = event.systemPromptOptions?.skills;
		state.activeSkillNames =
			skills?.map((s) => s.name).filter(Boolean) ?? [];
		rerender?.();
	});

	// LSP status: check if lsp_navigation is in active tools
	const refreshLsp = () => {
		const tools = pi.getActiveTools();
		const was = state.lspEnabled;
		state.lspEnabled = tools.includes("lsp_navigation");
		if (state.lspEnabled !== was) rerender?.();
	};

	// Streaming indicator
	pi.on("agent_start", () => {
		state.streaming = true;
		rerender?.();
	});
	pi.on("agent_end", () => {
		state.streaming = false;
		rerender?.();
	});

	// LSP check on each turn (active tools may change)
	pi.on("turn_start", () => refreshLsp());

	// Rerender on model / thinking changes
	pi.on("model_select", () => rerender?.());
	pi.on("thinking_level_select", (event) => {
		state.thinkingLevel = event.level;
		rerender?.();
	});

	// ── Install footer (auto-enables) ───────────────────────────────────

	pi.on("session_start", (_event, ctx) => {
		refreshLsp();
		state.thinkingLevel = pi.getThinkingLevel();
		if (!state.enabled) return;
		rerender = installFooter(pi, ctx, state);
	});

	// ── Toggle command ──────────────────────────────────────────────────

	pi.registerCommand("rich-footer", {
		description:
			"Toggle rich footer (context, tokens, branch, model, path, LSP, skill)",
		handler: async (_args, ctx) => {
			state.enabled = !state.enabled;

			// Persist immediately
			pi.appendEntry(STATE_ENTRY_TYPE, { enabled: state.enabled });

			if (state.enabled) {
				rerender = installFooter(pi, ctx, state);
				ctx.ui.notify("Rich footer enabled", "info");
			} else {
				rerender?.();
				ctx.ui.setFooter(undefined);
				rerender = null;
				ctx.ui.notify("Default footer restored", "info");
			}
		},
	});
}
