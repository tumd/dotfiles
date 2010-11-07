# OS X specific settings

export PATH=~/.homebrew/bin:~/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
export SVN_EDITOR='mate -w'
export GIT_EDITOR='mate -wl1'
export EDITOR='mate'
export GEM_OPEN_EDITOR='mate'
export LESSEDIT='mate -l %lm %f'

# Use OS X version of SSH with agent forwarding
alias ssh='/usr/bin/ssh -A'
alias scp='/usr/bin/scp'
alias sftp='/usr/bin/sftp'

alias ls='ls -ahGl'

# Load OSX specifi functions
fpath=(~/.dotfiles/zsh/osx/functions $fpath)
autoload -U ~/.dotfiles/zsh/osx/functions/*(:t)

localhost() {
  sudo dscl localhost -create /Local/Default/Hosts/$1 IPAddress 127.0.0.1
  echo "Added $1 at address 127.0.0.1"
}

case $OSTYPE in
  darwin10*)
		export ARCHFLAGS="-arch x86_64"
  ;;;
esac

ulimit -n 4096