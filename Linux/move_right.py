#!/usr/bin/python
from gtk.gdk import *
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

val = p[0] + s[0]
if val > width:
    val = width

if val <= width:
    window.move(val,p[1])

c.update()