#!/bin/zsh

# Karabiner setting
cp ./karabiner.json $HOME/.config/karabiner/karabiner.json

# zsh setting
sh -c "$(curl -fsSL https://git.io/zinit-install)"
ln -sF $HOME/.config/dotfiles/.zshrc $HOME

# Neovim setting
mkdir -p $HOME/.config/nvim
ln -sF $HOME/.config/dotfiles/init.vim $HOME/.config/nvim
ln -sF $HOME/.config/dotfiles/plugins.toml $HOME/.config/nvim
ln -sF $HOME/.config/dotfiles/ddu.toml $HOME/.config/nvim
ln -sF $HOME/.config/dotfiles/ddc.toml $HOME/.config/nvim

# Git setting
ln -sF $HOME/.config/dotfiles/.gitconfig $HOME
cp $HOME/.config/dotfiles/.gitconfig.local.sample $HOME/.gitconfig.local
