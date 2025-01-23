--[[
    definition of terms hierarchy

    Class = the basic data structure from classic.lua
    Prototype = a class implementation only for prototyping, no parents
                         /--------Input
                        /-------
    Class   --->\     /------ GameState  (a container of Map + entities + player state)
                ----<--------Layer----Map----World (matryoshka of physical space layers)  
    Prototype-->/    \-------Entity--------\-------Terrain
                                            \------Actor
                                             \-----Item

--]]
--1: written 2: basic test 3: iterated once 4: iterated again 5: polished 6: etc.
--[][][][][][]
--compare checkboxes with iteration level target (below)

--current iteration level target: 1
local context = {}  --only expose primitives when first initializing everything
context.System = require 'data.container.system'                    
context.Prototype = require 'data.container.prototype'               
context.Class = {}
context.Class.GameState = require 'data.class.framework.gamestate'   --[X]
context.Class.Overlay = require 'data.class.interface.overlay'       --[X]
context.Class.Input = require 'data.class.interface.input'           --[X]
context.Class.Space = require 'data.class.space.space'               --[X]
context.Class.Entity = require 'data.class.entity.entity'            --[X]

--the below are prototype and class _definitions_ e.g. actual data.
Systems = require ('data.system.systemInstances'):initialize(context)
Prototypes = require ('data.prototype.prototypeInstances'):initialize(context)
Classes = require ('data.class.classInstances'):initialize(context) --instantiate all of GameStates, Overlays, Inputs, Spaces, Entities





