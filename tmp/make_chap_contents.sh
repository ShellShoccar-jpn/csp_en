#!/bin/sh


# === Initialize =====================================================
set -u
umask 0022
export LC_ALL=C
type command >/dev/null 2>&1 &&
type getconf >/dev/null 2>&1 &&
export PATH="$(command -p getconf PATH)${PATH+:}${PATH-}"
export UNIX_STD=2003


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
# --- 2) Enumerate chap. dirs ----------------------------------------
find . -type d                                                          |
grep -E '^\./[0-9]+$'                                                   |
# --- 3) Chap. loop --------------------------------------------------  #
while read dir_chap; do                                                 #
  # --- 3a) Change to the chap. dir ----------------------------------  #
  cd "${dir_chap}" || {                                                 #
    error_exit 1 "Cannot enter the chap.$dir_chap directory"            #
  }                                                                     #
  # --- 3b) Make sure README.md exists -------------------------------  #
  [ -f 'README.md' ] || continue                                        #
  # --- 3c) Copy the header sections ---------------------------------  #
  cat 'README.md'                                           |           #
  awk '/^## Contents$/{step=1;                          }   #           #
                      {print; if(step==1){print "";exit;}}' >  $Tmp/new #
  # --- 3d) Generate the contents section ----------------------------  #
  find . -name '*.md'                                       |           #
  grep -Fv README.md                                        |           #
  sed 's/^\.\///'                                           |           #
  sort                                                      |           #
  while IFS= read -r file; do                               #           #
    export file                                             #           #
    l=$(grep '^' "./$file" | wc -l | tr -cd '0-9')          #           #
    cat "./$file"                                    |      #           #
    awk -v l=$l '                                    #      #           #
      /^# / {ttl=substr($0,3);                       #      #           #
             id=tolower(ttl);                        #      #           #
             gsub(/ /,"-",id);                       #      #           #
             gsub(/[^a-z0-9_-]/,"",id);              #      #           #
             if (l==1) {                             #      #           #
               printf("1. %s\n", ttl);               #      #           #
             } else   {                              #      #           #
               f=ENVIRON["file"];                    #      #           #
               printf("1. [%s](%s#%s)\n",ttl,f,id);  #      #           #
             }                                       #      #           #
            }                                        #      #           #
      /^## /{ttl=substr($0,4);                       #      #           #
             id=tolower(ttl);                        #      #           #
             gsub(/ /,"-",id);                       #      #           #
             gsub(/[^a-z0-9_-]/,"",id);              #      #           #
             f=ENVIRON["file"];                      #      #           #
             printf("   1. [%s](%s#%s)\n",ttl,f,id); #      #           #
            }                                        #      #           #
    '                                                       #           #
  done                                                      >> $Tmp/new #
  # --- 3e) Copy the footer sections ---------------------------------  #
  cat 'README.md'                                           |           #
  awk '/^## Contents$/ {step=1; next;}                      #           #
       (step==1)&&/^# /{step=2;      }                      #           #
       (step==2)       {print;       }'                     >> $Tmp/new #
  # --- 3f) Update README.md of the chapter --------------------------  #
  cat $Tmp/new > README.md || {                                         #
    error_exit 1 "Cannot update README.md of Chap.$dir_chap"            #
  }                                                                     #
  # --- 3g) Go back to the home dir ----------------------------------  #
  cd .. || error_exit 1 'Cannot return to the Home directory'           #
done


# === Finish =========================================================
exit 0
