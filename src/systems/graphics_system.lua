local Class = require 'libs.hump.class'

local GraphicsSystem = Class{}

function GraphicsSystem:draw_animation(position_component, sprite_component, animation_component)
   animation_component.current_animation:draw(sprite_component.img, position_component.x, position_component.y)
end

function GraphicsSystem:draw_image(position_component, sprite_component)
   love.graphics.draw(sprite_component.img, position_component.x, position_component.y)
end

function GraphicsSystem:draw_rectangle(position_component, size_component)
   love.graphics.rectangle('fill', position_component.x, position_component.y, size_component.width, size_component.height)
end

function GraphicsSystem:update_animation(dt, animation_component)
   animation_component.current_animation:update(dt)
end

return GraphicsSystem
