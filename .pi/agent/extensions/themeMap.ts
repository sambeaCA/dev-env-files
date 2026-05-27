/**
 * themeMap.ts — Per-extension default theme assignments
 *
 * Themes live in .pi/themes/ and are mapped by extension filename (no extension).
 * Each extension calls applyExtensionTheme(import.meta.url, ctx) in its session_start
 * hook to automatically load its designated theme on boot.
 *
 * Available themes (.pi/themes/):
 *   catppuccin-mocha · cyberpunk · dracula · everforest · gruvbox
 *   midnight-ocean   · nord      · ocean-breeze · rose-pine
 *   synthwave        · tokyo-night
 */

import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import { basename } from "path";
import { fileURLToPath } from "url";
// ── Theme assignments ────────────────────────────────────────────────────── Key   = extension filename without extension (matches extensions/<key>.ts) Value = theme name from .pi/themes/<value>.json
export const THEME_MAP: Record<string, string> = {
  "agent-chain": "dracula",   // deep sequential pipeline
  "agent-team": "tokyo-night",          // rich orchestration palette
  "coms": "dracula",     // peer-to-peer messaging, cross-boundary
  "coms-net": "dracula",     // peer-to-peer messaging, cross-boundary
  "cross-agent": "dracula",     // cross-boundary, connecting
  "damage-control": "dracula",          // grounded, earthy safety
  "minimal": "dracula",        // synthwave by default now!
  "pi-pi": "dracula",        // warm creative meta-agent
  "pure-focus": "dracula",       // calm, distraction-free
  "purpose-gate": "tokyo-night",      // intentional, sharp focus
  "session-replay": "dracula", // soft, reflective history
  "subagent-widget": "tokyo-night",        // multi-agent futuristic
  "system-select": "tokyo-night", // soft selection UI
  "theme-cycler": "dracula",        // neon, it's a theme tool
  "tool-counter": "dracula",        // techy metrics
  "tool-counter-widget": "dracula",        // same family
  "rich-footer": "tokyo-night"
};

// ── Helpers ───────────────────────────────────────────────────────────────

/** Derive the extension name (e.g. "minimal") from its import.meta.url. */
function extensionName(fileUrl: string): string {
  const filePath = fileUrl.startsWith("file://") ? fileURLToPath(fileUrl) : fileUrl;
  return basename(filePath).replace(/\.[^.]+$/, "");
}

// ── Theme ──────────────────────────────────────────────────────────────────

/**
 * Apply the mapped theme for an extension on session boot.
 *
 * @param fileUrl   Pass `import.meta.url` from the calling extension file.
 * @param ctx       The ExtensionContext from the session_start handler.
 * @returns         true if the theme was applied successfully, false otherwise.
 */
export function applyExtensionTheme(fileUrl: string, ctx: ExtensionContext): boolean {
  if (!ctx.hasUI) return false;

  const name = extensionName(fileUrl);

  // If there are multiple extensions stacked in 'ipi', they each fire session_start
  // and try to apply their own mapped theme. The LAST one to fire wins.
  // Since system-select is last in the ipi alias array, it was setting 'catppuccin-mocha'.

  // We want to skip theme application for all secondary extensions if they are stacked,
  // so the primary extension (first in the array) dictates the theme.
  const primaryExt = primaryExtensionName();
  if (primaryExt && primaryExt !== name) {
    return true; // Pretend we succeeded, but don't overwrite the primary theme
  }

  let themeName = THEME_MAP[name];

  if (!themeName) {
    themeName = "tokyo-night";
  }

  const result = ctx.ui.setTheme(themeName);

  if (!result.success && themeName !== "dracula") {
    return ctx.ui.setTheme("dracula").success;
  }

  return result.success;
}
// ── Title ──────────────────────────────────────────────────────────────────

/**
 * Read process.argv to find the first -e / --extension flag value.
 *
 * When Pi is launched as:
 *   pi -e extensions/subagent-widget.ts -e extensions/pure-focus.ts
 *
 * process.argv contains those paths verbatim. Every stacked extension calls
 * this and gets the same answer ("subagent-widget"), so all setTitle calls
 * are idempotent — no shared state or deduplication needed.
 *
 * Returns null if no -e flag is present (e.g. plain `pi` with no extensions).
 */
function primaryExtensionName(): string | null {
  const argv = process.argv;
  for (let i = 0; i < argv.length - 1; i++) {
    if (argv[i] === "-e" || argv[i] === "--extension") {
      return basename(argv[i + 1]).replace(/\.[^.]+$/, "");
    }
  }
  return null;
}

/**
 * Set the terminal title to "π - <first-extension-name>" on session boot.
 * Reads the title from process.argv so all stacked extensions agree on the
 * same value — no coordination or shared state required.
 *
 * Deferred 150 ms to fire after Pi's own startup title-set.
 */
function applyExtensionTitle(ctx: ExtensionContext): void {
  if (!ctx.hasUI) return;
  const name = primaryExtensionName();
  if (!name) return;
  setTimeout(() => ctx.ui.setTitle(`π - ${name}`), 150);
}

// ── Combined default ───────────────────────────────────────────────────────

/**
 * Apply both the mapped theme AND the terminal title for an extension.
 * Drop-in replacement for applyExtensionTheme — call this in every session_start.
 *
 * Usage:
 *   import { applyExtensionDefaults } from "./themeMap.ts";
 *
 *   pi.on("session_start", async (_event, ctx) => {
 *     applyExtensionDefaults(import.meta.url, ctx);
 *     // ... rest of handler
 *   });
 */
export function applyExtensionDefaults(fileUrl: string, ctx: ExtensionContext): void {
  applyExtensionTheme(fileUrl, ctx);
  applyExtensionTitle(ctx);
}

// No-op default export so pi recognizes this as a valid extension.
// The real functionality is in the named exports used by other extensions.
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
export default function(_pi: ExtensionAPI) { }
