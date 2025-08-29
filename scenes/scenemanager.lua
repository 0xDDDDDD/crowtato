local MenuScene = require("scenes.menuscene")
local GameScene = require("scenes.gamescene")


local SceneManager = {}
SceneManager.__index = SceneManager
SceneManager.instance = nil

function SceneManager:new(context)
    if SceneManager.instance then
        return SceneManager.instance
    end

    local sm = {}
    setmetatable(sm, SceneManager)

    sm.context = context
    sm.currentScene = nil

    return sm
end

function SceneManager:initialize()
    currentScene = MenuScene:new(self.context)
end

function SceneManager:switch()
    print("\nSCENE SWITCH TRIGGERED\n")
end

return SceneManager
