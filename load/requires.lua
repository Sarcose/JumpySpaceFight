    --[[       Core         ]]
--print('loading core._g^crash',os.time())
    require 'core._g^crash'
--print('lib.batteries:export()',os.time())
    require ('lib.batteries'):export()
--print('_c_todo',os.time())
    _c_todo{"Simple Quick UI","Controls","Classes","Camera","Map","Slick"}

    --[[       Update       ]]
--print('loading baton',os.time())
    baton = require 'lib.baton'

    --[[        Draw        ]]
--print('loading push',os.time())
    push = require 'lib.push'

    --[[         UI         ]]
--print('loading controls',os.time())
    controls = require 'ui.controls'
--print('loading colors',os.time())
    colors = require 'ui.colors'

    --[[     Physics       ]]
--print('loading slick',os.time())
    slick = require 'lib.slick'
--print('loading flux',os.time())
    flux = require 'lib.flux'

    --[[   Encapsulation    ]]
--print('loading Object',os.time())
    Object = require 'lib.classic'
--print('loading Memory',os.time())
    Memory = require 'core.memory'
--print('loading Classes',os.time())
    require 'data.container.class'
_c_debug(Classes)
    --[[       State        ]]
--print('loading Game',os.time())
    Game = require 'data.class.framework.game'
--print('requirefile done.',os.time())
    --save_file = require 'state.save.savestruct'