export HOMEBREW_NO_ANALYTICS=1

alias ibrew='arch -x86_64 /usr/local/Homebrew/bin/brew'
alias abrew='arch -arm64 /opt/Homebrew/bin/brew'
alias brew='abrew'

export PATH="/opt/Homebrew/bin:$PATH"
