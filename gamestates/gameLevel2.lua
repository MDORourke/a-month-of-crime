Gamestate = require 'libs.hump.gamestate'

local Entity = require 'entities.entity'
local PositionComponent = require 'components.position_component'
local SizeComponent = require 'components.size_component'

local GraphicsSystem = require 'systems.graphics_system'
local InputSystem = require 'systems.input_system'

local gameLevel2 = Gamestate.new()

function gameLevel2:enter()
   self.entities = {}

   self.player = Entity()

   self.player.components["position"] = PositionComponent(10, 10)
   self.player.components["size"] = SizeComponent(64, 64)

   table.insert(self.entities, self.player)

   self.graphics = GraphicsSystem()

   self.input = InputSystem()

   self.input:register("escape", function() love.event.push("quit") end)

end

function gameLevel2:update(dt)
   -- Nothing happening right this second
end

function gameLevel2:draw()
   self.graphics:draw(self.player.components["position"], nil, self.player.components["size"])
end

function gameLevel2:keypressed(key)
   self.input:keyPressed(key)
end

return gameLevel2
