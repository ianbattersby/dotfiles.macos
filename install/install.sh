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

#Zsh
if [ ! -f /bin/zsh ] && [ ! -f /usr/bin/zsh ] && [ ! -f /usr/local/bin/zsh ]; then
    echo "You must first install ZSH to continue."
    exit
fi

if [[ ! "$SHELL" =~ zsh$ ]]; then
    echo "Setting default shell to ZSH."
    chsh -s $(which zsh)

    echo "Relaunching in ZSH shell..."
    zsh $0
    exit
fi

#OhMyZsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

#Code
mkdir -p ~/code
cd ~/code

#dotfiles
if [ ! -d ~/code/dotfiles ]; then
    git@gitlab.com:ianbattersby/dotfiles.private.git ~/code/dotfiles
fi

[ ! -d ~/.dotfiles ] && ln -s ~/code/dotfiles ~/.dotfiles
[ ! -f ~/.tmux.conf ] && ln -s ~/.dotfiles/tmux/tmux.conf.symlink ~/.tmux.conf
[ ! -d ~/.vim ] && ln -s ~/.dotfiles/vim ~/.vim
[ ! -d ~/.weechat ] && ln -s ~/.dotfiles/weechat ~/.weechat

[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.config/alacritty ] && ln -s ~/.dotfiles/alacritty ~/.config/alacritty
[ ! -d ~/.config/karabiner ] && ln -s ~/.dotfiles/karabiner ~/.config/karabiner
[ ! -d ~/.config/nvim ] && ln -s ~/.dotfiles/nvim ~/.config/nvim

if [ ! -f ~/.zshrc ]; then
  ln -s ~/.dotfiles/zsh/zshrc.symlink ~/.zshrc
  echo "Please reload ZSH shell with 'source ~./.zshrc;$0' to continue."
  exit
fi

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

#Brew
if [ ! -x /usr/local/bin/brew ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo;
echo "Fetching Brew Taps...";BREW_TAPS="$(brew tap)"
echo "Fetching Brew Casks...";BREW_CASKS="$(brew cask ls)"

function brew_install(){
    FORMULA=$1
    VERSION=""

    if [ -n "$2" ]; then
        FORMULA="${1}@${2}"
        VERSION=$2
    fi

    echo "Brew: ${FORMULA} (formula)"

    if [[ ! "$(brew ls --versions $FORMULA)" =~ ^($FORMULA^|$1\ $VERSION\.*|$FORMULA\ $VERSION\.*) ]]; then
        echo "brew install ${FORMULA}"
    fi
}
    
function brew_cask_install(){
    echo "Brew: ${1} (cask)"

    if [[ ! $BREW_CASKS =~ [^\ \
]"${1}"[$\ \
]* ]]; then
        brew cask install $1
    fi
}

function brew_tap(){
    echo "Brew: ${1} (tap)"

    if [[ ! $BREW_TAPS =~ [^\ \
]"${1}"[$\ \
]* ]]; then
        brew tap $1
    fi
}

#Fonts
brew_tap homebrew/cask
brew_tap homebrew/cask-fonts
brew_tap alecthomas/homebrew-tap
brew_cask_install font-source-code-pro
brew_cask_install font-source-code-pro-for-powerline

#Languages
brew_install python 2
brew_install python 3
brew_install ruby
brew_install go
brew_install gometalinter
brew_install shellcheck
brew_install yamllint
brew_install tmux

#Rust
[[ ! "$(rustc --version)" =~ ^rustc ]] && curl https://sh.rustup.rs -sSf | sh

function cargo_install(){
    echo "Rust: ${1} (cargo)"

    if [ ! -x "~/.cargo/bin/${1}" ]; then
        eval "cargo install ${1} ${2}"
    fi
}

exit

cargo_install cargo-tree +stable
cargo install cargo-outdated +stable
cargo_install racer +nightly

#Go
[ ! -f "$GOPATH/bin/gometalinter" ] && go get -u github.com/nsf/gocode

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


