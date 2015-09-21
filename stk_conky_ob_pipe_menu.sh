#!/bin/sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

LOAD=$(conky -c ~/.conky/conkyrc_ob_pipe_menu -q -i 1 -t '${loadavg}')
TEMP=$(conky -c ~/.conky/conkyrc_ob_pipe_menu -q -i 1 -t '${acpitemp}°C')
echo "<openbox_pipe_menu>"
echo "<item label=\"load:$LOAD\" />"
echo "<item label=\"cpu temp:$TEMP\" />"
echo "</openbox_pipe_menu>"
