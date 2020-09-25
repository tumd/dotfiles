# https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc#L2721
# debian stuff
if [[ -r /etc/debian_version ]] ; then
	alias acp='apt-cache policy'
	if (( $+commands[apt] )); then
		alias acs="apt search"
		alias acsh="apt show"
    alias alu="apt list --upgradable"
		alias adg="sudo apt dist-upgrade"
		alias ag="sudo apt upgrade"
		alias agi="sudo apt install"
		alias au="sudo apt update"
	else
		alias acs="apt-cache search"
		alias acsh="apt-cache show"
		alias adg="sudo apt-get dist-upgrade"
		alias ag="sudo apt-get upgrade"
		alias agi="sudo apt-get install"
		alias au="sudo apt-get update"
	fi
fi

# ip aliases
(( $+commands[ip] )) && {
  (( ${terminfo[colors]:-0} >= 8 )) && ip -color -human rule > /dev/null 2> /dev/null && \
      alias ip='ip -color -human'
  alias ip6='ip -6'
  alias ipr='ip -resolve'
  alias ip6r='ip -6 -resolve'
  alias ipm='ip -resolve monitor'
  alias ipb='ip -brief'
  alias ip6b='ip -6 -brief'
}

(( $+commands[openssl] && ! $+commands[http-cert] )) && function http-cert() {
  _hp=("${(@s/:/)${@[1]:-localhost}}")
  echo | openssl s_client -connect "$_hp[1]":"${_hp[2]:-443}" -servername "$_hp[1]" 2>/dev/null | \
    openssl x509 -noout -subject -issuer -dates --ext subjectAltName
  unset '_hp'
}
