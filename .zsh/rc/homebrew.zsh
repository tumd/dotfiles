# Add curl from homebrew to path if it exists
[[ -d "${HOMEBREW_PREFIX}/opt/curl/bin" ]] && path=("${HOMEBREW_PREFIX}/opt/curl/bin" $path)
[[ -d "${HOMEBREW_PREFIX}/opt/curl/share/zsh/site-functions" ]] && fpath=("${HOMEBREW_PREFIX}/opt/curl/share/zsh/site-functions" $fpath)
[[ -d "${HOMEBREW_PREFIX}/opt/curl/share/man" ]] && manpath=("${HOMEBREW_PREFIX}/opt/curl/share/man" $manpath)
