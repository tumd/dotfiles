case $TERM in
    *xterm*|ansi)
	function settab { print -Pn "\e]1;%m:%c\a" }
	function settitle { print -Pn "\e]2;%n@%m: %~\a" }
	function preexec { print -Pn "\e]1;%m:$(history $HISTCMD | cut -b7- ) \a" }
	function precmd { settab;settitle }
#		function settab { print -Pn "\e]1;%n@%m\a" }
#		function settitle { print -Pn "\e]2;%n@%m: %~\a" }
#		function chpwd { settab;settitle }
#		settab;settitle
        ;;
esac
