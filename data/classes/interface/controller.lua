
local defaults = {
    type = "Controller",
    Name = "NoName",    
}
local Controller = Object:extend(defaults)
local defaultInputTable = { --this is a mouse-interface input table for designing.
    controls = {            --i might just put all the different input tables in this file then pick one
        buttons = {'mb_left','mb_right','mb_middle','mb_left','mb_forward','mb_backward','bottomface'},--'down' looks for down
    },
    serialized = false, --set to true to use the button table as a priority index and stop iterating the moment a button returns true
    wheels = true       --set to false to skip checking wheels
}

local function buildInput(i)
    i.queues = {       pressed = {}, directions = {}, down = {}, wheels = {}    }
end

function Controller:new(input)
    input = input or defaultInputTable
    local inst = self:extend()
    inst.type = "Controller"
    buildInput(input)
    tablex.overlay(inst,input)
  return inst
end

local directionPairs = {left = {-1,0}, right = {1,0}, up = {0,-1}, down = {0,1}}

function Controller:addImpulse(pair)
    if pair then table.insert(self.queues.impulses,pair) end
end

function Controller:processImpulses()


end

function Controller:update(dt)
    local buttons = self.controls.buttons
    local serialized = self.serialized
    local found = false
    for i=1, #buttons do
        if controller:pressed(buttons[i]) then
            self.queues.pressed[buttons[i]] = true
            self:addImpulse(directionPairs[buttons[i]])
            found = true
        elseif controller:down(buttons[i]) then
            self.queues.pressed[buttons[i]] = true
            self:addImpulse(directionPairs[buttons[i]])
            found = true
        end
        if found then break end --in a serialized control scheme we can optimize iteration.
    end                         --In gameplay we will not allow for all the mouse buttons
    if self.wheels then
        if controller.wheel.y > 0 then self.queues.mwheel = 1
        elseif controller.wheel.y < 0 then self.queues.mwheel = -1
        else self.queues.wheel = false
        end
    end

    self:processImpulses()
end

function Controller:clear()
    self.queues.down,self.queues.pressed,self.queues.impulses,self.queues.wheels = {},{},{},{}
    self.clearCalled = true
end





return Controller