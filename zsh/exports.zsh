export TERMINAL="kitty"
export BROWSER="firefox"
export VISUAL="nvim"
export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4e4e4e" # set foreground of completion suggestion
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # disable automatic widget re-binding
ZSH_AUTOSUGGEST_STRATEGY=(history completion) # suggest history then TAB completion

# zsh-syntax-highlighting
# main highlights: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
ZSH_HIGHLIGHT_STYLES[builtin]='fg=5'


# starship prompt
eval "$(starship init zsh)"

# FZF
# default command to show hidden files
export FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! \( -type d -path ./node_modules -prune \) \! -type d \! -name '\''*.tags'\'' -printf '\''%P\n'\'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF bases
export FZF_DEFAULT_OPTS="
  --color fg:$color7
  --color fg+:$color0
  --color bg:$background
  --color bg+:$color0
  --color hl:$color10
  --color hl+:$color2
  --color info:$color4
  --color prompt:$color4
  --color spinner:$color12
  --color pointer:$color7
  --color marker:$color5
  --color border:$background
  --color gutter:$color0
  --color header:$color8
  --prompt ' '
  --pointer ' λ'
  --layout=reverse
  --border horizontal
  --height 40"

# zoxide
eval "$(zoxide init zsh)"
