#!/usr/bin/env python3
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

if c.apx(p[0] + s[0], width):
    window.move_resize(p[0] - width / 6, p[1], s[0] + width / 6, s[1])
if c.apx(p[0], 0):
    window.move_resize(p[0], p[1], s[0] + width / 6, s[1])
if c.apx(p[0] + s[0] / 2, width / 2):
    window.move_resize(p[0] - width / 12 - 1, p[1], s[0] + width / 6 + 1, s[1])

c.update(window)
