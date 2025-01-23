local s = {
    ObjectSystem = 'data.system.systems.ObjectSystem'
}

local Systems = {}

function Systems:initialize(context)
    for k,v in pairs(s) do
        self[k] = require(v)
        if type(self[k].initialize) == "function" then
            self[k].initialize(context) 
        end
    end
end



return Systems