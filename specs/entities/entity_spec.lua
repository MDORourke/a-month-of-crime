local Entity = require 'entities.entity'

describe("Entity", function()
   it("should have all components", function()
      entity = Entity()
      entity.components = {}
      entity.components["test_component"] = "test"

      assert.truthy(entity:has_components("test_component"))
   end)

   it("should not have all components", function()
      entity = Entity()
      entity.components = {}
      entity.components["test_component"] = "test"
      
      assert.falsy(entity:has_components("test_component", "non_component"))
   end)
end)
