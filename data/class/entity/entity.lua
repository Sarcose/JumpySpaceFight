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
    

    Some:
    Inputs:
        Actor - AI, Controller


    Etc:
        Projectile: subclass of Actor

        onTouch - when Actor touches me
        onRelease - Terrain/Item, when Actor uses a Releasing thing, detaching me from my anchor
        onDestroy - Terrain/Item, when Actor uses a Destroying thing
        onDeath - Actor, when Actor/Terrain/Environment/Condition kills me
        collectorNear - Item, when an actor with Tag "collector" is within magnet range and isMagnetic
            --enemies may be able to collect?

]]




local defaults = {
    type = "Entity",
    Name = "EntityPrototype",
    systems = {},   --deterministic order is very important here.
    apply = {},
    update = "basic",
    draw = "basic",
}

return function(context)
    local Entity = context.Class:extend(defaults)
    local bodyTemplate = {  --will need to hash out the shapes to place on an entity, once we start testing physics.

    }


    function Entity:new(a)


    end


    return Entity
end