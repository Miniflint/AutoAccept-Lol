#NoEnv
SetWorkingDir %A_ScriptDir%

var_check 		:= "Coordinate_check"
var_click 		:= "Coordinate_click"
var_color 		:= "Accepting_color"
var_excep		:= "Exceptions"
ico_color		:= "Icon_menu_color"
log_file		:= "Log_File"
my_check_list 	:= [var_check, var_click, var_color, var_excep, ico_color, log_file]

file_name 		:= "check_value.ini"
name 			:= "ahk_class RCLIENT"

; 1 = lobby_x_check, 2 = lobby_y_check, 3 =  lobby_x_click, 4 =  lobby_y_click,  5 =  lobby_c_check,  6 =  icon_check_x,  7 =  icon_check_y,  8 =  settings_check_x,  9 =  settings_check_y,  10 =  quit_menu_x,  11 =  quit_menu_y,  12 =  icon_color,  13 =  settings_color,  14 =  quit_menu_color ]

log(text_write)
{
	log_file := "log_files.log"
	FormatTime, CurrentDateTime,, dd-MM-yyyy HH:mm:ss
	CurrentDateTime := "-----------" CurrentDateTime "----------- : "
	FileAppend, % CurrentDateTime text_write "`n", % log_file
}

Pixel_errorlevel(x, y, color_search, variation = 3)
{
	PixelSearch, val_x, val_y, %x%, %y%, %x%, %y%, %color_search%, %variation%
	if (errorlevel)
		return 0
	return 1
}

acceptLobby(all_values, log_check)
{
    while True
	{
		accept := Pixel_errorlevel(all_values[1], all_values[2], all_values[5], 10)
		if (accept)
		{
			error_icon 		:= Pixel_errorlevel(all_values[6], all_values[7], all_values[12])
			error_settings 	:= Pixel_errorlevel(all_values[8], all_values[9], all_values[13])
			error_quit		:= Pixel_errorlevel(all_values[10], all_values[11], all_values[14])
			if (!error_icon && !error_settings && !error_quit)
			{
				if (log_check = "True")
					log("Match found")
				click_x := all_values[3]
				click_y := all_values[4]
				sleep 200
				click, %click_x%, %click_y%
				sleep 200
			}
		}
		else
		{
			sleep, 400
		}
    }   
}

ini_write(x, y, name1, name2, section_name, file_name)
{
	IniWrite, %x%, %file_name%, %section_name%, %name1%
	IniWrite, %y%, %file_name%, %section_name%, %name2%
}
; my_check_list 	:= [var_check, var_click, var_color, var_excep, ico_color, make_log_file]
read_ini(file_name)
{
	global my_check_list

	IniRead, lobby_x_check, %file_name%, % my_check_list[1], x
	IniRead, lobby_y_check, %file_name%, % my_check_list[1], y
	IniRead, lobby_x_click, %file_name%, % my_check_list[2], x
	IniRead, lobby_y_click, %file_name%, % my_check_list[2], y
	IniRead, lobby_c_check, %file_name%, % my_check_list[3], Color

	IniRead, icon_x, %file_name%, % my_check_list[4], icon_menu_x
	IniRead, icon_y, %file_name%, % my_check_list[4], icon_menu_y
	IniRead, settings_x, %file_name%, % my_check_list[4], settings_menu_x
	IniRead, settings_y, %file_name%, % my_check_list[4], settings_menu_y
	IniRead, quit_menu_x, %file_name%, % my_check_list[4], quit_menu_x
	IniRead, quit_menu_y, %file_name%, % my_check_list[4], quit_menu_y
	IniRead, icon_color, %file_name%, % my_check_list[5], icon_color
	IniRead, settings_color, %file_name%, % my_check_list[5], settings_color
	IniRead, quit_menu_color, %file_name%, % my_check_list[5], quit_color

	IniRead, log_file, %file_name%, % my_check_list[6], make_log_file

	huge_list := [ lobby_x_check, lobby_y_check
		, lobby_x_click, lobby_y_click
		, lobby_c_check
		, icon_check_x, icon_check_y
		, settings_check_x, settings_check_y
		, quit_menu_x, quit_menu_y
		, icon_color, settings_color, quit_menu_color ]
	return huge_list
}

cal(a, ratio)
{
	c := a * ratio
	return floor(c)
}

write_default_values(file_name, width, height)
{
	global my_check_list

	ratio := width/1024
	ini_write(cal(775, ratio), cal(22, ratio), "x", "y", my_check_list[1], file_name)
	ini_write(cal(511, ratio), cal(449, ratio), "x", "y", my_check_list[2], file_name)
    IniWrite, 0x184857, %file_name%, % my_check_list[3], Color

	ini_write(cal(227, ratio), cal(100, ratio), "icon_menu_x", "icon_menu_y", my_check_list[4], file_name)
	ini_write(cal(377, ratio), cal(142, ratio), "settings_menu_x", "settings_menu_y", my_check_list[4], file_name)
	ini_write(cal(438, ratio), cal(257, ratio), "quit_menu_x", "quit_menu_y", my_check_list[4], file_name)
	ini_write(0x130A01, 0x130A01, "icon_color", "settings_color", my_check_list[5], file_name)
	IniWrite, 0x130A01, %file_name%, % my_check_list[5], quit_color

	IniWrite, True, %file_name%, % my_check_list[6], make_log_file
}

main()
{
	global file_name

    if (!FileExist(file_name)) {
		MsgBox,,, % "Couldn't find the file : " file_name "`nPress F1 to set the default values"
    }
	if (FileExist(file_name))
	{
		IniRead, log_check, %file_name%, Log_File, make_log_file
		if (log_check = "True")
			log("Starting")
		all_values := read_ini(file_name)
		acceptLobby(all_values, log_check)
	}
}

main()

get_values(file_name, section_list)
{
	new_list := ["x", "y", "icon_menu_x", "icon_menu_y", "settings_menu_x", "settings_menu_y", "quit_menu_x", "quit_menu_y", "Color"
	, "icon_color", "settings_color", "quit_color", "make_log_file"]
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

checking_file()
{
	global my_check_list, file_name
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

msgbox_text(x_pos, y_pos, text_msgbox, file_color = False, check_color = False)
{
	msgbox,,, % "Checking the pixel to " text_msgbox "`n" x_pos " - " y_pos, 5
	WinActivate, %name%, WinText, ExcludeTitle, ExcludeText]
	sleep 200
	MouseMove, %x_pos%, %y_pos%, 20
	if (check_color)
	{
		PixelGetColor, color_get_output, %x_pos%, %y_pos%
		msgbox,,, % "Color detected : " color_get_output " Color in the file : " file_color, 3
	}
}

mouse_move(list_pos)
{
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
	if (!FileExist(file_name)) {
		if (WinExist(name))
		{
			WinGetPos,,, Width, Height, %name%
			write_default_values(file_name, Width, Height)
			msgbox, 48,, % "Done", 2
		}
		else
		{
			msgbox,,, % "Couldn't fine the league Client. please open it`nClick OK if the client is already open`nThis message will stay 5 sec", 5
			IfMsgBox, ok
			{
				sleep 1000
				WinGetActiveStats, Title, Width, Height, X, Y
				write_default_values(file_name, Width, Height)
				msgbox, 48,, % "Done", 2
			}
		}
	}
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
	InputBox, coordinate, Get color of specific pixel, Input your x and y coordinate `n : exemple -> 775 22
	coordinate_split := StrSplit(coordinate, A_Space, ",")
	if (WinExist(name))
		WinActivate, %name%
	else
	{
		msgbox, % "couldn't detect the league client, open it manually "
	}
	PixelGetColor, color_coordinate, coordinate_split[1], coordinate_split[2]
	msgbox, % color_coordinate
	return
F11::
    Pause
