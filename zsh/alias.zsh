# reload zsh config
alias reload!='source ~/.config/zsh/.zshrc'

# ls aliases 
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -lahF'
alias lls='ls -lahFtr'
alias la='ls -A'

# exa aliases
alias e='exa -G -l --no-permissions --no-user --icons --group-directories-first' # better looking ls
alias et='exa -T --icons' # ls recursivly as a tree

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

# TODO: aliases to add
# search pacman & pipe to fzf
# search paru & pip to fzf

# neovim
alias vim='nvim'
alias vi='nvim'
alias svim='sudoedit'
alias nvimd='nvim --noplugin -u NONE' # (nvim debug) - launch nvim without plugins or config
