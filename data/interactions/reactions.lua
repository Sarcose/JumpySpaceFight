local reactions = {
    queueState = function(ctx) end, --queue a new state with an optional override flag
    queueBehavior = function(ctx) end, --queue a new behavior with an optional override flag
    applyMomentum = function(ctx) end,  --i think this will actualy apply a momentum template such as "pushOut" "pullIn" "bounce" etc.. I think under data.physics we can put this
    applyDamage = function(ctx) end,
    applyHeal = function(ctx) end,
    applyEffect = function(ctx) end,
    dropItems = function(ctx) end, --items can be "items" or they can be collectibles or powerups. ctx can have info such as momentum for the drops.
    addToInventory = function(ctx) end, --add an item to actor's inventory
    switch = function(ctx) end,
    startEvent = function(ctx) end,
    endEvent = function(ctx) end,
}

return reactions