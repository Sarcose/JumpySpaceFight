--the major system for all interactions e.g. triggers in the game
--this system is initialized with a list of interactions to apply to its list
--then it parses those per its priorities
--the interaction system will probably never have removeInteraction called but we should prototype it
--nonetheless.


--to follow the paradigm of the rest of the codebase, the actual interactions *should* be coded as separate files
--however I don't know if I like that. I think I can set a paradigm of putting like data points into the same files.



local interactSystem = {}
local properties = {
    Interactions = {
        total = 0,
        reindexLevel = 10,
        priority = {},
        ref = {},
    },
}

local evaluations = require 'data.interactions.evaluations'
local reactions = require 'data.interactions.reactions'
--this is kept local, and references are applied based on priority.
--a note about priority: I could "lazily" apply number priorities and a hastily thrown together logic
--OR I could analyze priority and list them in PRIORITY, thus never having to reindex
--also, are there some interactions that supersede others but not ALL others down the list? this must be analyzed as well.
--See interactions.lua "priority Study."


--[[
    Anatomy of an interaction:
    
    me.properties.myInteractions = {    --in this case, "lateral" means "some angle of tolerance around 90 degrees from gravitational direction"
        --{string eval, string or table evalProperties, string reaction, string or table reactionProperties}    
        {"onTouch",{type="terrain", direction="lateral",invalid={"Pain"}},"queueState","wallCling"},
        {"onProximity",{type="actor",relation="hostile",distance=1000,run=1}, "applyEffect",{effect="radar"}},    --is this the best way to do this one?
    }


]]


function interactSystem:new()
    local c = {}
    for k,v in pairs(self) do
        if type(k) == "function" then
            c[k] = v
        else
            if type(v) == "table" then
                c[k] = {}
                c[k] = tablex.overlay(c[k],v)
            else
                c[k] = gcore.var.shallowcopy(v)
            end
        end
    end
    c:initialize()
    gcore.container.assignType(self,"System","interactSystem")
    return c
end

function interactSystem:initialize(entity)
    local _interactions = entity.interactions
    local interaction = {}          --prototype the interaction type, which is a pair of "eval" and "reaction"
    for i,v in ipairs(_interactions) do  --use ipairs to establish a priority
        

    end


end


function interactSystem:addInteraction(interaction, order)


end


function interactSystem:removeInteraction(interaction)



end


function interactSystem:reindex()


end


function interactSystem:update(dt)



end


function interactSystem:draw()
        --i think this will only be used for debug


end


function interactSystem:unload()


end

return interactSystem