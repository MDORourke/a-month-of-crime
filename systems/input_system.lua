local Class = require 'libs.hump.class'
local Signal = require 'libs.hump.signal'

local InputSystem = Class{}

function InputSystem:init()
   self.bindings = {}
   -- Three key states
   self.bindings["press"] = {}
   self.bindings["release"] = {}
   self.bindings["hold"] = {}
end

function InputSystem:register(key, state, action)
   self.bindings[state][key] = action
end

function InputSystem:deregister(key, state)
   self.bindings[state][key] = nil
end

function InputSystem:signalAction(action)
   if action then
      Signal.emit(action)
   end
end

function InputSystem:keyPressed(key)
   action = self.bindings["press"][key]
   self:signalAction(action)
end

function InputSystem:keyReleased(key)
   action = self.bindings["release"][key]
   self:signalAction(action)
end

function InputSystem:update()
   for k, v in pairs(self.bindings["hold"]) do
      if love.keyboard.isDown(k) then
         action = self.bindings["hold"][k]
         self:signalAction(action)
      end
   end
end

return InputSystem
