--- used exclusively for handling save data.
local dataSystem = {}

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