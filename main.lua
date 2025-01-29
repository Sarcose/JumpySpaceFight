lg = love.graphics
lk = love.keyboard
la = love.audio
lm = love.math
require 'load.globals'
require 'load.requires'
love.run = require 'run'
push:setupScreen(GAME_W, GAME_H, w_width, w_height, {fullscreen = false, resizable = false, canvas = true, pixelperfect = true, stretched = true})

--[[
    The path to starting the first demo of the game is as such:

A test game state that loads a test reality that loads a test universe that loads
    test maps which load test layers and test entities.

]]

_G.TestFont = love.graphics.newFont(32)

function love.load()
    _G.controller = controls:load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    gcore:load()
    gamestate:load()
end

function love.update(dt)
    controller:update(dt)
    gcore:update(dt)
    flux.update(dt)
    gamestate:update(dt)
    controller.wheel.x,controller.wheel.y = 0,0
end

function love.draw()
    lg.clear()
    push:start()
    gamestate:draw()
    gcore:draw()
   -- _c_drawDebug()
    push:finish()
end

function love.resize(w,h)
    lg.clear()
end

function love.wheelmoved(x,y)
    controller.wheel.x, controller.wheel.y = x,y

end