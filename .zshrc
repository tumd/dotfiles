# Documentation: https://github.com/romkatv/zsh4humans/blob/v3/README.md.

# Export XDG environment variables. Other environment variables are exported later.
export XDG_CACHE_HOME="$HOME/.cache"

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
    curl -fsSL -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$ || return
  else
    wget -O-   -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$ || return
  fi
  mv -- "$Z4H"/z4h.zsh.$$ "$Z4H"/z4h.zsh || return
fi

# Code prior to this line should not assume the current shell is Zsh.
# Afterwards we are in Zsh.
. "$Z4H"/z4h.zsh || return

# 'ask': ask to update; 'no': disable auto-update.
zstyle ':z4h:'                auto-update      ask
# Auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:'                auto-update-days 28
# Stability vs freshness of plugins: stable, testing or dev.
zstyle ':z4h:*'               channel          stable
# Bind alt-arrows or ctrl-arrows to change current directory?
# The other key modifier will be bound to cursor movement by words.
zstyle ':z4h:'                cd-key           ctrl
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char     accept

if (( UID && UID == EUID && ! $#Z4H_SSH )); then
  # When logged in as a regular user and not via `z4h ssh`, check that
  # login shell is zsh and offer to change it if it isn't.
  z4h chsh
fi

zstyle ':z4h:fzf-tab' channel none
# Clone additional Git repositories from GitHub. This doesn't do anything
# apart from cloning the repository and keeping it up-to-date. Cloned
# files can be used after `z4h init`.

z4h install romkatv/archive || return
z4h install chriskempson/base16-shell || return

z4h source $Z4H/chriskempson/base16-shell/base16-shell.plugin.zsh
# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable. Everything
# that requires user interaction or can perform network I/O must be done
# above. Everything else is best done below.
z4h init || return


# Use additional Git repositories pulled in with `z4h install`.
#

fpath=($Z4H/romkatv/archive $fpath)
autoload -Uz archive unarchive lsarchive

# Source additional local files.
if [[ $LC_TERMINAL == iTerm2 ]]; then
  # Enable iTerm2 shell integration (if installed).
  z4h source ~/.iterm2_shell_integration.zsh
fi

# Define key bindings.
bindkey -M emacs '^H' backward-kill-word # Ctrl-H and Ctrl-Backspace: Delete previous word.

# Sort completion candidates when pressing Tab?
zstyle ':completion:*'                           sort               false
# Should cursor go to the end when Up/Down/Ctrl-Up/Ctrl-Down fetches a command from history?
zstyle ':zle:(up|down)-line-or-beginning-search' leave-cursor       yes
# When presented with the list of choices upon hitting Tab, accept selection and
# trigger another completion with this key binding. Great for completing file paths.
zstyle ':fzf-tab:*'                              continuous-trigger tab

# ZSH dir
ZSH=${ZSH:-${ZDOTDIR:-$HOME}/.zsh}

() {
    for config_file ($ZSH/rc/*.zsh) z4h source $config_file
}
