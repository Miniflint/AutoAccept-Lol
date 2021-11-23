# AutoAccept-Lol
## Useful tools :
F2 -> get the position of the mouse (x, y) + the color (in hex) of the active window
Display it in a messagebox and copy it to the clipboard

F3 -> Check if the ("check_value.ini") file is correct

F11 -> pause the script

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


## Usage
How to use it :
  1. Launch the script (probably an exe file. you can also take the ahk file if you have [AutoHotKey](https://www.autohotkey.com) installed)
  2. If it doesn't work [follow the steps bellow](https://github.com/Miniflint/AutoAccept-Lol/edit/main/README.md#In-case-of-problems)

## Code
### Brut Code
```
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
		}
```

### Explanation
`acceptLobby(all_values) {` : Create a function that take 1 parameter, and open the bracket (1)

`While True {` : While it's True is True (infinite loop) (2)

`PixelGetColor` : Get the color of [Coordinate_check] pixels and store the variable in "Lobby_color"

`if (lobby_color = all_values[5]) {` : If you find a match between "Lobby_color" and [Accepting_color], go in this condition (3)

`PixelGetColor` : Get the color value of [ChangingIcon_menu] x1 - y1 and store it in "icon_color"

`Other 2 pixelGetColor` : same but for x2 - y3

`if (icon_color != all_values[12] && icon_color_two != all_values[13]
	&& icon_color_three != all_values[14])` : if you don't find a match between "icon_color" and [ChangingIcon_menu] (all the 3 PixelGetColor and the color that goes with it), Go in this condition

`{` open the bracket of cond 2 (4)

`click_x := all_values[3]` : Store the value of [Coordinate_click] x in "click_x"

`click_y := all_values[4]` : Store the value of [Coordinate_click] y in "click_y"

`sleep 200` : Do nothing for 200 ms

`click, %click_x%, %click_y%` : Click at "click_x" and "click_y" position

`sleep 200` : Do nothing for 200 ms again

`}` : exit second condition (4)

`} else {` : exit first condition and enter the else (if you don't find a match between "Lobby_color" and [Accepting_color]) (3)(3)

`sleep, 400` : sleep for 400 ms

`}` : close the else condition (3)

`}` : close the While True condition (2)

`}` : Close the function (1)

## In case of problems
### The script doesn't work : what can you do ?

__If the mouse move at the wrong place :__ [click Here](https://github.com/Miniflint/AutoAccept-Lol/edit/main/README.md#Problem-n1-->-the-script-is-moving-the-mouse-at-the-wrong-place)

__If the mouse doesn't move :__ [click Here](https://github.com/Miniflint/AutoAccept-Lol/edit/main/README.md#Problem-n2-->-the-mouse-doesn't-move)

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
  1. Open the ini file ("check_value.ini")
  2. Get un-animated element on the screen
  3. Press F2
  4. Try to change a value until it work (x and y should leads to one hexadecimal color)
  5. If the mouse go to the wrong pos, [Check this](https://github.com/Miniflint/AutoAccept-Lol/edit/main/README.md#Problem-n1-->-the-script-is-moving-the-mouse-at-the-wrong-place)
