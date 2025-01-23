local d = {
    type = "Prototype",
    name = "Prototype",
    public = {},
}

local Prototype = Object:extend(d)

function Prototype:attach(o)
    for k,v in pairs(self.public) do
        o[k] = v
    end
    _c_debugL{_t = o, title = o._tableName}
    o:addSystem(self,self.name)
    _c_message("system added!","white","red")
end

function Prototype:new(methods,properties)
    local inst = self:extend()
    for k,v in pairs(methods) do
        self:addMethod(k,v)
    end
    local prop = gcore.var.deepcopy(properties)
    tablex.overlay(inst,prop)
    return inst
end

function Prototype:addMethod(k,f)
    if self.public[k] then k = "_"..k end
    self.public[k] = f
end

return Prototype