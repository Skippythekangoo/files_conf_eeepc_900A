#!/bin/sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

# Written by Ramses de Norre

# Match only positive integers as second argument
if [[ ${2} =~ ^[0-9]+$ ]]; then
  AMM=${2}
else
  AMM=1
fi

CTRL="Master"
PREFIX="Volume"
GB_WIDTH=50
GB_HEIGHT=7
DZEN_SEC=3
DZEN_Y="870"
DZEN_X="1300"
DZEN_TA="c"
DZEN_TW="140"

GB_ARGS="-l ${PREFIX} -w ${GB_WIDTH} -h ${GB_HEIGHT}"
DZEN_ARGS="-p ${DZEN_SEC} -ta ${DZEN_TA} -y ${DZEN_Y} -x ${DZEN_X} -tw ${DZEN_TW}"

if [ "$1" = "+" -o "$1" = "-" ]; then
  /usr/bin/amixer set ${CTRL} ${AMM}%${1} \
    | /bin/sed -n '${s/.*\[\([0-9]*\)%\].*/\1/p}' \
    | /usr/bin/gdbar ${GB_ARGS} \
    | /usr/bin/dzen2 ${DZEN_ARGS}
else
  echo "Wrong usage!" 2>&1
  exit 1
fi

exit 0
