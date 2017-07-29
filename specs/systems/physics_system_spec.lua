local PhysicsSystem = require 'systems.physics_system'
local PositionComponent = require 'components.position_component'
local PhysicsComponent = require 'components.physics_component'

describe("PhysicsSystem", function()
   it("should apply velocity in the X co-ordinate", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0, 0)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.x, phys_component.x_velocity)
   end)

   it("should apply velocity in the Y co-ordinate", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0, 0)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.y, phys_component.y_velocity)
   end)

   it("should apply friction in the X co-ordinate when friction * dt is less than 1", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0.5, 0)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.x, 50)
   end)

   it("should apply friction in the Y co-ordinate when friction * dt is less than 1", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0.5, 0)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.y, 50)
   end)

   it("should reduce velocity to 0 when friction * dt is more than 1", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 2, 0)
      
      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component.y_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.x, 0)
      assert.are.equal(pos_component.y, 0)
   end)

   it("should increase gravity by the time interval", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0.1, 0)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component.y_velocity = 100
      pos_component, phys_component = physics:update(5, pos_component, phys_component)
      assert.are.equal(pos_component.x, 50)
      assert.are.equal(pos_component.y, 50)
   end)

   it("should apply gravity to the Y co-ordinate", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0, 10)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.y, 110)
   end)

   it("should not apply gravity to the X co-ordinate", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0, 10)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      pos_component, phys_component = physics:update(1, pos_component, phys_component)
      assert.are.equal(pos_component.x, 100)
   end)

   it("should increase gravity by the time interval", function()
      pos_component = PositionComponent(0, 0)
      phys_component = PhysicsComponent(100, 0, 1)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      pos_component, phys_component = physics:update(10, pos_component, phys_component)
      assert.are.equal(pos_component.y, 110)
   end)
end)
