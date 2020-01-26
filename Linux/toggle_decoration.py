#!/usr/bin/python
from gtk.gdk import *
import gtk.gdk

w = gtk.gdk.get_default_root_window().get_screen().get_active_window()
w.set_decorations(1-int(w.get_decorations()))
window_process_all_updates()
gtk.gdk.flush()