#!/bin/bash

cd $GOCHAINSPATH
erb ./log2svg.erb <$GOCHAINSDATA/chains.log >$GOCHAINSDATA/display_icons.d/chains.svg
