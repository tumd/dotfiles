#!/bin/bash
# https://github.com/enkore/j4-dmenu-desktop/issues/48#issuecomment-493730345
function run_dmenu {
    while test $# -gt 0; do
        [[ $1 == fzf ]] && return 0
        shift
    done
    return 1
}
if run_dmenu $*; then
    SHELL=/bin/bash exec /bin/bash "$@"
else
    shift
    [[ $1 == -c ]] && shift
    exec echo "$@"
fi
