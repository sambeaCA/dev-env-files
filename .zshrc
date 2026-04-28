# =============================================================================
# PATH
# =============================================================================
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$PATH:/opt/homebrew/opt/tree-sitter-cli"
export PATH="$PATH:/Applications/Ghostty.app/Contents/MacOS"

# =============================================================================
# Environment
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM=$HOME/.config/oh-my-zsh
export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$HOME/.nvm"
export BAT_THEME=tokyonight_night

# =============================================================================
# Oh My Zsh
# =============================================================================
ZSH_THEME="sambea"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# =============================================================================
# FZF
# =============================================================================
eval "$(fzf --zsh)"

# theme palette
fg="#F6F6F6"
bg="#1A1516"
light_green="#A8F176"
hunter_green="#3A6A4F"
dust_gray="#D7D3CC"
bright_snow="#F6F6F6"
shadow_grey="#221D1E"

# fd as default source
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_DEFAULT_OPTS="--color=fg:${bright_snow},bg:${bg},hl:${hunter_green},fg+:${shadow_grey},bg+:${light_green},hl+:${hunter_green},info:${dust_gray},prompt:${light_green},pointer:${light_green},marker:${light_green},spinner:${light_green},header:${light_green}"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
    export|unset) fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh)          fzf --preview "dic {}"       "$@" ;;
    *)            fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
  esac
}

# =============================================================================
# Tool initialization
# =============================================================================
eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# =============================================================================
# Completions
# =============================================================================
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# =============================================================================
# Aliases & functions
# =============================================================================
alias vi="nvim"
alias vim="nvim"
alias ls="eza --color=always --long --no-filesize --icons=always  --no-time --no-user --no-permissions"
alias cd="z"
alias reload-zsh="source ~/.zshrc"
alias python="python3"

# folder shortcuts
alias gtsf="cd ~/Documents/studies/"
alias gtpf="cd ~/Documents/projects/"
alias gttf="cd ~/Documents/tools/"
alias gtdf="cd ~/Documents/ds-projects/"

# new data science project
ndsp() {
  $HOME/Documents/ds-projects/dsproject.sh "$@"
}

# =============================================================================
# History
# =============================================================================
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# =============================================================================
# Keybindings
# =============================================================================
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# =============================================================================
# Secrets & integrations
# =============================================================================
[ -f $HOME/.secrets ] && source $HOME/.secrets
test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true

# =============================================================================
# Syntax highlighting (MUST be last)
# =============================================================================
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
