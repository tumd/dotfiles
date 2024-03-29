if [[ $OSTYPE == linux* ]]; then
  # Try use Gnome keyring if no SSH_AUTH_SOCK is set
  [[ ! -S "$SSH_AUTH_SOCK" && -r "${XDG_RUNTIME_DIR:=/run/user/${UID}}/keyring/ssh" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:=/run/user/${UID}}/keyring/ssh"
  # Try use ssh-agent started from systemctl --user
  [[ ! -S "$SSH_AUTH_SOCK" && -r "${XDG_RUNTIME_DIR:=/run/user/${UID}}/openssh_agent" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:=/run/user/${UID}}/openssh_agent"
elif [[ $OSTYPE == darwin* ]]; then
  for _sshf in /private/tmp/com.apple.launchd.*/Listeners; do
    [[ ! -S "$SSH_AUTH_SOCK" && -r "$_sshf" ]] && export SSH_AUTH_SOCK="$_sshf"
    break
  done
  unset _sshf
fi

# Connect with agent-forwarding enabled but using a locked-down SSH
# agent. This assumes the key used to connect to the server will be
# the only one needed.
if (( ! $+commands[assh] )); then
  [[ $OSTYPE == darwin* ]] && [[ -f ${HOME}/.zsh/misc/ssh-askpass ]] && _sap="DISPLAY=ssh-askpass SSH_ASKPASS=${HOME}/.zsh/misc/ssh-askpass "
  alias assh="${_sap:-}ssh-agent ssh -o AddKeysToAgent=confirm -o ForwardAgent=yes"
  unset _sap
fi
