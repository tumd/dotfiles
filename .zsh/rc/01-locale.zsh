# -*- sh -*-
# https://github.com/vincentbernat/zshrc/blob/master/rc/01-locale.zsh

(( $+commands[locale] )) && () {
    local available
    local locales
    local locale
    locales=( "LANG sv_SE.utf8 sv_SE.UTF-8 en_US.utf8 en_US.UTF-8 C.utf8 C.UTF-8 C" \
	      "LC_MESSAGES en_US.utf8 en_US.UTF-8 sv_SE.utf8 sv_SE.UTF-8 C.utf8 C.UTF-8 C"
	      "LC_NUMERIC en_US.utf8 en_US.UTF-8 C.utf8 C.UTF-8 C" )
    available=("${(f)$(locale -a)}")
    for locale in $locales; do
	for l in $=locale[(w)2,-1]; do
            if (( ${available[(i)$l]} <= ${#available} )); then
		export $locale[(w)1]=$l
		break
	    fi
	done
    done
    export LC_CTYPE=$LANG
    unset LC_ALL
} 2> /dev/null
