#!/bin/bash

function munge_path(){
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
      PATH="$1:$PATH"
    fi
}

#Update package source
apt-get clean && apt-get install -y apt-utils
#add-apt-repository -y ppa:neovim-ppa/stable
#apt-get update
#apt-get autoclean

#Restore the google package-source GPG key in case it went walkabout
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

#Make sure git is installed (need it for git)
if [ ! -f /usr/bin/git ] && [ ! -f /usr/local/bin/git ]; then
    echo "Installing git, we can't do much without that."
    apt-get -y install git
fi

#Zsh
if [ ! -f /bin/zsh ] && [ ! -f /usr/bin/zsh ] && [ ! -f /usr/local/bin/zsh ]; then
    echo "Installing zsh."
    apt-get -y install zsh
fi

munge_path /usr/local/bin

function pkg_install(){
    [[ $1 =~ ([a-zA-Z0-9_\-]+)(@|$)([0-9]+$|$) ]]; PKG=${BASH_REMATCH[1]}; VERSION=${BASH_REMATCH[3]}

    FORMULA="${PKG}$([ ! -z $VERSION ] && echo "@${VERSION}")"

    echo "Pkg: ${FORMULA} (formula)"

    # Skip the whole version checking for now
    if apt -qq list $@ 2>/dev/null | grep -qE "(installed|upgradeable)"; then
        false
    else
        echo $@
        eval "apt-get install -y $@"
        true
    fi
}

#Package helpers
function cargo_install(){
    echo "Rust: $1 (cargo)"

    if [ ! -x ~/.cargo/bin/${1} ]; then
        eval "cargo ${2} install --quiet ${1}"
    fi
}


function pip_install(){
    echo "pip${1}: ${2} (package)"

    if [[ ! $(eval "pip${1} --disable-pip-version-check freeze") =~ (^|\ |
)"${2}"==* ]]; then
        eval "pip${1} install --disable-pip-version-check ${2} ${3} ${4} ${5}"
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
#Assume Python2.7+, Python3.5+, Go1.13, Ruby2.6
pkg_install shellcheck
pkg_install yamllint
#pkg_install bats-core #Batch Automated Testing Systems (shell batch testing)
#curl -sSL https://get.haskellstack.org/ | sh #Stack

#HadoLint
#cd /usr/local/src
#if [ ! -d /usr/local/src/hadolint ]; then
#    git clone https://github.com/hadolint/hadolint /usr/local/src/hadolint
#    cd hadolint
#fi
#/usr/local/bin/stack install

#Rust
#[ ! -x ~/.cargo/bin/rustc ] && curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
#
#munge_path ~/.cargo/bin
#
#[[ ! "$(rustup show)" =~ nightly\- ]] && rustup install nightly
#
#[[ ! "$(rustup component list --toolchain stable)" =~ rls\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rls --toolchain stable
#[[ ! "$(rustup component list --toolchain stable)" =~ rust\-analysis\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rust-analysis --toolchain stable
#[[ ! "$(rustup component list --toolchain stable)" =~ rust\-src\ \((installed|default)\)* ]] && rustup component add rust-src --toolchain stable
#
#[[ ! "$(rustup component list --toolchain nightly)" =~ rls\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rls --toolchain nightly
#[[ ! "$(rustup component list --toolchain nightly)" =~ rust\-analysis\-[\-_a-z0-9]+\ \((installed|default)\)* ]] && rustup component add rust-analysis --toolchain nightly
#[[ ! "$(rustup component list --toolchain nightly)" =~ rust\-src\ \((installed|default)\)* ]] && rustup component add rust-src --toolchain nightly
#
#cargo_install cargo-tree
#cargo_install cargo-outdated
#cargo_install racer +nightly
#cargo_install rusty-tags
#cargo_install ripgrep
#cargo_install exa
#
#if [ ! -d /usr/local/src/cargo.symlink ]; then
#    mkdir -p /usr/local/src/cargo.symlink
#    cp -r ~/.cargo/* /usr/local/src/cargo.symlink
#fi
#
#if [ ! -d /usr/local/src/rust-analyzer ]; then
#    mkdir -p /usr/local/src/rust-analyzer
#    git clone https://github.com/rust-analyzer/rust-analyzer.git /usr/local/src/rust-analyzer
#
#    cd /usr/local/src/rust-analyzer
#    cargo xtask install --server
#fi

#Go
mkdir -p /usr/local/src/go.symlink
export GOPATH=/usr/local/src/go.symlink

#[ ! -f "/usr/local/src/go.symlink/bin/gometalinter" ] && GOPATH=/usr/local/src/go.symlink go get -u github.com/alecthomas/gometalinter && /usr/local/src/go.symlink/bin/gometalinter --install --update
[ ! -f "/usr/local/src/go.symlink/bin/hey" ] && GOPATH=/usr/local/src/go.symlink go get -u github.com/rakyll/hey
[ ! -f "/usr/local/src/go.symlink/bin/gitbatch" ] && GOPATH=/usr/local/src/go.symlink go get -u github.com/isacikgoz/gitbatch
#[ ! -f "/usr/local/src/go.symlink/bin/vale" ] && GOPATH=/usr/local/src/go.symlink go get -u github.com/errata-ai/vale
[ ! -f "/usr/local/src/go.symlink/bin/gotop" ] && GOPATH=/usr/local/src/go.symlink go get -u github.com/cjbassi/gotop

#vale has since moved from open go code to some abstract rubbish
curl -sfL https://install.goreleaser.com/github.com/ValeLint/vale.sh | sh -s v1.7.1

#gometalinter replaced by golangci-lint which sadly recommends script-based install :'(
if [ ! -f "/usr/local/src/go.symlink/bin/golangci-lint" ]; then
  GOPATH=/usr/local/src/go.symlink curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh| sh -s -- -b /usr/local/src/go.symlink/bin v1.21.0
fi

#Ruby
pkg_install rbenv

#Misc
pkg_install fzf
#pkg_install exa
#pkg_install bat
pkg_install jq
pkg_install gnupg
pkg_install aspell
pkg_install ctags

#Neovim
pkg_install neovim-runtime=0.3.4-3~bpo9+1
pkg_install neovim=0.3.4-3~bpo9+1
pip_install 2 neovim
pip_install 3 neovim --upgrade
pip_install 3 neovim-remote --upgrade
pip_install 3 gitlint
gem_install neovim

if [ ! -d /usr/local/src/dotfiles.symlink/nvim/pack/minpac/opt/minpac ]; then
    git clone https://github.com/k-takata/minpac.git /usr/local/src/dotfiles.symlink/nvim/pack/minpac/opt/minpac
fi

find "/usr/local/src/dotfiles.symlink/nvim/pack/minpac/start" -type f -executable -exec file -i '{}' \; | grep 'application\/x-mach-binary; charset=binary' | sed 's/:\ application\/x-mach-binary;\ charset=binary//g' | xargs -I{} rm -f {}

