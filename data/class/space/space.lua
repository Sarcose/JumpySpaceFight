--[[    {
        Board = require 'data.classes.space.layer',
        Map = require 'data.classes.space.map',
        World = require 'data.classes.space.world',
    },]]
--[[
    Systems Spaces will *probably* use
    PhysicsSystem -- a system to handle and parse Slick.World
    EnvironmentSystem -- through which we can add directional gravity and other things
    Overlay or Minimap system maybe
    Relational system for other spaces and subspace containers
]]

--[[

    I think the goal of the Space type is to be able to run an entire game from within it.

    In other words: all extensions of this type will actually be specialized and tweaked

]]


local defaults = {
    type = "Space",
    Name = "SpacePrototype",
    systems = {ObjectSystem = "ObjectSystem"},  --todo: deterministic systems order.
    implement = {},
    update = "inputs",
    draw = "basic",
}
return function(context)
    local Space = context.Class:extend(defaults)

    function Space:new(a,name)
        local inst = self:extend(a)
        local s = a.systems or self.systems
        local imp = a.implement or self.implement
        self:addSystems(s)
        self:superImplement(imp)
        --grab a bunch of menu stuff from menu instances most likely
        return inst
    end

    function Space:load()
        --attach world
        --inhabit world with worlds
        --inhabit worlds with objects

    end
    --see Class: c._updateMethods.inputs, use systems to add new functionality.
    --see Class: c._drawMethods.basic, use systems to add new functionality.
    return Space
end



--[[
Design journal 1/24 (see Aseprite: JSF space journal)
]]