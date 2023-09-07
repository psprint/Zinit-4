#!/usr/bin/env zsh
# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4;-*-

# Copyright (c) 2023 Sebastian Gniazdowski

# Exit code
integer EC

# Set options
emulate -L zsh \
        -o extendedglob \
        -o warncreateglobal -o typesetsilent \
        -o noshortloops -o nopromptsubst \
        -o rcquotes
EC+=$?

# Set $0 with a new trik - use of %x prompt expansion
0=${ZERO:-${(%):-%X}}
[[ -f $0 ]];EC+=$?

zmodload zsh/terminfo zsh/termcap zsh/system zsh/datetime

EC+=$?

# Standard hash `Plugins` for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[ZINIT_DIR]="${0:h:h}"

# Standard work variables
typeset -g -a reply match mbegin mend
typeset -g REPLY MATCH; integer MBEGIN MEND

# Uniquify paths
typeset -gU fpath FPATH path PATH

## Return EC value
return EC
