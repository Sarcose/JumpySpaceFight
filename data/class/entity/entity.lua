--Terrain, Actor, and Item inherit from this. Thus, what do they all have in common?
--[[

    All:
        Physics
        Gravity (potentially, maybe not Terrain, maybe not Item)
        Interactions* (giving, receiving)
        Behaviors* (see below)

    Gravity:
        Terrain: When affected, fall. When released, fall.
        Item: When dropped, fall. Else, float.
        Actor: Fully affected, ignore under specific circumstances.

    Interactions:
        Terrain - onTouch, onRelease, onDestroy
        Item - onTouch, onRelease
        Actor - Touch things, and when touched

    Behaviors:
        Terrain - onTouch, onRelease, onDestroy
        Item - collectorNear behavior (magnet)
        Actor - all behaviors
    
    Thus:

    Entity:
        Physics Shape
        ExternForce (gravity) -- toggleables
        Interaction engine
            Terrain:
                Defaults: ExternForces off, onTouched off, onDestroyed off
                Interactions: situationally, onTouched, onDestroyed
            Actor:
                Defaults: ExternForce(Gravity) on, dropList On
                onTouch, onTouched, onInteract, onDestroyed, dropList (player: dropList off)
                AI (non-player) and Inputs (player)
            Item:
                Defaults: ExternForces(Gravity) creation dependent:
                    Created by drop: on
                    Created by map: off
                onTouched (collect)
                collectorNear behavior (magnet)
            Mechanism:
                onTouched, onExit, onInteract




            all of the above will be handled by Systems.Interaction
]]




local defaults = {
    type = "Entity",
    Name = "EntityPrototype",
    systems = {InteractionSystem = "InteractSystem"},   --deterministic order is very important here.
    interactions = {},      --use this to establish a priority system for interactions, see InteractSystem.lua
    apply = {},
    update = "basic",
    draw = "basic",
}

return function(context)
    local Entity = context.Class:extend(defaults)
    local bodyTemplate = {  --will need to hash out the shapes to place on an entity, once we start testing physics.

    }

    --parseTriggers goes in all entity updates

    Entity.Terrain = require 'data.class.entity.terrain'(context)
    Entity.Actor = require 'data.class.entity.actor'(context)
    Entity.Item = require 'data.class.entity.item'(context)
    Entity.Mechanism = require 'data.class.entity.mechanism'(context)
    Entity.Module = require 'data.class.entity.module'(context)


    function Entity:new(a)


    end
    

    return Entity
end