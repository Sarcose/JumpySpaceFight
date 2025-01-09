
_c_todo{"Next: newMenuObject. SHOULD we make it a class? Maybe it's time to index Classes a bit deeper."}
local function newMenuObject(label,tooltip,action)
    return {label = label, tooltip = tooltip, action = action}
end



local defaults = {
    type = "Menu",
    Name = "NoName",
    Objects = {
        TestSub = {
            TestTestSub = {}
        }
    },
    Animation = {},     --TODO
    persistent = false, --if false, menu closes when a selection is made. If true, menu stays open
    minimize = false,   --if true, when menu:close is called, it minimizes according to its animation data.
}
local Menu = Object:extend(defaults)


function Menu:AddObject(address, label, tooltip, action)
    local success, addy
    addy, success = gcore.ex:parseRefString(self.Objects, address)
    if not success then
        _c_warn({"Menu:AddObject fail with address ",tostring(address),"label",tostring(label),"Object not added to Menu!"},5)
    else
        local object = newMenuObject(label, tooltip, action)
        table.insert(addy, object)
    end
    --action is either "open a submenu when hovered" or "run a function when clicked". 
            --Action can also be nothing. Action can be a string, which will reference a predefined function here,
            --Or a custom function that is defined at the time the object is declared.
            --for a pause menu or a title menu that distinctly displays one page at a time, 
            --Use Action function() open a new menu with all menus persistent:false minimize:false
    --this was going to be "clickoption" but it might just be best to prototype a 
        --primitive classy object in this file instead.

end

function Menu:Open(x,y,persistent) 


end


--close the menu. Minimize indicates whether or not the menu will 
function Menu:Close(minimize) 


end
return Menu