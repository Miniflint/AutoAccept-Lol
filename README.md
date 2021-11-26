# AutoAccept-Lol
__ONLY WORKS ON WINDOWS__

## Useful tools :
`F1` -> Write [the default values](https://github.com/Miniflint/AutoAccept-Lol/blob/main/README.md#Default-Values) in ("check_value.ini")
	- overwrite the value if the file already exists
	- create the file if it didn't exists

`F2` -> get the position of the mouse (x, y) + the color (in hex) of the active window
	- Display it in a messagebox and copy it to the clipboard

`F3` -> Check if the ("check_value.ini") file is correct

`F4` -> Check values from the file
	- move the mouse at the location of the values
	- is it useful ? yes if you need to check visually what pixels it take

`F5` -> check color at specific pixel

`F11` -> pause the script
	- important if the mouse is not going where you want it to go


## Usage
How to use it :
  1. First start press F1
     - [Check this](https://github.com/Miniflint/AutoAccept-Lol/blob/main/README.md#debugging-the-script-or-first-start)
  2. Launch the script (probably an exe file. you can also take the ahk file if you have [AutoHotKey](https://www.autohotkey.com) installed)
  3. If it doesn't work [follow the steps bellow](https://github.com/Miniflint/AutoAccept-Lol/blob/main/README.md#in-case-of-problems)


## Default Values
The value i am trying to take for the script are as follow :
  1. [Coordinate_check]
     - Riot Rp logo (X and Y)(because it's not animated)
  2. [Coordinate_click]
     - ~ the middle of the _accept match_ button (so even with a bit of misclick it will still click on it)
  3. [Accepting_color]
     - darker RP logo (darker because of when the match pop-up) in hexadecimal
  4. [ChangingIcon_menu]
     - Summoner's icon menu :
     - because nothing is perfect, when you try to change your summoner's icon, it has the same color as when the match pop-up
     - So i am making a double if condition to check if we are changing the icon or if we are accepting a match
     - all of the coordinate are different position of the background menu (0x130A01)
  5. [Icon_menu_color]
     - Color of the summoner's icon menu's background
     - icon_color_three is equal to the disconnect menu's background
     - theses one is also an hexadecimal value. it's the color of the background
     - Both have the same value. but they can support different values. as long as the they are all correct (pixel coord + color)

## Code
### Brut Code
```
acceptLobby(all_values, log_check)
{
	game_name := "ahk_class RiotWindowClass"
    	while True
	{
		if (!WinExist(game_name))
		{
			accept := Pixel_errorlevel(all_values[1], all_values[2], all_values[5], 10)
			if (accept)
			{
				error_icon 		:= Pixel_errorlevel(all_values[6], all_values[7], all_values[14])
				error_settings	:= Pixel_errorlevel(all_values[8], all_values[9], all_values[15])
				error_quit		:= Pixel_errorlevel(all_values[10], all_values[11], all_values[16])
				error_post		:= Pixel_errorlevel(all_values[12], all_values[13], all_values[17], 30)
				x = 0
				if (!error_icon && !error_settings && !error_quit && !error_post)
				{
					if (x = 0)
						if (log_check = "True")
							Put_text("Match found")
					click_x := all_values[3]
					click_y := all_values[4]
					sleep 200
					click, %click_x%, %click_y%
					sleep 200
					x = 1
				}
			}
			else
			{
				sleep, 400
			}
		}
    	}   
}
```

### Quick explanation
it's an infinite loop that will permanantly check the value of 1 pixel, if the condition is true, it will check 4 other pixels. if the condition is true, it will
simply click on the accept button (value from : [Coordinate_click] section)


## In case of problems
### The script doesn't work : what can you do ?

__If the mouse move at the wrong place :__ [click Here](https://github.com/Miniflint/AutoAccept-Lol/blob/main/README.md#problem-n1-->-the-script-is-moving-the-mouse-at-the-wrong-place)

__If the mouse doesn't move :__ [click Here](https://github.com/Miniflint/AutoAccept-Lol/blob/main/README.md#problem-n2-->-the-mouse-doesn't-move)

### follow this steps :
  1. Open the Ini file that has been created with the first execution of the script ("check_value.ini")
  2. Open the league client
  3. Be ready to press F2 on some element on the screen (Something that is not gonna change color when you go on the shop, like the RP logo)
  4. Press F2 on the Riot logo when the screen is darker (match pop-up)
  5. Modify the Ini file with the new values (copied in your clipboard)


## If it still doesn't works
### Problem n1 -> the script is moving the mouse at the wrong place
  1. Open the ini file ("check_value.ini")
  2. Queue for a league of legend game
  3. Wait for a match to Pop up on the screen
  4. Press F2 where you want the mouse to click
  5. get the X and Y value
  6. Modify the ini file in the [Coordinate_click] section by your values


### Problem n2 -> the mouse doesn't move
In this case, it's less specific. but we can work it out anyway
  1. Reset the ini file (press F1)
  2. Press F3 to check the ini file
  3. Press F4 to check where the mouse is taking the values (riot RP logo, accepting, exception 1, exception 2, exception 3, exception 4)
  4. Watch the logs file ("log_files.log")


### Debugging the script or first start
__First start__ : Press F1 it will take the size and adapt the values

__Debugging__ :
Utils : [click here](https://github.com/Miniflint/AutoAccept-Lol/blob/main/README.md#useful-tools-)
 1. Try `F3`
    - it will check if something there is something wrong with the file
 2. if everything is good, try `f4`
    - it will make your mouse move and you will visually see which one is at the wrong place
 3. if everything is still good you can try to put different value in the file ("check_value.ini")
