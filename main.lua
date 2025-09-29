Context = require("context")
Player = require("player.player")

--TEST SESSION

local player

function love.load()
    player = Player:new(Context, Player.defaultOpts)
end

function love.keypressed(key)
    if key == "l" then
    end
end

function love.update(dt)

end


function love.draw()

end
