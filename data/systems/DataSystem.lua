--- used exclusively for handling save data.
local dataSystem = {}

function dataSystem:new()
    local c = {}
    for k,v in pairs(self) do
        if type(k) == "function" then
            c[k] = v
        else
            if type(v) == "table" then
                c[k] = {}
                c[k] = tablex.overlay(c[k],v)
            else
                c[k] = gcore.var.shallowcopy(v)
            end
        end
    end
    gcore.container.assignType(self,"System","dataSystem")
    c:initialize()
    return c
end


function dataSystem:initialize()


end


function dataSystem:construct()


end

--[[
    now, I think this system *should* actually be a one-stop shop for both PARSING and WRITING data.
    What this means is, when the gamestate hands this system its world data,
    the datasystem should parse that world data

    in fact, it MIGHT even be better to remove all of the "getSaveCtx"
    and it MIGHT even be best to have gamestate use its datasystem to apply the saveCtx to a loading state!

]]

return dataSystem