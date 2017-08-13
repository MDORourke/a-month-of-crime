local Class = require 'libs.hump.class'

local PositionComponent = Class{}

function PositionComponent:init(x, y)
   self.x = x
   self.y = y
end

return PositionComponent
