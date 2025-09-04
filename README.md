# crowtato
gamejam for Callunas birthday


## Sept 5th Target
- ~~Fully functioning UI Elements~~
- ~~Fully functioning decree picker (Current harness, disable all other input, trigger this with "d" to add new decrees)~~
- Add UI Module
- Get tooltips working

## Sept 12th Target
- Move current harness into "Test scene"
- Get test scene loading up with Scene manager
- Create a more organized Menu scene and get it booting with Scene manager
- Create a game scene skeleton. Maybe get UI booting with it. 

## Sept 17th Target (functional pushes only from this point)
- Get Menu scene buttons working (Play/Exit only)
- Get Game timer running
- Create Animation object, Test with "Player" object
- Create enemy spawner that spawns 5 enemies. Does nothing more. 

## Sept 21st Target
- Separate Combat loop, pre-wave timer and decree picker states
- Implement enemy collision detect and attack logic
- Implement decree pick after 100 points. 


<br/><br/><br/>

# Lessons from this project

## Data ownership
It's a good idea to implement rust style ownership over data. Since this can't be enforced in languages like Lua, Python etc, maybe it's a good idea to at least design with that intent being obvious in the design. A decent practise may be to add a simple prefix or suffix to denote a variable that should never be mutated and instead treated as read-only.
