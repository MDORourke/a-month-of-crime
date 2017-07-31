local InputSystem = require 'systems.input_system'
local Signal = require 'libs.hump.signal'

describe("InputSystem", function()
   it("should register a callback on pressing a button", function()
      input = InputSystem()
      press = spy.new(function() end)

      Signal.register("test", press)

      input:register("a", "press", "test")

      input:keyPressed("a")

      assert.spy(press).was.called()
   end)

   it("should de-register a callback on pressing a button", function()
      input = InputSystem()
      press = spy.new(function() end)

      Signal.register("test", press)

      input:register("a", "press", "test")
      input:deregister("a", "press")

      input:keyPressed("a")

      assert.spy(press).was_not.called()
   end)

   it("should register a callback on releasing a button", function()
      input = InputSystem()
      release = spy.new(function() end)

      Signal.register("test", release)

      input:register("a", "release", "test")

      input:keyReleased("a")

      assert.spy(release).was.called()
   end)

   it("should de-register a callback on releasing a button", function()
      input = InputSystem()
      release = spy.new(function() end)

      Signal.register("test", release)

      input:register("a", "release", "test")
      input:deregister("a", "release")

      input:keyReleased("a")

      assert.spy(release).was_not.called()
   end)
   
   it("should register a callback when a button is held down", function()
      input = InputSystem()
      hold = spy.new(function() end)

      Signal.register("test", hold)

      input:register("a", "hold", "test")

      _G.love = {
         keyboard = {
            isDown = function(key) return true end
         }
      }

      input:update()

      assert.spy(hold).was.called()
   end)

   it("should deregister a callback when a button is held down", function()
      input = InputSystem()
      hold = spy.new(function() end)

      Signal.register("test", hold)

      input:register("a", "hold", "test")
      input:deregister("a", "hold")

      _G.love = {
         keyboard = {
            isDown = function(key) return true end
         }
      }

      input:update()

      assert.spy(hold).was_not.called()
   end)

   it("should not call a callback when the button is not held down", function()
      input = InputSystem()
      hold = spy.new(function() end)

      Signal.register("test", hold)

      input:register("a", "hold", "test")

      _G.love = {
         keyboard = {
            isDown = function(key) return false end
         }
      }

      input:update()

      assert.spy(hold).was_not.called()
   end)
end)
