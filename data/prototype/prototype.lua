local d = {
    type = "Prototype",
    name = "Prototype",
    public = {},
}
--an extremely simple primitive, this will use layered implementation to apply its methods
local P = Object:extend(d)
return P