local Context = require("context")
local GameState = require("gamestate")

local gameState
local context

function love.load()

    context = Context:new()
    gameState = GameState:new(context)
    
end


function love.update(dt)
    gameState:update(dt)
end


function love.draw()
    gameState:draw()
end
