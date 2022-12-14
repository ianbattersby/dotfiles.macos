#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PYTHON_PIP2_BIN=~/Library/Python/2.7/bin/

function munge_path(){
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
      PATH="$1:$PATH"
    fi
}

#Make sure XCode command-line tools are installed (need it for git)
if [ ! -f /usr/bin/git ] && [ ! -f /usr/local/bin/git ]; then
    echo "Installing xcode command-line tools, ignore error if already installed."
    xcode-select --install
fi

#Ensure SSH is setup so we can clone the dotfiles repo
echo;while true; do
    read -p "Is SSH setup and working using 'ssh git@github.com'. Continue? (y[es]/n[o]) " yn
    case $yn in
        [Yy]* ) echo; break;;
        [Nn]* ) echo; echo "You're gonna have to be able to clone dotfiles for this to work ;-)"; exit;;
        * ) echo "Please answer yes or no.";
    esac
done

#Zsh
if [ ! -f /bin/zsh ] && [ ! -f /usr/bin/zsh ] && [ ! -f /usr/local/bin/zsh ]; then
    echo "You must first install ZSH to continue."
    exit
fi

if [ "$1" != "noshellcheck" ] && [[ ! "$SHELL" =~ zsh$ ]]; then
    echo "Setting default shell to ZSH."
    chsh -s $(which zsh)

    echo "If you are using Terminal.app, update preferences to launch /bin/zsh for 'Shell opens with'."
    read -p "Hit ENTER when complete."

    echo "Relaunching in ZSH shell..."
    zsh -c -i "${0} noshellcheck"
    exit
fi

#OhMyZsh
if [ ! -n "$OHMYZSH" ]; then
    OHMYZSH=~/.oh-my-zsh
fi

if [ ! -d $OHMYZSH ]; then
    umask g-w,o-w
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$OHMYZSH"
fi

#Code
mkdir -p ~/code
cd ~/code

#dotfiles
if [ ! -d ~/code/dotfiles ]; then
    git clone git@github.com:ianbattersby/dotfiles.private.git ~/code/dotfiles
fi

[ ! -d ~/.dotfiles ] && ln -s ~/code/dotfiles ~/.dotfiles
[ ! -f ~/.tmux.conf ] && ln -s ~/.dotfiles/tmux/tmux.conf.symlink ~/.tmux.conf
#[ ! -d ~/.vim ] && ln -s ~/.dotfiles/vim ~/.vim
#[ ! -d ~/.weechat ] && ln -s ~/.dotfiles/weechat ~/.weechat

[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.config/alacritty ] && ln -s ~/.dotfiles/alacritty ~/.config/alacritty
[ ! -d ~/.config/karabiner ] && ln -s ~/.dotfiles/karabiner ~/.config/karabiner
[ ! -d ~/.config/nvim ] && ln -s ~/.dotfiles/nvim ~/.config/nvim
[ ! -d ~/.config/git ] && ln -s ~/.dotfiles/git ~/.config/git

[ ! -f ~/.zshrc ] && ln -s ~/.dotfiles/zsh/zshrc.symlink ~/.zshrc
[ ! -f ~/.zshenv ] && ln -s ~/.dotfiles/zsh/zshenv.symlink ~/.zshenv

#Karabiner-Elements
if [ ! -d /Applications/Karabiner-Elements.app ]; then
    echo;while true; do
        read -p "Have you installed Karabiner-Elements? ([y]es/[n]o/[i]gnore) " yni
        case $yni in
            [YyIi]* ) echo; break;;
            [Nn]* ) echo; echo "Browse to 'https://pqrs.org/osx/karabiner' and install it."; exit;;
            * ) echo "Plase answer yes, no, or ignore."
        esac
    done
fi

#Alfred
if [ ! $(ls /Applications/Alfred*.app 2> /dev/null | wc -l) != "0" ]; then
    echo;while true; do
        read -p "Have you installed Alfred (and re-assigned shortcut to Cmd-Space)? ([y]es/[n]o/[i]gnore) " yni
        case $yni in
            [YyIi]* ) echo; break;;
            [Nn]* ) echo; echo "Browse to 'https://www.alfredapp.com' and install it."; exit;;
            * ) echo "Please answer yes, no, or ignore."s
        esac
    done
fi

#DockerForMac
if [ ! -d /Applications/Docker.app ]; then
    echo;while true; do
        read -p "Have you installed DockerForMac? ([y]es/[n]o/[i]gnore) " yni
        case $yni in
            [YyIi]* ) echo; break;;
            [Nn]* ) echo; echo "Browse to 'https://download.docker.com/mac/stable/Docker.dmg' and install it."; exit;;
            * ) echo "Plase answer yes, no, or ignore."
        esac
    done
fi

#Colour Profiles (used primarily for tmux)
function tic_(){
    echo "TermInfo: ${1}"

    if [[ ! $(toe) =~ (^|\ |
)"${1}"\ * ]]; then
        eval "tic -x ~/.dotfiles/terminfo/${1}.terminfo"
    fi
}

tic_ tmux-256color
tic_ xterm-256color

#Brew
if [ ! -x /usr/local/bin/brew ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

munge_path /usr/local/bin

echo;
echo "Fetching Brew Taps...";BREW_TAPS="$(brew tap)"
echo "Fetching Brew Casks...";BREW_CASKS="$(brew cask ls)"

function brew_install(){
    [[ $1 =~ ([a-zA-Z0-9_\-]+)(@|$)([0-9.]+$|$) ]]; PKG=${BASH_REMATCH[1]}; VERSION=${BASH_REMATCH[3]}

    FORMULA="${PKG}$([ ! -z $VERSION ] && echo "@${VERSION}")"

    echo "Brew: ${FORMULA} (formula)"

    if [[ ! "$(brew ls --versions $FORMULA)" =~ ^($PKG^|$PKG\ $VERSION\.*|$FORMULA\ $VERSION\.*) ]]; then
        eval "brew install $@"
        true
    else
        false
    fi
}
    
function brew_cask_install(){
    echo "Brew: ${1} (cask)"

    if [[ ! $BREW_CASKS =~ (^|\ |
)"${1}"($|\ |
)* ]]; then
        brew cask install $1
    fi
}

function brew_tap(){
    echo "Brew: ${1} (tap)"

    if [[ ! $BREW_TAPS =~ (^|\ |
)"${1}"($|\ |
)* ]]; then
        brew tap $1
    fi
}

#Powerline font install requires SVN :face_palming:
brew_install subversion

#Fonts
brew_tap homebrew/cask
brew_tap homebrew/cask-fonts
brew_tap alecthomas/homebrew-tap
brew_cask_install font-hack
brew_cask_install font-hack-nerd-font

#Package helpers
function cargo_install(){
    echo "Rust: $1 (cargo)"

    if [ ! -x ~/.cargo/bin/${1} ]; then
        eval "cargo ${2} install --quiet ${1}"
    fi
}


function pip_install(){
    [[ "${1}" == "2" ]] && PIP_LOCATION=$PYTHON_PIP2_BIN || PIP_LOCATION=""
    [[ "${1}" == "2" ]] && PIP_SUFFIX=" --user --no-python-version-warning" || PIP_SUFFIX=""

    echo "pip${1}: ${2} (package)"

    if [[ ! $(eval "${PIP_LOCATION}pip${1} freeze${PIP_SUFFIX}") =~ (^|\ |
)"${2}"==* ]]; then
        eval "${PIP_LOCATION}pip${1} install ${2} ${3} ${4} ${5} ${6} ${7}${PIP_SUFFIX}"
    fi
}

function gem_install(){
    echo "gem: ${1} (package)"

    if [[ ! $(gem list --local $1) =~ (^|\ |
)"${1}"\ * ]]; then
        sudo gem install $1
    fi
}

#Languages
brew_install node
brew_install yarn
brew_install go
brew_install python@3.10

#Python2 pip doesn't come with Catalina and brew no longer available
#[[ ! -e $PYTHON_PIP2_BIN/pip2 ]] && python "$SCRIPT_DIR/get-pip.py" --user

#Linting
brew_install shellcheck #bash linting
brew_install bats #Batch Automated Testing System (shell tests)
brew_install hadolint #Dockerfile linting

#Install golangci-lint (used to be gometalinter)
#brew_tap golangci/tap
#brew_install golangci-lint

#Rust
[ ! -x ~/.cargo/bin/rustc ] && curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y

munge_path ~/.cargo/bin

[[ ! "$(rustup show)" =~ nightly\- ]] && rustup install nightly

[[ ! "$(rustup component list --toolchain stable)" =~ rls\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rls --toolchain stable
[[ ! "$(rustup component list --toolchain stable)" =~ rust\-analysis\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rust-analysis --toolchain stable
[[ ! "$(rustup component list --toolchain stable)" =~ rust\-src\ \((installed|default)\)* ]] && rustup component add rust-src --toolchain stable

[[ ! "$(rustup component list --toolchain nightly)" =~ rls\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rls --toolchain nightly
[[ ! "$(rustup component list --toolchain nightly)" =~ rust\-analysis\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rust-analysis --toolchain nightly
[[ ! "$(rustup component list --toolchain nightly)" =~ rust\-src\ \((installed|default)\)* ]] && rustup component add rust-src --toolchain nightly

cargo_install cargo-tree
cargo_install cargo-outdated
cargo_install racer +nightly
cargo_install rusty-tags
cargo_install ripgrep
cargo_install ytop

#Install the corresponding linker tools so that cargo can produce a binary compatible with x86 64-bit Linux
brew_tap filosottile/musl-cross
brew_install musl-cross

#Go
[[ -z $GOPATH ]] && GOPATH=~/code/go
[[ ! -d $GOPATH ]] && mkdir -p $GOPATH

[ ! -f "$GOPATH/bin/hey" ] && GOPATH=~/code/go go install github.com/rakyll/hey #perf testing
[ ! -f "$GOPATH/bin/dlv" ] && GOPATH=~/code/go go install github.com/go-delve/delve/cmd/dlv@latest #dap-go debugging

#Ruby
if brew_install rbenv; then
    rbenv init
    #eval("rbenv init -")

    RUBY_LATEST=$(rbenv install -l | awk -F '.' '
        /^[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+[[:space:]]*$/ {
            if ( ($1 * 100 + $2) * 100 + $3 > Max ) { 
                Max = ($1 * 100 + $2) * 100 + $3
                Version=$0
            }
        }
        END { print Version }')

    rbenv install $RUBY_LATEST
    rbenv global $RUBY_LATEST
fi

#Alacritty
brew_cask_install alacritty
[[ ! $(toe) =~ (^|\ |
)"alacritty"\ * ]] && sudo tic -xe alacritty,alacritty-direct ~/.dotfiles/alacritty/alacritty.info

#Misc
brew_install tmux
brew_install mosh
brew_install reattach-to-user-namespace
brew_install fzf
brew_install exa
brew_install bat
brew_install jq
brew_install gnupg
brew_install aspell
#brew_install weechat --with-aspell --with-curl --with-python@2 --with-perl --with-ruby --with-lua --with-guile
brew_install terraform
#brew_install vault
brew_install ctags
#brew_install jsonnet

#Neovim
brew_install neovim
gem_install neovim
#pip_install 2 neovim
pip_install 3 neovim --upgrade
pip_install 3 neovim-remote --upgrade
#pip_install 2 install --upgrade --user jedi #Python completion
pip_install 3 install --upgrade --user jedi #Python completion
#pip_install 2 pylint --upgrade #Python linting
pip_install 3 pylint --upgrade #Python linting
pip_install 3 gitlint #git linting

if [ ! -d ~/.config/nvim/pack/minpac/opt/minpac ]; then
    git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
fi

#Docker
#brew_tap wagoodman/dive
#brew_install dive

#Kubernetes
brew_install kubernetes-cli
#brew_install kubernetes-helm
brew_install stern
brew_install istioctl

#GoogleCloudSDK
brew_cask_install google-cloud-sdk

#PostgreSQL
#if brew_install libpq; then
#    brew link --force libpq
#fi
