return function(_Gamestate)
    local def = {name = "Title_Gamestate", scene = "title"}
    local t = _Gamestate:construct(def)

    function t:load(data)
    
        self.super.load(self)
        self.loaded = true

        return self
    end    

    return t

end