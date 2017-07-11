local Class = require 'libs.hump.class'

local InputSystem = Class{}

function InputSystem:init()
   self.callbacks = {}
end

function InputSystem:register(key, callback)
   self.callbacks[key] = callback
end

function InputSystem:deregister(key)
   self.callbacks[key] = nil
end

function InputSystem:keyPressed(key)
   callback = self.callbacks[key]
   callback()
end

return InputSystem
