return function(C)
    local _Gamestate = C.GameState
    local def = {name = "Randomizer_Gamestate", scene = "rando"}
    local t = _Gamestate:construct(def)

    function t:load()
        self.super.load(self)
        --after loading my context in self.super.load(self) I will now attach my state-specific context!

        return self
    end    

    return t

end