# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# add/clone and source plugin
function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)


  if [[ ! -e $HOME/Packages/$PLUGIN_NAME ]]; then
    git clone --depth=1 https://github.com/$1.git $HOME/Packages/$PLUGIN_NAME
  fi

  source $HOME/Packages/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh || \
  source $HOME/Packages/$PLUGIN_NAME/$PLUGIN_NAME.zsh
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# TODO: add fzf functions here
# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/scripts_fzf.zsh
