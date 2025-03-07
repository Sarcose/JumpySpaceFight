return function(_Overlay)
    local O = {}
    O.instances = {
        --Menus
        Title = "jsf_title_menu",
        Pause = "jsf_pause_menu",    --i think this will stay the same in all modes, but have some conditional things

        --gamemode HUDs
        JumpySpaceFight = "jsf_basegame_hud",
        BossRush = "jsf_bossrush_hud",
        Randomizer = "jsf_randomizer_hud",
        Classic = "jsf_classic_hud",
        
        Trackdisplay= "trackdisplay", -- jsf's music display card based on MTV music videos

    }
    local path = 'data.class.interface.uis.'
    for k,v in pairs(O.instances) do
        if string.len(v)>0 then
            O.instances[k] = require(path..v)(_Overlay)
        end
    end

    function O:get(UI)
        return self.Instances[UI] or error("Overlay:get() passed with invalid UI: "..tostring(UI))
    end
    function O:new(u)   --wrapper to generate a new one based on elements and _Overlay

    end


    return O
end