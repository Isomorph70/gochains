#!/bin/bash

#env >/tmp/wcl-env.txt
[ -f ~/.bashrc ] && . ~/.bashrc # since mate don't read this file and put definition in the enviroment

cd $GOCHAINSPATH

(/bin/date +'%F%n%T' ; printf '%s\n%s\n' $1 $2) | xargs -n4 printf '%s\t%s\t%s\t%s\n' >>$GOCHAINSDATA/chains.log

erb ./log2svg.erb <$GOCHAINSDATA/chains.log >$GOCHAINSDATA/display_icons.d/chains.svg

COLOR='blue'
case $2 in
	0)
	COLOR='red'
	;;
	1)
	COLOR='green'
	;;
esac

PATTERN=$(printf 's/\(stop-color=\"\)\(.*\"\)/\\1%s\"/' $COLOR)
cat $GOCHAINSDATA/type_icons.d/$1_*.svg | sed -e $PATTERN >$GOCHAINSDATA/display_icons.d/$1.svg
