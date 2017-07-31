local Class = require 'libs.hump.class'

local CollisionComponent = Class{}

function CollisionComponent:init(collision_filter)
   self.collision_filter = collision_filter
end

return CollisionComponent
