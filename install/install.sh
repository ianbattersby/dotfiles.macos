#!/bin/bash

#Make sure XCode command-line tools are installed (need it for git)
echo "Installing xcode command-line tools, ignore error if already installed."
xcode-select --install

#Ensure SSH is setup so we can clone the dotfiles repo
echo;while true; do
    read -p "Please ensure that SSH is setup and working using 'ssh git@gitlab.com'. Continue? (y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";
    esac
done

#Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Fonts
brew tap caskroom/fonts
brew cask install font-source-code-pro
brew cask install font-source-code-pro-for-powerline

#Languages
brew install python@2
brew install python@3
brew install ruby
brew install golang
brew install gometalinter
brew install gocode
brew install shellcheck
brew install yamllint

#Rust
curl https://sh.rustup.rs -sSf | sh
cargo install cargo-tree
cargo install cargo-outdated
cargo +nightly install racer

#Tmux
brew install tmux

#Code
mkdir -p ~/code
cd ~/code

#Alacritty
git clone https://github.com/jwilm/alacritty.git
make app
cp -r target/release/osx/Alacritty.app /Applications

#Colour Profiles
tic -x ~/terminfo/tmux-256color.terminfo
tic -x ~/terminfo/xterm-256color.terminfo

#Neovim
brew install neovim
easy_install neovim
pip2 install neovim
pip3 install --upgrade neovim
gem install neovim

#Misc
brew install the_silver_searcher
brew install reattach-to-user-namespace
brew install fzf
brew install exa
brew install bat
brew install jq
brew install gpg
brew install aspell
brew install weechat --with-aspell --with-curl --with-python@2 --with-perl --with-ruby --with-lua --with-guile


