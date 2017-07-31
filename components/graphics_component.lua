local Class = require 'libs.hump.class'

local GraphicsComponent = Class{}

function GraphicsComponent:init(img)
   self.img = img
end

return GraphicsComponent
