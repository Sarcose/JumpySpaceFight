return function(_Gamestate)
    local def = {name = "Test_Gamestate"}
    local t = _Gamestate:construct(def)

    function t:load()
    
        self.super.load(self)
        --after loading my context in self.super.load(self) I will now attach my state-specific context!
        local testThing = {updatesalive = 0, timesdrawn = 0,}
        function testThing:draw()
            self.timesdrawn = self.timesdrawn + 1
            lg.setFont(TestFont)
            lg.setColor(0,0.5,0.5)
            lg.rectangle('fill',0,0,10000,10000)
            lg.setColor(1,1,1)
            lg.print("Look, I'm a testthing! updates_alive: "..tostring(self.updatesalive).." timesdrawn: "..tostring(self.timesdrawn),0,0)
           -- lg.draw(push:getCanvas((self.__name),0,0))
        end

        function testThing:update(dt)
            self.updatesalive = self.updatesalive + 1
        end
        self.memory:add(testThing)
        self.loaded = true

        return self
    end    

    return t

end