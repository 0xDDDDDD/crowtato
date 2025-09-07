local ui = require("ui.ui")
local gameScene = require("scenes.gamescene") -- should this be moved to make a distinction between treating this as a lib vs data

--global vars
local mousepos

GameState = {}
GameState.__index = GameState

function GameState:new(context)
    local gs = setmetatable({}, GameState)

    gs.context = context or nil

    gs.state = {
        coins = 0,
        wave = 0, 
        health = 100,
        decrees = {},
        inventory = {}
    }

    gs.components = {}

    gs.bindings = {
        state = gs.state
    }

    return gs
end

function GameState:load()
    self:loadUI()
end

function GameState:loadUI()
    self.components.ui = ui:new(self.context)

    for _, uiDef in ipairs(gameScene.UI) do  -- lowercase 'ui'
        local src = uiDef.datasrc
        if type(src) == "string" and self.bindings[src] then
            uiDef.datasrc = self.bindings[src]
        end
        self.components.ui:add(uiDef.type, uiDef)
    end
end

function GameState:update(dt)
    self.components.ui:update(dt)
end

function GameState:draw()
    self.components.ui:draw()
end



-- Utility functions, disorganized for now

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        state.counter = state.counter + 10
    elseif key == "h" and state.health >= 10 then
        state.health = state.health - 10
    elseif key == "d" then
        pick_decrees(get_random_decrees())
    elseif key == "w" then
        state.wave = state.wave + 1
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local dp = ui:get("decreepicker")
        table.insert(state.owned_decrees, dp:select(x, y))
    end
end

function pick_decrees(options)
    local dp = ui:get("decreepicker")
    dp:show(options)
end

function get_random_decrees()

    local choices = {unpack(state.decrees)}

    --Fisher-Yates Shuffle
    for i = #choices, 2, -1 do
        local j = math.random(i)
        choices[i], choices[j] = choices[j], choices[i]
    end

    local choice = {}
    for i = 1, math.min(3, #choices) do
        table.insert(choice, choices[i])
    end

    return choice
end


return GameState
