--[[
    The save structure is a big *design* component of JSF and thus OP. I think how we'll initially do it is this:
    Each savedata file has a base structure. savemanager.lua iterates this
    Each savedata "type" is created with a unique set of structures too


]]

local savePrimitive = { --baseline data for all save files
        globals = {},  -- variables (bools, ints, strings) that must be kept in memory at all times
        segments = {}, -- variables (bools, ints, strings), divided into subgroups based on game region, to be loaded and offloaded as needed
        player = {
            HP = 0,
            Statuses = {},
            Inventory = {},
        },
        map = 0, --a number that uses bitwise operations, see https://chatgpt.com/c/67eb258f-7e8c-8006-b5fb-5ad98f3b763d
        bestiary = {},
        trophies = {},

        parse = function(file)


        end,
    
}

local temporarySaveSchemes = { -- this is so we can put it all here at once then move it out into the mode programming once we get it down.
    test = {

    },
    campaign = {
        parse = function(file)

        end,
    },
    arcade = {
        parse = function(file)

        end,
    },
    randomizer = {
        parse = function(file)

        end,
    },
    bossrush  = {
        parse = function(file)

        end
    },

}



local SaveDataStructure = {
    schemes = {
        meta = {    --meta is preregistered as it uses a different, simpler structure.
            latestSave = nil, -- some kind of string for the name of the save I suppose
            configs = {},
            menuCursor = {},    --menu cursor locations for the main menu
            parse = function(file) --read the file and then plunk it into configs and latestSave, to then be applied in main.lua

            end,
        }
    },

}


function SaveDataStructure:register(scheme, dat, parse)   --registers a save data scheme. Modes must use this before they can start to save and load.
    dat = dat or temporarySaveSchemes[scheme]



end


function SaveDataStructure:newSave(scheme)  --generates a *new* savedata, to be kept in memory and then written later.
    assert(self.types[scheme],"SaveData Error: newSave called with invalid scheme: "..tostring(scheme).."! Use SaveDataStructure:register to use this savedata scheme!")

end


return SaveDataStructure
