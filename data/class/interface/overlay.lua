local defaults = {
    type = "Overlay",
    Name = "OverlayPrototype",
    systems = {},   
    apply = {},
    update = "inputs",
    draw = "basic",
}

return function (context)
    local Overlay = context.Class:extend(defaults)

    function Overlay:construct(a)

    end

    function Overlay:initialize(a)


    end


    function Overlay:new(a,name)
        local inst = self:extend(a)
        local s = a.systems or self.systems
        local apply = a.apply or self.apply
        self:addSystems(s)
        self:apply(apply)
        --grab a bunch of menu stuff from menu instances most likely
        return inst
    end
    
    function Overlay:receiveInput(input)   
    --rather than rewriting update, the gamestate that holds the menu instance will send signals
    --when appropriate.
    
    end
    
    function Overlay:Open(x,y,persistent) 
    
    
    end
    --close the menu. Minimize indicates whether or not the menu will 
    function Overlay:Close(minimize) 
    
    
    end

    return Overlay
end
