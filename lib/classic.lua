--
-- classic
--
-- Copyright (c) 2014, rxi
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
--


local Object = {}
Object.__index = Object


function Object:new(a)
  local inst = self:extend()
  if type(a)=='table' then tablex.overlay(inst, a) end
  return inst
end


function Object:extend(a)
  local cls = {}
  for k, v in pairs(self) do
    if type(k) == "function" then
      if a[k] then cls[k] = a[k]
      else cls[k] = v --all functions defined in class are reference unless otherwise determined.
      end
    elseif k:find("__") == 1 then
      cls[k] = v
    else
      if type(v) == "table" then
        cls[k] = {}
        cls[k] = tablex.overlay(cls[k],v) --I *think* this might still create references with >1 deep tables. 
                                          --I also believe it may just be a good practice for classes to *not* have >1 deep tables prototyped
      else
        cls[k] = gcore.var.shallowcopy(v)
      end
    end
  end
  cls.__index = cls
  cls.super = self
  setmetatable(cls, self)
  if type(a)=="table" then cls = tablex.overlay(cls, a) end
  return cls
end


function Object:implement(...)
  for _, cls in pairs({...}) do
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
end


function Object:is(T)
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end


function Object:__tostring()
  return "Object  "..string.format("%p", self)
end


function Object:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
end

function Object:__warn(_)
  if type(_) ~= "table" then _ = {_} end
  table.add(_,tostring(self.type))
  table.add(_,string.char(10))
  table.add(_,tostring(self))
  table.add(_," incorrect instantiation attempt")
  _c_warn(_,6)
end

return Object
