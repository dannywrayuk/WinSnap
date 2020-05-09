#!/usr/bin/env python3
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

left_regions = [1.0 / 2, 1.0 / 3, 1.0 / 4, 1.0 / 6]


def in_left_region(n):
    return (c.apx(p[0], 0) and c.apx(s[0], width * n))


non_region = 1
for k in range(0, len(left_regions) - 1):
    if in_left_region(left_regions[k]):
        non_region = 0
        window.move_resize(0, p[1], int(width * left_regions[k + 1]), s[1])
if non_region:
    window.move_resize(0, 0, width / 2, height)

c.update(window)
