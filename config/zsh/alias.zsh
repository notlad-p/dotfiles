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

# TODO: add fzf prompt: "Watch current directory: Choose file to execute"
# TODO: create different functions for different files (Python, Bash, JS, etc.)

# Watch current directory & execute $file on save
we () {
  local file
  file=$(fd . --type f | fzf --border-label="Watch current directory")
  if [[ -n "$file" ]]; then
    echo "Watching $file..."
    # echo "${file##*.}"
    # watchexec -e "${file##*.}" -- "$file"
  else
    echo "No file selected."
  fi
}

# Watch $file and execute $file on save
# alias wef

# Watch $file type and execute $file on save
# Example: If file is `main.py`, all `.py` files will be watched
# alias weft

# Watch directory and execute $file on save
# alias wed
