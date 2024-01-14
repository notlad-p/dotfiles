# reload zsh config
alias reload!='source ~/.config/zsh/.zshrc'

# exa/ls aliases
if [ -x "$(command -v exa)" ]; then
  alias ls='exa -Gl --no-permissions --no-user --icons --group-directories-first' # better looking ls
  alias lls='exa -lgh --icons --group-directories-first'

  alias la='exa -Gla --no-permissions --no-user --icons --group-directories-first' # better looking ls
  alias lla='exa -lGha --icons --group-directories-first'

  # alias lls
  alias lt='exa -T --icons' # ls recursivly as a tree
fi

# bat
alias bat='bat --theme gruvbox-dark' # use gruvbox-dark theme

# git
alias gs='git status'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias gb='git branch '
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'

# pacman
alias paci='sudo pacman -S' # install packages
alias pacsi= 'pacman -Qs'# search installed packages
alias pacs='pacman -Ss' # search arch packages

# neovim
if [ -x "$(command -v nvim)" ]; then
  alias vim='nvim'
  alias vi='nvim'
  alias nvimd='nvim --noplugin -u NONE' # (nvim debug) - launch nvim without plugins or config
fi
alias svim='sudoedit'

# nmcli
alias lswifi='nmcli device wifi list'
# TODO: add a connect to wifi function with:
# nmcli device wifi connect $ID password $PASSWORD
