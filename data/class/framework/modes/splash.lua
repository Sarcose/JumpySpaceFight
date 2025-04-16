local __proto = require 'data.class.framework.modes.prototype'
return function(_Gamestate)
    local def = {name = "Splash_Gamestate", scene = "splash"}
    local t = _Gamestate:construct(def)


    function t:load()   --in game modes, this is load(data)
        --in game modes, this is data = data or defaultdata
        --in title this grabs metadata
        self.super.load(self)--load meta-save; cursor positions, customizations, etc
        __proto.load(self)  --load. In game modes this is __proto.load(self,data)
        self.loaded = true
        return self
    end    


    function t:unload()
        self.super.unload(self)
    end
    return t

end

--[[
    A very brief journal of how Splash -> Title goes down.


    "Preload" -- this is the meta load that happens before any state logic begins. 
        There is a nebulous meta state that happens prior to Splash whereby all the game primitive types and globals are
        established.

    "Splash" -- once we're here, this is the first update and draw step. 
        It would probably be a good idea to put a slight delay here as well for serial loading of assets if necessary, but we'll get to that.
        This is where the first thread implementations should probably occur
        At bare minimum, a single image is shown that then fades to the Title
        If this were gameplay, it would mimic a cutscene: loss of player control or limited player control (skip button),
            an object that animates, and after that animation is over, a state change
        So then what we have here is a "Cutscene," but this is inadequate. A "Scene" feels too cliche. 
        But there's another way to view this. We use a Space - a Board or even a World.

    "Title" -- four majorly important components here:
            - The menu and graphics thereof, including animations
            - The settings, loaded into the meta-context -- kept above the Title, probably within Game itself.
            - The submenu of loading
            - The little real life fellers from the game.


    So more and more I am looking at the following notion: the multiverse system, as well as the entity system, should be worked on
    *next*. Because with this in mind, I can design a splash screen that flies through an IRIX Sysnav-style ("It's a Unix system, I know this!")
    series of graphics, in the same way that JSF is going to.


    So now we come to the crux of the matter: the stage. 
    In data.class.framework.modes.stage.splash we will set up the basic scenario and develop the mechanics to "fly through the computer"


    So now we're finally about to get to the fun part! Instantiation of actual entities and then drawing them!
    
    
]]