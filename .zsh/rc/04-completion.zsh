if (( $+commands[kubectl] )); then
  # kubectx and kubens likes to have this set - else it will look in
  # ${XDG_CACHE_HOME:-$HOME/.cache}/.kube/config ?!
  [[ -f "$HOME/.kube/config" ]] && export KUBECONFIG=$HOME/.kube/config
fi

if (( $+functions[complete] )); then
  (( $+commands[vault] )) && complete -o nospace -C vault vault
  (( $+commands[terraform] )) && complete -o nospace -C terraform terraform
fi
