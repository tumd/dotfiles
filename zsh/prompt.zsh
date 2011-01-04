# Git Stuff

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the status of the working tree
git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
if $(echo "$INDEX" | grep '^A ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
if $(echo "$INDEX" | grep '^R ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
echo $STATUS
}

# This could probably be removed.
git_diff_color() {
  changes=$(git status)
  case $changes in
    *Untracked*)
      echo "%{$fg[red]%}"
      return
    ;;;
    
    *updated*)
      echo "%{$fg[red]%}"
      return
    ;;;
    
    *committed*)
      echo "%{$fg[green]%}"
      return
    ;;;
  esac
}


#git_prompt_info() {
#  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#  echo "($(git_diff_color)${ref#refs/heads/}$(host_prompt_color))"
#}

autoload -U colors
colors

# Already in options.zsh
# setopt prompt_subst

# If we're running in an ssh session, use a different colour 
# than if we're on a local machine

host_prompt_color() {
#       if [[ ! -z "$SSH_CLIENT" -o "$(whoami)" = "root" ]]; then
        if [[ "$(whoami)" = "root" ]]; then
                echo "@%m:"
        else
                echo ":"
        fi
}



#host_prompt_color() {
#  case ${SSH_CLIENT} in 
#    [0-9]*)
#      echo "@%m:"
#    ;;;
#    
#    *)
#      echo ":"
#    ;;;
#  esac
#}
##blupp
# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}<%{$fg[white]%}git%{$fg[green]%}:%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}::%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}A"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}M"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}D"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}R"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}U"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?"

user_n_host() {
	if [[ ! -z "$SSH_CLIENT" ]]; then
		echo "%{$fg[white]%}%n@%m:"
	elif [[ "$(whoami)" = "root" ]]; then
		echo "%{$fg[red]%}%n%{$fg[white]%}@%m:"
	else
		echo "%{$fg[white]%}%n:"
	fi
}


#export PROMPT=$'$(host_prompt_color)%n@%m:%~$(git_prompt_info)$ %{$fg[white]%}'
#if [ "$(whoami)" = "root" ]; then NCOLOR="red"; else NCOLOR="white"; fi

PROMPT='$(user_n_host)%{$fg[green]%}%c %(!.#.$)%{$reset_color%} '
RPROMPT='$(git_prompt_info)'
#RPROMPT='[%*]'

# LS colors, made with http://geoff.greer.fm/lscolors/
# BSD
export LSCOLORS="Gxfxcxdxbxegedabagacad"
# Linux
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
