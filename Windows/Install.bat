@echo off
set file="WinSnap.exe"
set location="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
copy %file% %location%

echo I guess that worked? Now either restart you computer or just manually run the .exe file
pause