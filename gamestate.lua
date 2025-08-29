local SceneManager = require("scenes.scenemanager")

GameState = {}
GameState.__index = GameState
GameState.instance = nil

function GameState:new(context)
    if GameState.instance then
        return GameState.instance
    end

    local gs = {}
    setmetatable(gs, GameState)

    gs.context = context
    gs.sceneManager = SceneManager:new(context)

    return gs
end

function GameState:update(dt)

end

function GameState:draw()
    self.context.render.draw()
end

return GameState
