#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Top:= A_ScreenHeight - gettbHeight()


apx(a,b){
    return % Abs(Floor(a - b)) < 20
}

in_left_region(n,p,s,w){
    return % (apx(p, 0) and apx(s, w*n))
}

in_right_region(n,p,s,w){
    return % (apx(p, w*n) and apx(s, w*(1-n)))
}


!#Left::
    WinGetActiveTitle, title
    WinGetPosEx(getActiveWindow(title), p0,p1,s0,s1,ox,oy)

    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight
    ScreenHeight := Top

    left_regions := [1.0/2, 1.0/3, 1.0/4, 1.0/6]

    non_region := 1

    k :=0
    Loop % left_regions.length()-1
    {   
        if % in_left_region(left_regions[k+1],p0,s0,ScreenWidth)
        {
            non_region := 0
            WinMove, %title%,,ox,0, % Floor(ScreenWidth*left_regions[k+2])-2*ox,% ScreenHeight-2*oy
        }
        k := % k+1
        
    }

    if non_region
    {
        WinMove, %title%,,ox,0, % Floor(ScreenWidth/2)-2*ox,% ScreenHeight -2*oy
    }
    return 


!#Right::
    WinGetActiveTitle, title
    WinGetPosEx(getActiveWindow(title), p0,p1,s0,s1,ox,oy)
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight
    ScreenHeight := Top

    right_regions := [1.0/2, 2.0/3, 3.0/4, 5.0/6]

    non_region := 1

    k :=0
    Loop % right_regions.length()-1
    {   
        if % in_right_region(right_regions[k+1],p0,s0,ScreenWidth)
        {
            non_region := 0
            WinMove, %title%,,% Floor(ScreenWidth*right_regions[k+2])+ox,0, % Floor(ScreenWidth*(1-right_regions[k+2]))-2*ox,% ScreenHeight-2*oy
        }
        k := % k+1
        
    }

    if non_region
    {
        WinMove, %title%,,% Floor(ScreenWidth/2)+ox,0, % Floor(ScreenWidth/2)-2*ox,% ScreenHeight-2*oy
    }
    return 


!#Up::
    WinGetActiveTitle, title
    WinGetPosEx(getActiveWindow(title), p0,p1,s0,s1,ox,oy)
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

        WinMove, %title%,,% Floor((ScreenWidth-s0)/2)+ox,0,% s0 -2*ox,% ScreenHeight -2*oy 
    return 


!#Down::
    WinGetActiveTitle, title
    WinGetPosEx(getActiveWindow(title), p0,p1,s0,s1,ox,oy)
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

    if  % s0  < ScreenWidth-100
    {
        if apx(p0+s0, ScreenWidth)
        {
            WinMove, %title%,,% p0-ScreenWidth/6 +ox ,0 ,s0+ScreenWidth/6-2*ox,% ScreenHeight -2*oy
        }
        if apx(p0, 0) 
        {
            WinMove, %title%,,ox,0,% s0+ScreenWidth/6 -2*ox,% ScreenHeight -2*oy
        }
        if apx(p0+s0/2,ScreenWidth/2)
        {
            WinMove, %title%,,% p0-ScreenWidth/12 +ox,0,% s0+ScreenWidth/6-2*ox,% ScreenHeight -2*oy
        }
    }
    return 


^!#Left::
    WinGetActiveTitle, title
    WinGetPosEx(getActiveWindow(title), p0,p1,s0,s1,ox,oy)
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

    val := p0 - s0
    if val < 10
    {
        val := 0
    }
    if val >= 0
    {
        WinMove, %title%,,% val +ox , 0
    }
    return 


^!#Right::
    WinGetActiveTitle, title
    WinGetPosEx(getActiveWindow(title), p0,p1,s0,s1,ox,oy)
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

    val := p0 + s0
    if % val > (ScreenWidth-10)
    {
        val := ScreenWidth
    }
    if % val < ScreenWidth
    {
        WinMove, %title%,,% val + ox, 0
    }
    return 

t=0
^!#Up::
    t := !t  

    If (t = "1") {  ; Hide
        Top := A_ScreenHeight
        WinHide, ahk_class Shell_TrayWnd  ; Hide Taskbar
        WinHide, Start ahk_class Button  ; Hide Start Button
    } Else {  ; Show
        WinShow, ahk_class Shell_TrayWnd  ; Show Taskbar
        WinShow, Start ahk_class Button  ; Show Start Button
        Top := A_ScreenHeight - gettbHeight() ; Screen Height - Taskbar Height
    }
    return

gettbHeight(){
    WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
    return tbH
}

getActiveWindow(title){
    WinGet, hWin, ID, %title%
    return hWin
}

WinGetPosEx(hWindow,ByRef X="",ByRef Y="",ByRef Width="",ByRef Height="",ByRef Offset_X="",ByRef Offset_Y="")
    {
    Static Dummy5693
          ,RECTPlus
          ,S_OK:=0x0
          ,DWMWA_EXTENDED_FRAME_BOUNDS:=9

    ;-- Workaround for AutoHotkey Basic
    PtrType:=(A_PtrSize=8) ? "Ptr":"UInt"

    ;-- Get the window's dimensions
    ;   Note: Only the first 16 bytes of the RECTPlus structure are used by the
    ;   DwmGetWindowAttribute and GetWindowRect functions.
    VarSetCapacity(RECTPlus,24,0)
    DWMRC:=DllCall("dwmapi\DwmGetWindowAttribute"
        ,PtrType,hWindow                                ;-- hwnd
        ,"UInt",DWMWA_EXTENDED_FRAME_BOUNDS             ;-- dwAttribute
        ,PtrType,&RECTPlus                              ;-- pvAttribute
        ,"UInt",16)                                     ;-- cbAttribute

    if (DWMRC<>S_OK)
        {
        if ErrorLevel in -3,-4  ;-- Dll or function not found (older than Vista)
            {
            ;-- Do nothing else (for now)
            }
         else
            outputdebug,
               (ltrim join`s
                Function: %A_ThisFunc% -
                Unknown error calling "dwmapi\DwmGetWindowAttribute".
                RC=%DWMRC%,
                ErrorLevel=%ErrorLevel%,
                A_LastError=%A_LastError%.
                "GetWindowRect" used instead.
               )

        ;-- Collect the position and size from "GetWindowRect"
        DllCall("GetWindowRect",PtrType,hWindow,PtrType,&RECTPlus)
        }

    ;-- Populate the output variables
    X:=Left :=NumGet(RECTPlus,0,"Int")
    Y:=Top  :=NumGet(RECTPlus,4,"Int")
    Right   :=NumGet(RECTPlus,8,"Int")
    Bottom  :=NumGet(RECTPlus,12,"Int")
    Width   :=Right-Left
    Height  :=Bottom-Top
    OffSet_X:=0
    OffSet_Y:=0

    ;-- If DWM is not used (older than Vista or DWM not enabled), we're done
    if (DWMRC<>S_OK)
        Return &RECTPlus

    ;-- Collect dimensions via GetWindowRect
    VarSetCapacity(RECT,16,0)
    DllCall("GetWindowRect",PtrType,hWindow,PtrType,&RECT)
    GWR_Width :=NumGet(RECT,8,"Int")-NumGet(RECT,0,"Int")
        ;-- Right minus Left
    GWR_Height:=NumGet(RECT,12,"Int")-NumGet(RECT,4,"Int")
        ;-- Bottom minus Top

    ;-- Calculate offsets and update output variables
    Offset_X:=(Width-GWR_Width)//2
    Offset_Y:=(Height-GWR_Height)//2
    If (Offset_X != 0){
        Offset_X:= Offset_X-1
    }
    If (Offset_Y != 0){
        Offset_Y:= Offset_Y-1
    }
    NumPut(Offset_X,RECTPlus,16,"Int")
    NumPut(Offset_Y,RECTPlus,20,"Int")
    Return &RECTPlus
    }
