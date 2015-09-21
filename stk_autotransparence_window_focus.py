#!/usr/bin/python2
# -*- coding: utf-8 -*-

## vu sur http://forum.ubuntu-fr.org/viewtopic.php?id=338218

##
#   script that uses transset-df to allow opacity to follow the focused window.
#   The focused window get opacity 1.0 while all others have opacity set by 'OPACITY'
#
#   by ADcomp <david.madbox@gmail.com>  [ http://www.ad-comp.be/ ]
#
#   This program is distributed under the terms of the GNU General Public License
#   For more info see http://www.gnu.org/licenses/gpl.txt
##

import os

## from python-gtk2
import gtk 
## from python-gnome2-desktop
import wnck

## transset -i <xid> <opacity>
CMD = 'transset-df -i'
## opacity when not active
OPACITY = 0.75
## opacity when active
FOCUS_OPACITY = 1

class Transset():
    def __init__(self):
        self.screen = wnck.screen_get_default()
        self.screen.force_update()
        self.update()
        self.screen.connect("active_window_changed", self.active_window_changed)

    def update(self):
        win_list = self.screen.get_windows()
        active_ws = self.screen.get_active_workspace()
        active_win = self.screen.get_active_window()

        for window in win_list:
            ## don't check window if skip tasklist
            if not window.is_skip_tasklist():
                ## only window open on active workspace
                if window.get_workspace() == active_ws:
                    if window == active_win:
                        ## remove transparency
                        #cmd = "%s %s 1" % ( CMD, window.get_xid() )
                        ## remove transparency focus FOCUS_OPACITY
                        cmd = "%s %s %s" % ( CMD, window.get_xid(), FOCUS_OPACITY )
                    else:
                        ## set transparency
                        cmd = "%s %s %s" % ( CMD, window.get_xid(), OPACITY )
                    os.system(cmd)

    def active_window_changed(self, screen, window):
        self.update()

    def doquit(self, widget=None, data=None):
        gtk.main_quit()

    def run(self):
        gtk.main()

transset = Transset()
transset.run()
