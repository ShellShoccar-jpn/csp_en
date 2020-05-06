#!/bin/sh


# === Initialize =====================================================
set -u
umask 0022
export LC_ALL=C
export PATH="$(command -p getconf PATH 2>/dev/null)${PATH+:}${PATH-}"
case $PATH in :*) PATH=${PATH#?};; esac
export UNIX_STD=2003  # to make HP-UX conform to POSIX


# === Other Settings =================================================
print_usage_exit() {
  echo "Usage: ${0##*/} start" 1>&2
  exit 1
}
Homedir=$(d=${0%/*}/; [ "_$d" = "_$0/" ] && d='./'; cd "$d.."; pwd)
PATH="${Homedir}/tmp:${PATH}"
exit_trap() {
  set -- ${1:-} $?  # $? is set as $1 if no argument given
  trap - EXIT HUP INT QUIT PIPE ALRM TERM
  [ -d "${Tmp:-}" ] && rm -rf "${Tmp%/*}/_${Tmp##*/_}"
  exit $1
}
trap 'exit_trap' EXIT HUP INT QUIT PIPE ALRM TERM
error_exit() {
  ${2+:} false && echo "${0##*/}: $2" 1>&2
  exit_trap ${1:-0}
}
Tmp=`mktemp -d -t "_${0##*/}.$$.XXXXXXXXXXXX"` || {
  error_exit 1 "Can't make a temporary directory"
}


# === Parse Agruments ================================================
case $# in       1) :;; *) print_usage_exit;; esac
case $1 in 'start') :;; *) print_usage_exit;; esac


# === Main ===========================================================
# --- 1) Change to the home dir --------------------------------------
cd "${Homedir}" || error_exit 1 'Cannot enter the Home directory'
# --- 2) Make sure CONTENTS.md exists --------------------------------
[ -f 'CONTENTS.md' ] || error_exit 1 'CONTENTS.md does not exist'
# --- 3) Copy the header sections ------------------------------------
cat 'CONTENTS.md'                                                    |
awk '/^## .*Chapter [0-9]+\./{exit; }                                #
                             {print;}'                               >  $Tmp/new
# --- 4) Generate the contents section -------------------------------
n=0                                                                  #
find . -name '*.md'                                                  |
grep -Ev '^\./(README|CONTENTS)\.md$'                                |
sed 's/^\.\///'                                                      |
sed 's/README.md$/-.md/'                                             |
sort                                                                 |
sed 's/-.md$/README.md/'                                             |
while IFS= read -r file; do                                          #
  n=$((n+1))                                                         #
  export file                                                        #
  case "$file" in                                                    #
    *README.md) case $n in 1) :;; *) echo;; esac                     #
                cat "./$file"                                     |  #
                grep '^# '                                        |  #
                head -n 1                                         |  #
                sed 's/^# //'                                     |  #
                awk '{s=ENVIRON["file"]; sub(/\/[^\/]+$/,"",s);   #  #
                      printf("## [%s](%s)\n",$0,s);            }'    #
                echo                                                 #
                continue                                             #
                ;;                                                   #
  esac                                                               #
  l=$(grep '^' "./$file" | wc -l | tr -cd '0-9')                     #
  cat "./$file"                                                  |   #
  awk -v l=$l '                                                  #   #
    /^# / {ttl=substr($0,3);                                     #   #
           id=tolower(ttl);                                      #   #
           gsub(/ /,"-",id); gsub(/[^a-z0-9_-]/,"",id);          #   #
           if (l==1) {                                           #   #
             printf("1. %s\n", ttl);                             #   #
           } else   {                                            #   #
             printf("1. [%s](%s#%s)\n",ttl,ENVIRON["file"],id);  #   #
           }                                                     #   #
          }                                                      #   #
    /^## /{ttl=substr($0,4);                                     #   #
           id=tolower(ttl);                                      #   #
           gsub(/ /,"-",id); gsub(/[^a-z0-9_-]/,"",id);          #   #
           printf("   1. [%s](%s#%s)\n",ttl,ENVIRON["file"],id); #   #
          }                                                      #   #
  '                                                                  #
done                                                                 >> $Tmp/new
# --- 5) Copy the footer sections ------------------------------------
  cat 'CONTENTS.md'                                                  |
  awk '/^## .*Chapter [0-9]+\./                      {stp=1; next;}  #
       (stp==1)&&$0!~/^## .*Chapter [0-9]+\./&&/^## /{stp=2;      }  #
       (stp==2)                                      {print;      }' >> $Tmp/new
# --- 3f) Update CONTENTS.mdr ----------------------------------------
cat $Tmp/new > CONTENTS.md || {
  error_exit 1 "Cannot update CONTENTS.md"
}


# === Finish =========================================================
exit 0
