Gamestate = require 'libs.hump.gamestate'

Signal = require 'libs.hump.signal' -- Put this into a separate class later

local sti = require 'libs.sti.sti'

local Entity = require 'entities.entity'
local PositionComponent = require 'components.position_component'
local SizeComponent = require 'components.size_component'
local PhysicsComponent = require 'components.physics_component'
local CollisionComponent = require 'components.collision_component'

local GraphicsSystem = require 'systems.graphics_system'
local InputSystem = require 'systems.input_system'
local PhysicsSystem = require 'systems.physics_system'
local CollisionSystem = require 'systems.collision_system'

local gameLevel3 = Gamestate.new()

function gameLevel3:enter()
   self.entities = {}

   self.debug = false

   self.player = Entity()

   self.player.components["position"] = PositionComponent(10, 10)
   self.player.components["size"] = SizeComponent(64, 64)
   self.player.components["physics"] = PhysicsComponent(600, 20, 80)
   self.player.components["collision"] = CollisionComponent()

   table.insert(self.entities, self.player)

   self.graphics = GraphicsSystem()

   self.physics = PhysicsSystem()

   self.input = InputSystem()

   self.collision = CollisionSystem(16)

   for _, entity in ipairs(self.entities) do
      if entity:has_components("collision", "position", "size") then
         self.collision:register(entity.components["collision"], entity.components["position"], entity.components["size"])
      end
   end

   Signal.register("quit", function() love.event.push("quit") end)
   Signal.register("moveRight", function() self.player.components["physics"].x_velocity = self.player.components["physics"].x_velocity + 3 end)
   Signal.register("moveLeft", function() self.player.components["physics"].x_velocity = self.player.components["physics"].x_velocity - 3 end)
   Signal.register("toggleDebug", function() self.debug = not self.debug end)

   self.input:register("escape", "press", "quit")
   self.input:register("d", "hold", "moveRight")
   self.input:register("a", "hold", "moveLeft")
   self.input:register("x", "press", "toggleDebug")

   self.map = sti('assets/test.lua', { 'bump' })

   self.map:bump_init(self.collision.world)

end

function gameLevel3:update(dt)
   self.input:update()

   for _, entity in ipairs(self.entities) do
      if entity:has_components("physics") then
         entity.components["physics"] = self.physics:update(dt, entity.components["physics"])
      end

      if entity:has_components("collision", "position", "physics") then
         entity.components["position"] = self.collision:resolve(entity.components["collision"], entity.components["position"], entity.components["physics"])
      end
   end

   self.map:update(dt)
end

function gameLevel3:draw()
   love.graphics.setColor(255, 255, 255)

   for _, entity in ipairs(self.entities) do
      if entity:has_components("position", "size") then
         self.graphics:draw(entity.components["position"], nil, entity.components["size"])
      end
   end

   if self.debug then
      love.graphics.setColor(255, 0, 0)
      self.map:bump_draw(self.collision.world, 0, 0, 1, 1)
   else
      self.map:draw()
   end

end

function gameLevel3:keypressed(key)
   self.input:keyPressed(key)
end

function gameLevel3:keyreleased(key)
   self.input:keyReleased(key)
end

return gameLevel3
