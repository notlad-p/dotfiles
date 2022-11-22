#!/usr/bin/env bash


# # link .bashrc & run new .bashrc
# ln -s $WORK_DIR"/.bashrc" ~/.bashrc
# . ~/.bashrc

# echo $WORK_DIR"/.bashrc"

# link 

# # Test if command exists
# if ! command -v testcommand &> /dev/null
# then
#   echo "COMMAND NOT FOUND"
# fi

# -----------------------------------
WORK_DIR=`pwd`

# # symlink starship.toml
# ln -sf $WORK_DIR"/starship.toml" ~/.config/starship.toml

# # symlink config.fish to ~/.config/fish/config.fish
# # NEEDS STARSHIP.RS
# ln -sf $WORK_DIR"/config.fish" ~/.config/fish/config.fish

# symlink wezterm config
ln -s $WORK_DIR"/wezterm" ~/.config/wezterm
