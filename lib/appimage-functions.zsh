#!/usr/bin/env zsh

##
## Colors
##

z4::load-colors() {
    typeset -g -A ZINIT
    local ZITHEME=$ZITHEME ZITHEMEFILE
    : ${ZITHEME:=gold}
    : ${ZITHEMEFILE::=$APPDIR/share/themes/$ZITHEME.zsh}
    [[ -f $ZITHEMEFILE ]]&&source $ZITHEMEFILE
    ZINIT+=(
          col-E $'\e[38;5;82m'"▧ "$'\e[1;38;5;57mZ4 \e[1;31mError:\e[0;31m '
          col-W $'\e[38;5;82m'"▧ "$'\e[1;38;5;57mZ4 \e[1;38;5;208mWarning:\e[0;38;5;174m '
          col-I $'\e[38;5;82m'"▧ "$'\e[1;38;5;57mZ4 \e[1;38;5;39mInfo:\e[0;38;5;39m '
          col-S $'\e[38;5;82m'"▧ "$'\e[1;38;5;57mZ4 \e[1;38;5;220mSuccess:\e[0;38;5;69m '
          col-e $'\e[0;31m'
          col-w $'\e[0;38;5;174m'
          col-i $'\e[0;38;5;39m'
          col-s $'\e[0;38;5;69m'
    )
    return 0
}

##
## Options
##

z4::parse-opts()
{
    local AAVAR=$1 AVAR=$2 args=("$@[3,-1]") VARNAME1 VARNAME3
    local -a inopts

    builtin set -- "$args[@]"
    {
        inopts=(-r --run -f --force -v --verbose
                -i --install -e --eval
        )
        builtin zparseopts -D -E -A $AAVAR -a $AVAR -F -- \
                ${inopts[@]#-}||throw IncorrectOpts
        foreach T1 T3 ($inopts)
            VARNAME1=${AAVAR}"[$T1]" VARNAME3=${AAVAR}"[$T3]"
            ((${(P)+VARNAME1}||${(P)+VARNAME3}))&&\
                : ${(P)VARNAME1::=1}
        end
    } always {
        if catch *;then
            builtin print -P %B%F{1}Error:%b incorrect options \
                        detected, exiting
            return 1
        fi
    }
    return 0
}

##
## Messaging. Leading + means: functions operates on stdout.
##

+m(){
    local -a args=("${@//$HOME/~}")
    builtin print -r -u2 -P -- "${args[@]//(#b)\{([^\}]##)\}/\
$ZINIT[col-$match[1]]}$ZINIT[col-rst]"
}

##
## Should install?
##'

z4::install-version-check() {
    local __VERF __CVER __NVER __CDIR_PFX=$1 __DIR=$2
    if [[ -f ${__VERF::=$__CDIR_PFX.git/version.dat} || \
        -f ${__VERF::=$__CDIR_PFX.bin/version.dat}
    ]]
    then
        __CVER=$(<$__VERF)
    else
        __CVER=0.0.0
    fi

    __NVER=$(<$__DIR/version.dat)

    if [[ $__CVER == $__NVER ]];then
        (($+Opts[-v]))&&+m {I}Zinit-4 is already installed \
                        at the same version \
                        {lhi}\({version}$__NVER{lhi}\)
    fi
    reply=("$__CVER" "$__NVER" "$__VERF")
    [[ $__CVER == $__NVER ]]
}

##
## Install to $VERF:h
##

z4::install(){
    local SDIR=$1 NDIR=$2 CAUGHT EXCEPTION
    +m {I}Installing to {dir}$NDIR{i}…
    {
        noglob command rm -rf -- $NDIR:h/zinit.old||\
            throw rm
        if [[ -e $NDIR || -L $NDIR ]];then
            noglob command mv -f -- $NDIR $NDIR:h/zinit.old||\
                throw mv
        fi
        noglob command cp -R -- $SDIR:A $NDIR||\
            throw cp
    } always {
        if catch *;then
            +m {E}${${CAUGHT:+{cmd}$CAUGHT{e} command failed,\
 installation incomplete…}:-unrecognized\
 error occurred during install!}
            exit 1
        fi
    }
}

z4::run(){
    local NDIR=$1 NVER=$2
    local ZDOLD=${ZDOTDIR:-$HOME}
    local -x ZDOTDIR=$CACHE_DIR

    # Touch file
    builtin print -n >>!$ZDOLD/.zsh-plugins.zsh

    # Create .zshrc
    command cat >!$ZDOTDIR/.zshrc <<END
ZDOTDIR=${(qqq)ZDOLD}
typeset -A -g ZINIT
ZINIT[NO_PLGS_SRC]=1
builtin source $ZDOLD/.zshrc
ZINIT[NO_PLGS_SRC]=0
builtin source $NDIR/zinit.zsh
builtin print -r -P %F{39}Started up%B%F{220} =zsh\
        %b%F{39}and loaded %B%F{57}Z4 %b%F{39}at \
        version: %B%F{31}$NVER%b%f
END

    # Run Zsh
    (($+commands[env]))&&local env=env
    command $env zsh -l -i
    +m {I}exited the AppImage \`{cmd}zsh{i}\` \
        run \(exit code: {num}$?{i}\)
}

z4::eval-code(){
    local CDIR=$1 NDIR=$2 NVER=$3 CVER=$4
    local NFILE=$NDIR/zinit.zsh

    command cat <<END
if [[ ! -f $NFILE ]];then
    noglob builtin print -P -- %B%F{1}Error: %F{57}Z4%b%F{1} \
            is not installed. Run the AppImage with -i/--install \
            options first.\\\\n%fYou can also use -e option with -i, i.e.: \
            %F{38}eval \$\(…/z4-$NVER.AppImage -ie\)
    return 1
fi
builtin source ${(qqq)NFILE}
END

}