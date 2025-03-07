return function(_Input)
    local I = {}
    I.instances = {}    --use this to build basic control profiles e.g., "Player" "Menu" etc.
                        --just a collection of input tables to be passed. Define here inside function, abstraction be damned


    for k,v in pairs(I.instances) do
        I.instances = _Input:new(v)
    end

    function I:get(controller)
        return I.instances[controller] or error("Class.Input:get() called with unknown controller: "..tostring(controller).."!")
    end
    function I:new(inputTable)  --use this to adhoc create a control profile e.g., "Debug" when debugging is on
        return _Input:new(inputTable)
    end

    return I
end