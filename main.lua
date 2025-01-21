lg = love.graphics
lk = love.keyboard
la = love.audio
lm = love.math
require 'load.globals'
require 'load.requires'
love.run = require 'run'
push:setupScreen(GAME_W, GAME_H, w_width, w_height, {fullscreen = false, resizable = false, canvas = true, pixelperfect = true, stretched = true})


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