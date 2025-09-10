local Context = {}


local Animation = require("core.animation")
local UI = require("ui.ui")

Context.animation = Animation:new(Context)
Context.ui = UI:new(Context)


return Context
