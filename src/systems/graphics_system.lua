local Class = require 'libs.hump.class'

local GraphicsSystem = Class{}

function GraphicsSystem:draw(position_component, graphics_component, size_component)
   -- If the graphics component is supplied, draw an image
   if graphics_component ~= nil then
      love.graphics.draw(graphics_component.img, position_component.x, position_component.y)
   -- Otherwise, if the size component is supplied, draw a rectangle
   elseif size_component ~= nil then
      love.graphics.rectangle('fill', position_component.x, position_component.y, size_component.width, size_component.height)
   -- If neither, then nothing happens
   end
end

return GraphicsSystem
