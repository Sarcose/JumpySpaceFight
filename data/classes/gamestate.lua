
defaults = {
    Type = "State",
    Name = "NoName"
}

local State = Object:extend(defaults)

function State:load()

end

function State:update(dt)

end

function State:draw()

end

function State:unload()
    for k,v in pairs(self) do
        if v.release and type(v.release) == "function" then
            if _DEBUGLEVEL >= 3 then
                local st = "State "..tostring(self.name).." releasing "..tostring(k).." | "..tostring(v)
                _c_message(st)
            end
            v:release()
        end
    end
end

return State