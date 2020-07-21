# Documentation: https://github.com/romkatv/zsh4humans/blob/v3/README.md.

# 'ask': ask to update; 'no': disable auto-update.
zstyle ':z4h:'                auto-update      ask
# Auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:'                auto-update-days 28
# Stability vs freshness of plugins: stable, testing or dev.
zstyle ':z4h:*'               channel          stable
# Bind alt-arrows or ctrl-arrows to change current directory?
# The other key modifier will be bound to cursor movement by words.
zstyle ':z4h:'                cd-key           alt
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char     accept

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
bindkey '^H'   z4h-backward-kill-word   # Ctrl+H and Ctrl+Backspace: Delete previous word.
bindkey '^[^H' z4h-backward-kill-zword  # Ctrl+Alt+Backspace: Delete previous shell word.

# Sort completion candidates when pressing Tab?
zstyle ':completion:*'                           sort               false
# Should cursor go to the end when Up/Down/Ctrl-Up/Ctrl-Down fetches a command from history?
zstyle ':zle:(up|down)-line-or-beginning-search' leave-cursor       yes
# When presented with the list of choices upon hitting Tab, accept selection and
# trigger another completion with this key binding. Great for completing file paths.
zstyle ':fzf-tab:*'                              continuous-trigger tab

() {
  for config_file ($HOME/.zsh/rc/*.zsh) z4h source $config_file
}

fpath=($HOME/.zsh/completions $fpath)
z4h source "$HOME/.zshrc.$HOST" || true
