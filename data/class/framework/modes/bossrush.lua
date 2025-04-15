return function(_Gamestate)
    local def = {name = "Bossrush_Gamestate", scene = "bossrush"}
    local t = _Gamestate:construct(def)

    function t:load()
    
        self.super.load(self)
        --after loading my context in self.super.load(self) I will now attach my state-specific context!        self.loaded = true

        return self
    end    

    return t

end