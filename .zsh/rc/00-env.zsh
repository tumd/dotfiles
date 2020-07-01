# Logout ttyX after inactiviry
if [[ $(tty) =~ /dev\/tty[1-6] ]]; then TMOUT=1800; fi

# Load defaults
[[ -f /etc/profile    ]] && source /etc/profile
# Extend PATH.
[[ -d /usr/local/sbin ]] && path=(/usr/local/sbin $path)
[[ -d ~/.local/bin    ]] && path=(~/.local/bin $path)
[[ -d ~/bin           ]] && path=(~/bin $path)

# Use vim
export EDITOR='vim'

export GPG_TTY=$TTY

# Setting up less colors
# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
# termcap terminfo
# ks      smkx      make the keypad send commands
# ke      rmkx      make the keypad send digits
# vb      flash     emit visual bell
# mb      blink     start blink
# md      bold      start bold
# me      sgr0      turn off bold, blink and underline
# so      smso      start standout (reverse video)
# se      rmso      stop standout
# us      smul      start underline
# ue      rmul      stop underline
(( ${terminfo[colors]:-0} >= 8 )) && {
  export LESS_TERMCAP_mb=$(tput blink; tput setaf 1) # red
  export LESS_TERMCAP_md=$(tput bold; tput setaf 1) # red
  export LESS_TERMCAP_so="$(tput bold; tput setaf 3; tput setab 4)" # yellow on blue
  export LESS_TERMCAP_us=$(tput smul; tput setaf 2) # green
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_me=$'\E[0m'
}