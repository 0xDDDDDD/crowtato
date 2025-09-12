context = require("context")

function love.load()

    context.game:load()

end

function love.update(dt)
    context.game:update(dt)
    context.animation:update(dt)
end


function love.draw()
    --Rectangle
    love.graphics.setColor(0.0, 0.3, 0.1, 1.0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

    --Main
    context.game:draw()

end
