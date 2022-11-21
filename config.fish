if status is-interactive
    # Commands to run in interactive sessions can go here
end

# --------------
# Greeting image
# --------------
function fish_greeting
  set b (set_color 34bfd0)
  set y (set_color efbd5d)

  echo $y"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀"
  echo $b"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣤⣤⣤⣤⣄⣀⣀⣀"$y"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣾⡟⠁⠀"
  echo $b"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠉⠉⠉"$y"⢀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⠏⠀⠀⠀"
  echo $b"⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀"$y"⣀⣤⣶⣿⣿⣿⣿⡿⠿⠶⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀"
  echo $b"⠀⠀⠀⣠⣶⣿⣿⣿⡟⠉⢻⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀"$y"⣀⣴⣾⣿⣿⣿⠟⠋⠉⠀⠀"$b"⣀⣠⣤⣴⣶⣤⣄⡀⠀⠀⠀"$y"⢀⣤⣾⣿⣿⡿⠟⠋⠁⠀"$b"⢀⣠⠀⠀⠀⠀⠀"
  echo $b"⠀⠰⢾⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⠿⠋⠀⠀"$y"⢀⣤⣾⣿⣿⡿⠟⠉⠀⠀"$b"⢀⣠⣴⣿⣿⣿⣿⠿⠟⠋⠉⠉"$y"⢀⣤⣾⣿⣿⠿⠛⠉⠀"$b"⢀⣠⣴⣾⣿⣿⠀⠀⠀⠀⠀"
  echo $b"⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀"$y"⢀⣤⣾⣿⣿⡿⠟⠉⠀⠀"$b"⢀⣠⣶⣿⣿⣿⡿⠟⠋⠀⠀⠀"$y"⣀⣴⣾⣿⡿⠟⠋⠁"$b"⢤⣤⣴⣾⣿⣿⠿⠟⠋⠉⠀⠀⠀⠀⠀"
  echo $b"⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠁⠀"$y"⣀⣠⣴⣾⣿⣿⠿⠛⠉⠀⠀"$b"⣀⣤⣾⣿⣿⣿⠿⠛⠁⠀⠀"$y"⣀⣤⣶⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀"$b"⠈⠉⠉⠁⠀"$y"⣀⣀⣤⣴⣆⠀⠀⠀⠀"
  echo $y"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠉"$b"⣀⣀⣠⣤⣶⣿⣿⠿⠟⠋⠉⠀"$y"⣀⣠⣤⣶⡿⠿⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⠛⠛⠛⠀⠀⠀⠀"
  echo $b"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠀⠀⠀"$y"⠒⠒⠚⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"$b"⠒⠶⣶⣦⡀⠀"
  echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"$b"⠈⠉⠂"
end

# ---------------------
# Set fish color scheme
# ---------------------
set fish_color_normal 93a4c3 # #93a4c3
set fish_color_command 34bfd0 # #34bfd0
# $ set -U fish_color_keyword # falls back to command color
set fish_color_quote 8bcd5b # #8bcd5b
set fish_color_redirection c75ae8 # #c75ae8
set fish_color_end dd9046 # #dd9046
set fish_color_error f65866 # #f65866
set fish_color_param 93a4c3 # #93a4c3
set fish_color_valid_path --bold
set fish_color_option c75ae8 # #c75ae8
set fish_color_comment 455574 # #455574
# $ set -U fish_color_selection --background=#FFCC66
# $ set -U fish_color_operator #FFCC66
set fish_color_escape dd9046 # #dd9046 
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
set fish_pager_color_prefix normal --bold
# $ set -U fish_pager_color_completion normal
set fish_pager_color_description f2cc81 # #f2cc81
set fish_pager_color_selected_background --background=141b24 # #141b24
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
