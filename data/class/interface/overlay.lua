
local defaults = {
    type = "Menu",
    Name = "NoName",
}
local Menu = Object:extend(defaults)

local systems = {
    ObjectSystem = "ObjectSystem" --an object system with menu objects?
}
local implement = {}    --implement 
local State = Object:extend(defaults)

function State:new(a,name)
    local inst = self:extend(a)
    self:addSystems(systems)
    self:superImplement(implement)
    --grab a bunch of menu stuff from menu instances most likely
    return inst
end

function Menu:receiveInput(input)   
--rather than rewriting update, the gamestate that holds the menu instance will send signals
--when appropriate.

end

function Menu:Open(x,y,persistent) 


end
--close the menu. Minimize indicates whether or not the menu will 
function Menu:Close(minimize) 


end
return Menu