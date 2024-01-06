# vim mode
bindkey -v # set default editor to vi
bindkey -r "^[" # unbind default vim mode on ESC
bindkey -M viins 'jk' vi-cmd-mode # bind jk to enter vim mode

# edit commands directly in neovim with CTRL+v
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# fix backspace and other stuff in vi-mode
# bindkey -M viins '\e/' _vi_search_fix
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line

# enable text objects for things like da" or ci(
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done


# tools
bindkey -s '^N' 'nvim^M' # bind CTRL n to enter neovim
bindkey -s '^O' 'nvim $(fzf)^M' # bind CTRL o to search for file and open in nvim
bindkey -s '^T' 'tmux^M' # bind CTRL t to enter tmux

# fzf
# rebind CTRL-t to CTRL-p
# zle -N fzf-file-widget 
bindkey -rM emacs '\ec'
bindkey -rM vicmd '\ec'
bindkey -rM viins '\ec'

zle     -N            fzf-file-widget
bindkey -M emacs '^P' fzf-file-widget
bindkey -M vicmd '^P' fzf-file-widget
bindkey -M viins '^P' fzf-file-widget
