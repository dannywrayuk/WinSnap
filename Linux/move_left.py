#!/usr/bin/python
from gtk.gdk import *
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

val = p[0]- s[0]
if val < 10:
    val = 0

if val >= 0:
    window.move(val,p[1])

c.update()