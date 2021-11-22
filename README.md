# AutoAccept-Lol
# USE AUTOACCEPT V2
## Useful tools :
F2 -> get the position of the mouse (x, y) + the color (in hex)
F11 -> pause the script

## Default Values
The value i am trying to take are as follow :
  1. [Coordinate_check]
     - Riot Rp logo (X and Y)(because it's not animated)
  2. [Coordinate_click]
     - ~ the middle of the _accept match_ button (so even with a bit of misclick it will still click on it)
  3. [Accepting_color]
     - This one is an hexadecimal Value. It's the darker RP logo (darker because of when the match pop-up)
  4. [ChangingIcon_menu]
     - because nothing is perfect, when you try to change your summoner's icon, it has the same color as when the match pop-up
     - So i am making a double if condition to check if we are changing the icon or if we are accepting a match
     - all of the coordinate are different position of the background menu (0x130A01)
  5. [Icon_menu_color]
     - this one is also an hexadecimal value. it's the color of the background
     - Both have the same value. but they can support different values. as long as the x1 and y1 + x2 and y2 have the correct coordinate and colors


## Usage
How to use it :
  1. Launch the script (probably an exe file for you)
  2. If it doesn't work [follow the steps bellow](https://github.com/Miniflint/AutoAccept-Lol/edit/main/README.md#In-case-of-problems)


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
