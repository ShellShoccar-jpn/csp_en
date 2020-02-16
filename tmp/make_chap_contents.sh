#!/bin/sh


# === Initialize =====================================================
set -u
umask 0022
export LC_ALL=C
type command >/dev/null 2>&1 &&
type getconf >/dev/null 2>&1 &&
export PATH="$(command -p getconf PATH)${PATH+:}${PATH-}"
export UNIX_STD=2003

ACK=$(printf '\006')


# === Main ===========================================================

find . -name '*.md'                                                |
grep -Fv README.md                                                 |
sed 's/\.\///'                                                     |
sort                                                               |
xargs grep -E '^#{1,2} '                                           |
sed "s/:/$ACK/"                                                    |
awk -F "$ACK" '                                                    #
           {title=$2;sub(/^[^[:blank:]]+[[:blank:]]+/,"",title);}  #
  $2~/^# / {indent="1. ";id="";                                 }  #
  $2~/^## /{indent="   1. ";                                   #   #
            id=tolower(title);                                 #   #
            gsub(/ /,"-",id);                                  #   #
            gsub(/[^a-z0-9_-]/,"",id);                         #   #
            id="#" id;                                          }  #
           {print indent "[" title "](" $1 id ")";              }'
