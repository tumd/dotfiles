if [ -n "${ZSH_VERSION-}" ]; then
  : ${ZDOTDIR:=~}
  setopt no_global_rcs
  if [[ -o no_interactive && -z "${Z4H_BOOTSTRAPPING-}" ]]; then
    return
  fi
  setopt no_rcs
  unset Z4H_BOOTSTRAPPING
fi

# URL of zsh4humans repository. Used during initial installation and updates.
Z4H_URL="https://raw.githubusercontent.com/romkatv/zsh4humans/v3"

# Cache directory. Gets recreated if deleted. If already set, must not be changed.
: "${Z4H:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh4humans}"

# Do not create world-writable files by default.
umask o-w

# Fetch z4h.zsh if it doesn't exist yet.
if [ ! -e "$Z4H"/z4h.zsh ]; then
  mkdir -p -- "$Z4H" || return
  >&2 printf '\033[33mz4h\033[0m: fetching \033[4mz4h.zsh\033[0m\n'
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$  || return
  elif command -v wget >/dev/null 2>&1; then
    wget -O-   -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$  || return
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

