return function(C)
    _c_todo{"03/20/2025","Might it be better to merge Gamestates with Game?"}
    local S = {}
    S.Modes = {
        Splash = "splash", --"splash"
        --Title = "title", --"title"
        --JumpySpaceFight = "jsf",--"jsf"   --the base JSF game
        --Some example game Modes
        --BossRush = "bossrush",--"bossrush"
        --Randomizer = "randomizer",--"randomizer"
        --Classic = "classic", --"classic"--a reproduction of original JSF gameplay
    }

    local path = 'data.class.framework.modes.'
    print("LOADING MODES")
    local m = {}
    for k,v in pairs(S.Modes) do
        print("........."..tostring(k))
        if string.len(v) > 0 then
            m[k] = require(path..v)(C) --is this the right syntax??
        end
    end
    S.Modes = m
    function S:get(mode)
        return self.Modes[mode] or error("Gamestate:get() passed with unknown mode: "..tostring(mode).."!")
    end

    return S
end