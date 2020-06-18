if (( $+commands[kubectl] )); then
    __KUBECTL_COMPLETION_FILE="${Z4H}/cache/kubectl_completion"

    if [[ ! -f $__KUBECTL_COMPLETION_FILE ]]; then
        kubectl completion zsh >! $__KUBECTL_COMPLETION_FILE
    fi

    [[ -f $__KUBECTL_COMPLETION_FILE ]] && z4h source $__KUBECTL_COMPLETION_FILE

    unset __KUBECTL_COMPLETION_FILE
fi

if (( $+commands[helm] )); then
    __HELM_COMPLETION_FILE="${Z4H}/cache/helm_completion"

    if [[ ! -f $__HELM_COMPLETION_FILE ]]; then
        helm completion zsh >! $__HELM_COMPLETION_FILE
    fi

    [[ -f $__HELM_COMPLETION_FILE ]] && z4h source $__HELM_COMPLETION_FILE

    unset __HELM_COMPLETION_FILE
fi

if (( $+functions[complete] )); then
  (( $+commands[vault] )) && complete -o nospace -C vault vault
  (( $+commands[terraform] )) && complete -o nospace -C terraform terraform
fi
