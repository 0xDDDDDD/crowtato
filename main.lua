context = require("context")
local Entity = require("entity.entity")

local player = nil
local enemy = nil

function love.load()

        context.game:load()
        enemy = Entity.Enemy:new()

end

function love.update(dt)
    context.game:update(dt)
    context.animation:update(dt)

    --enemy:update(dt, player.posX, player.posY)
end


function love.draw()
    --Rectangle
    love.graphics.setColor(0.0, 0.3, 0.1, 1.0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

    --Main
    --enemy:draw(player.posX)
    context.game:draw()

end
