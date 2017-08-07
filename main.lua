Gamestate = require 'libs.hump.gamestate'

local mainMenu = require 'gamestates.mainmenu'
local gameLevel1 = require 'gamestates.gameLevel1'
local gameLevel2 = require 'gamestates.gameLevel2'
local gameLevel3 = require 'gamestates.gameLevel3'
local pause = require 'gamestates.pause'

function love.load()
   Gamestate.registerEvents()
   Gamestate.switch(gameLevel3)
end
