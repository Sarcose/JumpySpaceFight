-- Customization options

--[[
Refactor TODO:
	Functionality:
	--[X] Nested properties
		--[ ] Re-Address, test all methods
		--[ ] Implement new properties:
			--[X] Level and Switch checks
			--[ ] controls
			--[ ] tweaks
			--[ ] displayProperties
			--[ ] Remove deprecated
	--[ ] Better arg implementation of debug, allowing for a name that doesn't touch the table
		--[ ] Merge debug, debugN, debugL into one
	--[ ] Make a design decision re: export vs library, regarding update and draw
	--[ ] As of now, Debug_Level 3 is the same as 4. Recursion needs to be turned off for 3.
	--[ ] Better separation of debug vs. safety features. Maybe safety methods should be removed because of scope.
	--[ ] Rewrite or change generic methods for usability: printC/printCBG/blank/message
	
	Visual:
	--[ ] Color is still not fully standardized in implementation; review all methods' practices.
	--[ ] Full implement of GUI
	--[ ] Change "reminderHeader/reminderFooter" into a generic wrapper that can put a header/footer over anything.
	--[ ] Could potentially set up tabs with an int and implement ccandy.load()
	
	Upload:
	--[ ] Properly work from a repo instead of right inside one of my projects >_<
	--[ ] Test every feature again
	--[ ] New screenshots
	--[ ] Documentation for all the new features

	
	
]]



--[[
Debug levels:	(ccandy.controls.Debug_Level)
	0: Set to 0 to turn the whole library OFF.
	1: Errors and Warnings only
	2: Messages, Todo lists, Reminders, high level debug information. Tables are not recursed.
	3: Recurse through tables, filtering constructor methods and allowing for "exclude" in ccandy.debugL()
	4: No filters, all information shown. Debugging still applies.

Keys:
	-- Arrows: Move gui output
	-- Shift: Speed up
	-- Ctrl: Slow down
	-- +/-: Zoom
	-- D+Number keys (1, 2, 3, 4) set Debug_Level

]]

local ccandy = {
	controls = {			--Major functionality properties. Use the format Capital_Letter_Underscores to signiy their importance.
		Debug_Level = 3,
		Colors = true,		
		GUI = false,		--Toggle on GUI output for all methods. Multi-colored output not yet implemented (debugL)
		Start = 4,			--How many levels of stack trace to ignore (to avoid outputting the debug lib for instance)
		Trace_Level = 4,		--Level of stack trace all methods report by default. Level starts after |Start| is applied
		Override = false,	--Panic button. If true, all debug methods report |TraceLevel| stack trace, ignoring arguments.
		Keys = false,		--Set to true and use ccandy:update(dt) (or _c_debugUpdate(dt)) to have Debug Candy enable arrow keys for moving the GUI output
		Table_Depth_Limit = 9,	--hard limit on table depth parsing
	},
	switches = {			--Turn off the output of specific methods.
		debug 	= true,	
		todo 	= true,
		remind 	= true,
		warn 	= true,
		error 	= true,
		stop 	= true,
		assert 	= true,
		success = true,
		message = true,
	},
	tweaks = {				--Usage preferences
		toDoExpiration = 5,		--how long before a todo throws a warning that it's been ignored, only works if you pass a date.
		reminderheader = "==========!!!=======REMINDER=======!!!========",
		reminderfooter = "=========!!!=======================!!!========",
		toDoTab = "   ",
		debugLTab = "      ",		--how big the tab is between levels when using debugL()
		backgrounds = false,
	},
	dev = {					--If you REALLY want to...
		debugTheDebugger = false,
	},
	displayProperties = {	--TODO: add controls for offsetting.
		font = love.graphics.newFont(28),
		background = false,
		color = true,
		x = 0,
		y = 0,
		sx = 1,
		sy = 1,
		linespace = 0.5,
	},
--[[	Deprecated Properties	]]
	remindOn = true,
	debugOn = true,
	todosOn = true,
	colorsOn = true,
	baseLevel = 10,			--level of stack parsing
	pathDepth = 1,			--how many levels to skip before parsing, to avoid redundantly labeling the library in every output
	toDoExpiration = 5,		--how long before a todo throws a warning that it's been ignored, only works if you pass a date.
	reminderheader = "==========!!!=======REMINDER=======!!!========",
	reminderfooter = "=========!!!=======================!!!========",
	toDoTab = "   ",
	debugLTab = "      ",		--how big the tab is between levels when using debugL()
	backgrounds = false,
	tableDepthLimit = 9,
--[[	End of Deprecation	]]
	_drawTable = {},
	colors = {
		warn = "yellow",
		error = "red",
		debug = "blue",
		todo = "cyan",
		message = "cyan",
		remind = "yellow",
		success = "green"
	},
	bgcolors = {
		warn = "red",
		error = "white",
		debug = "yellow",
		todo = "magenta",
		message = "black",
		remind = "blue",
		success = "black"
	},
}
-- ANSI sequences
local resetANSI = "\x1B[m"
local consolecolors = {
	black = "\x1b[30m",			white = "\x1b[37m",
	red = "\x1B[31m", 			green = "\x1B[32m", 	
	yellow = "\x1b[33m", 		blue = "\x1b[94m",
	magenta = "\x1b[35m",		cyan = "\x1b[36m"	}		
local bgcolors = {
	white = "\x1b[47m",				black = "\x1b[40m",
	red = "\x1b[41m",				yellow = "\x1b[43m",	   		
	green = "\x1b[42m",				blue = "\x1b[44m",
	magenta = "\x1b[45m",			cyan = 	"\x1b[46m"	}

-- Helper functions

local function extractCallerInfo(level, parseStart)
    local stack = debug.traceback("", 2)
    local lines = {}
    for line in stack:gmatch("[^\n]+") do
        table.insert(lines, line)
    end
    local ret = ""
    parseStart = parseStart or 4
    local lastFile = nil
    local currentRange = {}
	local depth = ccandy.pathDepth
    if level then
        for i = 1, level do
            local n = (i - 1) + parseStart
            local callerInfo = lines[n]
            if callerInfo then
                local file, line = callerInfo:match("([^:]+):(%d+)")
                if file and line then
                    -- Handle the file path depth
                    local pathParts = {}
                    for part in file:gmatch("[^/\\]+") do
                        table.insert(pathParts, part)
                    end
                    -- Adjust the file path based on the depth
                    if depth > 0 then
                        local startIdx = math.max(#pathParts - depth, 1)
                        file = table.concat({unpack(pathParts, startIdx)}, "/")
                    else
                        file = pathParts[#pathParts]  -- Only the filename
                    end
					file = string.gsub(file, "%s", "")  -- Remove spaces	--TODO: this might interfere with filenames that have spaces. Solution: don't use spaces imo
                    file = string.gsub(file, "/", ".")  -- Replace '/' with '.'
                    local num = tonumber(line)
                    if lastFile == file then
                        -- Add the line number to the current range
                        table.insert(currentRange, num)
                    else
                        -- If there is a previous range, collapse it
                        if #currentRange > 0 then
                            if #currentRange > 1 then
                                ret = ret .. "[" .. lastFile .. ":" .. table.concat(currentRange, ":") .. "]"
                            else
                                ret = ret .. "[" .. lastFile .. ":" .. currentRange[1] .. "]"
                            end
                        end
                        -- Start a new range for the new file
                        lastFile = file
                        currentRange = {num}
                    end
                end
            end
        end

        -- Handle the last range (if any)
        if #currentRange > 0 then
            if #currentRange > 1 then
                ret = ret .. "[" .. lastFile .. ":" .. table.concat(currentRange, ":") .. "]"
            else
                ret = ret .. "[" .. lastFile .. ":" .. currentRange[1] .. "]"
            end
        end
    end
    return ret
end
local function getCallLine(n,level,parseStart)
	level = ccandy:_getLevel(level)
	local line = extractCallerInfo(level,parseStart)
	return n.." "..line..": "
end
local function getDeepest(t, refs, depth)
    depth = depth or 1
    refs = refs or {}
    refs[t] = true -- Use the table itself as the key
    local deepest = depth
    local limit = ccandy.tableDepthLimit

    if depth >= limit then return limit end

    for k, v in pairs(t) do
        if type(v) == "table" and not refs[v] then
            refs[v] = true
            local d = getDeepest(v, refs, depth + 1) -- Increment depth for recursion
            deepest = math.max(deepest, d)
            if deepest >= limit then return limit end
        end
    end

    return deepest
end
local function getSpacing(space, name, div)
	space = space or 9 --the size of a type label
	div = div or 1
	name = tostring(name)
	local spaces = ""
	local diff = space - #name
	diff = diff / div
	for i = 1, diff do
		spaces = spaces.." "
	end
	return spaces
end
local function inspect(i, refs)
    refs = refs or {}
    local t = type(i)
    local ret = ""
    local symbol = "= "
    local limit = ccandy.tableDepthLimit

    if t == "table" then
        symbol = ""
        local addr = string.gsub(tostring(i), "table: ", "")
        ret = ret .. "[ addr:" .. tostring(addr)

        if refs[i] then
            ret = ret .. "   <already visited> ]"
            return ret
        end
        refs[i] = true -- Mark table as visited

        local n = 0
        local deep = 1
        for k, v in pairs(i) do
            if type(v) == "table" and refs ~= "flat" then
                local d = getDeepest(v, refs)
                deep = math.max(deep, d)
            end
            if not tonumber(k) then n = n + 1 end
        end

        local keys = n > 0 and "   keys:" .. n or ""
        if #i > 0 or keys ~= "" then
            ret = ret .. "   #len:" .. #i .. keys
            if deep >= limit then
                ret = ret .. "   depth: > LIMIT (" .. tostring(limit) .. ")"
            elseif deep > 1 then
                ret = ret .. "   depth:" .. tostring(deep)
            end
        else
            ret = ret .. "   <empty>"
        end
        ret = ret .. " ]"
    elseif t == "function" then
        local addr = string.gsub(tostring(i), "function: ", "")
        ret = "addr:" .. addr
        symbol = "  "
    elseif t == "string" then
        ret = '"' .. i .. '"'
    else
        ret = tostring(i)
    end

    local space = getSpacing(nil, "(" .. t .. ")")
    if refs == "flat" then space = "" end
    return "(" .. t .. ")" .. space .. symbol .. ret
end
local function checkChecked(s)
    if string.sub(s, 1, 1) == "X" then
        -- Return the string without the "X" and true (indicating it started with "X")
        return string.gsub(s,"X",""), true
    else
        -- Return the original string and false (indicating no leading "X")
        return s, false
    end
end
local function compareDate(inputString)
    local currentDate = os.date("*t")
    local currentYear = currentDate.year
    local month, day, year = inputString:match("^(%d%d)/(%d%d)/(%d%d%d%d)$")
    if month and day and year then
        month, day, year = tonumber(month), tonumber(day), tonumber(year)
    else
        month, day = inputString:match("^(%d%d)/(%d%d)$")
        if month and day then
            month, day = tonumber(month), tonumber(day)
            year = currentYear
        else
            return false, nil -- Not a valid date format
        end
    end
    if not (month >= 1 and month <= 12 and day >= 1 and day <= 31) then
        return false, nil -- Invalid date
    end
    local inputTime = os.time({year = year, month = month, day = day})
    local currentTime = os.time()
    local secondsPassed = currentTime - inputTime
    local daysPassed = math.floor(secondsPassed / (24 * 60 * 60)) -- Convert seconds to days
    return true, daysPassed
end
local function getANSI(name,bgcolor)	--getANSI todo is passed
	local e = consolecolors[ccandy.colors[name]]
	local bg 
	if not e then 
		e = consolecolors[name]
	end
	if not e then e = "" end
	
	if bgcolor then 
		bg = bgcolors[ccandy.bgcolors[name]]
		if not bg then
			bg = bgcolors[bgcolor]
		end
		if not bg then bg = "" end
	end
	
	
	if ccandy.backgrounds then
		if not bg or (type(bg) == "string" and string.len(bg) <= 0) then
			bg = bgcolors[ccandy.bgcolors[bg]]
		end		
	end
	if not bg then bg = "" end
	e = e ..bg
	return e
end
local function boolswitch(v) return not v end

--[[
	Print an entire table, limited by the depth arg or the default depth/2
	Only the first stage prints a stacktrace, and only if Title is included in args
	Prints in layers separated by tabs
	Prints in index order first, then keys non-deterministically
	Keys have their tables and functions sorted and printed at the end, collecting all the simple variables
]]
local function isEmpty(t)
	local empty = true
	if #t>0 then empty = false
	else
		for k,v in pairs(t) do
			empty = false
			break
		end
	end
	return empty
end



--[[ TODO:
	- [ ] brackets don't appear behind their table values, this should be rectified
	- [ ] perhaps class instances should not be dug into, based on something set in classic:extend
	- [X] instead of relying on printC for color, roll our own color. Use multicolored printouts to link tables, with all variety of color combos.
	- [ ] colors look good, however some tables still appear empty but have newlines between the brackets {/n}. This creates some color overlap into the next table
	- [ ] Additionally, some tables appear to have another color as their "empty space" on the open bracket line
	- [ ] Removing more background colors because they don't all look good in this context.
]]


local index_colors = {
    "\27[97m", -- Bright White
    "\27[96m", -- Bright Cyan
    "\27[94m", -- Bright Blue
    "\27[92m", -- Bright Green
    "\27[93m", -- Bright Yellow
    "\27[31m", -- Red
    "\27[36m", -- Cyan
    "\27[35m", -- Magenta
    "\27[34m", -- Blue
    "\27[32m", -- Green
    "\27[33m", -- Yellow
    "\27[90m", -- Gray (Muted)
    "\27[30m\27[47m", -- White on Black
}

local function getWrapped(tbl, index)
    -- Ensure the input is a table
    assert(type(tbl) == "table", "First argument must be a table")
    
    -- Ensure the table is not empty
    local length = #tbl
    if length == 0 then
        error("Table is empty")
    end

    -- Calculate the wrapped index
    local wrappedIndex = ((index - 1) % length) + 1

    return tbl[wrappedIndex]
end

local function checkExclusion(key, exclude)
    ccandy.assert(type(exclude) == "table", "Exclude must be a table")
    if type(exclude.prefixes)=="table" then
		for _, prefix in ipairs(exclude.prefixes) do
			if type(key) == "string" and key:sub(1, #prefix) == prefix then
				return true
			end
		end
	end
	if type(exclude.keys)=="table" and exclude.keys[key] then
        return true
    end
    return false
end
local function dname(_,name)
	if type(_)=="table" then _._tableName = name end
	return _
end

local defaultExclude = {prefixes = {"_","__","_c_",}, keys = {}}


local function debugLayers(args, visited)
    visited = visited or {} -- Tracks already visited tables
    local t = args.t or args[1] or args.table
    if type(t) ~= "table" then
        return inspect(t) -- If not a table, return the inspected value
    end

    -- Initialize arguments
    local depth = args.depth or math.floor(ccandy.tableDepthLimit / 2)
    local colorDepth = args.colorDepth or 1
    local color = resetANSI .. getWrapped(index_colors,colorDepth)
    local tab = args.tab or ""
    local title = args.title or ""
    local exclude = args.exclude or defaultExclude --TODO: needs to be able to exclude classic's __methods

    -- Track visited tables
    local addr = tostring(t)
    if visited[addr] then
        return color .. tab .. title .. " = <already visited> \r\n"
    end
    visited[addr] = true

    -- Prepare output
    local output = color .. tab .. title .. " = {\r\n"
    if depth <= 0 then
        output = output .. color .. tab .. "  <depth limit reached>\r\n" .. color .. tab .. "}\r\n"
        return output
    end

    -- Process elements
    for k, v in pairs(t) do
        if checkExclusion(k, exclude) then
            goto skip -- Skip excluded keys
        end

        local valueType = type(v)
        if valueType == "table" then
			local keyCount = 0
			for _ in pairs(v) do keyCount = keyCount + 1 end
		
			if keyCount == 0 then
				output = output .. color .. tab .. "[" .. tostring(k) .. "] = { } \r\n"
			elseif keyCount <= 3 then -- Inline formatting for small tables
				local inline = "{ "
				for subKey, subValue in pairs(v) do
					inline = inline .. tostring(subKey) .. " = " .. inspect(subValue) .. ", "
				end
				inline = inline:sub(1, -3) .. " }" -- Remove trailing comma
				output = output .. color .. tab .. "[" .. tostring(k) .. "] = " .. inline .. "\r\n"
			else
				output = output .. debugLayers({
					table = v,
					tab = tab .. ccandy.debugLTab,
					exclude = exclude[k],
					depth = depth - 1,
					title = "[" .. tostring(k) .. "]",
					colorDepth = colorDepth + 1
				}, visited)
			end
        elseif valueType == "function" then
            output = output .. color .. tab .. "[" .. tostring(k) .. "] = <function>\r\n"
        else
            output = output .. color .. tab .. "[" .. tostring(k) .. "] = " .. inspect(v) .. "\r\n"
        end

        ::skip::
    end

    output = output .. color .. tab .. "}\r\n"
    return output
end
function ccandy.setGUI(set)
	if set then ccandy.gui = set else ccandy.gui = boolswitch(ccandy.gui) end
end
function ccandy.debugL(...)	--t,title,depth or args = {table table, int depth, string title}
	if ccandy.controls.Debug_Level < 2 or not ccandy.switches.debug then return end
	local args = {...}
	if type(args[1]) == "table" and not args[2] then
		ccandy.display("none",debugLayers(args[1]))
	else
		local a = {t = args[1], title = args[2], depth = args[3]}
		ccandy.display("none",debugLayers(a))
	end
end
function ccandy.debugN(_,name,level,parseStart)
	ccandy.debug(dname(_,name),level,parseStart)
end
function ccandy.debug(_,level,parseStart) -- print magenta to console, takes a string or table. Only when debugOn is on.
	if ccandy.controls.Debug_Level < 2 or not ccandy.switches.debug then return end
	local p = getCallLine("DEBUG",level,parseStart)
	if type(_) ~= "table" then 
		if type(_) == "string" then
			p = p .. _		--if it's a string we don't bother with the inspection, just print it as a message
		else
			p = p ..inspect(_)
		end
	else
		local cap = "\r\n  "
		if _.horizontal then 
			cap = "|" _.horizontal = nil 
		end
		p = p..tostring(_)
		local longestname = 0
		local refs = {}
		refs[tostring(_)] = true
		for k,v in pairs(_) do
			if type(k) == "string" then
				if #k > longestname then longestname = #k end
			end
		end
		if _._tableName then
			p = p..cap
			p = p..getSpacing(longestname,i,1.5).."Table Name: "..tostring(_._tableName)
		end
		for i=1, #_ do
			p = p..cap
			p = p..getSpacing(longestname,i)..tostring(i).." : "..inspect(_[i], refs)
		end
		for k,v in pairs(_) do
			if k ~= "_tableName" then
				if not tonumber(k) then
					p = p..cap
					p = p..getSpacing(longestname,k)..k.." : "..inspect(v, refs)
				end
			end
		end
		p = p:match("^(.-)[,\r\n]?$")
	end
	ccandy.display("debug",p)
end
function ccandy.todo(_) --ccandy.todo{"Update date","XChecked Step 1","Unchecked Step 2","Unchecked Step 3"}
	if ccandy.controls.Debug_Level < 2 or not ccandy.switches.todo then return end
	local level = ccandy:_getLevel(1)
	local todotab = ccandy.toDoTab
	if ccandy.todosOn and ccandy.debugOn then
		if type(_) ~= "table" then _ = {tostring(_)} end
		local p1 = getCallLine("TODO",level)
		local p2 = nil
		local p3 = ""
		local checked = "[X] "
		local unchecked = "[ ] "
		local checkbox = ""
		local exTimePassed
		local datefound,date,timePassed
		for i=1, #_ do
			local item = _[i]
			if not datefound then date, timePassed = compareDate(item) end
			if date then
				exTimePassed = timePassed
				if timePassed >= ccandy.toDoExpiration then
					p2 = "     WARNING: "..tostring(timePassed).." days since this Todo list was updated!"
				end
				datefound = true
				date = false
			else
				local s, isChecked = checkChecked(tostring(_[i]))
				if isChecked then
					checkbox = checked
				else
					checkbox = unchecked
				end

				local _s, count = string.gsub(s,"*","")
				local tab = ""
				for i=1, count do
					tab = tab..todotab
				end
				p3 = p3.."  "..tab..checkbox.._s
				if i < #_ then
					p3 = p3.."\r\n"
				end
			end
		end
		local warncolor = nil
		if exTimePassed then
			if exTimePassed >= (ccandy.toDoExpiration * 3) then
				warncolor = getANSI("error")
			elseif exTimePassed >= ccandy.toDoExpiration then
				warncolor = getANSI("error")
			end
		end
		ccandy.display({"todo","todo"},{p1,p2,p3})
		--ccandy.printCTable({getANSI("todo"),warncolor,getANSI("todo")},{p1,p2,p3})
	end
end
function ccandy.remind(setdate,reminderdate,_)
	if ccandy.controls.Debug_Level < 2 or not ccandy.switches.remind then return end
	local date, timePassedSinceSet = compareDate(setdate)
	assert(date,"ccandy.reminder called without setdate!")
	date, timePassedSinceReminder = compareDate(reminderdate)
	assert(date,"ccandy.reminder called without reminderdate!")
	if timePassedSinceReminder >= 0 then
		local heading = ccandy.reminderheader
		local since = "A reminder was set on "..setdate.." "..timePassedSinceSet.." days ago!"
		local reminder = ""
		local post = ccandy.reminderfooter
		ccandy.display("warn",{heading,since})
		--ccandy.printCTable(ccandy.colors.warn,{heading, since})
		if type(_) == "table" then
			for i,v in ipairs(_) do
				if type(v)=="string" then
					reminder = reminder..v
					if i < #_ then
						reminder = reminder.."\r\n"
					end
				elseif type(v)=="function" then
					v()
				end
			end
		elseif type(_) == "function" then
			_()
		else
			reminder = reminder.._
		end
		if type(_) == "table" then
			for k,v in pairs(_) do
				if type(k) ~= "number" then
					if type(v) == "function" then
						_[k]()
					end
				end
			end
		end
		ccandy.display("warn",reminder)
		ccandy.display("remind",post)
		--ccandy.printC(ccandy.colors.warn,reminder)
		--ccandy.printC(getANSI("remind"),post)
	end
end
function ccandy.success(_,level) --print green to console, takes a string or table
	if ccandy.controls.Debug_Level < 2 or not ccandy.switches.success then return end
	level = ccandy:_getLevel(level) or 0	--success uses its own default, 0, because that makes sense to me
    if type(_) ~= "table" then _ = {_} end
	local p = getCallLine("SUCCESS!",level)
	local item
    for i=1, #_ do
		item = _[i]
		if type(item)=="function" then
			item()
		else
			p = p..tostring(item)
		end
		if i < #_ then
			p = p..", "
		end
    end
	ccandy.display("success",p)
    --ccandy.printC(getANSI("success"),p)
end
function ccandy.message(_,level,color,bgcolor) --print yellow to console, takes a string or table
	if ccandy.controls.Debug_Level < 1 or not ccandy.switches.message then return end
	color = color or "cyan"
	level = ccandy:_getLevel(level) or 2
    if type(_) ~= "table" then _ = {_} end
	local p = getCallLine("Message",level,parseStart)
    for i=1, #_ do
		item = _[i]
		if type(item)=="function" then
			item()
		else
			p = p..tostring(item)
		end
		if i < #_ then
			p = p..", "
		end
    end
	ccandy.display(color,p)
    --ccandy.printC(color,p)
end
function ccandy.warn(_,level,parseStart) --print yellow to console, takes a string or table
    if ccandy.controls.Debug_Level < 1 or not ccandy.switches.warn then return end
	if type(_) ~= "table" then _ = {_} end
	local p = getCallLine("WARNING",level,parseStart)
    for i=1, #_ do
		item = _[i]
		if type(item)=="function" then
			item()
		else
			p = p..tostring(item)
		end
		if i < #_ then
			p = p..", "
		end
    end
	ccandy.display("warn",p)
    --ccandy.printC(getANSI("warn"),p)
end
function ccandy.stop(_,level,parseStart) --print red to console then stop the program
	if ccandy.controls.Debug_Level < 1 or not ccandy.switches.stop then return end
	parseStart = parseStart or 5
	ccandy.error(_,level,parseStart)
	if type(_) == "table" then _ = _[1] end
	error("Stopped by ccandy.stop(): ".._.." (console may have more info)")
end
function ccandy.assert(eval,msg,stop) 
	if ccandy.controls.Debug_Level < 1 or not ccandy.switches.remind then return end
	local level = ccandy:_getLevel(10)
	local parseStart = parseStart
	if not eval then
		local p = getCallLine("Assertion Fail",level, parseStart)
		p = p .. msg
		ccandy.display("error",p)
		--ccandy.printC(getANSI("error"),p)
		if stop then
			error(p)	--use lua's error here, because ccandy.assert already gives us the relevant info
		end
		return false
	end
	return true
end
function ccandy.error(_,level,parseStart) --print red to console, takes a string or table
	if ccandy.controls.Debug_Level < 1 or not ccandy.switches.assert then return end
	if type(_) ~= "table" then _ = {_} end
    local p = getCallLine("ERROR",level,parseStart)
	local item
    for i=1, #_ do
		item = _[i]
		if type(item)=="function" then
			item()
		else
			p = p..tostring(item)
		end
		if i < #_ then
			p = p..", "
		end
    end
	ccandy.display("error",p)
    --ccandy.printC(getANSI("error"),p)
end

function ccandy.blank(msg,n)
	if type(msg) == "number" then n = msg; msg = nil end
	n = n or 10
	local p = ""
	for i=1,n do
		p = p .. "\r\n"
	end
	if msg then ccandy.display("green",tostring(msg)) end
	ccandy.display("none",p)--io.write(p)
end
function ccandy.printCBG(_, color, bg, reset)	
	local s = ""
	if consolecolors[color] then s = s .. consolecolors[color] end
	if bgcolors[bg] then s = s..bgcolors[bg] end
	if type(_) == "table" then
		for i=1,#_ do
			s = s .. _[i].."    "	--/t seems to break bg color
		end
	else
		s = s .. tostring(_)
	end
	s = s .. "\r\n"
	ccandy.display("none",s)
	if reset then ccandy.display("reset")io.write(resetANSI) end
end
function ccandy.display(color, disp)	---beeeeeg design change here.
	if ccandy.gui then
		if type(disp)=="string" then
			table.insert(ccandy._drawTable,ccandy._drawObject("string",color,disp))
		end
	else
		if type(color) == "table" then
			local t = {}
			for i=1, #color do
				t = getANSI(color[i])
			end
			ccandy.printCTable(t,disp)
		else
			ccandy.printC(getANSI(color),disp)
		end
	end
end
function ccandy.printC(ANSI, _)
	if not ccandy.colorsOff then
		local fg, bg = ANSI:match("([^|]+)|([^|]+)")
		if not fg then fg = ANSI end
		local c = consolecolors[fg]
		local b = bgcolors[bg]
		if not c then c = fg end
		if bg and not b then b = bg end
		if b then c = c..b end
		io.write(c)
	end
	io.write(_)
	io.write("\r\n")
	io.write(resetANSI)
	::skip::
end
function ccandy.printCTable(cTable, sTable)	--print a table of strings with a table of colors, used in Todo list mainly
	local onlyColor
	if type(cTable) ~= "table" then onlyColor = cTable end
	for i=1, #sTable do
		local s = sTable[i]
		if s then
			local c = onlyColor or cTable[i]
			c = c or "reset"
			ccandy.printC(c,s)
		end
	end
end
function ccandy.setCandyProp(props)
	assert(type(props) == "table")
	for k,v in pairs(props) do
		if type(v) ~= "function" and type(v) ~= "table" then
			ccandy[k] = v
			ccandy.message(k .. " set to "..tostring(v))
		end
	end
end
function ccandy._drawObject(t,color,item,x,y,sx,sy,font)
	local object = {}
	x = x or ccandy.displayProperties.x
	y = y or ccandy.displayProperties.y
	sx = sx or ccandy.displayProperties.sx
	sy = sy or ccandy.displayProperties.sy
	font = font or ccandy.displayProperties.font
	local oldfont = love.graphics.getFont()
	if type(t)=="string" then
		function object.draw()
			lg.setFont(font)
			love.graphics.print(item,x,y,0,sx,sy)
		end
	elseif type(t) =="table" then


	end
	--maybe others
	return object

end

function ccandy:_getLevel(l)
	if self.overrideLevel then return self.baseLevel else return l end
end

local dlist = {
	{"success"," Success messages will not display"},
	{"debug","   No debug info will be displayed."},
	{"todo","    You will not see your todo lists."},
	{"message"," Standard messages after this message are turned OFF."},
	{"remind","  Reminders will be hidden."},
	{"warn","    You will not see warnings!"},
	{"assert","  Assertions will not run."},
	{"error","   Ignoring all errors!"},
	{"stop","    Program stops will be ignored."},
}

function ccandy.load()
	--TODO: build tabs based on integer
	if ccandy.controls.Debug_Level >= 1 then
		local lev = ccandy.controls.Debug_Level
		ccandy.controls.Debug_Level = 3
		local msg = "Debug Candy initialized at Debug Level "..tostring(lev).."\r\n"
		local optionsOn = true
		for i,v in ipairs(dlist) do
			local method = v[1]
			if not ccandy.switches[method] then
				msg = msg.."      "..getANSI(method)..method.." OFF. "..v[2].."\r\n"
				optionsOn = false
			end
		end
		if optionsOn then msg = msg.."      All options ON." end
		local m = ccandy.switches.message
		ccandy.switches.message = true
		ccandy.message(msg,0)
		ccandy.switches.message = m
		ccandy.controls.Debug_Level = lev
	end	
end
function ccandy.update(dt)
	local self = ccandy



end
function ccandy.draw()
	local self = ccandy
	for i=1, #self._drawTable do
		self._drawTable[i].draw()
	end
	self.drawTable = {}
end


function ccandy:export(n)
	ccandy.load()
	n = n or "_c_"
	local ignore = {export=true, _getLevel=true, _dname=true,}
	n = n or ""
	for k,v in pairs(self) do
		local p = "checking to export: "..tostring(k)
		if not ignore[k] and type(v) == "function" then
			local f = n..k
			_G[f] = v
			p = p.."->exported."
		end
		if self.debugTheDebugger then print(p) end
	end
	local f = n.."ccandy"
end



return ccandy