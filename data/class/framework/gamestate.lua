--Blueprint. Instances inherit directly from this.
--uses new "context.class" implementation
--I need a data structure that uses "initialize" and is called that way. So here's what we'll do.
--[[
    Ultimately I think a GameState is:
        An ObjectSystem with the categories "Space" and "Overlays"
        One or more Input sources
        "Load" and "Unload" with respect to States
        

]]
local defaults = {
    type = "GameState",
    Name = "GameStatePrototype",
    systems = {ObjectSystem = "ObjectSystem", MultiverseSystem = "MultiverseSystem", DataSystem = "DataSystem"},    ---DataSystem; tbd
    apply = {},
    update = "inputs",
    draw = "basic",
}

return function(context)
    local State = context.Class:extend(defaults)
   
    function State:construct(a)   
        --add "Space" and "Overlays" categories
        --Add whatever the game's input sources (is/are)
    end    

    function State:load() --called at the START of the gamestate
        --get the "context", which can be one of two basic categories:
            --An "active gameplay" context which will load a save game or start a new game
            --An "out of gameplay" context which is stuff like the main menu or other things that may crop up
        --specifically target self.systems.WorldSystem:load(context), instantiating the World. If the World is not in active gameplay
                                                        --this framework will nonetheless let us load things like "demos" and title screen game animations
        --load overlays, which are also based on context most likely
        --load the current inputs

    end

    function State:save()


    end

    function State:processInputs(dt)
        --"inputs" update calls this
        --processes self.input variables and then sends them to its World and its Overlays


    end

    function State:unload()
        --unload everything inside load. wrt the actual main gameplay state this will probably only be called when ending the game

    end

    return State
end
