#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


apx(a,b){
    return % Abs(Floor(a - b)) < 10
}

in_left_region(n,p,s,w){
    return % (apx(p, 0) and apx(s, w*n))
}

in_right_region(n,p,s,w){
    return % (apx(p, w*n) and apx(s, w*(1-n)))
}


!#Left::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight
    ScreenHeight := workAreaBottom

    left_regions := [1.0/2, 1.0/3, 1.0/4, 1.0/6]

    non_region := 1

    k :=0
    Loop % left_regions.length()-1
    {   
        if % in_left_region(left_regions[k+1],p0,s0,ScreenWidth)
        {
            non_region := 0
            WinMove, %title%,,0,%p1%, % Floor(ScreenWidth*left_regions[k+2]),%s1%
        }
        k := % k+1
        
    }

    if non_region
    {
        WinMove, %title%,,0,0, % Floor(ScreenWidth/2),%ScreenHeight%
    }
    return 


!#Right::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight
    ScreenHeight := workAreaBottom

    right_regions := [1.0/2, 2.0/3, 3.0/4, 5.0/6]

    non_region := 1

    k :=0
    Loop % right_regions.length()-1
    {   
        if % in_right_region(right_regions[k+1],p0,s0,ScreenWidth)
        {
            non_region := 0
            WinMove, %title%,,% Floor(ScreenWidth*right_regions[k+2]),%p1%, % Floor(ScreenWidth*(1-right_regions[k+2])),%s1%
        }
        k := % k+1
        
    }

    if non_region
    {
        WinMove, %title%,,% Floor(ScreenWidth/2),0, % Floor(ScreenWidth/2),%ScreenHeight%
    }
    return 


!#Up::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

        WinMove, %title%,,% Floor((ScreenWidth-s0)/2),%p1%
    return 


!#Down::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

    if  % s0  < ScreenWidth-100
    {
        if apx(p0+s0, ScreenWidth)
        {
            WinMove, %title%,,% p0-ScreenWidth/6,%p1%,s0+ScreenWidth/6,%s1%
        }
        if apx(p0, 0) 
        {
            WinMove, %title%,,%p0%,%p1%,% s0+ScreenWidth/6,%s1%
        }
        if apx(p0+s0/2,ScreenWidth/2)
        {
            WinMove, %title%,,% p0-ScreenWidth/12-1,%p1%,% s0+ScreenWidth/6+1,%s1%
        }
    }
    return 


^!#Left::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

    val := p0 - s0
    if val < 10
    {
        val := 0
    }
    if val >= 0
    {
        WinMove, %title%,,%val%,%p1%
    }
    return 


^!#Right::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    SysGet, workArea, MonitorWorkArea
    ScreenWidth := workAreaRight

    val := p0 + s0
    if % val > (ScreenWidth-10)
    {
        val := ScreenWidth
    }
    if % val < ScreenWidth
    {
        WinMove, %title%,,%val%,%p1%
    }
    return 


^!#Down::
    WinGetActiveTitle, title
    WinGetPos, p0,p1,s0,s1,%title%
    k := 8
    WinMove, %title%,, % p0 - k, % p1 - k, % s0 + 2*k, % s1 + 2*k 
    return