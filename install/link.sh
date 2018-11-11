#!/bin/bash

ln -s ~/code/dotfiles ~/.dotfiles
ln -s ~/.dotfiles/tmux/tmux.conf.symlink ~/.tmux.conf
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/weechat ~/.weechat
ln -s ~/.dotfiles/zsh/zshrc.symlink ~/.zshrc

mkdir -p ~/.config
ln -s ~/.dotfiles/alacritty ~/.cofnig/alacritty
ln -s ~/.dotfiles/karabiner ~/.config/karabiner
ln -s ~/.dotfiles/nvim ~/.config/nvim
