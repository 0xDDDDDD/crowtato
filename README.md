# crowtato
gamejam for Callunas birthday


## Sept 12th Target
- ~~Create Scene file. Main should be able to read this to build the UI. UI positioning and changes should work from the scene file.~~
- Get main player into the game, able to WASD around (no anim). All input can be handled in main at this point.
- Make enemy spawner object and add into scene file, use shifting target to spawn enemies randomly and move towards player
- Iterate over all of the code thus far, clean up, make changes in consideration for timers, anims, input manager and so on.
- Create 4 more decrees
- Add "multi" option on decrees, change decree choice generator to omit a non-multi choice if it's already owned. (Do not remove from list... Spent decrees can show up again)

<br><br>

# Minor tweaks needed
- Maybe decree points counter should count downwards? each decree it starts higher, and you need to get it to 0 to get decree at end of wave?

<br><br>

# Controls
- WASD to move around
- Auto attack
- < and > for volume up and down
- ESC immediately exits game

<br><br>

# Lessons from this project

## Data ownership
It's a good idea to implement rust style ownership over data. Since this can't be enforced in languages like Lua, Python etc, maybe it's a good idea to at least design with that intent being obvious in the design. A decent practise may be to add a simple prefix or suffix to denote a variable that should never be mutated and instead treated as read-only.
<br>

## Error handling
While it's not done well in this project, in future projects I need to learn about graceful and low-cost error handling in lua. 
