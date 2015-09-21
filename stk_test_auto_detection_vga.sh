#!/bin/sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

detection=$(xrandr | grep VGA | cut -d " " -f 2)
if [ $detection="connected" ]; then
echo "est bon"
fi
