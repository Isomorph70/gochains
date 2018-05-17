#!/bin/bash

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
