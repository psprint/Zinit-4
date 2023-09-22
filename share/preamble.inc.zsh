#!/usr/bin/env zsh
# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4;-*-

# Copyright (c) 2023 Sebastian Gniazdowski

# Exit code
integer ERCD

# Set options
emulate -L zsh \
        -o extendedglob \
        -o warncreateglobal -o typesetsilent \
        -o noshortloops -o nopromptsubst \
        -o rcquotes
ERCD+=$?

# Set $0 with a new trik - use of %x prompt expansion
0=${${ZERO:-${(%):-%x}}:A}
[[ -f $0 ]];ERCD+=$?

zmodload zsh/terminfo zsh/termcap zsh/system zsh/datetime

ERCD+=$?

# Standard hash `Plugins` for plugins, to not pollute the namespace
typeset -A -g Plugins
Plugins[ZINIT_DIR]=$0:h:h
[[ -d $Plugins[ZINIT_DIR] ]]||\
    {ERDC+=1;Plugins[ZINIT_DIR]='<unlocated>';}

# Standard work variables
typeset -g -a reply match mbegin mend
typeset -g REPLY MATCH; integer MBEGIN MEND

# Uniquify paths
typeset -gU fpath FPATH path PATH

## Return ERCD value
return ERCD
