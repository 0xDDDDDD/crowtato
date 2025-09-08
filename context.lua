--Render = require("core.render")
--Input
--audio
--animation
--tween
--ui

local Context = {}
Context.__index = Context
Context.instance = nil

-- Core modules
--local Render    = require("core.render")
--local Input     = require("core.input")
--local Audio     = require("core.audio")
--local Animation = require("core.animation")
--local Tween     = require("core.tween")


function Context:new()
    if Context.instance then
        return Context.instance
    end

    local c = {}

    --c.render = Render:new(c)
    --c.input = Input:new(c)
    --c.audio = Audio:new(c)
    --c.animation = Animation:new(c)
    --c.tween = Tween:new(c)

    setmetatable(c, Context)
    Context.instance = c

    return c
end

return Context
