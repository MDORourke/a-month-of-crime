Gamestate = require 'libs.hump.gamestate'

local Entity = require 'entities.entity'
local PositionComponent = require 'components.position_component'
local SizeComponent = require 'components.size_component'

local GraphicsSystem = require 'systems.graphics_system'

local gameLevel2 = Gamestate.new()

function gameLevel2:enter()
   self.entities = {}

   player = Entity()

   player.components["position"] = PositionComponent(10, 10)
   player.components["size"] = SizeComponent(64, 64)

   table.insert(self.entities, player)

   graphics = GraphicsSystem()
end

function gameLevel2:update(dt)
   -- Nothing happening right this second
end

function gameLevel2:draw()
   graphics:draw(player.components["position"], nil, player.components["size"])
end

return gameLevel2
