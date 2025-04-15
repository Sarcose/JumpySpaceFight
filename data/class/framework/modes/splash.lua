local __proto = require 'data.class.framework.modes.prototype'
return function(_Gamestate)
    local def = {name = "Splash_Gamestate", scene = "splash"}
    local t = _Gamestate:construct(def)
    t.defaultData = {
        
    }


    function t:load(data)
        data = data or self.defaultData
        self.super.load(self)--load meta-save; cursor positions, customizations, etc
        __proto.load(self,data)  --load save and stage
        self.loaded = true
        return self
    end    


    function t:unload()
        self.super.unload(self)
    end
    return t

end





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