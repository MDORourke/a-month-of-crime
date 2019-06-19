local Gamestate = require 'libs.hump.gamestate'

local Signal = require 'libs.hump.signal'

local sti = require 'libs.sti.sti'

local anim8 = require 'libs.anim8.anim8'

local Entity = require 'entities.entity'
local PositionComponent = require 'components.position_component'
local SizeComponent = require 'components.size_component'
local PhysicsComponent = require 'components.physics_component'
local CollisionComponent = require 'components.collision_component'
local SpriteComponent = require 'components.sprite_component'
local AnimationComponent = require 'components.animation_component'

local GraphicsSystem = require 'systems.graphics_system'
local InputSystem = require 'systems.input_system'
local PhysicsSystem = require 'systems.physics_system'
local CollisionSystem = require 'systems.collision_system'
local CameraSystem = require 'systems.camera_system'

local KeyBindings = require 'utils.key_bindings'

local BaseLevel = {}

function BaseLevel:enter(old_state, map_name)
   self.entities = {}

   self.debug = false

   self.player = Entity()

   self.player.components["position"] = PositionComponent(10, 10)
   self.player.components["physics"] = PhysicsComponent(600, 20, 80)
   self.player.components["collision"] = CollisionComponent()
 
   -- Test code for anim8 library
   image = love.graphics.newImage('assets/advnt_full.png')
   local g = anim8.newGrid(32, 64, image:getWidth(), image:getHeight())
   anim_idle = anim8.newAnimation(g(1, 1), 1)
   anim_running_right = anim8.newAnimation(g('2-7', 1), 0.1)
   anim_running_left = anim_running_right:clone():flipH()

   self.player.components["sprite"] = SpriteComponent(image)
   self.player.components["animation"] = AnimationComponent({ ["idle"] = anim_idle, ["running_right"] = anim_running_right, ["running_left"] = anim_running_left }, anim_idle)
   self.player.components["size"] = SizeComponent(32, 64)

   table.insert(self.entities, self.player)

   self.graphics = GraphicsSystem()

   self.physics = PhysicsSystem()

   self.input = InputSystem()

   self.collision = CollisionSystem(16)

   self.camera = CameraSystem(self.player.components["position"])

   for _, entity in ipairs(self.entities) do
      if entity:has_components("collision", "position", "size") then
         self.collision:register(entity.components["collision"], entity.components["position"], entity.components["size"])
      end
   end

   Signal.register("quit", function() love.event.push("quit") end)
   Signal.register("moveRight", function() self.player.components["physics"].x_velocity = self.player.components["physics"].x_velocity + 3 end)
   Signal.register("moveLeft", function() self.player.components["physics"].x_velocity = self.player.components["physics"].x_velocity - 3 end)
   Signal.register("toggleDebug", function() self.debug = not self.debug end)

   for key, bindings in pairs(KeyBindings) do
      for _, options in pairs(bindings) do
         self.input:register(key, options[1], options[2])
      end
   end

   self.map = sti('assets/'..map_name..'.lua', { 'bump' })
   self.map:bump_init(self.collision.world)
end

function BaseLevel:update(dt)
   self.input:update()

   -- Temporary hack, I promise
   if self.player.components["physics"].x_velocity > 0 then
      self.player.components["animation"].current_animation = self.player.components["animation"].animations["running_right"]
   elseif self.player.components["physics"].x_velocity < 0 then
      self.player.components["animation"].current_animation = self.player.components["animation"].animations["running_left"]
   else
      self.player.components["animation"].current_animation = self.player.components["animation"].animations["idle"]
   end

   for _, entity in ipairs(self.entities) do
      if entity:has_components("physics") then
         entity.components["physics"] = self.physics:update(dt, entity.components["physics"])
      end

      if entity:has_components("animation") then
         self.graphics:update_animation(dt, entity.components["animation"])
      end

      if entity:has_components("collision", "position", "physics") then
         entity.components["position"] = self.collision:resolve(entity.components["collision"], entity.components["position"], entity.components["physics"])
      end
   end

   self.map:update(dt)

   self.camera:update_position(self.player.components["position"])
end

function BaseLevel:draw()
   love.graphics.setColor(255, 255, 255)

   -- Draw the level
   self.camera:activate()

   for _, entity in ipairs(self.entities) do
      if entity:has_components("position", "sprite", "animation") then
         self.graphics:draw_animation(entity.components["position"], entity.components["sprite"], entity.components["animation"])
      elseif entity:has_components("position", "sprite") then
         self.graphics:draw_image(entity.components["position"], entity.components["sprite"])
      elseif entity:has_components("position", "size") then
         self.graphics:draw_rectangle(entity.components["position"], entity.components["size"])
      end
   end

   if self.debug then
      love.graphics.setColor(255, 0, 0)
      self.map:bump_draw(self.collision.world, 0, 0, 1, 1)
   else
      self.map:draw()
   end

   self.camera:deactivate()

   -- Draw the HUD
end

function BaseLevel:keypressed(key)
   self.input:keyPressed(key)
end

function BaseLevel:keyreleased(key)
   self.input:keyReleased(key)
end

return BaseLevel
