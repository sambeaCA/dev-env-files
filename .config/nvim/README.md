# Custom NeoVim configuration

Custom Neovim setup, with a major update.
Finally ditched the 2025 Mac Air for a pro, so big changes :D

---

### Setup Requires

- True Color Terminal Like: [iTerm2](https://iterm2.com/)
- [Neovim](https://neovim.io/) (Version 0.9 or Later)
- [Nerd Font](https://www.nerdfonts.com/) - I use Meslo Nerd Font
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope Fuzzy Finder
- XCode Command Line Tools
- If working with typescript/javascript and the typescript language server like me. You might need to install node/npm.

If you're on mac, like me, you can install iTerm2, Neovim, Meslo Nerd Font, Ripgrep and Node with homebrew.

iTerm2:

```bash
brew install --cask iterm2
```

Nerd font:

```bash
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
```

Neovim:

```bash
brew install neovim
```

Ripgrep:

```bash
brew install ripgrep
```

Node/Npm:

```bash
brew install node
```

For XCode Command Line Tools do:

```bash
xcode-select --install
```

## Plugins

#### Plugin Manager

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Amazing plugin manager

#### Dependency For Other Plugins

- [nvim-lua/plenary](https://github.com/nvim-lua/plenary.nvim) - Useful lua functions other plugins use

#### Preferred Colorscheme

- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - tokyonight colorscheme (I modified some colors it in config)

#### Navigating Between Neovim Windows and Tmux

- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - navigate b/w nvim splits & tmux panes with CTRL+h,j,k,l

#### Essentials

- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) - manipulate surroundings with "ys", "ds", and "cs"
- [gbprod/substitute.nvim](https://github.com/gbprod/substitute.nvim) - replace things with register with "s" and "S"

#### File Explorer

- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

#### VS Code Like Icons

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

#### Neovim Greeter

- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) -- neovim greeter on startup

#### Auto Sessions

- [rmagatti/auto-session](https://github.com/rmagatti/auto-session) - auto save neovim sessions/restore with keymap

#### Statusline

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Better statusline

#### Bufferline

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Better looking tabs with ordinal numbers and hover close button
- [famiu/bufdelete.nvim](https://github.com/famiu/bufdelete.nvim) - Close buffers without destroying window/split layout

#### Keymap Suggestions

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Get suggested keymaps as you type

#### Fuzzy Finder

- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - Dependency for better performance
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy Finder
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - select/input ui improvement

#### Autocompletion

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion plugin
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Completion source for text in current buffer
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - Completion source for file system paths
- [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) - Vs Code Like Icons for autocompletion

#### Snippets

- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Useful snippets for different languages
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - Completion source for snippet autocomplete

#### Managing & Installing Language Servers, Linters & Formatters

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Install language servers, formatters and linters

#### LSP Configuration

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridges gap b/w mason & lspconfig
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Easy way to configure lsp servers
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - Smart code autocompletion with lsp

#### Trouble.nvim

- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - nice way to see diagnostics and other stuff

#### Formatting & Linting

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) - Easy way to configure formatters
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) - Easy way to configure linters
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto install linters & formatters on startup

#### Comments

- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) - toggle comments with "gc"
- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Requires treesitter
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - highlight/search for comments like todo/hack/bug

#### Treesitter Syntax Highlighting, Autoclosing & Text Objects

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter configuration
- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter configuration
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autoclose brackets, parens, quotes, etc...
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Autoclose tags

#### Indent Guides

- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides with treesitter integration

#### Git

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show modifications on left hand side and interact with git hunks
- [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - Use lazygit within Neovim

#### AI

- [coder/claudecode.nvim](https://github.com/coder/claudecode.nvim) - Claude Code integration inside Neovim

---

## Key Mappings

### Buffer Management (VSCode-style tabs)

| Key | Action |
|-----|--------|
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>x` | Close buffer (keeps window open) |
| `<leader>wc` | Close buffer (keeps window open) |
| `<leader>1–9` | Jump to buffer by position |

### Line Editing

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | Normal | New line below (stay normal) |
| `<S-CR>` | Normal / Insert | New line below (enter insert) |
| `<M-j>` / `<M-k>` | Normal / Visual | Move line/selection down/up |
| `<S-M-j>` / `<S-M-k>` | Normal | Duplicate line down/up |

### Window / Split Management

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Focus pane left/down/up/right |
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize/minimize split |

### AI / Claude Code

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude Code |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume last session |
| `<leader>ab` | Add current buffer |
| `<leader>as` | Send selection to Claude (visual) |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

### Terminal

| Key | Action |
|-----|--------|
| `\|` (Shift+\) | Toggle floating terminal |
