--[[ List of interactions thus far:
    
--simple interactions--
--THESE are EVALUATIONS and we will change to 'evaluateSystem'. An example of a reaction is given after each:
    onTouch -- when I touch a thing     (reaction example: if i am enemy and touched entity is player, send damage)
    onTouched -- when a thing touches me   (reaction example: if i am switch and touched entity is valud, cause switch)
    onDestroy -- when I am about to self-delete (reaction example: drop dropitem)
    onInteract -- when an actor (usually player) uses the interact move (like, up or E) (reaction example: play animation)
    onMessage -- when I have received a message (usually a command) from a messager sending entity that is compatible with me
    onInterval -- after (interval) has passed. Can be used for timers or regular logic. (reaction example: play animation)
    onProximity -- when <type or tag> entity is within <proximity> (reaction example: follow entity)


    --terrain only--

    --actors only--
    onDamage -- when a damage source has applied damage to me (reaction example: apply damage, go into iframes state)
    onHeal -- when I or an external heal source has applied healing to me (reaction example: apply heal)
    onDistance -- when the distance between myself and <tracked entity> has changed (greater or smaller) (reaction example: move closer)
    onLostTarget -- when my target has become incompatible with my targeting (out of range, gone invisible, become ally) (reaction example: return to prev behavior)
    onGainTarget -- when I have acquired a target (reaction example: change to chase behavior)
    onAggro -- when I have been aggro'd to another entity (reaction example: change to attack behaior)
    onCalm -- when my aggro state has been cleared (reaction example: change to calm behavior)

    --items only--
    onUse -- when I am an entity that can be used, and I have been used (items only) (reaction example: apply a thing)
    onPickup -- when I have been picked up (items only) (reaction example: add to item count of <item>)
    onDrop -- when I have been dropped by an actor (reaction example: bounce a bit)
    
    --mechanisms only--
    onExit -- when an item that was within my hitbox leaves my hitbox (reaction example: trigger cutscene)
    onEntry -- when an item that was not within my hitbox enters my hitbox -- distinct from onTouched (reaction example: trigger cutscene)

--proximity types--
    collector -- actors that can pick up items
    



]]


local eval = {
    --universal--
    onTouch = function(ctx) end,
    onTouched = function(ctx) end,
    onDestroy = function(ctx) end,
    onInteract = function(ctx) end,
    onMessage = function(ctx) end,
    onInterval = function(ctx) end,
    onProximity = function(ctx) end,
    
    --terrain--

    --actors--
    onDamage = function(ctx) end,
    onHeal = function(ctx) end,
    onDistance = function(ctx) end,
    onGainTarget = function(ctx) end,
    onLostTarget = function(ctx) end,
    onAggro = function(ctx) end,
    onCalm = function(ctx) end,
    

    --items--
    onUse = function(ctx) end,
    onPickup = function(ctx) end,
    onDrop = function(ctx) end,
    
    --mechanisms--
    onEnter = function(ctx) end,
    onExit = function(ctx) end,
}



return eval