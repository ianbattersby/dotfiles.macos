#!/usr/local/bin/bash

function munge_path(){
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
      PATH="$1:$PATH"
    fi
}

#Update package source
sudo pkg update

#Make sure XCode command-line tools are installed (need it for git)
if [ ! -f /usr/bin/git ] && [ ! -f /usr/local/bin/git ]; then
    echo "Installing git, we can't do much without that."
    sudo pkg install --yes git
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
    echo "Installing zsh."
    sudo pkg install --yes zsh
fi

if [ "$1" != "noshellcheck" ] && [[ ! "$SHELL" =~ zsh$ ]]; then
    echo "Setting default shell to ZSH."
    sudo chsh -s $(which zsh) ian

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
    git@github.com:ianbattersby/dotfiles.private.git ~/code/dotfiles
fi

[ ! -d ~/.dotfiles ] && ln -s ~/code/dotfiles ~/.dotfiles
[ ! -f ~/.tmux.conf ] && ln -s ~/.dotfiles/tmux/tmux.conf.symlink ~/.tmux.conf
#[ ! -d ~/.vim ] && ln -s ~/.dotfiles/vim ~/.vim
[ ! -d ~/.weechat ] && ln -s ~/.dotfiles/weechat ~/.weechat

[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.config/alacritty ] && ln -s ~/.dotfiles/alacritty ~/.config/alacritty
[ ! -d ~/.config/karabiner ] && ln -s ~/.dotfiles/karabiner ~/.config/karabiner
[ ! -d ~/.config/nvim ] && ln -s ~/.dotfiles/nvim ~/.config/nvim

[ ! -f ~/.zshrc ] && ln -s ~/.dotfiles/zsh/zshrc.symlink ~/.zshrc

munge_path /usr/local/bin

echo;
echo "Fetching installed package list...";PKGS_INSTALLED="$(pkg version)";

function pkg_install(){
    [[ $1 =~ ([a-zA-Z0-9_\-]+)(@|$)([0-9]+$|$) ]]; PKG=${BASH_REMATCH[1]}; VERSION=${BASH_REMATCH[3]}

    FORMULA="${PKG}$([ ! -z $VERSION ] && echo "@${VERSION}")"

    echo "Pkg: ${FORMULA} (formula)"

    if [[ ! $PKGS_INSTALLED =~ (^|\ |
)("${PKG}-"|"${PKG}-${VERSION}."|"${FORMULA}-${VERSION}.")($|\ |
)* ]]; then
    echo $@
        eval "sudo pkg install --yes $@"
        true
    else
        false
    fi
}

#Fonts

#Package helpers
function cargo_install(){
    echo "Rust: $1 (cargo)"

    if [ ! -x ~/.cargo/bin/${1} ]; then
        eval "cargo ${2} install --quiet ${1}"
    fi
}


function pip_install(){
    echo "pip${1}: ${2} (package)"

    if [[ ! $(eval "sudo pip-${1} --disable-pip-version-check freeze") =~ (^|\ |
)"${2}"==* ]]; then
        eval "sudo pip-${1} install --disable-pip-version-check ${2} ${3} ${4} ${5}"
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
pkg_install python27
pkg_install py27-pip
pkg_install python36
pkg_install py36-pip
pkg_install go
pkg_install hs-ShellCheck
pkg_install py36-yamllint
pkg_install bats-core #Batch Automated Testing Systems (shell batch testing)
#pkg_install ghc
pkg_install stack

#HadoLint
cd ~/code
if [ ! -d ~/code/hadolint ]; then
    git clone https://github.com/hadolint/hadolint
    cd hadolint
fi
#/usr/local/bin/stack install

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

#Go
[ ! -f "$GOPATH/bin/gometalinter" ] && go get -u github.com/alecthomas/gometalinter && gometalinter --install --update
[ ! -f "$GOPATH/bin/hey" ] && go get -u github.com/rakyll/hey
[ ! -f "$GOPATH/bin/gitbatch" ] && go get -u github.com/isacikgoz/gitbatch
[ ! -f "$GOPATH/bin/vale" ] && go get -u github.com/errata-ai/vale

#Ruby
if pkg_install rbenv; then
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

pkg_install ruby24-gems

#Misc
pkg_install tmux
pkg_install mosh
pkg_install fzf
pkg_install exa
pkg_install bat
pkg_install jq
pkg_install gnupg
pkg_install aspell
pkg_install weechat #--with-aspell --with-curl --with-python@2 --with-perl --with-ruby --with-lua --with-guile
pkg_install terraform
pkg_install ctags
pkg_install gotop #command-line graphical activity monitor

#Neovim
pkg_install neovim
pip_install 2.7 neovim
pip_install 3.6 neovim --upgrade
pip_install 3.6 neovim-remote --upgrade
pip_install 3.6 gitlint
gem_install neovim

if [ ! -d ~/.config/nvim/pack/minpac/opt/minpac ]; then
    git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
fi

#GoogleCloudSDK
pkg_install google-cloud-sdk

#Kubernetes
pkg_install kubectl

