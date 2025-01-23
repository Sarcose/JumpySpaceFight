--Blueprint. Instances inherit directly from this.

local defaults = {
    type = "State",
    Name = "NoName",

}
local systems = {
    ObjectSystem = "ObjectSystem"
}
local implement = {}    --may end up implementing a menu?
local State = Object:extend(defaults)

function State:new(a,name)  --use new because this is 
    local inst = self:extend(a)
    self:addSystems(systems)
    self:superImplement(implement)
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