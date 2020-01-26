from gtk.gdk import *
import gtk.gdk

def init():
    screen = gtk.gdk.get_default_root_window().get_screen()
    width = screen.get_width()
    height = screen.get_height()
    window = screen.get_active_window()

    p = window.get_position()
    s = window.get_size()
    print([window,p,s,width,height])
    return [window,p,s,width,height]

def update():
    window_process_all_updates()
    gtk.gdk.flush()

def window_init(window):
    window.unmaximize()
    window.set_decorations(0)

def apx(a,b):
    return abs(a - b) < 10