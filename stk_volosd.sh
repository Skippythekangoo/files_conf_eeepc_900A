#!/bin/sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

# http://ubuntuforums.org/showthread.php?t=1174798

# amixer options
CHANNEL=Master  # usually Master, but for Asus EEE, this is iSpeaker
CARD=0          # Which sound card, if your system has more than one?
VOL_STEP=2      # amount to increase / decrease volume

# osd_cat options
POS=middle      # top, middle or bottom
ALIGN=center    # left, center or right
OFFSET=0        # offset from the top or bottom
COLOR=gray      # white, blue, yellow, cyan, magenta, green, etc
MUTECOLOR=brown # color to use instead when muted
SHADOW=2        # offset of shadow, 0 for none
DELAY=3         # seconds to show the OSD
AGE=0           # seems broken :\
BARMODE=slider  # percentage or slider
FONT=-*-helvetica-medium-r-*-*-*-320-*-*-*-*-*-*

if [ "$1" = "mute" ]; then
    amixer -c $CARD set $CHANNEL toggle >/dev/null 2>&1
elif [ "$1" = "up" ]; then
    amixer -c $CARD set $CHANNEL $VOL_STEP+ >/dev/null 2>&1
elif [ "$1" = "down" ]; then
    amixer -c $CARD set $CHANNEL $VOL_STEP- >/dev/null 2>&1
else
    echo "Usage: $0 up|down|mute"
    exit 1
fi


STATUS=$(amixer -c $CARD sget ${CHANNEL} | grep -c "\\[on\\]")
VOLUME=$(amixer -c $CARD sget ${CHANNEL}  | awk '$0 ~ "%" { vol=$(NF-2); \
     gsub("\\[", "", vol); gsub("\\]", "",vol); print vol; exit; }' )

if [ $STATUS -eq 0 ]; then
    STATUS=" (muted)"
    COLOR=$MUTECOLOR
else
    STATUS=""
fi

killall osd_cat >/dev/null 2>&1   # if the -a switch worked, we wouldn't need this

osd_cat -p $POS -c $COLOR -s $SHADOW -a $AGE -d $DELAY -o $OFFSET -A $ALIGN \
-b $BARMODE -P $VOLUME -l 1 -T "Volume: $VOLUME$STATUS"
#-b $BARMODE -P $VOLUME -f $FONT -l 1 -T "Volume: $VOLUME$STATUS"
