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
local thought = gcore.debug.thought

return function(context)
    local _,fn = thought(4,"Starting space test, use key !@#$%^","Testing spaces from space.lua")
    _G.SplashTest = fn
    SplashTest("PRIOR TO INSTANTIATION: showing defaults before :extend")
    local Space = context.Class:extend(defaults)
    SplashTest("%% printing function address for context.Class.extend"..tostring(context.Class.extend))
    SplashTest("^^ Finding if context.Class now has a .systems: ")
    _c_debug(context.Class.systems)
    function Space:new(a,name)      --somewwhere in here, self.systems and defaults/a.systems are one and the same!
        SplashTest("%% printing function address for self.extend"..tostring(self.extend))
        SplashTest("@ Space:new called.")
        a = a or gcore.var.deepcopy(defaults)
        SplashTest("@ a instantiated. Comparing addresses between a and defaults:")
        SplashTest("a:"..tostring(a))
        SplashTest("defaults:"..tostring(defaults))
        SplashTest("a.systems:"..tostring(a.systems))
        SplashTest("defaults.systems:"..tostring(defaults.systems))
        SplashTest("self.systems = "..tostring(self.systems))
        SplashTest("#Now Extending into inst")
        local inst = self:extend(a,true)
        SplashTest("#self:extend called.")
        SplashTest("a:"..tostring(a))
        SplashTest("defaults:"..tostring(defaults))
        SplashTest("a.systems:"..tostring(a.systems))
        SplashTest("defaults.systems:"..tostring(defaults.systems))
        SplashTest("self.systems = "..tostring(self.systems))
        SplashTest("inst.systems = "..tostring(inst.systems))
        local s = a.systems or {}
        local imp = a.implement or {}
        self:addSystems(s)
        --self:superImplement(imp) --something drove me to write this but i got no idea what it is...
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

    SplashTest("!Space prototype has been instantiated. Now comparing addresses of Space.systems, defaults.systems:")
    SplashTest("Space.systems:"..tostring(Space.systems))
    SplashTest("defaults.systems:"..tostring(defaults.systems))

    _c_debug(Space.systems)

    _c_debug(defaults.systems)

    return Space
end
