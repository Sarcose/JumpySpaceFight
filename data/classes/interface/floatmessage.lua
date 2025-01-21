local defaults = {
    type = "FloatMessage",
    Name = "NoName",    
    message = ""
    time = 2,
}
local FloatMessage = Object:extend(defaults)


function FloatMessage:new(a)
    if type(a) == "string" then a = {message=a} end
    local inst = self:extend(a)
    return inst
end


function FloatMessage:update(dt)
    self.time = self.time - dt
    if self.time < 0 then
        
    end

end