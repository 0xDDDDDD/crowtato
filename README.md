# crowtato
gamejam for Callunas birthday


## Sept 5th Target
- ~~Fully functioning UI Elements~~
- ~~Fully functioning decree picker (Current harness, disable all other input, trigger this with "d" to add new decrees)~~
- ~~Add UI Module~~
- Get tooltips working

## Sept 12th Target
- Create Scene Manager/host (which is more applicable?)
- Create Scene file, start offloading main.lua UI test harness into it
- Finish getting entire UI into scene file and decide how a scene file should look
- Based on the code in the UI manager, set up the input manager
- Get main player into the game, able to WASD around (no anim)
- Get enemy spawner object, use shifting target to spawn enemies randomly and move towards player
- Iterate over all of the code thus far, clean up, make changes in consideration for timers and anims and so on.


# Minor tweaks needed
- Maybe decree points counter should count downwards? each decree it starts higher, and you need to get it to 0 to get decree at end of wave?


# Controls
- WASD to move around
- Auto attack
- hold LMB for active attack? (possible secondary bigger attack w/cooldown?)
- < and > for volume up and down
- ESC immediately exits game


<br/><br/><br/>

# Lessons from this project

## Data ownership
It's a good idea to implement rust style ownership over data. Since this can't be enforced in languages like Lua, Python etc, maybe it's a good idea to at least design with that intent being obvious in the design. A decent practise may be to add a simple prefix or suffix to denote a variable that should never be mutated and instead treated as read-only.
