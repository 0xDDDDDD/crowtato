--TODO: Go over context.lua.  Should that be a class? or a dumb data table? 
Animation = require("core.animation")
local Game = require("gamestate")

local Entity = require("entity.entity")

context = {}
local player = nil
local enemy = nil

function love.load()
        context.game = Game:new(context)
        context.game:load()

        context.animation = Animation:new()


        --PLAYER AND ENEMY SCAFFOLD


        player = Entity.Player:new()
        enemy = Entity.Enemy:new()

end

function love.update(dt)
    context.game:update(dt)
    context.animation:update(dt)

    local moving = false

    if love.keyboard.isDown("w") then
        player.posY = player.posY - (player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("a") then
        player.posX = player.posX - (player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("s") then
        player.posY = player.posY + (player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("d") then
        player.posX = player.posX + (player.movSpeed * dt)
        moving = true
    end

    if moving then
        if player.animator.currentAnim ~= "walk" then
            player.animator:setAnimation("walk")
        end
    else
        if player.animator.currentAnim ~= "idle" then
            player.animator:setAnimation("idle")
        end
    end

    player:update(dt)
    enemy:update(dt, player.posX, player.posY)
end


function love.draw()
    love.graphics.setColor(0.0, 0.3, 0.1, 1.0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    player:draw()
    enemy:draw(player.posX)
    context.game:draw()

end
