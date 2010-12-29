system_name=`uname -a`

fpath=(~/.dotfiles/zsh/functions $fpath)

#for config_file (~/.dotfiles/zsh/*.zsh) source $config_file

#source ~/.dotfiles/zsh/prompt.zsh
#source ~/.dotfiles/zsh/title.zsh
#source ~/.dotfiles/zsh/misc.zsh
#source ~/.dotfiles/zsh/history.zsh
#
autoload -U ~/.dotfiles/zsh/functions/*(:t)


alias g='git'
alias nano='nano -wK'

# cdpath=(~ ~/Projects/apps ~/Projects/tools ~/Projects/plugins ~/Projects/sites)


# Load vendor specific scripts

case $system_name in
  Darwin*)
    source ~/.dotfiles/zsh/osx/osx.zsh
    ;;
  *)
    source ~/.dotfiles/zsh/linux/linux.zsh
    ;;;
esac

#source ~/.dotfiles/zsh/completion.zsh
