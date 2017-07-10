local Class = require 'libs.hump.class'

local PhysicsComponent = Class{}

function PhysicsComponent:init(velocity, acceleration, maxSpeed, friction, gravity)
   self.velocity = velocity
   self.acceleration = acceleration
   self.maxSpeed = maxSpeed
   self.friction = friction
   self.gravity = gravity
end

return PhysicsComponent
