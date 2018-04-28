#!/bin/bash
[ -f ~/.bashrc ] && . ~/.bashrc # since mate don't read this file and put definition in the enviroment

/usr/bin/ruby21 -C$GOCHAINSPATH today.rb <$GOCHAINSDATA/chains.ct
