lg = love.graphics
lk = love.keyboard
la = love.audio
lm = love.math
require 'load.globals'
require 'load.requires'
love.run = require 'run'

--[[
    The path to starting the first demo of the game is as such:

A test game state that loads a test reality that loads a test universe that loads
    test maps which load test layers and test entities.

]]

--push:setupCanvas(canvasList)

--e.g. push:setupCanvas({   { name = "foreground", shader = foregroundShader }, { name = "background" }   })


function love.load()
    _G.TestFont = lg.newFont(32)
    _G.controller = controls:load()
    push:setupScreen(GAME_W, GAME_H, w_width, w_height, {fullscreen = false, resizable = false, canvas = true, pixelperfect = true, stretched = true})
    lg.setDefaultFilter("nearest", "nearest")
    gcore:load()
    Game:load("Splash")
end

function love.update(dt)
    Memory:update(dt)
    controller:update(dt)
    gcore:update(dt)
    flux.update(dt)
    Game:update(dt)
    controller.wheel.x,controller.wheel.y = 0,0
end

function love.draw()
    lg.clear()
    push:start()
    Game:draw()
    gcore:draw()
    push:finish()
end

function love.resize(w,h)
    lg.clear()
end

function love.wheelmoved(x,y)
    controller.wheel.x, controller.wheel.y = x,y

end


local kbTodo = {
    "04/08/2025",
    "KB last edited according to this TODO",
    "Trace how Game updates State",
    "Indicate how State can receive data"
}

local trueTodo = {
    "04/08/2025",
    "XTrace how Game updates State",
    "Figure out why Mode is not creating fully unique gamestates",
    "Open game into a RUDIMENTARY menu state, for selecting game modes",
    "Indicate how State can receive Data",
    "Begin prototyping that data",
    "Moving back to Opening menu - iterate upon it, begin using a Menu class",
    "Side Quests:",
    "[ ] Change controller.wheel.x and controller.wheel.y into their own reset fn",
}

_c_todo(kbTodo)
_c_todo(trueTodo)


