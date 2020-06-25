# Add curl from homebrew to path if it exists
[[ -d /usr/local/opt/curl/bin ]] && path=(/usr/local/opt/curl/bin $path)
[[ -d /usr/local/opt/curl/share/zsh/site-functions ]] && fpath=(/usr/local/opt/curl/share/zsh/site-functions $fpath)
