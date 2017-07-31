local Class = require 'libs.hump.class'

local SizeComponent = Class{}

function SizeComponent:init(width, height)
   self.width = width
   self.height = height
end

return SizeComponent
