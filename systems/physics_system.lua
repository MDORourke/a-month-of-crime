local Class = require 'libs.hump.class'

local PhysicsSystem = Class{}

function PhysicsSystem:update(dt, position_component, physics_component)
   -- Apply friction
   physics_component.x_velocity = physics_component.x_velocity * (1 - math.min(dt * physics_component.friction, 1))
   physics_component.y_velocity = physics_component.y_velocity * (1 - math.min(dt * physics_component.friction, 1))

   -- Apply gravity
   physics_component.y_velocity = physics_component.y_velocity + physics_component.gravity * dt

   position_component.x = position_component.x + physics_component.x_velocity
   position_component.y = position_component.y + physics_component.y_velocity

   return position_component, physics_component
end

return PhysicsSystem
