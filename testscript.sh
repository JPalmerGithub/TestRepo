#! /bin/bash

# "/root/filecount/ninjapayments-pre_integration"

NOCOLOR="\033[0m"
RED="\033[0;31m"
REDBOLD="\033[1;31m"
GREEN="\033[0;32m"
GREENBOLD="\033[1;32m"
YELLOW="\033[0;33m"
YELLOWBOLD="\033[1;33m"
BLUE="\033[0;34m"
BLUEBOLD="\033[1;34m"
PURPLE="\033[0;35m"
PURPLEBOLD="\033[1;35m"
CYAN="\033[0;36m"
CYANBOLD="\033[1;36m"
WHITE="\033[0;37m"
WHITEBOLD="\033[1;37m"
DARKGRAY="\033[0;90m"


if [[ $# -lt 1 ]]; then
      echo
      echo "USAGE: $0 directory"
      echo "ERROR: not enough arguments supplied"
      echo
      exit 1
elif [[ $# -gt 1 ]]; then
      echo
      echo "USAGE: $0 directory"
      echo "ERROR: too many arguments supplied"
      echo
      exit 1
elif [[ ! -d $1 ]]; then
      echo
      echo "USAGE: $0 directory"
      echo "ERROR: The directory \"$1\" does not exist ..."
      echo
      exit 1
fi

DIRECTORY="${1}"

EXTENSIONS=`find "${DIRECTORY}" ! -name '.gitattributes'  ! -name '.gitignore'  -type f -exec basename '{}' \;  |awk -F . '{print $NF}' | sort | uniq`

pnumber='           '
xnumber='   '
lnumber='       '
cnumber='        '
totfiles='        '
totlines='        '
totchars='        '

TOTALFILES=0
TOTALLINES=0
TOTALCHARS=0

echo "#============================================================================="

for X in `echo ${EXTENSIONS}`
do
     COUNT=`find  "${DIRECTORY}" -type f -name "*.${X}" | wc -l`
     LINES=`find  "${DIRECTORY}" -type f -name "*.${X}" -exec cat '{}' \; | wc -l`
     CHARS=`find  "${DIRECTORY}" -type f -name "*.${X}" -exec cat '{}' \; | wc -c`

     printf  "${DARKGRAY}EXTNS:  ${REDBOLD}%s%s${NOCOLOR}      "   "${pnumber:${#X}}"        "${X}"
     printf  "${DARKGRAY}COUNT:  ${PURPLEBOLD}%s%s${NOCOLOR}    "  "${xnumber:${#COUNT}}"    "${COUNT}"
     printf  "${DARKGRAY}LINES:  ${BLUEBOLD}%s%s${NOCOLOR}      "  "${lnumber:${#LINES}}"    "${LINES}"
     printf  "${DARKGRAY}CHARS:  ${GREENBOLD}%s%s${NOCOLOR}\n"     "${cnumber:${#CHARS}}"    "${CHARS}"

     TOTALFILES=$(( ${TOTALFILES} + ${COUNT} ))
     TOTALLINES=$(( ${TOTALLINES} + ${LINES} ))
     TOTALCHARS=$(( ${TOTALCHARS} + ${CHARS} ))
done

echo "#============================================================================="

     printf  "#======== ${DARKGRAY}TOTALFILES:  ${PURPLEBOLD}%s%s${NOCOLOR}\n"  "${totfiles:${#TOTALFILES}}"    "${TOTALFILES}"
     printf  "#======== ${DARKGRAY}TOTALLINES:  ${BLUEBOLD}%s%s${NOCOLOR}\n"    "${totlines:${#TOTALLINES}}"    "${TOTALLINES}"
     printf  "#======== ${DARKGRAY}TOTALCHARS:  ${GREENBOLD}%s%s${NOCOLOR}\n"   "${totlines:${#TOTALCHARS}}"    "${TOTALCHARS}"

echo "#============================================================================="
echo
