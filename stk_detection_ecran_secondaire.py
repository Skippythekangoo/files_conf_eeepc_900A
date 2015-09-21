#!/usr/bin/env python2

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

# http://stackoverflow.com/questions/10400236/how-to-observe-changes-in-connected-monitors-via-xlib

"""
Send RESET_COMMAND via os.system() call when xbc.randr reports
that a small screen (main monitor) has just changed configuration.
ie The secondary (TV) monitor has just been turned on.
"""

# Could also be xrandr settings, if need be #
# These values came from the nvidia-settings GUI with Base Mosaic enable with custom scaling on HDMI-0 determined experiementally
#RESET_COMMAND = 'nvidia-settings --assign CurrentMetaMode="GPU-08c5ca05-d3cc-b022-4fab-3acab0500b7c.VGA-0: 1280x1024 +0+0, GPU-08c5ca05-d3cc-b022-4fab-3acab0500b7c.HDMI-0: 1920x1080 +1280+0 {viewportin=1920x1080, viewportout=1774x998+73+41}"'
RESET_COMMAND = 'xrandr --output VIRTUAL1 --off --output LVDS1 --mode 1280x800 --pos 0x0 --rotate normal --primary --output TV1 --off --output VGA1 --mode 1280x1024 --pos 1280x0 --rotate normal'

MAIN_MONITOR_HEIGHT = 1024
MAIN_MONITOR_WIDTH = 1280

import os
# Do one reset at startup (login) - this may be a shortcoming of LXDM that has things wrong after the first login #
os.system(RESET_COMMAND)

import xcb
from xcb.xproto import *

import xcb.randr as RandR
from xcb.randr import NotifyMask, ScreenChangeNotifyEvent


def startup():
    """Hook up XCB_RANDR_NOTIFY_MASK_SCREEN_CHANGE"""
    # In the xcb.randr module, the result of
    # key = xcb.ExtensionKey('RANDR')
    # xcb._add_ext(key, randrExtension, _events, _errors)
    # is stored in xcb.randr.key and retrieved in some very odd manner =>
    randr = conn(RandR.key)
    randr.SelectInput(root.root, NotifyMask.ScreenChange)
    # may as well flush()
    conn.flush()



def run():
    """Listen for XCB_RANDR_SCREEN_CHANGE_NOTIFY"""
    currentTimestamp = 0
    connected = False
    startup()

    while True:
        try:
            event = conn.wait_for_event()
            connected = True
        except xcb.ProtocolException, error:
            print "Protocol error %s received!" % error.__class__.__name__
            break
        except Exception, error:
            print "Unexpected error received: %s" % error.message
            break

        # Once the ScreenChangeNotify Event arrives, filter down to the one we care about. #
        if isinstance(event, ScreenChangeNotifyEvent):
            # 3 consecutive events arrive with the same timestamp, #
            if currentTimestamp != event.config_timestamp:
                # so mask off the next two and #
                currentTimestamp = event.config_timestamp
                # mask off the disconnect altogether by looking at the initial screen size. #
                if ((event.width == MAIN_MONITOR_WIDTH) and (event.height == MAIN_MONITOR_HEIGHT)):
                    os.system(RESET_COMMAND)

    # won't really get here, will we?
    if connected:
        conn.disconnect()



conn = xcb.connect()
setup = conn.get_setup()
# setup.roots holds a list of screens (just one in our case) #
root = setup.roots[0]

run()
