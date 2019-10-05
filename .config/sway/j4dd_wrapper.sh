#!/bin/bash
# https://github.com/enkore/j4-dmenu-desktop/issues/48#issuecomment-493730345
export SHELL="${HOME}/.config/sway/fake_dmenu_shell.sh"
cmd=$(j4-dmenu-desktop --dmenu="fzf" --term="termite" | sed -n 2p)
[[ -n "$cmd" ]] && swaymsg exec "$cmd"
