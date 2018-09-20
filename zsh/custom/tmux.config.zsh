alias tm='tmux attach -t base || (tmux -2 new-session -d -s `basename $USER`; tmux rename-window -t `basename $USER`:1 terminal; tmux attach -t `basename $USER`)'
