#!/usr/bin/env python3
import common as c

[window, p, s, width, height] = c.init()

c.window_init(window)

right_regions = [1.0 / 2, 2.0 / 3, 3.0 / 4, 5.0 / 6]


def in_right_region(n):
    return (c.apx(p[0], width * n) and c.apx(s[0], width * (1 - n)))


non_region = 1
for k in range(0, len(right_regions) - 1):
    if in_right_region(right_regions[k]):
        non_region = 0
        window.move_resize(int(
            width * right_regions[k + 1]), p[1], int(width * (1 - right_regions[k + 1])), s[1])
if non_region:
    window.move_resize(width / 2, 0, width / 2, height)

c.update(window)
