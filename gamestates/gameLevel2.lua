Gamestate = require 'libs.hump.gamestate'

Signal = require 'libs.hump.signal' -- Put this into a separate class later

local Entity = require 'entities.entity'
local PositionComponent = require 'components.position_component'
local SizeComponent = require 'components.size_component'
local PhysicsComponent = require 'components.physics_component'

local GraphicsSystem = require 'systems.graphics_system'
local InputSystem = require 'systems.input_system'
local PhysicsSystem = require 'systems.physics_system'

local gameLevel2 = Gamestate.new()

function gameLevel2:enter()
   self.entities = {}

   self.player = Entity()

   self.player.components["position"] = PositionComponent(10, 10)
   self.player.components["size"] = SizeComponent(64, 64)
   self.player.components["physics"] = PhysicsComponent(600, 20, 80)

   table.insert(self.entities, self.player)

   self.graphics = GraphicsSystem()

   self.physics = PhysicsSystem()

   self.input = InputSystem()

   Signal.register("quit", function() love.event.push("quit") end)
   Signal.register("moveRight", function() self.player.components["physics"].x_velocity = self.player.components["physics"].x_velocity + 3 end)
   Signal.register("moveLeft", function() self.player.components["physics"].x_velocity = self.player.components["physics"].x_velocity - 3 end)

   self.input:register("escape", "press", "quit")
   self.input:register("d", "hold", "moveRight")
   self.input:register("a", "hold", "moveLeft")

end

function gameLevel2:update(dt)
   self.input:update()

   for _, entity in ipairs(self.entities) do
      if entity:has_components("position", "physics") then
         entity.components["position"], entity.components["physics"] = self.physics:update(dt, entity.components["position"], entity.components["physics"])
      end
   end
end

function gameLevel2:draw()
   for _, entity in ipairs(self.entities) do
      if entity:has_components("position", "size") then
         self.graphics:draw(entity.components["position"], nil, entity.components["size"])
      end
   end
end

function gameLevel2:keypressed(key)
   self.input:keyPressed(key)
end

function gameLevel2:keyreleased(key)
   self.input:keyReleased(key)
end

return gameLevel2
