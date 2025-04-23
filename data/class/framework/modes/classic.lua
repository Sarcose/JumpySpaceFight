return function(C)
    local _Gamestate = C.GameState
    local def = {name = "Classic_Gamestate", scene = "classic"}
    local t = _Gamestate:construct(def)

    function t:load()
    
        self.super.load(self)
        self.loaded = true

        return self
    end    

    return t

end