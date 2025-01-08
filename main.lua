lg = love.graphics
lk = love.keyboard
la = love.audio
lm = love.math
require 'data.globals'
require 'load.requires'
love.run = require 'run'
push:setupScreen(GAME_W, GAME_H, w_width, w_height, {fullscreen = false, resizable = false, canvas = true, pixelperfect = true, stretched = true})


function love.load()
    _G.controller = controls:load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    gamestate:load()
end

function love.update(dt)
    controller:update(dt)
    flux.update(dt)
    gamestate:update(dt)
    --update other visual things
end

function love.draw()
    push:start()
    gamestate:draw()
    push:finish()
end

function love.resize(w,h)
    lg.clear()
end