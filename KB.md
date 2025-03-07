# Knowledge Base For using the JSF Engine

## Gameist DataTypes:
    *Inputs* are controllers.
        TODO: what should inputs be attached to, specifically? What types? GameStates perhaps?
        TODO: impulses in controllers

        Define new ones in      'data.class.interface.inputs' using inputTable (see example in that file)
        Reference them with     foo.input = Classes.Input:get(name)
        Create new adhoc with   foo.input = Classes.Input:new(inputTable)
        Update with             foo.input:update(dt)
        Get button states with
            foo.input.queues


    *Overlays* are menus, HUDs, various visual data displayed
        TODO: overlays should probably be attached exclusively to Gamestates methinks? Or maybe they're usage-dependent.

        Define new ones in          'data.class.interface.overlays'
        Reference them with         foo.overlay = Classes.Overlay:get(name)
            Then attach to foo:     foo.overlay.attach(foo) //this will allow the overlay to reference and manipulate foo
            Attach a controller:    foo.overlay.input = Classes.Input:get(overlaycontroller)
        Update with                 foo.overlay:update(dt)
        Draw with                   foo.overlay:draw()
    
    *GameStates* are the whole game, the title screen, and any other game modes.
        TODO: Document attaching systems to GameStates

        Define new ones in          'data.class.framework.gamestates'
        Reference them with         foo.gamestate = Classes.Gamestate:get(name)
        Update with                 foo.gamestate:update(dt)
        Draw with                   foo.gamestate:draw()

    *Spaces* are relational/spatial containers. E.g. they are where things have gravity and can bump into each other
        TODO: document how Spaces work with the slick polygonal collision library
        TODO: document the different kinds and uses of spaces, and how spaces contain spaces
        
        Define new ones in          'data.class.space.spaces'
        Reference them with         foo.space = Classes.Space:get(name)
        Update with                 foo.space:update(dt)
        Draw with                   foo.space:draw()

    *Entities* are objects that exist in the world
        TODO: this is slightly different as it has subcategories. Document the subcategories.
        TODO: document usage
        
        Define new subcategories in    'data.class.entity.entities'

        Entity Subcategories:
            *Terrain* are polygonal objects that provide collision with limited behavior. They may be gathered in "composites" that can be moderately altered through destruction.
            
            *Items* are AABB sprites that can be interacted with and spawned by actors and mechanisms, supplementing Actor capability or updating the gamestate.
            
            *Actors* are the "meat" of the game. These are creatures, people, players, anything with movement and behavior and complex interactions. They have dynamic and sometimes multiple polygons that can be changed during gameplay.
            
            *Mechanisms* are hidden sensors, triggers, toggles that alter gamestate upon being activated, sometimes multiple times. The only polygons they use will be polygons meant to sense gamestates (like a player passing a trigger location)

