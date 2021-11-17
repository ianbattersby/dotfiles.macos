export HOMEBREW_NO_ANALYTICS=1

function brew_detect() {
    if [[ "$(uname -m)" == "x86_64" ]]; then
        command arch -x86_64 /usr/local/Homebrew/bin/brew "$@"
    else
        command arch -arm64 /opt/homebrew/bin/brew "$@"
    fi
}

alias ibrew='arch -x86_64 /usr/local/Homebrew/bin/brew'
alias abrew='arch -arm64 /opt/homebrew/bin/brew'
alias brew='brew_detect'

export PATH="/opt/homebrew/bin:$PATH"
