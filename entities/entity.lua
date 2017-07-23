local Class = require 'libs.hump.class'

local Entity = Class{}

function Entity:init()
   self.components = {}
end

function Entity:has_components(...)
   local components = {...}

   for _, component in pairs(components) do
      if self.components[component] == nil then
         return false
      end
   end
   return true
end

return Entity
