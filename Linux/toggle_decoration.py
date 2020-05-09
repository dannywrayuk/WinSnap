#!/usr/bin/env python3
import common as c
import gi
gi.require_version('Gdk', '3.0')
from gi.repository import Gdk

window = Gdk.Screen.get_active_window(Gdk.Screen.get_default())
window.set_decorations(Gdk.WMDecoration(
    window.get_decorations().decorations != 1))
c.update(window)
