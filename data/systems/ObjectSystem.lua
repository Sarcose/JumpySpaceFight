local objectSystem = {}
local properties = {
    Objects = {
        categories = {},
        total = 0,
        defaultCategory = "Main",
        reindexLevel = 100, --set to a very high level first.
    }
}

function objectSystem:initialize()
    self._self.Objects = gcore.var.deepcopy(properties.Objects)
    self._self.AddObject = function(self,Object,cat,i) self.systems.ObjectSystem:addObject(Object,cat,i) end
    self._self.RemoveObject = function(self,Object) self.systems.ObjectSystem:removeObject(Object) end
end

function objectSystem:addObject(Object, cat, i)
    cat = cat or self.Objects.defaultCategory
    if not self.Objects[cat] then 
        self.Objects[cat] = {total = 0, reindex = 0} 
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
function objectSystem:removeObject(Object)
    local index, cat = Object._address.index, Object._address.category
    local removed
    self.Objects[cat][index] = "%Removed"
    removed = true
    self.Objects.total = self.Objects.total - 1
    self.Objects[cat].total = self.Objects[cat].total - 1
    self.Objects[cat].reindex = self.Objects[cat].reindex + 1
    return removed
end
function objectSystem:reindex(cat)
    self = self._self
    local o,re
    local ReCat = {}
    local cat_table = self.Objects[cat] 
    self.Objects.total = 0
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
function objectSystem:update(dt)
    self = self._self
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
            if object_cat.reindex>self.Objects.reindexLevel then    --quick and dirty, may cause brief lag spikes?
                self.systems.ObjectSystem:reindex(self.Objects.categories[i])
            end
        end
    end
end

function objectSystem:draw()
    if self.Objects.total > 0 then
        local o, object_cat
        local called
        for i=1,#self.Objects.categories do
            object_cat = self.Objects[self.Objects.categories[i]]
            if object_cat.total > 0 then
                for i=1, #object_cat do
                    o = object_cat[i]
                    called = _safe.call(o.draw, o)
                end
            end
        end
    end
end

function objectSystem:unload()
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
end


return objectSystem


