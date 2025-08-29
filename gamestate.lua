local SceneManager = require("scenes.scenemanager")

GameState = {}
GameState.__index = GameState
GameState.instance = nil

function GameState:new(context)

end

function GameState:update(dt)

end

function GameState:draw()

end

return GameState
