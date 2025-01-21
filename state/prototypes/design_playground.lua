--[[
Idea: an image editor that lets you prototype polygons by drawing lines from connectors,
and moving connectors or deleting lines/connectors.
]]
local font = love.graphics.newFont(32)
lg.setFont(font)

local Designer = Classes.Framework.State:new(nil,"Designer")



local mousepriority = {"mb_left","mb_right","mb_middle","mb_backward","mb_forward"}
function Designer:mouseButton()
    local click = false
    local down, pressed = self.inputQueues.down, self.inputQueues.pressed
    for i,v in ipairs(mousepriority) do
        if pressed[v] then
            click = {}
            click.button = v
            click.PRESSED = true
            click.s = v.." PRESSED"
            break
        end
    end
    if not click then
        for i,v in ipairs(mousepriority) do
            if down[v] then
                click = {}
                click.button = v
                click.DOWN = true
                click.s = v.." DOWN"
                break
            end
        end
    end
    if click then
        click.x,click.y = gcore.graphics.getMousePosition()
    end
    return click
end
local buttonpriority = {"pause","select","bottomface","rightface","leftface","topface","lbutton","rbutton"}
local labels = {rightface = "action", bottomface = "unaction", leftface = "mod1", topface = "menu", lbutton = "rotateL", rbutton = "rotateR"}
-- zoom? what else do we need?
function Designer:button()
    local button = false
    local down, pressed = self.inputQueues.down, self.inputQueues.pressed
    for i,v in ipairs(buttonpriority) do
        if pressed[v] then
            button = {}
            button.button = v
            button.PRESSED = true
            break
        end
    end
    if not button then
        for i,v in ipairs(buttonpriority) do
            if down[v] then
                button = {}
                button.button = v
                button.DOWN = true
                break
            end
        end
    end
    return button
end

function Designer:load()
    love.mouse.setVisible(true)
    self._input = Classes.Interface.Controller:new()
    self._input:createParentRefs(self)


end

local function testUpdate(self,dt)
    
end
local function testDraw(self)
    local fr,fg,fb = lg.getColor()
    lg.setColor(1,1,1)
    lg.circle("fill",self.x,self.y,self.r)
    lg.print(self.s,self.x+self.r,self.y+self.r)
    lg.setColor(fr,fg,fb)
end

function Designer:addTestObject(s,x,y)
    local o = {
        r = 4,
        x = x,
        y = y,
        s = s,
    }
    o.update = testUpdate
    o.draw = testDraw
    o._address = Designer:add(o)
end




function Designer:processInputs(dt)
    self._input:clear()
    self._input:update(dt)
    local click = self:mouseButton()
    local button = self:button()

    if click then
        if not self._menu:send(click) then  --our menu checks if the click will do something
            

        end
    elseif self.inputQueues.mwheel then
        if not self._menu:send({button = "mwheel", dir = self.inputQueues.mwheel}) then


        end    
    elseif button then        --interaction buttons


    elseif self.inputImpulse.active then    --if there's something to move, move it.

    end
end

function Designer:update(dt)
    self:processInputs(dt)
    --if self.input.queues.pressed.mb_wheelup etc.
    if self.Objects.total > 0 then
        local o, object_cat
        for i=1,#self.Objects.categories do
            object_cat = self.Objects[self.Objects.categories[i]]
            if object_cat.total > 0 then
                for i=1, #object_cat do
                    o = object_cat[i]
                    _safe.call(o.update, o, dt)
                end
            end
        end
    end

end


--








return Designer