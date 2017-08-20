local Class = require 'libs.hump.class'

local SpriteComponent = Class{}

function SpriteComponent:init(img)
   self.img = img
end

return SpriteComponent
