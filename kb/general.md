All information starts here.

Information gets moved to a dedicated document only when warranted.

===== Container Architecture =====
data.container.class requires primitive types
data.class.classInstances establishes type instances


===== Game Architecture =====

# Top Level -- main.lua
**PreLoad**: *this is all loaded before the Love engine is initialized*
    - aliases `lg, lk, la, lm`
    - require 'load.globals' *this should be dove into with a globals kb*
    - require 'load.requires' *this can be examined with a requires kb*
    - love.run = require 'run' *just a fixed timestep*

**Load** *love.load(), this is for anything that needs to deterministically have love engine initialized*
    - testfont *_G.TestFont*
    - controller *_G.controller*
    - set up push
    - lg.setDefaultFilter
    - gcore:load() *loads gamecrash core lib... why do we load it <--here?*
    - Game:load("FirstState") *<---HERE is where we put the opening state. Menu, splash sequence, etc*


**GameLoop** *from here, the game runs. We will dive deep into this in Second level*

    - **Update**
    - Memory:update(dt)
    - controller:update(dt)
    - gcore:update(dt)       
    - flux.update(dt)
    - Game:update(dt)     --the magic happens here
    - controller.wheel.x, controller.wheel.y = 0,0  
    - **Draw**
    - lg.clear()
    - push:start()
    - Game:draw()         --the magic is *drawn* here
    - gcore:draw()
    - push:finish()


## Second Level -- data.class.framework.game.lua
*putting the "second level gameloop code" three levels deep might be confusing*
    **Game:update(dt)**
        - Updates State:update(dt)  *Classes.GameState.Modes[mode]*

## Third Level -- data.class.framework.modes[gamemode].lua
*the actual game logic is now directly contained and accessed from here*
*game is controlled from a "mode"*
    **Defined in class.framework.gamestates**
    local systemOrder = {"DataSystem","MultiverseSystem","ObjectSystem"}

    gamemode.memory ; where everything is going to get stored
    local objectSystem = gamemode.memory:get("objectSystem")
    -- do stuff with objectSystem


    gamemode.memory:update(dt) -- updates the systems in systemorder
    gamemode.memory:draw() -- draws the systems in systemmorder
-------------------------------------------------------------

