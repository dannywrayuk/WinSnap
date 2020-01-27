# WinSnap
### Snap and move windows with keyboard shortcuts

I have a super ultrawide monitor and snapping windows to half the screen isn't enough.
Inspired by [Spectacle](https://www.spectacleapp.com/) for mac, this little gadet lets you snap windows into halfs, thirds, quarters and sixths.
Works on windows and linux.

### Requirements
 
Windows: [Auto Hot Key](https://www.autohotkey.com/)

Linux: python and the gtk module

### Controls

**Win+Alt+Left:** Snap a window to the left. Repeated presses decrease the size of the window.  
**Win+Alt+Right:** Snap a window to the right. Repeated presses decrease the size of the window.  
**Win+Alt+Up:** Center the window.  
**Win+Alt+Down:** Increase window size by smallest allowed increment (1/6 of the screen width).  
**Ctrl+Win+Alt+Left:** Move a window left by size of window.  
**Ctrl+Win+Alt+Right:** Move a window right by by size of window.  
**Ctrl+Win+Alt+Down:** Some windows have a huge invisible border, this might fix that. It also might not, it's a tricky issue.

Linux Specific
**Ctrl+Alt+Up:** Show/Hide the window decoration such as titlebar and borders.  

### Installation

### Linux

Clone the Repo somewhere on your computer and cd into the Linux directory then simply run Install.S

```
git clone https://github.com/dannywrayuk/winsnap.git
cd Linux
./Install.S
```
### Windows
If you're lazy, download the windows folder and run the script inside it.
But if you're xXhacker_pro_420Xx like me, do this
```
git clone https://github.com/dannywrayuk/winsnap.git
cd Windows
Install.bat
```