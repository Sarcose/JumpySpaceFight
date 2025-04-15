local P = {}
--the collection of shared


function P.load(mode)
    local ctx = mode.Context
    local testobjects = require('data.class.framework.modes.stage.test.testObjects')
    for i,v in ipairs(testobjects) do
        ctx.ObjectSystem:addObject(v)
    end

end

function P.unload(mode)

end

return P