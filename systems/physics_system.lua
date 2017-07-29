local Class = require 'libs.hump.class'

local PhysicsSystem = Class{}

function PhysicsSystem:update(dt, physics_component)
   -- Apply friction
   physics_component.x_velocity = physics_component.x_velocity * (1 - math.min(dt * physics_component.friction, 1))
   physics_component.y_velocity = physics_component.y_velocity * (1 - math.min(dt * physics_component.friction, 1))

   -- Apply gravity
   physics_component.y_velocity = physics_component.y_velocity + physics_component.gravity * dt

   return physics_component

end

return PhysicsSystem
