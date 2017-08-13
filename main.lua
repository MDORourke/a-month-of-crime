package.path = package.path .. ";src/?.lua"

Gamestate = require 'libs.hump.gamestate'

BaseLevel = require 'gamestates.baseLevel'

function love.load()
   Gamestate.registerEvents()
   Gamestate.switch(BaseLevel, "test")
end
