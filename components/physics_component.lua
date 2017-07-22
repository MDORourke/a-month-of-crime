local Class = require 'libs.hump.class'

local PhysicsComponent = Class{}

function PhysicsComponent:init(max_speed, friction, gravity)
   self.x_velocity = 0
   self.y_velocity = 0
   self.acceleration = 0
   self.max_speed = max_speed
   self.friction = friction
   self.gravity = gravity
end

return PhysicsComponent
