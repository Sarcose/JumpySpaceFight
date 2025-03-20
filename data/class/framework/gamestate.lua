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
    systems = {ObjectSystem = "ObjectSystem", MultiverseSystem = "MultiverseSystem", DataSystem = "DataSystem" },    ---DataSystem; tbd
    apply = {},
    update = "inputs",
    draw = "basic",
}

local systemOrder = {"DataSystem","MultiverseSystem","ObjectSystem"}

return function(context)
    local State = context.Class:extend(defaults)
    local def = gcore.var.deepcopy(defaults)
    def.Name = "GameState_Unnamed"
    function State:construct(a)   
        local d = gcore.var.deepcopy(def)
        if type(a,"table") then gcore.var.merge(d,a) end
        local s = self:extend(d)
        return s
        --add "Space" and "Overlays" categories
        --Add whatever the game's input sources (is/are)
    end    

    function State:load() 
        --so first, we are going to create a unique, instanced memory context
        self.memory = Memory:new(self.Name.."_TopLevelMemoryContainer_")

        --then we will configure the memory container based on usage. In a gamestate, the memory is configured to update and draw its objects
        self.memory:configure("draw","update")
        
        --then we will add any generalized features that the memory container needs access to:
        --generic systems added to all states are added here in priority order
        for _,v in ipairs(systemOrder) do
            self.memory:add(v, self.systems[v]:new())   --just build a new system instance for each one I think?
        end
        --then we add anything else we need to add. I actually don't think there's anything else to add, however!


        --all that being said, DataSystem, MultiverseSystem, and ObjectSystem may be the only specific objects being added!
        --note: we need to make sure that we are instantiating new ObjectSystems, MultiverseSystems, and DataSystems to the list!


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
