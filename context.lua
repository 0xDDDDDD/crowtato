local Context = {}

local Game = require("gamestate")
local Animation = require("core.animation")
local UI = require("ui.ui")

Context.game = Game:new()
Context.animation = Animation:new(Context)
Context.ui = UI:new(Context)


return Context
