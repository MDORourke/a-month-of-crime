Gamestate = require 'libs.hump.gamestate'

local mainMenu = require 'gamestates.mainmenu'
local gameLevel1 = require 'gamestates.gameLevel1'
local gameLevel2 = require 'gamestates.gameLevel2'
local pause = require 'gamestates.pause'

function love.load()
   Gamestate.registerEvents()
   Gamestate.switch(gameLevel2)
end

function love.keypressed(key)
   if key == "escape" then
      love.event.push("quit")
   end
end
