return function(C)
    local _Gamestate = C.GameState
    local def = {name = "JSF_Gamestate", scene = "jsf"}
    local t = _Gamestate:construct(def)

    function t:load()
    
        self.super.load(self)
        --after loading my context in self.super.load(self) I will now attach my state-specific context!
        self.loaded = true

        return self
    end    

    return t

end