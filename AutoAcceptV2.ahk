var_check 		:= "Coordinate_check"
var_click 		:= "Coordinate_click"
var_color 		:= "Accepting_color"
var_excep		:= "Exceptions"
ico_color		:= "Icon_menu_color"
file_name 		:= "check_value.ini"

;1 = lobby_x_check, 2 = lobby_y_check, 3 = lobby_x_click, 4 = lobby_y_click, 5 = lobby_c_check
;6 = icon_x1_check, 7 = icon_y1_check, 8 = icon_x2_check, 9 = icon_y2_check, 10 = icon_x3_check
;11 = icon_y3_check, 12 = icon_cr_check, 13 = icon_cr_check_two, 14 = icon_cr_check_three
acceptLobby(all_values) {
    while True {
		PixelGetColor, lobby_color, all_values[1], all_values[2]
		if (lobby_color = all_values[5]) {
			PixelGetColor, icon_color, all_values[6], all_values[7] ; icon_menu_x - icon_menu_y
			PixelGetColor, settings_color, all_values[8], all_values[9] ; settings_menu_x - settings_menu_y
			PixelGetColor, quit_color, all_values[10], all_values[11] ; quit_menu_x - quit_menu_y
			if (icon_color != all_values[12] && settings_color != all_values[13]
					&& quit_color != all_values[14])
			{
				click_x := all_values[3]
				click_y := all_values[4]
				sleep 200
				click, %click_x%, %click_y%
				sleep 200
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
	global var_check, var_click, var_color, var_excep, ico_color

	IniRead, lobby_x_check, %file_name%, %var_check%, x
	IniRead, lobby_y_check, %file_name%, %var_check%, y
	IniRead, lobby_x_click, %file_name%, %var_click%, x
	IniRead, lobby_y_click, %file_name%, %var_click%, y
	IniRead, lobby_c_check, %file_name%, %var_color%, Color

	IniRead, icon_x1_check, %file_name%, %var_excep%, icon_menu_x
	IniRead, icon_y1_check, %file_name%, %var_excep%, icon_menu_y
	IniRead, icon_x2_check, %file_name%, %var_excep%, settings_menu_x
	IniRead, icon_y2_check, %file_name%, %var_excep%, settings_menu_y
	IniRead, icon_x3_check, %file_name%, %var_excep%, quit_menu_x
	IniRead, icon_y3_check, %file_name%, %var_excep%, quit_menu_y
	IniRead, icon_cr_check, %file_name%,  %ico_color%, icon_color
	IniRead, icon_cr_check_two, %file_name%,  %ico_color%, settings_color
	IniRead, icon_cr_check_three, %file_name%,  %ico_color%, quit_color

	huge_list := [ lobby_x_check, lobby_y_check
		, lobby_x_click, lobby_y_click
		, lobby_c_check
		, icon_x1_check, icon_y1_check
		, icon_x2_check, icon_y2_check
		, icon_x3_check, icon_y3_check
		, icon_cr_check, icon_cr_check_two, icon_cr_check_three ]
	return huge_list
}
cal(a, ratio)
{
	c := a * ratio
	return floor(c)
}
write_default_values(file_name, width, height) {
	global var_check, var_click, var_excep, var_color, ico_color

	ratio := width/1024
	ini_write(cal(775, ratio), cal(22, ratio), "x", "y", var_check, file_name)
	ini_write(cal(511, ratio), cal(449, ratio), "x", "y", var_click, file_name)
    IniWrite, 0x184757, %file_name%, %var_color%, Color

	ini_write(cal(227, ratio), cal(100, ratio), "icon_menu_x", "icon_menu_y", var_excep, file_name)
	ini_write(cal(501, ratio), cal(74, ratio), "settings_menu_x", "settings_menu_y", var_excep, file_name)
	ini_write(cal(438, ratio), cal(257, ratio), "quit_menu_x", "quit_menu_y", var_excep, file_name)
	ini_write(0x130A01, 0x130A01, "icon_color", "settings_color", ico_color, file_name)
	IniWrite, 0x130A01, %file_name%, %ico_color%, quit_color
}

main() {
	global file_name
    if (FileExist(file_name)) {
		all_values := read_ini(file_name)
		acceptLobby(all_values)
    } else {
		MsgBox,,, % "Couldn't find the file : " file_name "`nPress F1 to set the default values"
	}
}

main()

get_values(file_name, section_list) {
	new_list := ["x", "y", "icon_menu_x", "icon_menu_y", "settings_menu_x", "settings_menu_y", "quit_menu_x", "quit_menu_y", "Color"
	, "icon_color", "settings_color", "quit_color"]
	section_list.MaxIndex()
	for values in section_list
	{
		section_name := section_list[values]
		IniRead, check_str, %file_name%, %section_name%
		list_key := []
		x := 0
		loop, Parse, check_str, `n
		{
			x += 1
			list_key[x] := A_LoopField
			list_key := StrSplit(list_key[x], "=")
			for i in new_list
			{
				if (list_key[1] = new_list[i])
					break
				if (i = new_list.MaxIndex() && list_key[1] != new_list[i])
				{
					msgbox, % "Error :`nValue not found :`n" list_key[1] " found in " section_name
					return 0
				}
			}
		}
	}
	return 1
}

checking_file() {
	global var_check, var_click, var_color, var_excep, ico_color, file_name
	my_check_list := [var_check, var_click, var_color, var_excep, ico_color]
	IniRead, sections, %file_name%
	section_name := []
	loop, Parse, sections, `n
	{
		x += 1
		nb_section := a_index
		section_name[x] := A_LoopField
	}
	if (nb_section != my_check_list.MaxIndex())
	{
		MsgBox, % "Incorrect number of sections :`n" %nb_section% " instead of " my_check_list.MaxIndex()
		return 0
	}
	for x in my_check_list
	{
		if (section_name[x] != my_check_list[x])
		{
			MsgBox, % "Error :`nWrong section name : `n" section_name[x] " instead of " my_check_list[x]
			return 0
		}
	}
	check_section := get_values(file_name, section_name)
	if (!check_section)
		return 0
	Return 1
}

msgbox_text(x_pos, y_pos, text_msgbox, file_color = False, check_color = False) {
	msgbox,,, % "Checking the pixel to " text_msgbox "`n" x_pos " - " y_pos "`nPlease select the client again (you have 1 sec)`nThis message will disapear in 5 seconds", 5
	sleep 1000
	MouseMove, %x_pos%, %y_pos%, 20
	if (check_color)
	{
		PixelGetColor, color_get_output, %x_pos%, %y_pos%
		msgbox,,, % "Color detected : " color_get_output " Color in the file : " file_color
	}
}

mouse_move(list_pos) {
	msgbox_text(list_pos[1], list_pos[2], "detect the riot RP logo (dark version, when the match pop-up)", list_pos[5], True)
	msgbox_text(list_pos[3], list_pos[4], "click on the accepting")
	msgbox_text(list_pos[6], list_pos[7], "the first exception (icon's menu, by default)", list_pos[12], True)
	msgbox_text(list_pos[8], list_pos[9], "the second exception (setting's menu, by default)", list_pos[13], True)
	msgbox_text(list_pos[10], list_pos[11], "the third exception (quit's menu, by default)", list_pos[14], True)
}

F1::
	if (FileExist(file_name))
	{
		MsgBox, 4, Confirmation, % "The file already exist. Do you wanna delete it ?"
		IfMsgBox, Yes
			FileDelete, %file_name%
	}
	MsgBox,,, % "Select the league client to setup default values`nYou have 5 seconds. this message will delete itself", 5
	sleep 1000
	WinGetActiveStats, useless_var, Width, Height, X, Y
	write_default_values(file_name, Width, Height)
	msgbox, 48,, % "Done", 2
	return
F2::
    MouseGetPos, xPos, yPos
    PixelGetColor, colorTest, xPos, yPos
    clipboard := "x"xPos " y"yPos " = " colorTest
    MsgBox, x%xPos% y%yPos% = %colorTest%`nCopied to clipboard
    return
F3::
	v := checking_file()
	if (v)
		MsgBox, % "The file is good. Nothing that i could detect wrong with it"
	return
F4::
	my_list := read_ini("check_value.ini")
	MsgBox, % "The mouse is gonna move alone.`nit will read the program's file input to check if everything is ok according to you"
	mouse_move(my_list)
	return
F5::
	InputBox, coordinate, Get color of specific pixel, Input your x and y coordinate `n : exemple -> 775 22`n`n and select the client
	coordinate_split := StrSplit(coordinate, A_Space, ",")
	sleep 1000
	PixelGetColor, color_coordinate, coordinate_split[1], coordinate_split[2]
	msgbox, % color_coordinate
	return
F11::
    Pause
