#!/bin/bash

D=$PWD
remove=$HOME
D=${D#*$remove} 


python3 CreateKeybind.py 'WinSnap Left' .$D/left.py '<Super><Alt>Left'
python3 CreateKeybind.py 'WinSnap Right' .$D/right.py '<Super><Alt>Right'
python3 CreateKeybind.py 'WinSnap Center' .$D/center.py '<Super><Alt>Up'
python3 CreateKeybind.py 'WinSnap Stretch' .$D/stretch.py '<Super><Alt>Down'
python3 CreateKeybind.py 'WinSnap Move Left' .$D/move_left.py '<Control><Super><Alt>Left'
python3 CreateKeybind.py 'WinSnap Move Right' .$D/move_right.py '<Control><Super><Alt>Right'
python3 CreateKeybind.py 'WinSnap Border Fix' .$D/fix.py '<Control><Super><Alt>Down'
python3 CreateKeybind.py 'WinSnap Toggle Decoration' .$D/toggle_decoration.py '<Control><Super><Alt>Up'