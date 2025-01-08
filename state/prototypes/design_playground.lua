--[[
Idea: an image editor that lets you prototype polygons by drawing lines from connectors,
and moving connectors or deleting lines/connectors.

]]
local s = Classes.State:new()

local font = love.graphics.newFont(32)
lg.setFont(font)
local MouseCheck = {
    currentButton = "Nothing pressed"
}
function MouseCheck:update(dt)
    if controller:pressed('mb_left')            then self.currentButton = "Left Mouse Button Clicked!"
    elseif controller:pressed('mb_right')       then self.currentButton = "Right Mouse Button Clicked!"
    elseif controller:pressed('mb_middle')      then self.currentButton = "Middle Mouse Button Clicked!"
    elseif controller:pressed('mb_wheeldown')   then self.currentButton = "Mousewheel Down!"    --love.mouse.wheelmoved
    elseif controller:pressed('mb_wheelup')     then self.currentButton = "Mousewheel Up!"      --love.mouse.wheelmoved
    elseif controller:pressed('mb_x1')          then self.currentButton = "Mouse X1 Pressed!"   ---dunno what these are yet
    elseif controller:pressed('mb_x2')          then self.currentButton = "Mouse X2 Pressed"
    end
end

function MouseCheck:draw()
    love.graphics.print(self.currentButton,100,100)
end

MouseCheck._address = s:add(MouseCheck)




return s