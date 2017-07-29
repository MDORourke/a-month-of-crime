local PhysicsSystem = require 'systems.physics_system'
local PhysicsComponent = require 'components.physics_component'

describe("PhysicsSystem", function()
   it("should apply velocity in the X co-ordinate", function()
      phys_component = PhysicsComponent(100, 0, 0)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.x_velocity, 100)
   end)

   it("should apply velocity in the Y co-ordinate", function()
      phys_component = PhysicsComponent(100, 0, 0)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.y_velocity, 100)
   end)

   it("should apply friction in the X co-ordinate when friction * dt is less than 1", function()
      phys_component = PhysicsComponent(100, 0.5, 0)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.x_velocity, 50)
   end)

   it("should apply friction in the Y co-ordinate when friction * dt is less than 1", function()
      phys_component = PhysicsComponent(100, 0.5, 0)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.y_velocity, 50)
   end)

   it("should reduce velocity to 0 when friction * dt is more than 1", function()
      phys_component = PhysicsComponent(100, 2, 0)
      
      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component.y_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.x_velocity, 0)
      assert.are.equal(phys_component.y_velocity, 0)
   end)

   it("should increase gravity by the time interval", function()
      phys_component = PhysicsComponent(100, 0.1, 0)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component.y_velocity = 100
      phys_component = physics:update(5, phys_component)
      assert.are.equal(phys_component.x_velocity, 50)
      assert.are.equal(phys_component.y_velocity, 50)
   end)

   it("should apply gravity to the Y co-ordinate", function()
      phys_component = PhysicsComponent(100, 0, 10)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.y_velocity, 110)
   end)

   it("should not apply gravity to the X co-ordinate", function()
      phys_component = PhysicsComponent(100, 0, 10)

      physics = PhysicsSystem()

      phys_component.x_velocity = 100
      phys_component = physics:update(1, phys_component)
      assert.are.equal(phys_component.x_velocity, 100)
   end)

   it("should increase gravity by the time interval", function()
      phys_component = PhysicsComponent(100, 0, 1)

      physics = PhysicsSystem()

      phys_component.y_velocity = 100
      phys_component = physics:update(10, phys_component)
      assert.are.equal(phys_component.y_velocity, 110)
   end)
end)
