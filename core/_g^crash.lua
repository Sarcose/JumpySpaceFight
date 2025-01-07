--[[=========================================================================]]
--[[=========================================================================]]
--[[===========___=========================___==============_================]]
--[[========  / _ \__ _ _ __ ___   ___    / __\ __ __ _ ___| |__=============]]
--[[======== / /_\/ _` | '_ ` _ \ / _ \  / / | '__/ _` / __| '_ \ ===========]]
--[[========/ /_\\ (_| | | | | | |  __/ / /__| | | (_| \__ \ | | |===========]]
--[[========\____/\__,_|_| |_| |_|\___| \____/_|  \__,_|___/_| |_|===========]]
--[[=========================================================================]]
--[[=========================================================================]]
-- core utilities lib for Game Crash
-- last update: 01/03/2025

--[[-------------------------------------------------------------------------]]
--[[      Table of Contents---#CONTENTS--------------------------------------]]
--[[      #DEBUG-------------------------------------------------------------]]
--[[      #ACTOR-------------------------------------------------------------]]
--[[      #COMPARISON--------------------------------------------------------]]
--[[      #STATE-------------------------------------------------------------]]
--[[      #MATHS-------------------------------------------------------------]]
--[[      #COLOR-------------------------------------------------------------]]
--[[      #VARIABLE----------------------------------------------------------]]
--[[      #GRAPHICS----------------------------------------------------------]]
--[[      #FILE--------------------------------------------------------------]]
--[[      #DEPRECATED - (stub functions)-------------------------------------]]
--[[-------------------------------------------------------------------------]]
require ('core.debugcandy'):export()
--require 'core.debugcandytest'     --uncomment this when uploading new debugcandy examples
require 'core.reminders'
--Intended use: local rsign = gcore.var.rsign
--Or just call gcore.var.rsign directly
--This way we can call all our utility functions with intellisense if possible
local g = {}

--[[Debug     #DEBUG]]
g.debug = {}
function g.debug.guitableprint(t, name, x, y, font, color, tab, offset,depth)
	setparams = false
	if tab == nil then setparams = true tab = "" end
	name = name or "table"
	x = x or 100
	y = y or 100
	font = font or 'Menu'
	color = color or {1,1,1,1}
	tab = tab or ""
	offset = offset or 0
	depth = depth or 3
	if setparams then
		lg.setColor(color)
		lg.setFont(_G.Font[font])
	end
	lg.print(tostring(tab)..tostring(name).." = {",x,y+offset)
	if depth > 0 then
		for i,v in pairs(t) do
			offset = offset + _G.Font[font]:getHeight("W")
			if type(v) == "table" then
				guitableprint(t[i], i, x, y, font, color, tostring(tab).."  ",offset,depth-1)
			else
				lg.print(tostring(tab).."    "..tostring(i).."= "..tostring(v),x+100,y+offset)
			end
		end
	end
	lg.print(tostring(tab).."		   ".."}")
end
function g.debug.guitableprint_shallow(t, name, x, y, font, color, offset)
	if type(t) ~= 'table' then return end
	name = name or "table"
	x = x or 100
	y = y or 100
	font = font or 'defaultfont'
	color = color or {1,1,1,1}
	offset = offset or 0
	lg.print(tostring(name).." = {",x,y+offset)
	for i,v in pairs(t) do
		offset = offset + _G.fonts[font]:getHeight("W")+4
		lg.print("    "..tostring(i).."= "..tostring(v),x,y+offset)
	end
	lg.print("		   }",x,y+offset + _G.fonts[font]:getHeight("W")+4)
end
function g.debug.guitableprint_vectors(t,name,x,y,font,color,offset)
	assert(type(t) == 'table','ERROR! type passed to guitableprint_vectors is not a table, item is: '..tostring(t))
	assert(type(t[1]) == 'table','ERROR! Type of table passed to guitabelprint_vectors is not a nested table, first index is '..tostring(t[1]))
	assert(#t[1] >= 2 or (t[1].x and t[1].y), 'ERROR! Nested table passed to guitabelprint_vectors is not a complete vector table. First index of first entry is '
		..tostring(t[1][1])..
		'and x/y keys are: '..
		tostring(t[1].x)..', '..tostring(t[1].y))

	name = name or "table"
	x = x or 100
	y = y or 100
	font = font or 'defaultfont_s'
	color = color or {1,1,1,1}
	lg.setColor(color)
	lg.setFont(_G.fonts[font])
	offset = offset or 0
	local step = _G.fonts[font]:getHeight("W")+4
	lg.print(tostring(name).." = {",x,y+offset)
	offset = offset + step
	if t[1].x then --display as a key/value vector
		for i=1,#t do
			lg.print('(x: '..tostring(roundFloat(t[i].x, 3))..', y: '..tostring(roundFloat(t[i].y,3))..')',x,y+offset)
			offset = offset + step
		end
	else	--display as an indiced vector, adding x/y labels
		for i=1,#t do
			lg.print('(x: '..tostring(roundFloat(t[i][1], 3))..', y: '..tostring(roundFloat(t[i][2],3))..')',x,y+offset)
			offset = offset + step
		end
	end

end
function g.debug.guiprint(p,x,y,font,color)
	p=p or 'nil'
	x=x or 0
	y=y or 0
	font = font or 'defaultfont_s'
	color = color or {1,1,1,1}
	lg.setColor(color)
	lg.setFont(_G.fonts[font])
	lg.print(p,x,y)
end
function g.debug.horizontaltableprint(t,x,y,font,color,limit)
	local setparams = false
	if font == nil then setparams = true end    
    x = x or 40
	y = y or 100
	font = font or 'defaultfont_s'
	color = color or {1,1,1,1}
    limit = limit or 10
    local printstring = " "
	for i,v in pairs(t) do
        if limit < 0 then break end
        printstring = printstring..tostring(i).."="..tostring(v)..", "
        limit = limit - 1
    end
	printstring = printstring.."}"
    lg.print(printstring,x,y)
    if setparams then
		lg.setColor(color)
		lg.setFont(_G.fonts[font])
	end
end
function g.debug.displayInputs(t, name, x, y, font, color, offset)
	local setparams = false
	name = name or "table"
	x = x or 40
	y = y or 100
	font = font or 'defaultfont_s'
	color = color or {1,1,1,1}
	tab = tab or ""
	offset = offset or 0
	depth = depth or 3
	if setparams then
		lg.setColor(color)
		lg.setFont(_G.fonts[font])
	end
	lg.print("inputs = {",x,y+offset)
	for i,v in pairs(t) do
		offset = offset + _G.fonts[font]:getHeight("W")
		if type(v) == "table" then
			lg.print(tostring(tab).."  "..tostring(i).."= {",x+20,y+offset)
			local width = _G.fonts[font]:getWidth(tostring(tab).."  "..tostring(i).."= ")
			horizontaltableprint(t[i], x+10+width, y+offset,font,color)
		else
			lg.print(tostring(tab).."    "..tostring(i).."= "..tostring(v),x+20,y+offset)
		end
	end
	lg.print("}",x,y+offset)
end
function g.debug.tablePrint_asString(t, name, tbls)
	local s = name or ""
	local tbls = tbls or {}
	for i = 1, #t do
		if type(t[i]) == "table" and not tbls[tostring(t[i])] then
			tbls[tostring(t[i])] = true
			s = s .."["..tostring(i).."]={"..tablePrint_asString(t[i],nil,tbls).."}"
		elseif type(t[i]) == "table" then
			s = s.." "..tostring(t[i])
		else
			s = s .."["..tostring(i).."]="..tostring(t[i])
		end
	end
	for k,v in pairs(t) do
		if type(k) == "string" then
			if type(t[k]) ~= "function" and k[1]~= "_" and k ~="super" then
				if type(t[k]) == "table" and not tbls[tostring(t[k])] then
					tbls[tostring(t[k])] = true
					s = s .."["..tostring(k).."]={"..tablePrint_asString(t[k],nil,tbls).."}"
				elseif type(t[k]) == "table" then
					s = s.." "..tostring(t[k])
				else
					s = s .."["..tostring(k).."]="..tostring(t[k])
				end
			end
		end
	end
	return s
end
function g.debug.printHeader(text,line,color,bg)
	print(line)
	color = color or "yellow"
	line = line or "============================================================"
	local title_width = #line
	local third = title_width/3
	local char = string.sub(line,1,1)
	text = text or "Title"
	text = string.upper(text)
	text = string.gsub(text, "(.)", "%1 ")
	local len = #line
	local title_len = #text
	local total_padding = len - title_len
	if total_padding < 0 then total_padding = 0 end
	local left_padding = math.floor(total_padding / 2)
    local right_padding = total_padding - left_padding
    local titlestring = string.rep("=", left_padding) .. "  " .. text .. "  " .. string.rep("=", right_padding)
	if #titlestring > len then titlestring = string.sub(titlestring,#titlestring-len+1) end
	_c_printCBG(line,color,bg)
	_c_printCBG(line,color,bg)
	_c_printCBG(titlestring,color,bg)
	_c_printCBG(line,color,bg)
	_c_printCBG(line,color,bg)
	
end
function g.debug.printBreak(text)
	text = text or "============================================================"
	_c_printC("yellow",text)
end
function g.debug.loadingBar(value, start, goal, text)	--TODO: for now only use start/goal that divides evenly by 100
	text = text or "[.]"
	local open, tick, close = text.char(1), text.char(2),text.char(3)
	if value == start then
		io.write(open)
	elseif value == goal then
		io.write(close)
		return true
	else
		local period = (goal-start)/100
		if value % period == 0 then
			io.write(tick)
		end
	end
end
g.actor = {}
--[[Actor Functions #ACTOR]]

function g.actor.distanceHorizontal(a,b)
	if a.x < b.x then
		return math.abs(a.x+(a.w/2) - b.x-(b.w/2))
	else
		return math.abs(a.x-(a.w/2) - b.x+(b.w/2))
	end
end

function g.actor.distanceVertical(a,b)
	if a.y < b.y then
		return math.abs(a.y+(a.h/2) - b.y-(b.h/2))
	else
		return math.abs(a.y-(a.h/2) - b.y+(b.h/2))
	end
end

g.comparison = {}

--[[Comparison      #COMPARISON]]   --check batteries for a lot of these
function g.comparison.bigger(a,b)
	return (a > b) and a or b or 0
end
function g.comparison.smaller(a,b)
	return (a < b) and a or b or 0
end
function g.comparison.compareFloat(a,b)
	--print('comparing '..tostring(a)..' to '..tostring(b))
	return (tostring(a)==tostring(b))
end
function g.comparison.getClosestNumber(n,t) --a table of numbers arranged in numeric order
	for i=1,#t-1 do
		if n <= t[i] then return t[i]
		elseif n <= (t[i+1]-t[i])/2 then return t[i]
		elseif n >= (t[i+1]-t[i])/2 and n <= t[i+1] then return t[i+1]
		end
		if i == #t-1 then return t[#t] end
	end
end
function g.comparison.shuffle(t)
	local tbl = {}
	for i = 1, #t do
	  tbl[i] = t[i]
	end
	for i = #tbl, 2, -1 do
	  local j = math.random(i)
	  tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end
function g.comparison.clamp(n,clampmin,clampmax)
	if n > clampmax then return clampmax elseif n < clampmin then return clampmin else return n end
end
function g.comparison.getSign(x)
	if x >= 0 then return 1 else return -1 end
end
function g.comparison.notZero(x,y)
	if math.abs(x)>=y then return x else return y end
end
function g.comparison.orZero(n)
	if n<0 then return 0 else return n end
end

g.state = {}
--[[state           #STATE]]
local function addMethods(a)
	function a.load () end
	function a.update(dt) end
	function a.draw() end


end

-- TODO
function g.state.new_engine(...)  
    local args = {...}
    local c = {}
    local prefix = "_Engine"
    for i, v in ipairs(args) do
        if type(v) == "table" then
            c = v
        elseif type(v) == "string" then
            prefix = v
        end
    end



end








g.math = {}
--[[Maths           #MATHS]]        --check batteries for a lot of these
function g.math.ccw(A,B,C)
    return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x)
end
function g.math.lineIntersect(Ax,Ay,Bx,By,Cx,Cy,Dx,Dy)
	return intersect2{
						A = {x = Ax, y = Ay},
						B = {x = Bx, y = By},
						C = {x = Cx, y = Cy},
						D = {x = Dx, y = Dy},}
end
function g.math.intersect2(A,B,C,D)
    return ccw(A,C,D) ~= ccw(B,C,D) and ccw(A,B,C) ~= ccw(A,B,D)
end


function g.math.dist(x1,y1,x2,y2)
	return math.sqrt((x1-x2)^2+(y1-y2)^2)
end

function g.math.distanceBetweenObjects(a,b)    --assuming the objects have w,h,x,y values
	return dist(a.x+a.w/2,a.y+a.h/2,b.x+b.w/2,b.y+b.h/2)
end

function g.math.speedByVector(x1,y1,x2,y2)
	local xspeed = (x1-x2)
	local yspeed = (y1-y2)
	
	return xspeed, yspeed
end
function g.math.randomRadian(r1, r2)   -- TODO: what is this function for?
	r1 = r1 or 0
	r2 = r2 or 315
	return rand(r1,r2)
end
function g.math.roundFloat(n,dec)
	return roundfloat(n,dec)
end
function g.math.roundfloat(n,dec)
	return math.floor(n*10^dec)/10^dec

end
function g.math.round(n, mult)
    mult = mult or 1
    return math.floor((n + mult/2)/mult) * mult
end
function g.math.timeToRads(hour)	--decimal hour
	return math.rad((hour-18)*15)	-- hour-18 *should* put 0 at 6AM~ish
end
function g.math.decimalToTime(decTime)
	local hr = math.floor(decTime)
	local min = (decTime - hr)*60
	return hr,min
end
function g.math.decimalToTimeString(decTime)	--we'll do seconds another time
	local hr,min = decimalToTime(decTime)
	if min < 9 then min = '0'..tostring(math.floor(min))
	else min = tostring(math.floor(min)) end
	return tostring(hr)..':'..min
end
function g.math.convertToTimeNotation(sec) --a number in seconds
	sec = round(sec, 2) --round to a number of seconds + .00
	local m = math.floor(sec / 60) --we have the total minutes
	local h = math.floor(m / 60) --we have the final hours
	local s = sec - (m * 60) --we have the final seconds.milli
	m = m - (h * 60) --we have the final minutes
	
	local sh, sm, ss
	
	if h < 10 then
		sh = "0"..tostring(h)
	else
		sh = tostring(h)
	end
	
	if m < 10 then
		sm = "0"..tostring(m)
	else
		sm = tostring(m)
	end
	
	if s < 10 then
		ss = "0"..tostring(s)
	else
		ss = tostring(s)
	end
	
	local s = sh..":"..sm..":"..ss
	
	return s
end
function g.math.stepToTarget(x1,y1,x2,y2,speed,dt)
	dt = dt or 1
	local dx,dy = x2-x1,y2-y1
	local dist = math.sqrt(dx*dx + dy*dy)
	local step = speed*dt
	if dist <= step then
		return x2,y2
	else
		local nx = dx/dist
		local ny = dy/dist
		return x1+nx*step,y1+ny*step
	end
end
function g.math.moveByVector(x,y,xv,yv,dist)
	return stepToTarget(x,y,x+xv*dist,y+yv*dist,dist)
end
function g.math.angleByPoints(x1,y1,x2,y2)
	return math.atan2(y2-y1, x2-x1)
end
function g.math.invertAngle(angle) 
	return (angle + math.pi) % (2 * math.pi)
end
function g.math.angleRadians(x1,y1,x2,y2)
	return math.atan2(y2 - y1, x2 - x1) * math.pi/180
end
function g.math.degToRad(deg)
	return deg*(math.pi/180)
end
function g.math.angleFromVector(x,y)
	return math.atan2(y,x)
end
function g.math.vectorFromAngle(a)
	return math.cos(a),math.sin(a)
end
local _angleDirections = {
	[-1] = {
		[-1] =225,
		[0] =180,
		[1] =135,
	},
	[0] = {
		[-1] =270,
		[0] =0,
		[1] =90,
	},
	[1] = {
		[-1] = 315,
		[0] =0,
		[1] =45,
	}

}
function g.math.angleByDirections(dir,vert,facingdir)
	assert(dir,'dir passed is '..tostring(dir))
	assert(vert,'vert passed is '..tostring(vert))
	if facingdir ~= 0 then facingdir = getsign(facingdir) end
	if dir == 0 and vert == 0 then
		assert(_angleDirections[facingdir],'facingdir == '..tostring(facingdir))
		assert(_angleDirections[facingdir][vert],'vert == '..tostring(vert))
		return _angleDirections[facingdir][vert]
	else	return _angleDirections[dir][vert]	
	end
end

function g.math.third(value,max)	--
	local first,second = max/3,max/3*2
	if value <= first then return 1
	elseif value <= second then return 2
	else return 3 end
end
function g.math.getPercent(value,max)
	return value/max*100
end
local sin,cos = math.sin,math.cos
local pi = math.pi
function g.math.sineMove(time, angle, amplitude, waveLen)
    return
		cos(angle) * time * waveLen + ((amplitude / 2) * sin(time) * sin(angle)), 
    	sin(angle) * time * waveLen - ((amplitude / 2) * sin(time) * cos(angle))
end
function g.math.sineVector(x,y,oX,oY,offset,time,angle,amplitude,wavelen)
	local vectorX,vectorY = vectorFromAngle(angle)
    local sinX,sinY = sineMove(time,angle,amplitude,wavelen)
    local goalX,goalY = oX+sinX-(offset*vectorX),oY+sinY-(offset*vectorY)
	return goalX-x,goalY-y
end
g.color = {}

--[[Colors          #COLOR]]    -- this *probably* can be achieved by batteries
function g.color.darkenColor(o,ratio)
	local r = {}
	ratio = ratio or 0.5
	r[1] = o[1]*ratio
	r[2] = o[1]*ratio
	r[3] = o[1]*ratio
	return r
end
function g.color.reverseColor(o)
	local r = {}
	r[1] = 0.5 + (0.5 - o[1])
	r[2] = 0.5 + (0.5 - o[2])
	r[3] = 0.5 + (0.5 - o[3])
	return r
end

function g.color.rgbMult(color,mult)
	return {color[1]*mult,color[2]*mult,color[3]*mult}
end

function g.color.lumenMultiply(color,mult,clamp)
    local c = {}
    local ret = {}
    c[1],c[2],c[3] = colour.rgb_to_hsl(color[1],color[2],color[3])

    c[3] = c[3] * mult
	if clamp then
		if clamp.min and c[3] < clamp.min then
			c[3] = clamp.min
		elseif clamp.max and c[3] > clamp.max then
			c[3] = clamp.max
		end
	end
    ret[1],ret[2],ret[3] = colour.hsl_to_rgb(c[1],c[2],c[3])
    return ret
end
function g.color.raw2color(r, g, b, a)
	if type(r) == 'table' then
		r, g, b, a = unpack(r)
	end
	return r / 255, g / 255, b / 255, a and a / 255
end
function g.color.lumenSet(color,amount,clamp)
	local c = {}
    local ret = {}
    c[1],c[2],c[3] = colour.rgb_to_hsl(color[1],color[2],color[3])

    c[3] = amount
	if clamp then
		if clamp.min and c[3] < clamp.min then
			c[3] = clamp.min
		elseif clamp.max and c[3] > clamp.max then
			c[3] = clamp.max
		end
	end
    ret[1],ret[2],ret[3] = colour.hsl_to_rgb(c[1],c[2],c[3])
    return ret
end


function g.color.hsvToRgb(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r, g, b
end
function g.color.rgbToHsv(r, g, b)
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local delta = max - min

    -- Calculate Hue
    local h
    if delta == 0 then
        h = 0
    elseif max == r then
        h = (g - b) / delta % 6
    elseif max == g then
        h = (b - r) / delta + 2
    elseif max == b then
        h = (r - g) / delta + 4
    end
    h = h / 6

    -- Calculate Saturation
    local s = (max == 0) and 0 or (delta / max)

    -- Value (Brightness)
    local v = max

    return h, s, v
end
function g.color.hsvGlow(h, s, minV, maxV, speed, time)
    local v = minV + (maxV - minV) * (0.5 * (1 + math.sin(time * speed)))
    return hsvToRgb(h, s, v)
end
--local r, g, b = glow(h, s, minV, maxV, speed, love.timer.getTime())
function g.color.hsvGlowByGlobalTimer(color,minV,maxV,speed)
	local r,g,b = color[1],color[2],color[3]
	local h,s,v = rgbToHsv(r,g,b)
	return hsvGlow(h,s,minV,maxV,speed,love.timer.getTime())
end

function g.color.rgbHSLmod(r,g,b,nh,ns,nl)
	local h,s,l = rgbToHsl(r,g,b)
	return hslToRgb(h+nh,s+ns,l+nl)
end

g.var = {}
--[[Variable operations #VARIABLE]]
function g.var.rsign()
	return math.random(0,1)*2-1
end
function g.var.boolSwitch(v)
	if v then return false else return true end
end
function g.var.getsign(v)
	if v >= 0 then return 1 else return -1 end
end
function g.var.getsignzero(v)
	if v > 0 then return 1 elseif v == 0 then return 0 else return -1 end
end
function g.var.randomPick(t)	--random{1,2,3,4,5}
	return t[math.random(1,#t)]
end
function g.var.weightedRandom (pool)
    local poolsize = 0
    for k,v in ipairs(pool) do
      poolsize = poolsize + v[1]
    end
    local selection = math.random(1,poolsize)
    for k,v in pairs(pool) do
       selection = selection - v[1] 
       if (selection <= 0) then
          return v[2]
       end
    end
 end
 
function g.var.shallowcopy(orig)
    _c_debug("shallowcopy called: batteries might have a better alternative",1)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function g.var.deepcopy(orig,src)
    _c_debug("deepcopy called: batteries might have a better alternative",1)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key,src)] = deepcopy(orig_value,src)
        end
        setmetatable(copy, deepcopy(getmetatable(orig),src))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function g.var.getCentered(w,h)
	w = w or 1
	h = h or 1
	return (GAME_W - w)/2, (GAME_H - h)/2
end

function g.var.getClosestMod(n, m)	--todo: do this lol
	assertType(n,"number","getClosestMod","n")
	assertType(m,"number","getClosestMod","m")
end


function g.var.tablePurge(table,countTo)
	if #table > countTo then
		local t = {}
		for i=1,countTo do
			t[i] = table[i]
		end
		return t
	else return table end
end
function g.var.addWrapped(value,max)
	if value <= max then return value
	else return value-max end
end
function g.var.getWrapped(list,ind)	
	if ind <= #list then return ind
	elseif (ind - #list) > #list then return getWrapped(list,ind-#list)
	else return ind-#list
	end
end

function g.var.shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

g.graphics = {}
--[[Graphics #GRAPHICS]]
function g.graphics.loadImageDataFromPath( filePath )
    local f = io.open( filePath, "rb" )
    if f then
        local data = f:read( "*all" )
        f:close()
        if data then
            data = love.filesystem.newFileData( data, "tempname" )
            data = love.image.newImageData( data )
            local image = love.graphics.newImageData( data )
            return image
        end
    else
		error('loadImageDataFromPath error: no file loaded!')
	end
end
function newFont_Sizes(fontname,tf,n)
	name = n or fontname or 'default'
	name = string.lower(name)
	tf = tf or 0	--tinyfont - you can pass the smallest font increment and it'll scale it up from there
	local sizetable = {t = 8+tf, s = 10+tf, m = 12+tf, l = 16+tf, xl = 18+tf, xxl = 20+tf, xxxl = 24+tf, xxxxl = 42+tf}
	for i,v in pairs(sizetable) do
		if fontname then
			local f = lg.newFont('fonts/'..fontname..'.ttf',v)
			_G.fonts[(name..'_'..string.lower(tostring(i)))] = f
		else
			local f = lg.newFont(v)
			_G.fonts[('default'..'_'..string.lower(tostring(i)))] = f
		end
	end
end

g.file = {}
--[[File ops #FILE]]

function g.file.evaluate(cmd,v) -- this uses recursion to solve math equations
    --[[ We break it into pieces and solve tiny pieces at a time then put them back together
        Example of whats going on
        Lets say we have "5+5+5+5+5"
        First we get this:
        5+5+5+5 +   5
        5+5+5   +   5
        5+5 +   5
        5   +   5
        Take all the single 5's and do their opperation which is addition in this case and get 25 as our answer
        if you want to visually see this with a custom expression, uncomment the code below that says '--print(l,o,r)'
    ]]
    v=v or 0
    local count=0
    local function helper(o,v,r)-- a local helper function to speed things up and keep the code smaller
        if type(v)=="string" then
            if v:find("%D") then
                v=tonumber(math[v]) or tonumber(_G[v]) -- This section allows global variables and variables from math to be used feel free to add your own enviroments
            end
        end
        if type(r)=="string" then
            if r:find("%D") then
                r=tonumber(math[r]) or tonumber(_G[r]) -- A mirror from above but this affects the other side of the equation
                -- Think about it as '5+a' and 'a+5' This mirror allows me to tackle both sides of the expression
            end
        end
        local r=tonumber(r) or 0
        if o=="+" then -- where we handle different math opperators
            return r+v
        elseif o=="-" then
            return r-v
        elseif o=="/" then
            return r/v
        elseif o=="*" then
            return r*v
        elseif o=="^" then
            return r^v
        end
    end
    for i,v in pairs(math) do
        cmd=cmd:gsub(i.."(%b())",function(a)
            a=a:sub(2,-2)
            if a:sub(1,1)=="-" then
                a="0"..a
            end
            return v(evaluate(a))
        end)
    end
    cmd=cmd:gsub("%b()",function(a)
        return evaluate(a:sub(2,-2))
    end)
    for l,o,r in cmd:gmatch("(.*)([%+%^%-%*/])(.*)") do -- iteration this breaks the expression into managable parts, when adding pieces into
        --print(":",l,o,r) -- uncomment this to see how it does its thing
        count=count+1 -- keep track for certain conditions
        if l:find("[%+%^%-%*/]") then -- if I find that  the lefthand side of the expression contains lets keep breaking it apart
            v=helper(o,r,evaluate(l,v))-- evaluate again and do the helper function
        else
            if count==1 then
                v=helper(o,r,l) -- Case where an expression contains one mathematical opperator
            end
        end
    end
    if count==0 then return (tonumber(cmd) or tonumber(math[cmd]) or tonumber(_G[cmd])) end
    -- you can add your own enviroments as well... I use math and _G
    return v
end

--[[Replace print() with debugcandy, throw soft warnings w/trace if print() is used directly]]
function _G.print(...)
    local printResult = "print() called: "
    local args = {...}
    for i,v in ipairs(args) do
        printResult = printResult ..tostring(v).."\t "
    end
    printResult = printResult .."\n"
    _c_debug(printResult)
end

--[[ Reference g into global gcore ]]
_G.gcore = g
