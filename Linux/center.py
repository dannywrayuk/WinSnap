#!/usr/bin/python
from gtk.gdk import *
import gtk.gdk
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

window.move((width-s[0])/2,p[1])

c.update()