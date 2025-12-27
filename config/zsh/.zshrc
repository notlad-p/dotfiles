export ZDOTDIR="$HOME/.config/zsh"

autoload -Uz compinit

# options
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt autocd # cd by just typing a directory (without prepended cd command)
# history
setopt appendhistory
setopt HISTIGNOREDUPS # prevent current line from being saved if it's the same as the previous one

source "$ZDOTDIR/functions.zsh"

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "Aloxaf/fzf-tab"
# NOTE: zsh-syntax-highlighting must be the last plugin sourced
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

source /usr/share/fzf/completion.zsh #fzf completions
source /usr/share/fzf/key-bindings.zsh # fzf key-binds
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/keys.zsh"

# fzf-tab style
zstyle ':fzf-tab:*' fzf-flags --height=60% # increase fzf height
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!

# different completion command for certain CLIs
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           find . -type d | fzf --preview 'tree -C {}' "$@";;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# completion
zstyle ':completion:*' completer _extensions _complete _approximate

# completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# initialize completion
# NOTE: this must be after completion plugins to load them
compinit 
# initialize autopairs
autopair-init

autoload -U colors && colors

eval fastfetch
