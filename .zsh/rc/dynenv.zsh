# Function to automatically update your environment in all open shells based on 
# the content of the file the symlink ~/.dynenv is pointing at.
function -update-dynamic-environment-preexec() {
  builtin emulate -L zsh -o no_aliases -o no_unset -o err_return -o pipe_fail -o extended_glob

  local _envlink=${ZDOTDIR:-$HOME}/.dynenv

  # Only continue if _envlink exists
  [[ -e $_envlink ]] || return

  # Resolve the symlink to a non-world writable file and return only
  # the suffix after '.dynenv_' in the name.
  local _env=(${_envlink}(#q@-^W:A)(#q:t:s/${_envlink:t}_//))
  if [[ -n $_env && $_env != ${DYNENV:-} ]]; then

    # Debug
    print $(date +%Y%m%d.%H%M%S) $TTY $_envlink $_env >> /tmp/dynenv

    export DYNENV=$_env
    builtin source $_envlink >/dev/null  || return

  fi
  
}

# Uncomment to enable preexec function.
# add-zsh-hook -- preexec -update-dynamic-environment-preexec || return

# TODO: Finish function that sets the ~/.dynenv symlink
function dynenv() {
  emulate -L zsh
  

}
