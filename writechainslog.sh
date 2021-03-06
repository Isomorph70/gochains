#!/bin/bash

#env >/tmp/wcl-env.txt
[ -f ~/.bashrc ] && . ~/.bashrc # since mate don't read this file and put definition in the enviroment

(/bin/date +'%F%n%T' ; printf '%s\n%s\n' $1 $2) | xargs -n4 printf '%s\t%s\t%s\t%s\n' >>$GOCHAINSDATA/chains.log

. $GOCHAINSPATH/update_display.sh
. $GOCHAINSPATH/update_icon.sh $1 $2
