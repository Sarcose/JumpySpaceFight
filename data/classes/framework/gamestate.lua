
local defaults = {
    type = "State",
    Name = "NoName",
}

local State = Object:extend(defaults)
local function testFunc(first, second, third, fourth)
    _c_message{"Testing!",first,second,third,fourth}
    return first, second, third, fourth
end


function State:new(a,name)
    --print("instantiating new state from "..tostring(name))
    local inst = self:extend(a)
    Prototypes.Systems.ObjectSystem:attach(inst)
    --_c_debug(inst)
    return inst
end


function State:update(dt)
    _safe.call(self.input.update,self,dt)
    self:updateSystems(dt)
    _safe.call(self.input.reset,self)
end

function State:draw()
    self:drawSystems()
end

function State:unload()
    self:unloadSystems()
    for k,v in pairs(self) do
        _safe.release(v)
    end
end

return State