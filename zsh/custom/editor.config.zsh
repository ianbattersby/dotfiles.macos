export EDITOR='nvim'

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL=$EDITOR
fi

alias vim='nvim'
alias vi='nvim'
alias oldvim='/usr/bin/vim'
alias oldvi='/usr/bin/vi'
alias vimdiff='nvim -d'
