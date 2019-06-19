local Class = require 'libs.hump.class'
local Camera = require 'libs.hump.camera'

local CameraSystem = Class{}

function CameraSystem:init(position_component)
   self.camera = Camera(position_component.x, position_component.y)
end

function CameraSystem:update_position(position_component)
   self.camera:lookAt(position_component.x, position_component.y)
end

function CameraSystem:activate()
   self.camera:attach()
end

function CameraSystem:deactivate()
   self.camera:detach()
end

function CameraSystem:x()
   return self.camera.x
end

function CameraSystem:y()
   return self.camera.y
end

return CameraSystem
