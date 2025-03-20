--[[
    definition of terms hierarchy

    Class = the basic data structure from classic.lua
    Template = a class implementation only for prototyping, no parents
                         /--------Input
                        /-------Overlay
    Class   --->\     /------ GameState  (a container of Map + entities + player state)
                ----<--------Layer----Map----World (matryoshka of physical space layers)  
    Template-->/    \-------Entity--------\-------Terrain
                                            \------Actor
                                             \-----Item
                                              \----Mechanism

--]]
--1: written 2: basic test 3: iterated once 4: iterated again 5: polished 6: etc.
--[][][][][][]
--compare checkboxes with iteration level target (below)

--current iteration level target: 1
--I think we have to do this without a Context, because the context asks for systems as it's created.
Systems = require ('data.systems.systems'):initialize()             --[X][X]




local context = {}  --only expose primitives when first initializing everything
--"Class" is a primitive Object that implements : "update" "draw" "updateSystems" "drawSystems" "Systems" "addSystem" "unloadSystems" 
local c = {}
c.systems = {}
function c:updateSystems(dt)
  for i,v in ipairs(self.systems) do
    if v.update then v:update(dt) end
  end
end
function c:drawSystems()
  for i,v in ipairs(self.systems) do
    if v.draw then v:draw() end
  end
end
function c:addSystems(sys) --<------- Problem here for some reason
    --_c_debugL(sys)
  for k,v in pairs(sys) do
    local s = Systems:getSystem(v) --will not parse >1 deep but for this one it's not necessary
    self:addSystem(s,k)
  end
end
function c:addSystem(sys,k)
    table.insert(self.systems,sys)
    self.systems[k] = sys
    self.systems[k]._self = self
    if type(self.systems[k].initialize) == "function" then self.systems[k].initialize(self.systems[k],self) end
end
function c:unloadSystems()
  for i,v in ipairs(self.systems) do
    if v.unload then v:unload() end
  end
end

function c:checkFlags()
    --these are processing flags that may trigger recalculation or changing behaviors per turn
    --some examples are included but this is effectively pseudocode so far

    --I think these should be done per update and deterministically.
    --I think that these should be broken down, because not all flag functionality is for "remind self to do a thing"
    --so in theory we could have self.flags.changes and self.flags.constant or something
    if self.flags.RESHAPE then self:reshape() end --reshape for slick
    if self.flags.RESPAWN then self:respawn() end --duplicate self then destroy original. This WILL have weird consequences if I'm not careful..


end
function c:parseAndApply(a)
    for _, path in pairs(a) do
        local template = Templates[path]  --TODO: needs work, will not parse >1 deep (...maybe that's fine though...)
        if template.systems and #template.systems > 0 then self:addSystems(template.systems) end
        if type(template.applications, "table") then 
            for _,v in ipairs(template.applications) do
                v(self)
            end
        end
    end
    self:checkFlags()

end
c._updateMethods = {
    basic = function(self, dt) self:updateSystems(dt) end,
    inputs = function(self, dt)
        self.input.update(self,dt)
        self:processInputs(dt)
        self:updateSystems(dt)
        self.input.reset(self)
    end,
    actor = function(self,dt)
        self:checkForInput(dt)
        self:updateSystems(dt)
    end
}
c._drawMethods = {
    basic = function(self, dt) self:drawSystems() end
}
function c:getUpdate(update)
    if type(update,"function") then return update end
    local up = self._updateMethods[update] or self._updateMethods.basic
    self._updateMethods = nil
    return up
end
function c:getDraw(draw)
    if type(draw, "function") then return draw end
    local dr = self._drawMethods[draw] or self._drawMethods.basic
    self._drawMethods = nil
    return dr
end
function c:unload()
    self:unloadSystems()
    for k,v in pairs(self) do
        _safe.release(v)
    end
end
context.Class = Object:extend(c)
--this implementation of new expects systems and implementations
--defaults and passed "a" both have a "systems" and "implement" table.
--we remove this table and attach it after extending and instantiating, to keep the namespace from being overpopulated by refs.
context.Class._new = context.Class.new
context.Class._extend = context.Class.extend
function context.Class:new(a)
    local systems = a.systems or self.systems
    local apply = a.apply or self.apply
    local update = a.update or "basic"
    local draw = a.draw or "basic"
    a.apply = nil
    local inst = self:_new(a)
    inst.flags = {}
    inst.update = self:getUpdate(update)
    inst.draw = self:getDraw(draw)
    if systems then inst:addSystems(systems) end
    --if apply then inst:parseAndApply(apply) end
    if self.construct then self:construct(a) end    --the FINAL constructor function, which is dynamic, for the PRIMITIVE type.
    return inst
end
function context.Class:extend(a)
    local systems = a.systems
    local apply = a.apply
    a.systems, a.implement = nil,nil
    local cls = self:_extend(a)
    cls.flags = {}
    if systems then cls:addSystems(systems) end
    if apply then cls:parseAndApply(apply) end
    local t, name = a.type, a.Name
    gcore.container.assignType(cls,t,name)
    return cls
end

--[X] 1: Class. 2: Some functionality. 3: Specific functionality. 4: First pass "working". 5: Mostly ready.

--quick refactor! since I am just "initializing" from inside the doc, skip the table altogether.
--below are the Class subtypes. These are all implementing Class in order to utilize the above methods.
--we now need two layers of checkboxes to reimplement this.
--testing new architecture starts in gamestate.lua btw
context.Class.GameState = require 'data.class.framework.gamestate'(context)   --[X][X]
context.Class.Overlay = require 'data.class.interface.overlay'(context)       --[X]
context.Class.Input = require 'data.class.interface.input'(context)           --[X]
context.Class.Space = require 'data.class.space.space'(context)               --[X]       
context.Class.Entity = require 'data.class.entity.entity'(context)            --[X]



--"Template" is a raw object that is "implemented" by Instances of the above Types. The Template Type is thus extremely basic
--and missing certain methods.
context.Template = require 'data.template.template'               

--systems are NOT instantiated, nor are they prototyped. They may not even need or reference Object at all.
--Exception: I *might* use ObjectSystem as a primitive for more complex object manipulation. That is still UNCLEAR.

--Actual DATA below. Individual templates and Individual Classes of various kinds.
context.Templates = require ('data.template.templateInstances')(context)  --[X]
context.Archetypes = require ('data.class.archetypes.archetypes')(context)

Classes = require 'data.class.classInstances'(context) --instantiate all of GameStates, Overlays, Inputs, Spaces, Entities
    --this will establish the structure of all classes and instantiate all prototypes, preparing to instantiate the rest as needed


--_c_warn("The next place to put together data will be accessed in templateInstances and classInstances!")

