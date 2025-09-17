# crowtato
gamejam for Callunas birthday


## Sept 20th Target
- Get a song done. Even if its a basic repeating ostinato with some chords (but lets aim for 3 movements, minimum)
- Finish the input handler, complete with context awareness to clean out all the code in the gamestate manager
- Set up the game state related stuff. 
- Set up the framework at least, for the collision/hit detection and enemy range detection.

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

# Stretch Goals
- Weapons (different system for projectile vs melee)
- Osteo Striga, Evensong, Glaive, Kompressa
- Randomized boss that shows up repeatedly but randomly (think: tormentor in onslaught)

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
