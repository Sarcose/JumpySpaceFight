--[[       Core         ]]
require 'core._g^crash'
require ('lib.batteries'):export()
_c_todo{"Simple Quick UI","Controls","Classes","Camera","Map","Slick"}

--[[       Update       ]]
baton = require 'lib.baton'

--[[        Draw        ]]
push = require 'lib.push'

--[[         UI         ]]
controls = require 'ui.controls'

--[[     Physics       ]]
slick = require 'lib.slick'
flux = require 'lib.flux'

--[[   Encapsulation    ]]
Object = require 'lib.classic'
require 'data.container.class'



--[[       State        ]]
gamestate = require 'state.engine'
--save_file = require 'state.save.savestruct'

