bindkey -v

bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word
bindkey "^[[5D" beginning-of-line
bindkey "^[[5C" end-of-line
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey "^S" history-incremental-pattern-search-backward
bindkey "^R" history-incremental-search-backward
bindkey "^T" history-incremental-search-forward
