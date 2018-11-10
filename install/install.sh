#!/bin/bash

#Make sure XCode command-line tools are installed (need it for git)
if [ ! -f /usr/bin/git ] && [ ! -f /usr/local/bin/git ]; then
    echo "Installing xcode command-line tools, ignore error if already installed."
    xcode-select --install
fi

#Ensure SSH is setup so we can clone the dotfiles repo
echo;while true; do
    read -p "Is SSH setup and working using 'ssh git@gitlab.com'. Continue? (y[es]/n[o]) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo; echo "You're gonna have to be able to clone dotfiles for this to work ;-)"; exit;;
        * ) echo "Please answer yes or no.";
    esac
done

#Karabiner-Elements
if [ ! -d /Applications/Karabiner-Elements.app ]; then
    echo;while true; do
        read -p "Have you installed Karabiner-Elements ([y]es/[n]o/[i]gnore)? " yni
        case $yni in
            [YyIi]* ) break;;
            [Nn]* ) echo; echo "Browse to 'https://pqrs.org/osx/karabiner' and install it."; exit;;
            * ) echo "Plase answer yes, no, or ignore."
        esac
    done
fi

#Alfred
if [ ! $(ls /Applications/Alfred*.app 2> /dev/null | wc -l) != "0" ]; then
    echo;while true; do
        read -p "Have you installed Alfred and re-assigned shortcuts (Cmd-Space) ([y]es/[n]o/[i]gnore)? " yni
        case $yni in
            [YyIi]* ) break;;
            [Nn]* ) echo; echo "Browse to 'https://www.alfredapp.com' and install it."; exit;;
            * ) echo "Please answer yes, no, or ignore."s
        esac
    done
fi

#OhMyZsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

#Brew
if [ ! -x /usr/local/bin/brew ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo;
echo "Fetching Brew Taps...";BREW_TAPS="$(brew tap)"
echo "Fetching Brew Casks...";BREW_CASKS="$(brew cask ls)"

function brew_install(){
    VERSION=""

    if [ -n $2 ]; then
        FORMULA="${1}@${2}"
        VERSION="${2}."
    fi

    if [[ ! "$(brew ls --versions $FORMULA)" =~ ^(${1}|${FORMULA})(\$|\ )"${VERSION}"* ]]; then
        eval "brew install ${1}@${2}"
    fi
}
    
function brew_cask_install(){
    if [[ ! $BREW_CASKS =~ [^\ \
]"${1}"[$\ \
]* ]]; then
        brew cask install $1
    fi
}

function brew_tap(){
    if [[ ! $BREW_TAPS =~ [^\ \
]"${1}"[$\ \
]* ]]; then
    echo "install"
        brew tap $1
    fi
    exit
}

#Fonts
brew_tap homebrew/cask
brew_tap homebrew/cash-fonts
brew_tap alecthomas/homebrew-tap
brew_cask_install font-source-code-pro
brew_cask_install font-source-code-pro-for-powerline

#Languages
brew_install python 2
brew_install python 3
brew_install ruby
brew_install golang
brew_install gometalinter
brew_install gocode
brew_install shellcheck
brew_install yamllint

#Rust
curl https://sh.rustup.rs -sSf | sh
cargo install cargo-tree
cargo install cargo-outdated
cargo +nightly install racer

#Tmux
brew_install tmux

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
brew_install neovim
easy_install neovim
pip2 install neovim
pip3 install --upgrade neovim
gem install neovim

#Misc
brew_install the_silver_searcher
brew_install reattach-to-user-namespace
brew_install fzf
brew_install exa
brew_install bat
brew_install jq
brew_install gpg
brew_install aspell
brew_install weechat --with-aspell --with-curl --with-python@2 --with-perl --with-ruby --with-lua --with-guile


