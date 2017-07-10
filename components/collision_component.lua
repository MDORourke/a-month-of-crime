local Class = require 'libs.hump.class'

local CollisionComponent = Class{}

function CollisionComponent:init(world)
   self.world = world
end

return CollisionComponent
