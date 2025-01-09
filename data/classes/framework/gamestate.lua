
local defaults = {
    type = "State",
    Name = "NoName",
    Objects = {
        categories = {}, 
        total = 0,
        defaultCategory = "Main"
    }
}

local State = Object:extend(defaults)
local function testFunc(first, second, third, fourth)
    _c_message{"Testing!",first,second,third,fourth}
    return first, second, third, fourth
end


function State:new(a,name)
    --print("instantiating new state from "..tostring(name))
    local inst = self:extend(a)
    --_c_debug(inst)
    return inst
end
-- Object._address = State:add(Object, category) -- I don't think I'll use i but you never know
function State:add(Object, cat, i)
    cat = cat or self.Objects.defaultCategory
    if not self.Objects[cat] then 
        self.Objects[cat] = {total = 0} 
        table.insert(self.Objects.categories,cat)
    end
    if i == nil then i = #self.Objects[cat] + 1 end
    table.insert(self.Objects[cat],i, Object)
    self.Objects.total = self.Objects.total + 1
    self.Objects[cat].total = self.Objects[cat].total + 1
    return {
        success = true,
        category = cat,
        index = i,
        object = Object,
    }
end

--isRemoved = State:remove(Object)
function State:remove(Object)
    local index, cat = Object._address.index, Object._address.category
    local removed
    self.Objects[cat][index] = "%Removed"
    removed = true
    self.Objects.total = self.Objects.total - 1
    self.Objects[cat].total = self.Objects[cat].total - 1
    return removed
end

function State:reindex()
    local o,re
    local cat, cat_table, ReCat
    self.Objects.total = 0
    for i=1, #self.Objects.categories do
        cat = self.Objects.categories[i]
        cat_table = self.Objects[cat]
        ReCat = {}
        for index=1, #cat_table do
            o = cat_table[index]
            if o and o ~= "%Removed" then 
                table.insert(ReCat,o) 
                re = {
                    success = true,
                    category = cat,
                    index = #ReCat,
                    object = o
                }
                _safe.call(o.reindex,o,re)  --objects will have a "reindex" method that resupplies them with their index info
                self.Objects.total = self.Objects.total + 1
                cat_table.total = cat_table.total + 1
            end
        end
        self.Objects[cat] = ReCat
    end
end

function State:update(dt)
    _safe.call(self.input.update,self,dt)
    if self.Objects.total > 0 then
        local o, object_cat
        for i=1,#self.Objects.categories do
            object_cat = self.Objects[self.Objects.categories[i]]
            if object_cat.total > 0 then
                for i=1, #object_cat do
                    o = object_cat[i]
                    _safe.call(o.update, o, dt)
                end
            end
        end
    end
    _safe.call(self.input.reset,self)
end

function State:draw()
    if self.Objects.total > 0 then
        local o, object_cat
        local called
        for i=1,#self.Objects.categories do
            object_cat = self.Objects[self.Objects.categories[i]]
            if object_cat.total > 0 then
                for i=1, #object_cat do
                    o = object_cat[i]
                    called = _safe.call(o.draw, o, dt)
                end
            end
        end
    end
end

function State:unload()
    if self.Objects.total > 0 then
        local o, object_cat
        for i=1,#self.Objects.categories do
            object_cat = self.Objects[self.Objects.categories[i]]
            if object_cat.total > 0 then
                for i=1, #object_cat do
                    o = object_cat[i]
                    _safe.release(o)
                end
            end
        end
    end
    for k,v in pairs(self) do
        _safe.release(v)
    end
end

return State