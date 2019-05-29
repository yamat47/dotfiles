#!/bin/sh

mv $HOME/.bashrc $HOME/.bashrc.bak

ln -s $HOME/.config/dotfiles/nvim/ $HOME/.config/
ln -s $HOME/.config/dotfiles/git-completion.bash $HOME/.config/git-completion.bash
ln -s $HOME/.config/dotfiles/git-prompt.sh $HOME/.config/git-prompt.sh
ln -s $HOME/.config/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $HOME/.config/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $HOME/.config/dotfiles/.bash_aliases $HOME/.bash_aliases
