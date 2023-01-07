#!/bin/bash

# The purpose of this install script is to install all the libraries, tools and applications I use.
# Then it will run a script to sym link the configurations.
# Next it will clone my personal configurations that have separate repos.

#############
### NOTES ###
#############
# Assumes lua & luarocks already installed
# Switches to ~/Downloads when installing a file / .deb package / zip / git clone

# TODO: change ~/projects/dotfiles to below variable
# WORK_DIR=`pwd`

# TODO: USE MAKEFILE EVENTUALLY?
# https://github.com/jessfraz/dotfiles#installing

# exit on error
set -e

# ------------------------------------------------------
# install required stuff (tools)
# ------------------------------------------------------

# install apt packages
echo "Installing apt packages"
sudo apt install -y rofi curl wget tmux htop ranger exa zoxide

# Fish Shell
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish
# set fish to default shell
chsh -s /usr/bin/fish

# # FISHER & PLUGINS
echo "Installing fisher and fisher plugins"
fish -c "curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jorgebucaran/nvm.fish"
echo "Installed plugins:"
fish -c "fisher list"
# Install Node LTS and set it to default node version
fish -c "nvm install lts"
fish -c "set --universal nvm_default_version lts"
# TODO: test if this works
# Install node packages for fish shell
# fish -c "npm i -g @fsouza/prettierd eslint_d yarn narn typescript typescript-language-server"

# HOMEBREW
echo "Installing Homebrew"
sudo apt install build-essential
# install script & run install script
cd ~/Downloads
curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
/bin/bash install.sh
# add homebrew to path
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
# TODO: test if sourcing works
# source new .profile
source ~/.profile
source ~/.bash_profile
# TODO: figure out how to install Brewfile packages
cd ~/projects/dotfiles
brew bundle install --file=./Brewfile

# LUAROCKS
# wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz
# tar zxpf luarocks-3.9.1.tar.gz
# cd luarocks-3.9.1
# ./configure && make && sudo make install

# NVM / NODE LTS & NPM / NPM PACKAGES
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
command -v nvm
source ~/.bashrc
nvm install --lts
nvm use --lts
npm i -g @fsouza/prettierd eslint_d yarn narn typescript typescript-language-server

# Rust & stylua
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo install stylua

# luacheck
sudo luarocks install luacheck

# ------------------------------------------------------
# install applications
# ------------------------------------------------------
cd ~/Downloads
# OBSIDIAN
curl -LO https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.9/obsidian_1.1.9_amd64.deb
sudo apt install -y ./obsidian_1.1.9_amd64.deb

# WEZTERM
curl -LO https://github.com/wez/wezterm/releases/download/20221119-145034-49b9839f/wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb
sudo apt install -y ./wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb

# DISCORD
wget -O ~/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install -y ~/discord.deb

# SPOTIFY
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client


# ------------------------------------------------------
# Looks
# ------------------------------------------------------

# Install Fonts

# TODO: fix SFMono? might not install right
# SFMono
git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git && cd SFMono-Nerd-Font-Ligaturized
cp *.otf ~/.fonts

# FiraCode
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
unzip FiraCode.zip -d ~/.fonts

# rebuild font cache
fc-cache -fv

cd ~/projects/dotfiles
echo "Done installing!"

# symlink configs in this repo
echo "Now symlinking configs."
. ./symlink.sh

# TODO: next clone configs by running clone.sh
# Clone configs with their own repo
. ./clone.sh

echo "-------------------------------"
echo "All done!"
echo "Logout and log back in for default shell to be changed to fish."
