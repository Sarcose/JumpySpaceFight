--[[
The below are *instantiations* meaning here we define the filenames and then generate them using the relevant target in context.
]]
local classes = {
    Input = {},                  --context.Class.Input
    Overlay = {},               --context.Class.Overlay
    GameState = {},
    Space = {},
    Entity = {  --i think entity should be broken down into Terrain | Actor | Item | Mechanism
        Terrain = "",               --context.Class.Entity.Terrain
        Actor = "",                 --context.Class.Entity.Actor
        Item = "",                  --context.Class.Entity.Item
        Mechanism = ""              --context.Class.Entity.Terrain
    }
}

--[[
    the above creates the prototypes. In the case of Input, Overlay, Gamestate, and Space, each of these is a prototype
    In the case of Entity, it prototypes for Terrain, Actor, Item, Mechanism
    Therefore, I think Terrain, Actor, Item, and Mechanism should be considered of type "Entity" with name
        "TerrainEntityPrototype", "ActorEntityPrototype", "ItemEntityPrototype", "MechanismEntityPrototype"


    COnfusingly, the labels "Interface" and "Framework" are meaningless except as containers.
        Board, Map, and World all instantiate Space with templates

    Terrain, Actor, Item, Mechanism are themselves instantiated prototypes from Entity
        However they do not represent new gcoreTypes IMO
        
        
    This means the next to do is as follows: 
        Instantiate TerrainEntityPrototype
        Instantiate ActorEntityPrototype
        Instantiate ItemEntityPrototype
        Instantiate MechanismEntityPrototype

    THEN we will finally have all prototypes. From here it is a matter of defining ARCHETYPES:
        An Archetype is a collection of Templates making up an object to instantiate
        An archetype can define zero templates:
            A "GenericController" archetype will probably just be a standard input, no templates.
        It can define overriding templates:
            A "RunningEnemy" archetype
        A todo list of basic Archetypes to define and test
        --[ ] Controller Archetypes
        --[ ] Menu archetypes
        --[ ] Gamestate archetypes
        --[ ] Map archetypes
        --[ ] Block (terrain piece) archetypes
        --[ ] Actor (enemy/player) archetypes
        --[ ] Item (collectible) archetypes
        --[ ] Mechanism (trigger/zone/adjuster) archetypes


        Rough Stages:
            1. Write the pseudocode for all of above, in structure.
            2. Test implementing one by one, starting with zero physics and only drawing and controlling
                2a. These will be instantiated with the Instances section below.
            3. Add in physics via Slick, and then implement Slick via Systems
            4. Add in additional functionality



    After we have defined some archetypes we can finally create INSTANCES:

        local newController = Classes.Interface.Input:new(controllerArchetype)
        local newMenu = Classes.Interface.Overlay:new(menuArchetype)
        local newGameState = Classes.Framework.Gamestate:new(gamestateArchetype)
        local newMap = Classes.Space.Space:new(mapArchetype)
        local newTerrainPiece = Classes.Entity.Terrain:new(terrainArchetype)
        local newActor = Classes.Entity.Actor:new(actorArchetype)
        local newItem = Classes.Entity.Item:new(itemArchetype)
        local newMechanism = Classes.Entity.Mechanism:new(mechanismArchetype)


    Therefore, the BULK of the game's CONTENT will be written in the template data structure! BAM.



]]

--	self._input = Classes.Interface.Controller:new(inputTable)
local function nameSpaceTest(context)   --DONE
    local instances = {}
    --target for categories is in:
        --context.Class
    local C = context.Class
    _c_message("Testing Namespace Setup")
    for k,P in pairs(classes) do
        local exists = "\x1b[31m and NOT found in context"
        if C[k] then exists = " and found in context" end
        print("\x1b[32m          "..tostring(k).." found in local ..."..tostring(exists))
        for m,v in pairs(P) do
            local existing = "\x1b[31m and NOT found in context"
            if C[k] and C[k][m] then existing = " and found in context" end
            print("\x1b[36m                    "..tostring(m).." found in local......"..tostring(existing)) 
        end
        io.write("\x1b[0m")
    end
    _c_debugL(instances)
end

_c_todo{"03/06/2025", "XC.Input","C.GameState","SlickTest","C.Overlay","C.Space","C.Entity.Terrain","C.Entity.Actor","C.Entity.Item","C.Entity.Mechanism","C.Entity.Module","A Test Game"}


--REWRITE THIS TODO over in GAMESTATES
--[[As of 03/06/2025 here is our most relevant TODO:
--[ ] Get Gamestate written, create test gamestates.
--[ ] Use test gamestates to test:
    --[ ] Instantiation; self and then more gamestates, moving from state to state. Use basic functional data displays.
    --[ ] Input (should already be done pretty much)
    --[ ] Overlays (a variety of these)
    --[ ] Entities; ~In this gamestate, start with a very simple physics world, ignoring Spaces. Use the following tests to learn the means of Spaces.
        --[ ] Terrain    
        --[ ] Item
        --[ ] Actor
            --[ ] Actors that move on their own kinda
            --[ ] Actors that can interact with terrain, impacted by physics
            --[ ] Actor that can be controlled by player. Change these around a lot
        --[ ] Mechanism
        --[ ] Module ; the components that make up overlays specifically
    --[ ] Spaces;
        --[ ] Normal up-down space
        --[ ] Variegated gravity spaces
        ------Etc-------
]]

--Classes = require 'data.class.classInstances'(context) --insta
local function secondInit(ctx)
    local C = ctx.Class
    local Classes = {}
    --'data.class.framework.gamestate'(context) 
    Classes.Input = require 'data.class.interface.inputs'(C.Input) --TODO; add input templates
    Classes.GameState = require 'data.class.framework.gamestates'(C.GameState) --TODO; add gamestate templates
    -- Classes.Entity = require 'data.class.entity.entities'(C.Entity)
    Classes.Overlay = require 'data.class.interface.overlays'(C.Overlay)--TODO; add overlays
    -- Classes.Space = require 'data.class.space.spaces'(C.Space)
    return Classes
end


local function firstInit(ctx)
    _c_warn("Class instances instantiating... prototyped namespace ONLY")
    return ctx.Class
end

return function(context)
    return secondInit(context)
end