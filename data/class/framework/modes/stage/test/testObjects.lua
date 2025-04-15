local o = {}

local testNumbers = {
    label = "testNumbers : ",
    num = 10,
    p = "",
    max = 1000,
    min = -1000,
    font = lg.newFont(32),
    color = {1,0,1},
    x = 100,
    y = 100,
    draw = function(self) 
        lg.setFont(self.font)
        lg.setColor(self.color)
        lg.print(self.p,self.x,self.y)
    end,
    constrain = function(num,min,max)
        if num < min then return min
        elseif num > max then return max
        else return num
        end
    end,
    update = function(self,dt) 
        self.num = self.constrain(self.num + lm.random(self.min,self.max),self.min,self.max)
        self.p = self.label .. tostring(self.num)
    end,
}
--[[
    lg.circle mode x, y, radius
    lg.rectangle mode, x, y, w, h, rx, ry, seg
]]

local function getRandomCircle()
    local line = gcore.var.rsign()
    if line >= 1 then line = 'line' else line = 'fill' end
    return {color = colors:random(), prim='circle',shape = {line, math.random(0,1500),math.random(0,1000),math.random(20,40)}}
end

local function getRandomRect()
    local line = gcore.var.rsign()
    if line >= 1 then line = 'line' else line = 'fill' end
    return {color = colors:random(),prim='rectangle',shape = {line, math.random(0,1500),math.random(0,1000),math.random(10,40),math.random(10,40),math.random(0,10)*10,math.random(0,10)*10}}
end

local function getRandomShape()
    if gcore.var.rsign() == 1 then
        return getRandomCircle()
    else
        return getRandomRect()
    end
end


local testDrawPrims = {
    label = "testDrawPrims: ",
    prims = {},
    color = {0,1,1},
    draw = function(self) 
        for i,v in ipairs(self.prims) do
            lg.setColor(v.color)
            local p = v.shape
            love.graphics[v.prim](p[1],p[2],p[3],p[4],p[5],p[6],p[7])
        end
    end,
    update = function(self,dt) end,
}

for i=1, math.random(10,30) do
    testDrawPrims.prims[i] = getRandomShape()
end

o[1] = testNumbers
o[2] = testDrawPrims


return o