#!/usr/bin/env sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

#http://blog.chibi-nah.fr/article59/deux-claviers-deux-dispositions
#Permet de redéfinir à la volée les dispositions des claviers branchés.
#Clavier du laptop : ch-fr
#Clavier usb azerty, si branché : fr-oss

CLAV_LAPTOP=$(xinput --list --id-only "keyboard:AT Translated Set 2 keyboard")
setxkbmap -device $CLAV_LAPTOP -layout ch fr

#À noter, le clavier azerty  peut ne pas être présent.
#Dans ce cas, on ne fait rien
CLAV_FR=$(xinput --list --id-only "keyboard:Logitech USB Receiver" | sed 's/[^0-9]//g')

if [ -n "$CLAV_FR" ]
then
    setxkbmap -device $CLAV_FR -layout fr oss
fi
