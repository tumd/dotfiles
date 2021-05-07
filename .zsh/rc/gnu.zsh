if [[ $OSTYPE == darwin* ]]; then
  # coreutils
  [[ -d "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin" ]] &&    path=("${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin" $path)
  [[ -d "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman" ]] && manpath=("${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman" $manpath)
  # tar
  [[ -d "${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin" ]] &&      path=("${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin" $path)
  [[ -d "${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnuman" ]] &&   manpath=("${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnuman" $manpath)
fi
