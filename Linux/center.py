#!/usr/bin/env python3
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

window.move((width - s[0]) / 2, p[1])

c.update(window)
