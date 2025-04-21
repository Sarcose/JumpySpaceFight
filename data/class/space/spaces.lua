return function(Space)
    local def = {}
    local test = {
        Space:extend(Space),Space:extend(Space),Space:extend(Space),Space:extend(Space)
    }
    for i,v in ipairs(test) do
        print("======================================")
        _c_debugL(v)

    end
    return {}
end