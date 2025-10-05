Context = require("context")
Player = require("player.player")

--TEST SESSION

local player

function love.load()
    player = Player:new(Context, Player.defaultOpts)
    player:load()
end

function love.keypressed(key)
end

function love.update(dt)
    player:update(dt)
end


function love.draw()
    player:draw()
end
