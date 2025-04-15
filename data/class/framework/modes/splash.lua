local __proto = require 'data.class.framework.modes.prototype'
return function(_Gamestate)
    local def = {name = "Splash_Gamestate", scene = "splash"}
    local t = _Gamestate:construct(def)

    function t:load()
        self.super.load(self)
        --load meta-save; cursor positions, customizations, etc
        __proto.load(self)
        self.loaded = true
        return self
    end    


    function t:unload()
        self.super.unload(self)
    end
    return t

end


--[[
    As of right now, this document accesses a discrete "load.lua"

    I am growing tired of prototyping but, once again, it seems I should do so.
    However, I could do things a lil different -- a "prototype file" that every mode passes itself into

    
    e.g.: require('data.class.framework.modes.prototype'):load(self)

]]




--[[
default = table 0x03ad6588

a = table: 0x03ad40c0
d: nil nil d = table: 0x03a7d688
state constructed: Classic_Gamestate classic
.........Test
constructing state Test_Gamestate test from a = table: 0x04e6ac38
testing d: Classic_Gamestate classic d = table: 0x03a7d688
state constructed: Classic_Gamestate classic
.........JumpySpaceFight
constructing state JSF_Gamestate jsf from a = table: 0x04e891a0
testing d: Classic_Gamestate classic d = table: 0x03a7d688
state constructed: Classic_Gamestate classic
.........Title
constructing state Title_Gamestate title from a = table: 0x03aaa908
testing d: Classic_Gamestate classic d = table: 0x03a7d688
state constructed: Classic_Gamestate classic
.........Randomizer
constructing state Randomizer_Gamestate rando from a = table: 0x04da0508
testing d: Classic_Gamestate classic d = table: 0x03a7d688
state constructed: Classic_Gamestate classic
.........Splash
constructing state Splash_Gamestate splash from a = table: 0x04d62058
testing d: Classic_Gamestate classic d = table: 0x03a7d688
state constructed: Classic_Gamestate classic
.........BossRush
constructing state Bossrush_Gamestate bossrush from a = table: 0x04e649d8
testing d: Classic_Gamestate classic d = table: 0x03a7d688


]]