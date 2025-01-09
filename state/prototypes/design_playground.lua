--[[
Idea: an image editor that lets you prototype polygons by drawing lines from connectors,
and moving connectors or deleting lines/connectors.
]]
local font = love.graphics.newFont(32)
lg.setFont(font)

local Designer = Classes.Framework.State:new(nil,"Designer")





function Designer:load()
   self._input = Classes.Interface.Controller:new()
   self.inputQueues = self._input.queues

   _c_debugL(self._input,"Controller")
end

function Designer:processInputs(dt)
    self._input:clear()
    self._input:update(dt)
end

function Designer:update(dt)

end

local function noop()
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

function Designer:draw()
    gcore.debug.guitableprint(self.inputQueues)


end

--MouseCheck._address = Designer:add(MouseCheck)








return Designer