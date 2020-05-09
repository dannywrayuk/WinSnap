#!/usr/bin/env python3
import time
import common as c
import gi
gi.require_version('Gdk', '3.0')
from gi.repository import Gdk

window = Gdk.Screen.get_active_window(Gdk.Screen.get_default())


d = window.get_decorations().decorations
if d == 1:
    exit()

g = window.get_geometry()

window.set_decorations(Gdk.WMDecoration(True))
c.update(window)

time.sleep(0.01)
window.move_resize(g[0], g[1], g[2] + 5, g[3])

window.set_decorations(d)
c.update(window)
