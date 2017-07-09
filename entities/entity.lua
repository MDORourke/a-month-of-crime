local Class = require 'libs.hump.class'

local Entity = Class{}

function Entity:init(world, x, y, w, h) -- At some point I'm going to turn this into a lazy ECS so we don't have an ever-growing constructor (and for other, better reasons)
   self.world = world
   self.x = x
   self.y = y
   self.w = w
   self.h = h
end

function Entity:getRect()
   return self.x, self.y, self.w, self.h
end

function Entity:draw()
   -- Virtual function to override
end

function Entity:update(dt)
   -- Virtual function to override
end

return Entity
