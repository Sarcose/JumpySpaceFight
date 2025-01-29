--[[
    Some of the implementation of this will have to be done after World -> Map -> Board is defined.


]]


local multiverseSystem = {}


--initialize is separate from "construct" in that it's done at instantiation
function multiverseSystem:initialize()   


end

--load is separate from "initialize" in that it is done as a precursor to "starting"
--a Multiverse loads several "realities" and can load new ones on the fly. A reality is a *game*
        --that is to say, it is a set of determined rules for play.
        --reality hopping can change fundamental game rules.
        --the first use of this will be to include portals to the original Jumpy Space Fight, for example.
function multiverseSystem:load(ctx)  
    --the ctx here is "context" and can refer to a gameplay state (such as a new game or a save game)
    --or it can refer to a pre-built "animation" or "demo" state to display on the screen
    --or it can load nothing or we *could* use the framework of this system as a way of displaying other things.



end




function multiverseSystem:update(dt)
end


function multiverseSystem:draw()
end

--query its attached multiverse to build the saveContext it needs
--its parent gamestate will write the saveContext if it deems it necessary
function multiverseSystem:createSaveContext()



end


--regardless of the saving state, unload is called whenever we exit to title, game over, or load a new game (unload -> load)
function multiverseSystem:unload()



end



return multiverseSystem