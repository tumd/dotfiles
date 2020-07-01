(( $+commands[keychain] )) || return

command keychain --inherit any-once --systemd --nogui -q --agents ssh,gpg --noask || return
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        source $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        source $HOME/.keychain/$HOSTNAME-sh-gpg
