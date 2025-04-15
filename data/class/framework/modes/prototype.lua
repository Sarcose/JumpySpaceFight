local P = {}
--the collection of shared




function P.loadData(mode,data)
    --apply data

end

function P.loadStage(mode)
    local ctx = mode.Context
    --based on mode.currentData or something, load stage

    local testobjects = require('data.class.framework.modes.stage.test.testObjects')
    for i,v in ipairs(testobjects) do
        ctx.ObjectSystem:addObject(v)
    end

end


function P.load(mode,data)
    P.loadData(mode, data) 
    P.loadStage(mode)
end

function P.unload(mode)

end

return P