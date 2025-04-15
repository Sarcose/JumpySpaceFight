--the container that controls and switches between large Gamestate objects

local Game = {
    State = {},
    Mode ={ mode = "test", loadedby = "none", loadtime = 0, previous = "none",uptime = 0,memory = 0},
}

--mode switches can only happen in the main menu, which will be written later
--for the main menu see Overlays, this will use Classes.Overlay
function Game:load(mode, reload) --if reload, then the game mode is reloaded
    if reload or not Classes.GameState.Modes[mode].loaded then
        self.State = Classes.GameState.Modes[mode]:load()
    else
        self.State = Classes.GameState:get(mode)
    end

    if not self.State then 
        _c_stop({"Invalid State loaded in Game manager!", "state = "..tostring(mode), "reload = "..tostring(reload),10})
    end
end

function Game:switch(mode, unload)
    if not Classes.GameState.Modes[mode] then _c_stop("Game mode switch attempt made with invalid mode! mode passed: "..tostring(mode)) end
    if unload then
        self.State:unload()
    end
    self.Mode = {
        previous = gcore.var.shallowcopy(self.Mode.mode),
        mode = mode,
        loadedby = "unknown", --TODO; should find a way to backtrace who called me
        loadtime = tostring(love.timer.getTime()),
        memory = 0,  --TODO; should reference the game mode container's memory values once i implement this tracking.
        uptime = 0,
    }
    self.State = Classes.GameState.Modes[mode]:load()
end

function Game:printModeDetails()    --use this for debugging only


end
function Game:getMode(detail)
    if not detail then return self.Mode.mode
    elseif self.Mode[tostring(detail)] then return self.Mode[tostring(detail)] 
    else return self.Mode
    end
end

function Game:update(dt)
    if self.State.loaded then 
        self.State:update(dt) 
        self.Mode.uptime = self.Mode.uptime + dt
    end
end

function Game:draw()
    if self.State.loaded then self.State:draw() end
end

return Game