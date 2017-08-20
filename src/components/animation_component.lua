local Class = require 'libs.hump.class'

local AnimationComponent = Class{}

function AnimationComponent:init(animations, current_animation)
   self.animations = animations
   self.current_animation = current_animation
end

return AnimationComponent
