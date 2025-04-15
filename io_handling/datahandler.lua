--[[
    The save structure is a big *design* component of JSF and thus OP. I think how we'll initially do it is this:
    Each savedata file has a base structure. savemanager.lua iterates this
    Each savedata "type" is created with a unique set of structures too


]]

   -- current_file = nil,
   -- current_mode = nil,
   -- current_save = nil,
   -- data = nil

local savePrimitive = { --baseline data for all save files
        meta = {
            settings = {},
            bestiary = {},
            trophies = {},
        },
        internal = {
            globals = {},   --loaded immediately
            locals = {},    --as a player crosses a "CheckData" point, it looks for the target data within data.internal.locals[nameofplaceimgoing] and applies it prior to loading the area
            player = {      --also loaded immediately
                HP = 0,
                Statuses = {},
                Inventory = {},
            },
        },
        map = 0, --a number that uses bitwise operations, see https://chatgpt.com/c/67eb258f-7e8c-8006-b5fb-5ad98f3b763d
        
}
     


return 
