local r = {

}


local reality = Object:extend(r)

reality._new = reality.new

--[[    example; remember realities are implemented BY gamestate, so gamestate is one step UP and universe would be one step DOWN
    local mainRuleSet = {--puzzleCreature, theoretical entity type for all characters in the main ruleset
        player = Classes.Entities.Actors.ShapeBuildActor, --entity is instantiated with :new(nil)
        playerTemplate = Data.Entities.Templates.PuzzlePlayer,   --template is applied with :apply(actor)
        universe = Universes.mainUniverse, --this is the path where the actual gameplay is built; all maps, characters, quests, switches, items, etc.
        rules = Rules.mainRules, --where things like the gravity constant and some universal animation stuff is set (as well as the RNGs used)
        saveCtx = "MainGameMode", --savegame is applied on top of player as well as universe, however that is needed
        overlay = Data.Overlays.Main, --UI is generated, which governs pausing and character manipulation as well
    }

    local jumpySpaceFightRuleSet = {
        player = Classes.Entities.Actors.JumpySpaceFighter,
        playerTemplate = Data.Entities.Templates.jsfPlayer,
        universe = Universes.jsfUniverse,
        rules = Rules.jsfRules,
        saveCtx = "JumpySpaceFightMode", 
        overlay = Data.Overlays.JumpySpaceFight, 
    }

    local MainGameMode = reality:new(mainRuleSet)
    local JumpySpaceFight = reality:new(jumpySpaceFightRuleSet)

    another TODO: a means to translate player state from one reality to another.
    --this will probably create conditions were player states mutate between realities
    --e.g. collecting X item in Reality A may result in an alternate reality version in Reality B with Y item instead
    --rather than 1:1. In certain circumstances, I could see how progress in the main game could imply a scaling factor
    --of difficulty in one of the other realities.
]]




function reality:new(r)
    local inst = self:_new(r)
    --establish rules
    --establish dimensions of reality camera (this is used in the draw and drawPortal functions)
    --establish cached spaces that will be loaded upon self:load()


end

function reality:load()
    --actually load everything. Before this it is just a set of references
    --there is a possibility that i might want to preload these when the player gets close to a portal.


end


function reality:setSpaceCoordinates()  
    --pass details as to a coordinate within the "map / board" coordinate system
    --as well as details as to the coordinate within the map/board system (ugh, still up in the air on this)



end

--ughhhh, I *might* want multiple cameras
function reality:adjustCamera(dt)
    --set or lerp camera to a specific place, in a specific "layer" or spaceworld/map/board.



end



function reality:update(dt)
    --use current cameras + camera radius to update
    --if the reality is not "active" don't update anything outside the active layer
    --if the reality is "active" then it is the one we're "playing" that means update the layer we're in + the layers around it.
    --if the reality/location is not "discovered" dont even update anything, a "fog of war" effect will be used instead.



end


function reality:draw()



end


function reality:drawPortal()   
    --



end