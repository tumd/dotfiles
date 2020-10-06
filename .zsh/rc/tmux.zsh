# Automagically update environment variables
# on remote long-running tmux-sessions.
function -update-tmux-environment-preexec {
  emulate -L zsh
  if [[ -n $TMUX ]]; then
    # Avoid running if our SSH_AUTH_SOCK socket already exist
    [[ -n $SSH_AUTH_SOCK && -e $SSH_AUTH_SOCK ]] && return

    # If this is set, we are most likely connected over ssh
    if [[ -n $SSH_CONNECTION || $P9K_SSH == 1 ]]; then
      update-tmux-environment || return
    fi
  fi
}

# Dedicated function that may easily be run manually
# in case the above checks by some reason doesn't apply.
function update-tmux-environment {
  emulate -L zsh
  eval $(tmux show-environment -s)
}

add-zsh-hook -- preexec -update-tmux-environment-preexec || return
