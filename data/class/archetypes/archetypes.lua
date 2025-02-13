--[[
    collections of templates ONLY. will pull a structure from its own folder structure of something like:

    Controllers
    Overlays
    GameStates
    Spaces**
        Maps
    Entities
        Actors 
            Animals
            Artificial
            Humanoid
        TerrainPieces
        Items
        Mechanisms

    **STILL trying to figure out how to abstract Spaces intelligently and effectively. I'm not fucking with it for now. 
    For NOW, instantiating a Space will create a flat table of items
]]

return function(context)
    local Archetypes = {}
    Archetypes.Controllers = {}
    --playerOne.Controller = Classes.Interface.Input:new(Classes.Archetypes.Controller.Basic)
    --playerTwo.Controller = playerOne.Controller -- boom, lookit that, 1C2P
    --at the moment, the controller under "Controller" does not need to do anything special or even need an archetype
    --What can we use an archetype for with a controller? specifying no debug buttons I think.
    --Here are two possible archetypes:
        --Classes.Archetypes.Controller.Play: for the playing field
        --Classes.Archetypes.Controller.Menu: Menu controls
        --Classes.Archetypes.Controller.Debug: Debug controls

    --Then,                     --extension to new allowing for specific controllers to attach
        --playerOne.PlayControl = Classes.Interface.Input:new(Classes.Archetypes.Controller.Play)
        --etc.
        --when menu then only update menu controls
        --when debug then only update debug controls
        --etc.

    --That MIGHT be a bit too abstracted and unnecessary though. 
    --[ ] Run another controller test using gcore alone (with gcore update)
    --[ ] Rewrite controller to accept templates for buttons, testing different templates
    --[ ] Establish the standard of what input update looks like, and then apply it to the code
    --[ ] Then, move on.

end