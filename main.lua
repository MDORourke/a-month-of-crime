bump = require 'libs.bump.bump'

world = nil

ground_0 = {}
ground_1 = {}

-- Player object
player = {
   x = 16,
   y = 16,
   width = 64,
   height = 64,

   xVelocity = 0, -- TODO: Create a Vector object of some kind later (or steal one)
   yVelocity = 0,
   acc = 100,
   maxSpeed = 600,
   friction = 20,
   gravity = 80,

   isJumping = false,
   isGrounded = false,
   hasReachedMax = false,
   jumpAcc = 500,
   jumpMaxSpeed = 9.5
}

player.filter = function(item, other)
   local x, y, w, h = world:getRect(other)
   local px, py, pw, ph = world:getRect(item)
   local playerBottom = py + ph
   local otherBottom = y + h

   if playerBottom <= y then
      return 'slide'
   end
end

function love.load()
   -- Setup bump
   world = bump.newWorld(16)

   world:add(player, player.x, player.y, player.width, player.height)

   -- Create level
   world:add(ground_0, 120, 360, 640, 16)
   world:add(ground_1, 0, 448, 640, 32)
end

function love.update(dt)
   local goalX = player.x + player.xVelocity
   local goalY = player.y + player.yVelocity

   player.x, player.y, collisions = world:move(player, goalX, goalY)

   for i, coll in ipairs(collisions) do
      if coll.touch.y > goalY then
         player.hasReachedMax = true
         player.isGrounded = false
      elseif coll.normal.y < 0 then
         player.hasReachedMax = false
         player.isGrounded = true
      end
   end

   -- Apply friction
   player.xVelocity = player.xVelocity * (1 - math.min(dt * player.friction, 1))
   player.yVelocity = player.yVelocity * (1 - math.min(dt * player.friction, 1))

   -- Apply gravity
   player.yVelocity = player.yVelocity + player.gravity * dt

   if love.keyboard.isDown("left", "a") and player.xVelocity > -player.maxSpeed then
      player.xVelocity = player.xVelocity - player.acc * dt
   elseif love.keyboard.isDown("right", "d") and player.xVelocity < player.maxSpeed then
      player.xVelocity = player.xVelocity + player.acc * dt
   end

   if love.keyboard.isDown("up", "w") then
      if -player.yVelocity < player.jumpMaxSpeed and not player.hasReachedMax then
         player.yVelocity = player.yVelocity - player.jumpAcc * dt
      elseif math.abs(player.yVelocity) > player.jumpMaxSpeed then
         player.hasReachedMax = true
      end

      player.isGrounded = false
   end
end

function love.keypressed(key)
   if key == "escape" then
      love.event.push("quit")
   end
end

function love.draw(dt)
   love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
   love.graphics.rectangle('fill', world:getRect(ground_0))
   love.graphics.rectangle('fill', world:getRect(ground_1))
end
