checkIfStillOnLobby() {
    xLobby := 359, yLobby := 544
    xRunes := 88, yRunes := 70
    colorRunes := 0x143746, colorLobby := 0x2A556A, colorLobbySelected := 0x9A8D71
    while True {
        PixelGetColor, currentColorLobby, xLobby, yLobby
        PixelGetColor, currentColorRunes, xRunes, yRunes
        if (currentColorLobby = colorLobby || currentColorRunes = colorRunes || currentColorLobby = colorLobbySelected) {
            sleep 700
        } else {
            main()
        }
    } 
}
; 502 247 0x815900
; 536 281 0x364D51
; 537 231 0x423B28

acceptLobby() {
    xAccept1 := 502, yAccept1 := 247
    xAccept2 := 536, yAccept2 := 281
    colorAccept1 := 0x815900, colorAccept2 := 0x364D51
    xAcceptClick := 500, yAcceptClick := 450
    while True {
        PixelGetColor, currentColorAccept1, xAccept1, yAccept1
        PixelGetColor, currentColorAccept2, xAccept2, yAccept2
        if (currentColorAccept1 = colorAccept1 && currentColorAccept2 = colorAccept2) {
            sleep 200
            click, 500, 450
            sleep 200
            checkIfStillOnLobby()
        } else {
            sleep, 100
        }
    }   
}

main() {
    acceptLobby()
}

main()

F2::
    MouseGetPos, xPos, yPos
    PixelGetColor, colorTest, xPos, yPos
    MsgBox, x%xPos% y%yPos% =  %colorTest%
    clipboard := "; " xPos " " yPos " " colorTest
    return
F11::
    Pause
