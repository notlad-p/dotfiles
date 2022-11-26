# ------------------------------------------------------
# install required stuff (tools)
# ------------------------------------------------------

# install apt packages
sudo apt install lua5.4 liblua5.4-dev awesome rofi nodejs

# TODO: FISH SHELL
# check if fish is installed
# if not run commands to install fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
# set fish to default shell
chsh -s /usr/bin/fish

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# # FISHER & PLUGINS
echo "Installing fisher and fisher plugins"
curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
# TODO: move fish shell scripts elseware? (won't run in bash)
fisher install jorgebucaran/nvm.fish
fish -c "fisher update"

# HOMEBREW
sudo apt install build-essential
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
# TODO: add aditional commands to add homebrew to PATH

# LUAROCKS
wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz
tar zxpf luarocks-3.9.1.tar.gz
cd luarocks-3.9.1
./configure && make && sudo make install

# WEZTERM
curl -LO https://github.com/wez/wezterm/releases/download/20221119-145034-49b9839f/wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb
sudo apt install -y ./wezterm-20221119-145034-49b9839f.Ubuntu22.04.deb

# NODE.JS & PACKAGES
# TODO: test this install
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

npm i -g prettierd eslint_d yarn narn typescript

# FiraCode Nerd font



# ------------------------------------------------------
# install applications
# ------------------------------------------------------
# OBSIDIAN
#


# ------------------------------------------------------
# Clone separate configs
# ------------------------------------------------------
# neovim
# awesomewm
# obsidian

# USE MAKEFILE EVENTUALLY?
# https://github.com/jessfraz/dotfiles#installing
