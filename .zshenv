# Documentation: https://github.com/romkatv/zsh4humans/blob/v3/README.md.
#
# Do not modify this file unless you know exactly what you are doing.
# Keep all shell customization and configuration (including exported
# environment variables such as PATH) in ~/.zshrc or in files sourced
# from ~/.zshrc.

if [ -n "${ZSH_VERSION-}" ]; then
  : ${ZDOTDIR:=~}
  setopt no_global_rcs
  if [[ -o no_interactive && -z "${Z4H_BOOTSTRAPPING-}" ]]; then
    return
  fi
  setopt no_rcs
  unset Z4H_BOOTSTRAPPING

  # If you are certain that you must export some environment variables
  # in .zshenv (see comments at the top!), do it here:
  #
  #   export GOPATH=$HOME/go
fi

# URL of zsh4humans repository. Used during initial installation and updates.
Z4H_URL="https://raw.githubusercontent.com/romkatv/zsh4humans/v3"

# Cache directory. Gets recreated if deleted. If already set, must not be changed.
: "${Z4H:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh4humans/v3}"

# Do not create world-writable files by default.
umask o-w

# Fetch z4h.zsh if it doesn't exist yet.
if [ ! -e "$Z4H"/z4h.zsh ]; then
  mkdir -p -- "$Z4H" || return
  >&2 printf '\033[33mz4h\033[0m: fetching \033[4mz4h.zsh\033[0m\n'
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$ || return
  elif command -v wget >/dev/null 2>&1; then
    wget -O-   -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$ || return
  else
    >&2 printf '\033[33mz4h\033[0m: please install \033[32mcurl\033[0m or \033[32mwget\033[0m\n'
    return 1
  fi
  mv -- "$Z4H"/z4h.zsh.$$ "$Z4H"/z4h.zsh || return
fi

# Code prior to this line should not assume the current shell is Zsh.
# Afterwards we are in Zsh.
. "$Z4H"/z4h.zsh || return

setopt rcs

