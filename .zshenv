# ~/.zshenv

# language settings (read in /etc/environment before /etc/default/locale as
# the latter one is the default on Debian nowadays)
# no xsource() here because it's only created in zshrc! (which is good)
[[ -r /etc/environment ]] && source /etc/environment

[[ -r /etc/profile ]] && source /etc/profile

[[ -r ~/.profile ]] && source ~/.profile

[[ -r ~/.zshenv.local ]] && source ~/.zshenv.local

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use $SHLVL to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
# is only sourced if we are a login shell).
# https://github.com/zsh-users/zsh/blob/master/StartupFiles/zshenv
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    [[ -r ~/.zpath ]] && source ~/.zpath

    if [[ -d "$HOME/bin" ]]; then
      PATH="$HOME/bin:$PATH"
    fi

    # Used by pipenv (and other?)
    if [[ -d "$HOME/.local/bin" ]]; then
      PATH="$HOME/.local/bin:$PATH"
    fi

fi

# Other environment variables
export LANG=sv_SE.UTF-8
# Messages in english
export LC_MESSAGES=en_US.UTF-8

export HISTSIZE=
export HISTFILESIZE=
export LESS=-MRXiF
export LESSCHARSET=utf-8
export SYSTEMD_LESS=-MRXiF
export TERM=xterm-256color
