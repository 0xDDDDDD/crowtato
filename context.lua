local Context = {}

local Game = require("gamestate")
local Audio = require("core.audio")
local Animation = require("core.animation")
local UI = require("ui.ui")
local Input = require("core.input")

Context.game = Game:new(Context)
Context.audio = Audio:new(Context)
Context.animation = Animation:new(Context)
Context.ui = UI:new(Context)
Context.input = Input:new(Context)


return Context
