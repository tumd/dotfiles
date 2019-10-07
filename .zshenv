# ~/.zshenv

# language settings (read in /etc/environment before /etc/default/locale as
# the latter one is the default on Debian nowadays)
# no xsource() here because it's only created in zshrc! (which is good)
[[ -r /etc/environment ]] && source /etc/environment

[[ -r /etc/profile ]] && source /etc/profile

[[ -r ~/.profile ]] && source ~/.profile

[[ -r ~/.zshenv.local ]] && source ~/.zshenv.local

[[ -r ~/.zpath ]] && source ~/.zpath

if [[ -d "$HOME/bin" ]]; then
  PATH="$HOME/bin:$PATH"
fi

# Used by pipenv (and other?)
if [[ -d "$HOME/.local/bin" ]]; then
  PATH="$HOME/.local/bin:$PATH"
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
