Screen 12

' define cube vertices (cube of side L 2 centered at origin)

Dim Shared vx(8) As Single, vy(8) As Single, vz(8) As Single
Dim Shared sxp(8) As Single, syp(8) As Single
                                            
Data -1,-1,-1,1,-1,-1,1,1,-1,-1,1,-1
Data -1,-1,1,1,-1,1,1,1,1,-1,1,1

For i = 1 To 8
    Read vx(i), vy(i), vz(i)
Next

' edge between vertex indices thingies
Dim e1(12), e2(12)
Data 1,2,2,3,3,4,4,1
Data 5,6,6,7,7,8,8,5
Data 1,5,2,6,3,7,4,8

For i = 1 To 12
    Read e1(i), e2(i)
Next

angleX! = 0
angleY! = 0
frame& = 0


Do
    Screen 12


    frame& = frame& + 1

    ' rotation angle increase
    angleX = angleX + 3
    angleY = angleY + 5

    cx! = Cos(angleX!)
    sx! = Sin(angleX!)
    cy! = Cos(angleY!)
    sy! = Cos(angleY!)

    ' precomp sine/cosine for speed
    cx = Cos(angleX): sx = Sin(angleX)
    cy = Cos(angleY): sy = Sin(angleY)

    ' transform/project vertices
    For i = 1 To 8
        ' rotate around x axis
        y1! = vy(i) * cx! - vz(i) * sx!
        z1! = vy(i) * sx! + vz(i) * cx!

        ' rotate around y axis
        x2! = vx(i) * cy! + z1! * sy!
        z2! = -vx(i) * sy! + z1! * cy!

        ' perspective projection
        distance = 16
        scale = 1024 / (z2! + distance)

        sxp(i) = x2 * scale + 320
        syp(i) = y1 * scale + 200
    Next

    ' delete old cube
    For i = 1 To 12
        Line (oxp(e1(i)), oyp(e1(i)))-(oxp(e2(i)), oyp(e2(i))), 0
    Next

    ' draw cube
    For i = 1 To 12
        Line (sxp(e1(i)), syp(e1(i)))-(sxp(e2(i)), syp(e2(i))), 15
    Next

    ' save pos
    For i = 1 To 8
        oxp(i) = sxp(i)
        oyp(i) = syp(i)
    Next

    ' print text
    Locate 2, 4
    Color 15
    Print "KubeKlikkr: a Cookie Clicker clone for DOS and Windows by lfo/VyRaL^HF^RSE"
    Locate 3, 4
    Print "(make sure to turn off Sticky Keys if you're running the Windows version!)"
    Locate 5, 4
    If frame& = 1 Then Print "So far, you have redrawn the cube a total of"; frame&; "time!" Else Print "So far, you have redrawn the cube a total of"; frame&; "times!"
    Locate 21, 8
    Print "Press Shift to redraw the cube. Press any other key twice to exit."
    Locate 23, 17
    Print "---------------- Update History ----------------"
    Locate 25, 4
    Print "05 Dec 2025 (v1.0) - First public release in Inercia 2025 demo compo."
    Locate 26, 4
    Print "02 Apr 2026 (v1.1) - Layout changed, color and auto-redraw removed."
    Locate 28, 4
    Print "NOTE: I'm not sure if I'll update this thing again. I'm one busy scener!"

    ' delay for ez spin
    Sleep 0

Loop Until InKey$ <> ""
