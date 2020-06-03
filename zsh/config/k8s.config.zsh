alias k='kubectl'

alias kg='kubectl get'
alias ksysg='kubectl --namespace=kube-system get'
alias kgpo='kubectl get pod'
alias ksysgpo='kubectl --namespace=kube-system get pod'

alias ka='kubectl apply --recursive -f'
alias ksysa='kubectl --namespace=kube-system apply --recursive -f'

alias klo='kubectl logs -f'
alias ksyslo='kubectl --namespace=kube-system logs -f'
alias kls='kubectl logs --namespace spinnaker --tail=20 -f'

alias kp='kubectl proxy'

alias kd='kubectl describe'
alias ksysd='kubectl --namespace=kube-system describe'

alias kgdep='kubectl get deployment'
alias ksysgdep='kubectl --namespace=kube-system get deployment'
alias kddep='kubectl describe deployment'
alias ksysddep='kubectl --namespace=kube-system describe deployment'

alias kgsvc='kubectl get service'
alias ksysgsvc='kubectl --namespace=kube-system get service'
alias kdsvc='kubectl describe service'
alias ksysdsvc='kubectl --namespace=kube-system describe service'

alias kging='kubectl get ingress'
alias ksysging='kubectl --namespace=kube-system get ingress'
alias kding='kubectl describe ingress'
alias ksysding='kubectl --namespace=kube-system describe ingress'

alias kgno='kubectl get nodes'
alias kdno='kubectl describe nodes'

alias kgns='kubectl get namespaces'
alias kdns='kubectl describe namespaces'

alias kgall='kubectl get --all-namespaces'
alias kdall='kubectl describe --all-namespaces'
alias kgpoall='kubectl get pods --all-namespaces'
alias kdpoall='kubectl describe pods --all-namespaces'
alias kgdepall='kubectl get deployment --all-namespaces'
alias kddepall='kubectl describe deployment --all-namespaces'
alias kgsvcall='kubectl get service --all-namespaces'
alias kdsvcall='kubectl describe service --all-namespaces'
alias kgingall='kubectl get ingress --all-namespaces'
alias kdingall='kubectl describe ingress --all-namespaces'
