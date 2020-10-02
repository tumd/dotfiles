# Documentation: https://github.com/romkatv/zsh4humans/blob/v3/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
zstyle ':z4h:'                auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:'                auto-update-days '28'
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char     'accept'
# End key accepts to the end of the line ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' end-of-line      'accept'
# Send these files over to the remote host when using `z4h ssh`.
zstyle ':z4h:ssh:*'           send-extra-files '~/.zsh/rc'

# Disable fzf-tab
zstyle ':z4h:fzf-tab' channel none

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
#z4h install ohmyzsh/ohmyzsh || return

z4h install romkatv/archive || return
z4h install chriskempson/base16-shell || return

# Placed here because the scripts from base16-shell sometimes produce output.
z4h source $Z4H/chriskempson/base16-shell/base16-shell.plugin.zsh

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return


# Use additional Git repositories pulled in with `z4h install`.
#

fpath=($Z4H/romkatv/archive $fpath)
autoload -Uz archive unarchive lsarchive

# Source additional local files if they exist.
if [[ $LC_TERMINAL == iTerm2 ]]; then
  # Enable iTerm2 shell integration (if installed).
  z4h source ~/.iterm2_shell_integration.zsh
fi

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

# Sort completion candidates when pressing Tab?
zstyle ':completion:*'                      sort               false
# Keep cursor position unchanged when Up/Down fetches a command from history?
zstyle ':zle:up-line-or-beginning-search'   leave-cursor       true
zstyle ':zle:down-line-or-beginning-search' leave-cursor       true
# When presented with the list of choices upon hitting Tab, accept selection
# and trigger another completion with this key binding.
zstyle ':fzf-tab:*'                         continuous-trigger tab

() {
  for config_file ($HOME/.zsh/rc/*.zsh) z4h source $config_file
}

fpath=($HOME/.zsh/completions $fpath)
z4h source "$HOME/.zshrc.$HOST" || true
