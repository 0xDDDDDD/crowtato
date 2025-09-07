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
