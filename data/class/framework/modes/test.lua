return function(_Gamestate)
    local def = {name = "Test_Gamestate"}
    local t = _Gamestate:construct(def)
    


    function t:update(dt)
        if self.memory and not self.memory:check("updated") then print('TEST UPDATE SUCCESSFUL!!!!!!!!!') self.memory:set("updated") end
        self.memory:update(dt)
    end

    function t:load()
        _c_message{"GameState TEST Loaded"}
        self.super.load(self)
        --after loading my context in self.super.load(self) I will now attach my state-specific context!
        local testThing = {updatesalive = 0, timesdrawn = 0,}
        function testThing:draw()
            self.timesdrawn = self.timesdrawn + 1
            lg.print("Look, I'm a testthing! updates_alive: "..tostring(self.updatesalive).." timesdrawn: "..tostring(self.timesdrawn),0,0)
        end

        function testThing:update(dt)
            self.updatesalive = self.updatesalive + 1
        end
        self.memory:add(testThing)
        self.loaded = true

        return self
    end

    function t:unload()
        _c_message{"GameState TEST Unloaded"}
        self.super.unload(self)
        self.loaded = false
    end

    function t:draw()
        if self.memory and not self.memory:check("drawn") then print('TEST DRAW SUCCESSFUL!!!!!!!!!') self.memory:set("drawn") end
        self.memory:draw()
    end

    return t

end