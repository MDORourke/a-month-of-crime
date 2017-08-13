-- Each key has a list of both input types ["press", "release", "hold"] and actions
-- E.g.
-- "escape" = {
--    {"press", "quit"}
-- }
-- Would map the "escape" key to the "quit" action if pressed
local key_bindings = {
   escape = {
      {"press", "quit"}
   },
   d = {
      {"hold", "moveRight"}
   },
   a = {
      {"hold", "moveLeft"}
   },
   x = {
      {"press", "toggleDebug"}
   },
   left = {
      {"hold", "moveLeft"}
   },
   right = {
      {"hold", "moveRight"}
   },
}

return key_bindings
