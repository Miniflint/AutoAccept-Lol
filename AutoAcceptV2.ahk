var_check 		:= "Coordinate_check"
var_click 		:= "Coordinate_click"
var_color 		:= "Accepting_color"
var_icons		:= "ChangingIcon_menu"
ico_color		:= "Icon_menu_color"

acceptLobby(all_values) {
	;1 = lobby_x_check, 2 = lobby_y_check, 3 = lobby_x_click, 4 = lobby_y_click, 5 = lobby_c_check
	;6 = icon_x1_check, 7 = icon_y1_check, 8 = icon_x2_check, 9 = icon_y2_check, 10 = icon_x3_check
	;11 = icon_y3_check, 12 = icon_cr_check, 13 = icon_cr_check_two, 14 = icon_cr_check_three
    while True {
		PixelGetColor, lobby_color, all_values[1], all_values[2]
		if (lobby_color = all_values[5]) {
			PixelGetColor, icon_color, all_values[6], all_values[7] ; x1 - y1
			PixelGetColor, icon_color_two, all_values[8], all_values[9] ; x2 - y2
			PixelGetColor, icon_color_three, all_values[10], all_values[11] ; x3 - y3
			if (icon_color != all_values[12] && icon_color_two != all_values[13]
					&& icon_color_three != all_values[14])
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
	global var_check, var_click, var_color, var_icons, ico_color

	IniRead, lobby_x_check, %file_name%, %var_check%, x
    IniRead, lobby_y_check, %file_name%, %var_check%, y
    IniRead, lobby_x_click, %file_name%, %var_click%, x
    IniRead, lobby_y_click, %file_name%, %var_click%, y
    IniRead, lobby_c_check, %file_name%, %var_color%, Color

	IniRead, icon_x1_check, %file_name%, %var_icons%, x1
	IniRead, icon_y1_check, %file_name%, %var_icons%, y1
	IniRead, icon_x2_check, %file_name%, %var_icons%, x2
	IniRead, icon_y2_check, %file_name%, %var_icons%, y2
	IniRead, icon_x3_check, %file_name%, %var_icons%, x3
	IniRead, icon_y3_check, %file_name%, %var_icons%, y3
    IniRead, icon_cr_check, %file_name%,  %ico_color%, icon_color_one
	IniRead, icon_cr_check_two, %file_name%,  %ico_color%, icon_color_two
	IniRead, icon_cr_check_three, %file_name%,  %ico_color%, icon_color_three

	huge_list := [ lobby_x_check, lobby_y_check
		, lobby_x_click, lobby_y_click
		, lobby_c_check
		, icon_x1_check, icon_y1_check
		, icon_x2_check, icon_y2_check
		, icon_x3_check, icon_y3_check
		, icon_cr_check, icon_cr_check_two, icon_cr_check_three ]
	return huge_list
}

write_default_values(file_name) {
	global var_check, var_click, var_icons, var_color, ico_color

	ini_write(775, 22, "x", "y", var_check, file_name)
	ini_write(500, 450, "x", "y", var_click, file_name)
    IniWrite, 0x184757, %file_name%, %var_color%, Color

	ini_write(227, 100, "x1", "y1", var_icons, file_name)
	ini_write(648, 109, "x2", "y2", var_icons, file_name)
	ini_write(440, 254, "x3", "y3", var_icons, file_name)
	ini_write(0x130A01, 0x130A01, "icon_color_one", "icon_color_two", ico_color, file_name)
	IniWrite, 0x130A01, %file_name%, %ico_color%, icon_color_three
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

get_values(file_name, section_list) {
	new_list := ["x", "y", "x1", "y1", "x2", "y2", "x3", "y3", "Color"
	, "icon_color_one", "icon_color_two", "icon_color_three"]
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
				{
					break
				}
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
	global var_check, var_click, var_color, var_icons, ico_color
	file_name := "check_value.ini"
	my_check_list := [var_check, var_click, var_color, var_icons, ico_color]
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

F2::
    MouseGetPos, xPos, yPos
    PixelGetColor, colorTest, xPos, yPos
    clipboard := "x"xPos " y"yPos " = " colorTest
    MsgBox, x%xPos% y%yPos% = %colorTest%`nCopied to clipboard
    return
F3::
	v := checking_file()
	if (v)
		MsgBox, % "Tout est bon !"
	return
F11::
    Pause
