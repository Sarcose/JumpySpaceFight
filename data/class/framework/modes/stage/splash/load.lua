return function(ctx)
    local testobjects = require('data.class.framework.modes.stage.test.testObjects')
    for i,v in ipairs(testobjects) do
        ctx.ObjectSystem:addObject(v)
    end

end
-- ctx.ObjectSystem:addObject(obj)
