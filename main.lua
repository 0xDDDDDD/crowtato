--TODO: Go over context.lua.  Should that be a class? or a dumb data table? 

local Game = require("gamestate")

context = {}


function love.load()
        context.game = Game:new(context)
        context.game:load()
end

function love.update(dt)
    context.game:update(dt)
end

function love.draw()
    context.game:draw()
end
