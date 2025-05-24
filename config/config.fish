if status is-interactive
    # Commands to run in interactive sessions can go here
end

# --------------
# Greeting image
# --------------
function fish_greeting
  # set b (set_color 34bfd0)
  # set y (set_color efbd5d)
  set r (set_color fb4934)

  # echo $y"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀"
  # echo $b"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣤⣤⣤⣤⣄⣀⣀⣀"$y"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣾⡟⠁⠀"
  # echo $b"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠉⠉⠉"$y"⢀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⠏⠀⠀⠀"
  # echo $b"⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀"$y"⣀⣤⣶⣿⣿⣿⣿⡿⠿⠶⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⣠⣶⣿⣿⣿⡟⠉⢻⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀"$y"⣀⣴⣾⣿⣿⣿⠟⠋⠉⠀⠀"$b"⣀⣠⣤⣴⣶⣤⣄⡀⠀⠀⠀"$y"⢀⣤⣾⣿⣿⡿⠟⠋⠁⠀"$b"⢀⣠⠀⠀⠀⠀⠀"
  # echo $b"⠀⠰⢾⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⠿⠋⠀⠀"$y"⢀⣤⣾⣿⣿⡿⠟⠉⠀⠀"$b"⢀⣠⣴⣿⣿⣿⣿⠿⠟⠋⠉⠉"$y"⢀⣤⣾⣿⣿⠿⠛⠉⠀"$b"⢀⣠⣴⣾⣿⣿⠀⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀"$y"⢀⣤⣾⣿⣿⡿⠟⠉⠀⠀"$b"⢀⣠⣶⣿⣿⣿⡿⠟⠋⠀⠀⠀"$y"⣀⣴⣾⣿⡿⠟⠋⠁"$b"⢤⣤⣴⣾⣿⣿⠿⠟⠋⠉⠀⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠁⠀"$y"⣀⣠⣴⣾⣿⣿⠿⠛⠉⠀⠀"$b"⣀⣤⣾⣿⣿⣿⠿⠛⠁⠀⠀"$y"⣀⣤⣶⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀"$b"⠈⠉⠉⠁⠀"$y"⣀⣀⣤⣴⣆⠀⠀⠀⠀"
  # echo $y"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠉"$b"⣀⣀⣠⣤⣶⣿⣿⠿⠟⠋⠉⠀"$y"⣀⣠⣤⣶⡿⠿⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⠛⠛⠛⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠀⠀⠀"$y"⠒⠒⠚⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"$b"⠒⠶⣶⣦⡀⠀"
  # echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"$b"⠈⠉⠂"

  # echo $b"⠀⠀⠀⢀⣴⠀⢸⡄⠀⢀⣀⣤⣤⣶⣶⣶⣶⣶⣦⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⢸⡧⣠⣿⡇⢀⣤⠹⣿⣿⣿⣿⣿⣭⣭⣛⡻⢿⣿⣷⣄⠀⠀⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⣘⣾⣿⣟⣤⡀⠹⣷⠘⣿⣿⣿⣿⣽⡻⢿⣿⣷⣬⡙⢿⣷⣄⠀⠀⠀⠀"
  # echo $b"⠀⠀⠀⣿⣫⣿⣿⣿⣿⡆⢹⡇⢻⣿⣿⣿⣿⣿⣷⣝⢿⣿⣿⣄⠻⣿⣆⠀⠀⠀"
  # echo $b"⠀⠀⢼⣿⠟⠋⢩⣿⣿⡇⢸⡇⣸⣿⣿⣿⣿⡝⣿⣿⣆⢹⣿⣿⣆⠹⣿⡆⠀⠀"
  # echo $b"⠀⠀⠈⠁⠀⣰⣿⣿⣿⠇⣸⢣⣿⣿⣿⣿⣿⣷⢸⣿⣿⡀⢿⣿⣿⡀⢻⣷⠀⠀"
  # echo $b"⠀⠀⠀⠀⣼⣿⣿⣿⡟⠠⣣⣾⣿⣿⣿⣿⣿⡟⢀⣿⣿⡇⢸⣿⣿⡇⢸⣿⠀⠀"
  # echo $b"⠀⠀⠀⢸⣿⣿⣿⣿⣧⣌⣻⢿⣿⣿⣿⠿⠛⠃⠘⠛⠿⠁⢸⣿⣿⡇⢈⣿⠀⠀"
  # echo $b"⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣀⠀⠀⠀⠈⠛⢿⠇⢸⡏⠀⠀"
  # echo $b"⠀⠀⠀⠈⢿⣿⣿⣿⣿⣟⠿⣿⣿⣿⣿⢿⣿⣿⣿⣷⡄⠀⠀⠀⠈⠀⡼⠁⣸⡀"
  # echo $b"⠀⠀⣀⣤⣶⣯⣟⢻⣿⣿⡇⠛⠛⣛⣛⢸⣿⣿⣿⢹⣿⣦⡀⠀⠀⠠⠁⠐⢻⠁"
  # echo $b"⢀⣾⢿⡏⠁⠀⠀⠀⢿⣿⡇⠀⠀⠘⢿⡸⣿⣿⣿⣄⡙⠻⢿⣷⣤⣤⣤⣴⠏⠀"
  # echo $b"⠀⠿⠈⠀⠀⠀⠀⠀⠈⢿⣷⡄⠀⠀⠀⢱⣭⠙⠛⠛⢿⣿⠀⠀⠉⠉⠉⠀⠀⠀"
  # echo $b"⠀⠀⠀⠀⠀⠀⠀⣤⣤⣾⡟⠀⠀⣤⣤⣼⣿⠗⣤⣤⣼⣿⠗⠀⠀⠀⠀⠀⠀⠀"

  echo $r"⠀⠀⣶⣶⣶⣶⣶⣶⣶⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
  echo $r"⠀⠀⠈⣽⣦⣤⣤⣍⣉⣉⣩⣿⣿⡇⢿⣷⣶⣤⣀⣰⡆⠀⠀⠀⠀⠀⠀⠀"
  echo $r"⠀⠀⠀⠈⢛⣛⡛⠛⠛⠛⢿⣿⡏⢠⣿⣿⠟⠛⠻⢿⣿⡦⠀⠀⠀⠀⠀⠀"
  echo $r"⠀⠀⠀⠀⠀⠻⠿⠿⠿⢿⣿⣿⡇⢸⣿⢿⣷⣤⣄⣀⠛⣁⣺⠛⠛⢷⣶⠆"
  echo $r"⠀⠀⠀⠀⠀⠀⠈⢿⣷⣦⣬⣿⣷⡘⢿⣧⣈⡉⠛⠻⣿⣦⠙⠛⠿⠛⠋⠀"
  echo $r"⠠⣤⣶⠾⠛⢖⣀⣀⡈⠉⠉⠛⣿⣿⣶⣿⣿⣿⣿⣷⣼⣿⡇⠀⠀⠀⠀⠀"
  echo $r"⠀⠙⠷⠶⠿⠟⠛⠛⠻⣷⣴⣿⠟⢛⣿⡿⠋⠀⠀⣿⣿⣿⠃⠀⠀⠀⠀⠀"
  echo $r"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣷⣶⡿⠛⣡⣴⣶⣾⡿⠟⠃⠀⠀⠀⠀⠀⠀"
  echo $r"⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣤⡀⢸⣿⣿⣯⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀"
  echo $r"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠉⠁⠈⠉⠉⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀"
end

# ---------------------
# Set fish color scheme
# ---------------------

# ----------------
# onedark:
# ----------------
# set fish_color_normal 93a4c3 # #93a4c3
# set fish_color_command 34bfd0 # #34bfd0
# set fish_color_quote 8bcd5b # #8bcd5b
# set fish_color_redirection c75ae8 # #c75ae8
# set fish_color_end dd9046 # #dd9046
# set fish_color_error f65866 # #f65866
# set fish_color_param 93a4c3 # #93a4c3
# set fish_color_valid_path --bold
# set fish_color_option c75ae8 # #c75ae8
# set fish_color_comment 455574 # #455574
# set fish_color_escape dd9046 # #dd9046 
# set fish_pager_color_description f2cc81 # #f2cc81
# set fish_pager_color_selected_background --background=141b24 # #141b24

# ----------------
# gruvbox
# ----------------

set fish_color_normal ebdbb2 # #ebdbb2
set fish_color_command 83a598 # #83a598 
set fish_color_quote b8bb26 # #b8bb26
set fish_color_redirection d3869b # #d3869b 
set fish_color_end fe8019 # #fe8019 
set fish_color_error fb4934 # #fb4934 
set fish_color_param ebdbb2 # #ebdbb2 
set fish_color_option d3869b # #d3869b 
set fish_color_comment 4b4b4b # #4b4b4b 
set fish_color_escape fe8019 # #fe8019 
set fish_pager_color_description fbf1c7 # #fbf1c7 
set fish_pager_color_selected_background --background=232323 # #232323 

# ----------------
# defaults
# ----------------
set fish_pager_color_prefix normal --bold
set fish_color_valid_path --bold

# ----------------
# unset colors:
# ----------------
# $ set -U fish_color_keyword # falls back to command color
# $ set -U fish_color_selection --background=#FFCC66
# $ set -U fish_color_operator #FFCC66
# $ set -U fish_color_autosuggestion #707A8C
# $ set -U fish_color_cwd #73D0FF
# $ set -U fish_color_cwd_root red
# $ set -U fish_color_user brgreen
# $ set -U fish_color_host normal
# $ set -U fish_color_host_remote
# $ set -U fish_color_cancel --reverse
# $ set -U fish_color_search_match --background=#FFCC66
# $ set -U fish_pager_color_progress brwhite --background=cyan
# $ set -U fish_pager_color_background
# $ set -U fish_pager_color_completion normal
# $ set -U fish_pager_color_selected_prefix
# $ set -U fish_pager_color_selected_completion
# $ set -U fish_pager_color_selected_description
# $ set -U fish_pager_color_secondary_background
# $ set -U fish_pager_color_secondary_prefix
# $ set -U fish_pager_color_secondary_completion
# $ set -U fish_pager_color_secondary_description
# $ set -U fish_color_history_current --bold
# $ set -U fish_color_match #F28779

# -------------------------------------
# Start starship (https://starship.rs/)
# -------------------------------------
starship init fish | source

# -----------------
# Alias definitions
# -----------------

# editor
alias v "nvim"
alias vim "nvim"

alias g="firefox -search"

# Better ls commands with recursion, all files
function ls --wraps ls
  exa -1 -l -h --no-permissions --no-user --icons $argv
end
alias lsa="ls -a"
alias lsd="ls -D"
alias lsr="ls -R"
function lsrl --wraps ls 
  lsr --level=$argv
end

# git
alias gp "git push"

# uses npm if its an npm repo. https://www.npmjs.com/package/narn
alias yarn=narn

# find file with fzf then open in nvim
alias f "fd --type f --hidden --exclude node_modules --exclude .git | fzf-tmux -p | xargs nvim"
# 'find project directory' with fzf then cd into it
alias fpd "cd (fd --full-path '/home/dalton/projects' --max-depth 2 --type d --hidden --exclude node_modules --exclude .git | fzf-tmux -p)"
# 'find directory neovim' with fzf then cd into it & start nvim with session restore
alias fdn "cd (fd --type d --hidden --exclude node_modules --exclude .git | fzf-tmux -p); nvim -c 'SessionRestore'"
# TODO: add more aliases?
# Create a new directory and enter it

# Best default keybinds:
# Autocomplete and start search mode - Shift + tab 
# list current directory - Alt + l 
# clear screen - Ctrl + l
# Prepend sudo to current command - Alt + s 
# Move to previous directory - Alt + Left
# Move to next directory - Alt + Right
# Delete from beginning of line to cursor - Ctrl + u
# Delete from cursor to previous '/', ':', or '@' - Ctrl + w
# Exit fish - Ctrl + d

#--------------
# Set keybinds
#--------------

# Ctrl + n - Open neovim
bind \cn 'nvim'
# Alt + n - Open neovim and restore session
bind \en 'nvim -c "SessionRestore"'

# Ctrl + t - Start tmux session
bind \ct 'tmux'

# Alt + z - Open zellij
bind \ez 'zellij'

# initialize zoxide
zoxide init fish | source

# add cargo to fish path
#export PATH="$HOME/.cargo/bin:$PATH"
#set PATH $HOME/.cargo/bin $PATH
set -gx EDITOR nvim
set -gx VISUAL nvim
