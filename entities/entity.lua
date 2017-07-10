local Class = require 'libs.hump.class'

local Entity = Class{}

function Entity:init()
   self.components = {}
end

return Entity
