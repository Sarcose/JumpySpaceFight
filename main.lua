lg = love.graphics
lk = love.keyboard
la = love.audio
lm = love.math
require 'data.globals'
require 'load.requires'
love.run = require 'run'
_c_todo("Setup Push")
push:setupScreen(GAME_W, GAME_H, w_width, w_height, {fullscreen = false, resizable = false, canvas = true, pixelperfect = true, stretched = true})


function love.load()

end

function love.update(dt)

end

function love.draw()

end

function love.resize(w,h)
    lg.clear()
end