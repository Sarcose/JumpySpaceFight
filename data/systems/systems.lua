local Systems = {
    Systems = {
        ObjectSystem = 'data.systems.ObjectSystem',
        MultiverseSystem = 'data.systems.MultiverseSystem',
        InteractSystem = 'data.systems.InteractSystem'
    },
    Flattened = {}, --in case I need a ref table for later.
    _tableName = "Systems List",
}

_c_todo{"03/20/2025","Though the systems paradigm was not meant to be super standardized, we do need to standardize the new() function","objectSystem's prior implementation has been broken by the removal of _self. We must reapproach this going forward. For now top level systems are treated as independent objects/containers."}

function Systems:initialize()
    gcore.container.assignType(self,"Global","Systems")
    local s = self.Systems
    local f = self.Flattened
    for k,v in pairs(s) do  --todo: if systems get too bloated, layer this down into categories.
        s[k] = require(v)
        _safe.call(s[k].construct,s[k])
        f[k] = s[k] --if we end up using categories, flattened will be used to direct reference in a single list.
        gcore.container.assignType(s[k],"System",k)
    end
    return self
end
function Systems:getSystem(s)
    local sys = self.Flattened
    if type(sys[s],"System") then
        return sys[s]
        
    else
        _c_error("GetSystem called with invalid system ref : "..tostring(s))
        _c_debug(s)
        _c_debug(sys)
    end
end


return Systems