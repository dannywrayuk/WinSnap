#!/usr/bin/python
from gtk.gdk import *
import gtk.gdk
import time 
import common as c

screen = gtk.gdk.get_default_root_window().get_screen()
window = screen.get_active_window()



d = window.get_decorations()
if d==1:
    exit()

g = window.get_geometry()

window.set_decorations(1)
c.update()

time.sleep(0.01)
window.move_resize(g[0],g[1],g[2]+5,g[3])

window.set_decorations(d)
c.update()
