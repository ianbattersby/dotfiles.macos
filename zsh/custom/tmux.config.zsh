exit() {
    if [[ -z $TMUX ]]; then
        builtin exit
        return
    fi

    nr=$(tmux list-panes | wc -l)
    if [ $count = eq 1 ]; then
        tmux detach
    else
        builtin exit
    fi
}

alias tm='tmux attach -t base || (tmux -2 new-session -d -s `basename $USER`; tmux rename-window -t `basename $USER`:1 terminal; tmux attach -t `basename $USER`)'

export ZSH_TMUX_TERM=xterm-256color
