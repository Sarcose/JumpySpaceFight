--[[======DEBUG THINGS====]]
_DEBUGLEVEL = 3





--[[======DISPLAY THINGS==]]
desktopWidth, desktopHeight = love.window.getDesktopDimensions()
w_width = desktopWidth * .9		--default
w_height = desktopHeight * .9
GAME_W = 1792--896--widescreen: 896x504
GAME_H = 1008--504*2--gameboy: 640x576    



--[[======ENCAPSULATION=====]]
_allobjects = {}
_deepcopylimit = 10



--[[======DATA=====]]
_DATA = {}
_DATA.controllercount = 0