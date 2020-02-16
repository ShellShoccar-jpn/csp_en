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

find . -name '*.md'                                                   |
grep -Ev '^\./(README|CONTENTS)\.md$'                                 |
sed 's/^.\///'                                                        |
sed 's/README.md$/-.md/'                                              |
sort                                                                  |
sed 's/-.md$/README.md/'                                              |
while IFS= read -r file; do                                         # #
  export file                                                       # #
  case "$file" in                                                   # #
    *README.md) echo                                                # #
                cat "./$file"                                       | #
                grep '^# '                                          | #
                head -n 1                                           | #
                sed 's/^# //'                                       | #
                awk '{printf("## [%s](%s)\n",$0,ENVIRON["file"]);}'   #
                echo                                                  #
                continue                                              #
                ;;                                                    #
  esac                                                                #
  n=$(grep '^' "./$file" | wc -l | tr -cd '0-9')                      #
  cat "./$file"                                                     | #
  awk -v n=$n '                                                     # #
    /^# / {ttl=substr($0,3);                                        # #
           id=tolower(ttl);                                         # #
           gsub(/ /,"-",id); gsub(/[^a-z0-9_-]/,"",id);             # #
           if (n==1) {                                              # #
             printf("1. %s\n", ttl);                                # #
           } else   {                                               # #
             printf("1. [%s](%s#%s)\n",ttl,ENVIRON["file"],id);     # #
           }                                                        # #
          }                                                         # #
    /^## /{ttl=substr($0,4);                                        # #
           id=tolower(ttl);                                         # #
           gsub(/ /,"-",id); gsub(/[^a-z0-9_-]/,"",id);             # #
           printf("   1. [%s](%s#%s)\n",ttl,ENVIRON["file"],id);    # #
          }                                                         # #
  '                                                                   #
done
