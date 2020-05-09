#!/usr/bin/env python3
import gi
gi.require_version('Gdk', '3.0')
from gi.repository import Gdk


def init():
    screenGeometry = Gdk.Monitor.get_workarea(
        Gdk.Display.get_primary_monitor(Gdk.Display.get_default()))
    width = screenGeometry.width
    height = screenGeometry.height
    window = Gdk.Screen.get_active_window(Gdk.Screen.get_default())
    windowGeometry = window.get_geometry()
    p = [windowGeometry.x, windowGeometry.y]
    s = [windowGeometry.width, windowGeometry.height]
    print([window, p, s, width, height])
    return [window, p, s, width, height]


def update(window):
    window.process_all_updates()
    Gdk.flush()


def window_init(window):
    window.unmaximize()
    window.set_decorations(0)


def apx(a, b):
    return abs(a - b) < 10
