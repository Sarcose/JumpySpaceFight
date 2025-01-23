--Primitive. Instances do not reference this directly. Thus, use :extend()
--Terrain, Actor, and Item inherit from this. Thus, what do they all have in common?
local d = {

}

local implement = {
    --I don't think the Entity primitive will have any implements!
}
local systems = {
    ShapeSystem = "ShapeSystem" 
}

local Entity = Object:extend(d)
Entity._extend = Entity.extend
--we are not using new here, because we are not instantiating this directly.

function Entity:extend(a)
    local cls = self:_extend(a)
    cls:addSystems(systems)
    cls:superImplement(implement)
    return cls
  end