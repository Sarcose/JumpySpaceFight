--Blueprint. Instances inherit directly from this.
--uses new "context.class" implementation
--I need a data structure that uses "initialize" and is called that way. So here's what we'll do.
--[[
    Ultimately I think a GameState is:
        An ObjectSystem with the categories "Space" and "Overlays"
        One or more Input sources
        "Load" and "Unload" with respect to States
        

]]
local Defaults = {
    type = "GameState",
    Name = "GameStatePrototype",
    systems = {ObjectSystem = "ObjectSystem", MultiverseSystem = "MultiverseSystem", DataSystem = "DataSystem" },    ---DataSystem; tbd
    apply = {},
    update = "inputs",
    draw = "basic",
    stage = "data.class.framework.modes.stage",
    Context = {},   --where everything is probably going to be run from.
}

local systemOrder = {"DataSystem","MultiverseSystem","ObjectSystem"}

return function(context)
    local State = context.Class:extend(Defaults)
    local default = gcore.var.deepcopy(Defaults)
    print("initializing def as "..tostring(default))
    default.Name = "GameState_Unnamed"
    function State:construct(a)   
        local d = {
            type = "GameState",
            Name = a.name,
            apply = {},
            update = "inputs",
            draw = "basic",
            stage = "data.class.framework.modes.stage"
        }
        if type(a,"table") then gcore.var.merge(d,a) end
        local s = self:extend(d)
        return s
    end    

    function State:load() 
        --first, create our anonymous type
        gcore.container.assignAnonymousType(self)

        --next we are going to create a unique, instanced memory context
        self.memory = Memory:new(self.Name.."_TopLevelMemoryContainer_")

        --then we will configure the memory container based on usage. In a gamestate, the memory is configured to update and draw its objects
        self.memory:configure("draw","update")
        
        --then we will add any generalized features that the memory container needs access to:
        --generic systems added to all states are added here in priority order
        for _,v in ipairs(systemOrder) do
            local sys = self.systems[v]:new()
            self.memory:add(v, sys)   --just build a new system instance for each one I think?
            self.Context[v] = sys
        end
        self.memory:report()
        --now add our drawing logic
        push:setupCanvas({{name = self.__name}})


        local super = self.super

        self.draw,self.update,self.save,self.processInputs,self.unload = super.draw,super.update,super.save,super.processInputs,super.unload

        --all that being said, DataSystem, MultiverseSystem, and ObjectSystem may be the only specific objects being added!
        --note: we need to make sure that we are instantiating new ObjectSystems, MultiverseSystems, and DataSystems to the list!

    end

    function State:draw()
        push:setCanvas(self.__name)
        if self.memory and not self.memory:check("drawn") then print('TEST DRAW SUCCESSFUL!!!!!!!!!') self.memory:set("drawn") end
        self.memory:draw()
    end
    function State:update(dt)
        if self.memory and not self.memory:check("updated") then print('TEST UPDATE SUCCESSFUL!!!!!!!!!') self.memory:set("updated") end
        self.memory:update(dt)
    end
    function State:save()

    end
    function State:processInputs(dt)

    end


    function State:unload()
        --unload everything inside load. wrt the actual main gameplay state this will probably only be called when ending the game
        _c_message{"GameState "..tostring(self.name).." Unloaded"}
        self.loaded = false
    end

    return State
end
