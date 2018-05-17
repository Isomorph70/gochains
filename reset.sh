#!/bin/bash

#env >/tmp/wcl-env.txt
[ -f ~/.bashrc ] && . ~/.bashrc # since mate don't read this file and put definition in the enviroment

. $GOCHAINSPATH/update_display.sh
/usr/bin/ruby21 -C$GOCHAINSPATH log2status.rb <$GOCHAINSDATA/chains.log | xargs -n 2 $GOCHAINSPATH/update_icon.sh
