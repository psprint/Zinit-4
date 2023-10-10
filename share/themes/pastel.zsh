# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# Copyright (c) 2016-2023 Sebastian Gniazdowski and contributors.

 ZINIT+=(
    col-annex   $'\e[38;5;57m'         col-faint   $'\e[38;5;238m'         col-msg2    $'\e[38;5;172m'
    col-apo     $'\e[1;38;5;207m'        col-file    $'\e[3;38;5;201m\e[48;5;236m'       col-msg3    $'\e[38;5;238m'
         col-flag    $'\e[1;3;38;5;141m'      col-nb      $'\e[22m'            col-rst     $'\e[0m'
    col-b       $'\e[1m'                col-func    $'\e[38;5;207m'         col-nit     $'\e[23m'            col-slight  $'\e[38;5;230m'
    col-b-lhi   $'\e[1;38;5;141m'     col-glob    $'\e[1;38;5;201m'
     col-nl      $'\n'                col-st      $'\e[9m'
    col-b-warn  $'\e[1;38;5;105m'       col-happy   $'\e[1m\e[38;5;123m'     col-note    $'\e[38;5;82m\e[48;5;235m'
       col-hi      $'\e[1m\e[38;5;45m'    col-nst     $'\e[29m'
        col-ice     $'\e[38;5;123m'          col-nu      $'\e[24m'            col-th-bar  $'\e[38;5;82m'
    col-bar     $'\e[38;5;33m'          col-id-as   $'\e[4;38;5;33m'       col-num     $'\e[3;38;5;207m'    col-time    $'\e[38;5;69m'
         col-info    $'\e[38;5;87m'          col-obj     $'\e[38;5;69m'
    col-bspc    $'\b'                   col-info2   $'\e[38;5;87m'         col-obj2    $'\e[38;5;201m'      col-u       $'\e[4m'
    col-cmd     $'\e[1;3;38;5;123m'          col-info3   $'\e[1m\e[38;5;141m'    col-ok      $'\e[38;5;220m'      col-u-warn  $'\e[4;38;5;214m'
    col-data    $'\e[38;5;87m'          col-it      $'\e[3m'                col-opt     $'\e[38;5;205m'      col-uname   $'\e[1;4m\e[33m'
    col-data2   $'\e[38;5;87m'         col-keyword $'\e[1;38;5;123m'               col-p       $'\e[236;5;141m'
    col-dir     $'\e[3;38;5;141m'       col-lhi     $'\e[38;5;81m'          col-pkg     $'\e[1;3;38;5;123m'   col-url     $'\e[38;5;87m'
    col-ehi     $'\e[1m\e[38;5;69m'    col-meta    $'\e[38;5;141m'          col-pname   $'\e[1;4;32m'     col-var     $'\e[38;5;51m'
    col-error   $'\e[1m\e[38;5;204m'    col-meta2   $'\e[38;5;51m'         col-pre     $'\e[38;5;123m'      col-version $'\e[3;38;5;69m'
         col-msg     $'\e[0m'                col-profile $'\e[38;5;82m\e[48;5;236m'      col-warn    $'\e[38;5;99m'

    col-i $'\e[1;38;5;51m'"==>"$'\e[0m' col-e $'\e[1;38;5;204m'"Error: "$'\e[0m'
    col-m $'\e[1;38;5;87m'"==>"$'\e[0m' col-w $'\e[1;38;5;99m'"Warning: "$'\e[0m'

    col--…   "${${${(M)LANG:#*UTF-8*}:+⋯⋯}:-···}"    col-lr "${${${(M)LANG:#*UTF-8*}:+↔}:-"«-»"}"
    col-ndsh "${${${(M)LANG:#*UTF-8*}:+–}:-}"        col-…  "${${${(M)LANG:#*UTF-8*}:+…}:-...}"

    col-mdsh  $'\e[1;38;5;220m'"${${${(M)LANG:#*UTF-8*}:+–}:--}"$'\e[0m'
    col-mmdsh $'\e[1;38;5;220m'"${${${(M)LANG:#*UTF-8*}:+――}:--}"$'\e[0m'

    col-↔     ${${${(M)LANG:#*UTF-8*}:+$'\e[38;5;82m↔\e[0m'}:-$'\e[38;5;82m«-»\e[0m'}
    col-date $'\e[1;38;5;82m' col-exitcd $'\e[1;38;5;201m'
    col-ref $'\e[1;38;5;208m' col-\$ $'\e[0m'
    col-param $'\e[1;38;5;81m'
)
if [[ -z $SOURCED && ( $+terminfo -eq 1 && \
                        $terminfo[colors] -ge 256) || \
      ( $+termcap -eq 1 && $termcap[Co] -ge 256 ) ]]
then
    ZINIT+=( col-pname $'\e[1;4;38;5;44;3m' col-uname  $'\e[1;4;38;5;141m' )
fi

# vim: ft=zsh sw=4 ts=4 et foldmarker=[[[,]]] foldmethod=marker
