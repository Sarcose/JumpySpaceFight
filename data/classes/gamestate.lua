
defaults = {
    Type = "State",
    Name = "NoName",
    Objects = {}
}

local State = Object:extend(defaults)
local function testFunc(first, second, third, fourth)
    _c_message{"Testing!",first,second,third,fourth}
    return first, second, third, fourth
end

function State:load()

end


function State:update(dt)
    local o
    for i=1,#self.Objects do
        o = self.Objects[i]
        _safe.call(o.update, self, o, dt)
    end
end

function State:draw()
    local o
    for i=1,#self.Objects do
        o = self.Objects[i]
        _safe.call(o.draw, self, o)
    end
end

function State:unload()
    for k,v in pairs(self) do
        if v.release and type(v.release) == "function" then
            if _DEBUGLEVEL >= 3 then
                local st = "State "..tostring(self.name).." releasing "..tostring(k).." | "..tostring(v)
                _c_message(st)
            end
            v:release()
        end
    end
end

return State