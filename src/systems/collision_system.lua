bump = require 'libs.bump.bump'

local Class = require 'libs.hump.class'

local CollisionSystem = Class{}

function CollisionSystem:init(cell_size)
   self.world = bump.newWorld(cell_size)
end

function CollisionSystem:register(collision_component, position_component, size_component)
   self.world:add(collision_component, position_component.x, position_component.y, size_component.width, size_component.height)
end

function CollisionSystem:resolve(collision_component, position_component, physics_component)
   local goal_x = position_component.x + physics_component.x_velocity
   local goal_y = position_component.y + physics_component.y_velocity

   local x, y, collisions, len = self.world:move(collision_component, goal_x, goal_y, collision_component.collision_filter)
   
   position_component.x = x
   position_component.y = y

   -- Ignore collisions list for now
   return position_component
end

function CollisionSystem:getAABB(collision_component)
   local x, y, w, h = self.world:getRect(collision_component)
   return {x, y, w, h}
end

return CollisionSystem
