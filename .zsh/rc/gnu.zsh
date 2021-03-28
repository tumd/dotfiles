if [[ $OSTYPE == darwin* ]]; then
  # coreutils
  [[ -d /usr/local/opt/coreutils/libexec/gnubin ]] && path=(/usr/local/opt/coreutils/libexec/gnubin $path)
  [[ -d /usr/local/opt/coreutils/libexec/gnuman ]] && manpath=(/usr/local/opt/coreutils/libexec/gnuman $manpath)
  # tar
  [[ -d /usr/local/opt/gnu-tar/libexec/gnubin ]] && path=(/usr/local/opt/gnu-tar/libexec/gnubin $path)
  [[ -d /usr/local/opt/gnu-tar/libexec/gnuman ]] && manpath=(/usr/local/opt/gnu-tar/libexec/gnuman $manpath)
fi
