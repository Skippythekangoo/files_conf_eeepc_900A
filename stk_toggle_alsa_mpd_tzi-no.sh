#!/bin/sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

ALSA_ENABLE=$(mpc --host 192.168.1.2 outputs | grep ALSA | grep enable | echo $?)
echo $ALSA_ENABLE
if [ $ALSA_ENABLE -eq "0" ]
   then mpc --host=192.168.1.2 disable 1
   else mpc --host=192.168.1.2 enable 1
fi

