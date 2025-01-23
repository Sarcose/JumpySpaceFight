--[[    {
        Board = require 'data.classes.space.layer',
        Map = require 'data.classes.space.map',
        World = require 'data.classes.space.world',
    },]]

local defaults = {
    type = "",
    Name = "NoName"
}
local systems = {
    ObjectSystem = "ObjectSystem"
    --others a simulation might have: "gravity" and "physics" which will be "slick"
    --that will probably be in the Layer level
}
local implement = {}

local Space = Object:extend(defaults)

Space._extend = Space.extend


function Space:extend(a)
    local cls = self:_extend(a)
    cls:addSystems(systems)
    cls:superImplement(implement)
    return cls
end


return Space