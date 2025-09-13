# crowtato
gamejam for Callunas birthday


## Sept 16th Target
- Finish the functionality of the spawner
- Add the different game states into the manager: inPlay, pickDecree, and the logic for switching waves.
- Add the attacking when enemy is in range (util/math helpers for range/direction)
- Add the anim for attacking, including rotating it for the enemy direction
- Figure out how to make a collision for the hit to attack multiple enemies
- Add the more functional side of enemies (collisions, hp, etc)

## Sept 19th Target
- Refactor to make sure a clean stream between interactions and wave control
- Set up exposed values to allow for decree modifying values such as player, enemy, and reading game state values like wave, coins, etc
- Refactor to make Input manager and move input there to clean it up.

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
<br>

## Order of Operations
While BODMAS/PEMDAS is undeniably good to know it does nothing for actual readability. always use parenthesis so that there is one consistent style rather than having to switching between an abstract ruleset when it applies and parenthesis when it doesn't.
<br>
