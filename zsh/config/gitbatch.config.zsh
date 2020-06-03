function most_recent_branches() {
    git for-each-ref \
        --format="%(refname:short)" \
        --count=5 \
        --sort=-committerdate \
        refs/heads/
}

alias gbrcnt='most_recent_branches'
alias gbat='gitbatch -d ~/code -r 1'
