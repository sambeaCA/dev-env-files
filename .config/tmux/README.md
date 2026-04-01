# Tmux Configuration

Custom tmux setup with vim-style navigation and session management.

---

### Highlights

- **Prefix:** `Ctrl-a` (remapped from default `Ctrl-b`)
- **Splits:** `|` for vertical, `-` for horizontal
- **Pane resize:** `h/j/k/l` with prefix
- **Mouse mode** enabled
- **Vi copy mode** with `v` to select and `y` to yank

### Theme

- [Tokyo Night (Moon)](https://github.com/fabioluciano/tmux-tokyo-night) with powerline-style separators

### Plugins (via TPM)

| Plugin | Purpose |
|--------|---------|
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless Ctrl+h/j/k/l navigation between Neovim and tmux panes |
| [tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control) | Sensible pane management bindings |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Persist sessions across restarts |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions every 15 minutes |

### Session Management (Sesh)

- `prefix + T` opens an fzf-powered session picker via [sesh](https://github.com/joshmedeski/sesh)
- `prefix + L` switches to the last session
