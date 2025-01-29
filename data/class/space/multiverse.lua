--will not actually use any systems, this is just a bare container for all of the realities.
local multiVerse = Object:extend()

multiVerse.currentReality = nil
multiVerse.realityList = {} --an indiced list that also has references
multiVerse.realityRefs = {}


function multiVerse:addReality(r)
    table.insert(self.realityList,r)
    self.realityList[r.name] = r
    self.realityRefs[r.name] = #self.realityList
    if type(self.realityList[r.name])=="reality" then return true end
end

function multiVerse:cleanUp()   --this will only be needed once the game balloons to a huge size, tbh

end


function multiVerse:update(dt)
    --update current reality
    --update any realities that need to be run in the background (with slower or faster time ticks?)
    --run logic to get controller, pass it to current reality


end


function multiVerse:draw()
    --draw /only/ the current reality.
    --objects that serve as portals to other realities will call a reality's specific "portalDraw" function


end




return multiVerse


