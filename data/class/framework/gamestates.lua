return function(_Gamestate)
    _c_todo{"03/20/2025","Might it be better to merge Gamestates with Game?"}
    local S = {}
    S.Modes = {
        Splash = "", --"splash"
        Title = "", --"title"
        Test = "test",  --"test"
        JumpySpaceFight = "",--"jsf"   --the base JSF game
        --Some example game Modes
        BossRush = "",--"bossrush"
        Randomizer = "",--"randomizer"
        Classic = "", --"classic"--a reproduction of original JSF gameplay
    }

    local path = 'data.class.framework.modes.'
    for k,v in pairs(S.Modes) do
        if string.len(v) > 0 then
            S.Modes[k] = require(path..v)(_Gamestate) --is this the right syntax??
        end
    end

    function S:get(mode)
        return self.Modes[mode] or error("Gamestate:get() passed with unknown mode: "..tostring(mode).."!")
    end

    return S
end