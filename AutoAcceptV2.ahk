var_check 		:= "Coordinate_check"
var_click 		:= "Coordinate_click"
var_color 		:= "Accepting_color"
var_icons		:= "ChangingIcon_menu"

/*
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
*/

acceptLobby(all_values) {
	;1 = lobby_x_check, 2 = lobby_y_check, 3 = lobby_x_click, 4 = lobby_y_click, 5 = lobby_c_check
	;6 = icon_x1_check, 7 = icon_y1_check, 8 = icon_x2_check, 9 = icon_y2_check, 10 = icon_cr_check
    while True {
		PixelGetColor, lobby_color, all_values[1], all_values[2]
		if (lobby_color = all_values[5] && icon_color) {
			PixelGetColor, icon_color, all_values[6], all_values[7]
			PixelGetColor, icon_color_two, all_values[8], all_values[9]
			if (icon_color = all_values[10] && icon_color_two = all_values[10])
			{
				sleep 200
				click, all_values[3], all_values[4]
				sleep 200
			; checkIfStillOnLobby()
			}
		} else {
			sleep, 400
		}
    }   
}

ini_write(x, y, name1, name2, section_name, file_name) {
	IniWrite, %x%, %file_name%, %section_name%, %name1%
	IniWrite, %y%, %file_name%, %section_name%, %name2%
}

read_ini(file_name) {
	global var_check, var_click, var_color, var_icons

	IniRead, lobby_x_check, %file_name%, %var_check%, x
    IniRead, lobby_y_check, %file_name%, %var_check%, y
    IniRead, lobby_x_click, %file_name%, %var_click%, x
    IniRead, lobby_y_click, %file_name%, %var_click%, y
    IniRead, lobby_c_check, %file_name%, %var_color%, Color

	IniRead, icon_x1_check, %file_name%, %var_icons%, x1
	IniRead, icon_y1_check, %file_name%, %var_icons%, y1
	IniRead, icon_x2_check, %file_name%, %var_icons%, x2
	IniRead, icon_y2_check, %file_name%, %var_icons%, y2
    IniRead, icon_cr_check, %file_name%,  Color_icon, Color

	huge_list := [ lobby_x_check
		, lobby_y_check
		, lobby_x_click
		, lobby_y_click
		, lobby_c_check
		, icon_x1_check
		, icon_y1_check
		, icon_x2_check
		, icon_y2_check
		, icon_cr_check ]
	return huge_list
}

write_default_values(file_name) {
	global var_check, var_click, var_icons, var_color

	ini_write(775, 22, "x", "y", var_check, file_name)
	ini_write(500, 450, "x", "y", var_click, file_name)
    IniWrite, 0x184757, %file_name%, %var_color%, Color

	ini_write(227, 100, "x1", "y1", var_icons, file_name)
	ini_write(648, 109, "x2", "y2", var_icons, file_name)
	Iniwrite, 0x130A01, %file_name%, Color_icon, icon_color
}

main() {
    file_name := "check_value.ini"
    if (!FileExist(file_name)) {
        write_default_values(file_name)
    }
	all_values := read_ini(file_name)
    acceptLobby(all_values)
}

main()

F2::
    MouseGetPos, xPos, yPos
    PixelGetColor, colorTest, xPos, yPos
    clipboard := "x"xPos " y"yPos " = " colorTest
    MsgBox, x%xPos% y%yPos% = %colorTest%`nCopied to clipboard
    return
F11::
    Pause