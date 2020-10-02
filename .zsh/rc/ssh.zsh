if [[ $OSTYPE == linux* ]]; then
  # Try use Gnome keyring if no SSH_AUTH_SOCK is set
  [[ ! -S "$SSH_AUTH_SOCK" && -r "${XDG_RUNTIME_DIR:=/run/user/${UID}}/keyring/ssh" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:=/run/user/${UID}}/keyring/ssh"
  # Try use ssh-agent started from systemctl --user
  [[ ! -S "$SSH_AUTH_SOCK" && -r "${XDG_RUNTIME_DIR:=/run/user/${UID}}/openssh_agent" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:=/run/user/${UID}}/openssh_agent"
fi

# https://github.com/vincentbernat/zshrc/blob/master/rc/ssh.zsh
ssh() {

    # TERM is one of the variables that is usually allowed to be
    # transmitted to the remote session. The remote host should have
    # the appropriate termcap or terminfo file to handle the TERM you
    # provided. When connecting to random hosts, this may not be the
    # case if your TERM is somewhat special. A good fallback is
    # xterm. Most terminals are compatible with xterm and all hosts
    # have a termcap or terminfo file to handle xterm. Therefore, for
    # some values of TERM, we fallback to xterm.
    #
    # Now, you may connect to a host where your current TERM is fully
    # supported and you will get xterm instead (which means 8 base
    # colors only). There is no clean solution for this. You may want
    # to reexport the appropriate TERM when logged on the remote host
    # or use commands like this:
    #     ssh -t XXXXX env TERM=$TERM emacsclient -t -c
    #
    # If the remote host uses the same zshrc than this one, there is
    # something in `$ZSH/rc/00-terminfo.zsh` to restore the
    # appropriate terminal (saved in `LC__ORIGINALTERM`).
    #
    # The problem is quite similar for LANG and LC_MESSAGES. We reset
    # them to C to avoid any problem with hosts not having your
    # locally installed locales. See this post for more details on
    # this:
    #    http://vincent.bernat.im/en/blog/2011-zsh-zshrc.html
    #
    # Also, when the same ZSH configuration is used on the remote
    # host, the locale is reset with the help of
    # `$ZSH/rc/01-locale.zsh`.
    case "$TERM" in
	*-*)
	    #LC__ORIGINALTERM=$TERM TERM=${TERM%%-*} LANG=C LC_MESSAGES=C command ssh $extra "$@"
	    LC__ORIGINALTERM=$TERM LANG=C LC_MESSAGES=C command ssh $extra "$@"
	    ;;
	*)
	    LANG=C LC_MESSAGES=C command ssh $extra "$@"
	    ;;
    esac
}

# Connect with agent-forwarding enabled but using a locked-down SSH
# agent. This assumes the key used to connect to the server will be
# the only one needed.
[[ $OSTYPE == darwin* ]] && _sap="SSH_ASKPASS=${HOME}/.zsh/misc/ssh-askpass "
(( ! $+commands[assh] )) && alias assh="${_sap:-}ssh-agent ssh -o AddKeysToAgent=confirm -o ForwardAgent=yes"
