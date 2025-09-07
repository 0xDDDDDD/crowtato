--TODO:  is it healthy to be calling context.game.components.ui:func() ? Or should I find a way to shorten these paths for readability?

local ui = require("ui.ui")
local Decrees = require("data.decrees")
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
    gs.state.decrees = Decrees
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

function love.keypressed(key) --TODO: needs to go to input module
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        context.game.state.coins = context.game.state.coins + 10
    elseif key == "h" and context.game.state.health >= 10 then
        context.game.state.health = context.game.state.health - 10
    elseif key == "d" then
        pick_decrees(get_random_decrees())
    elseif key == "w" then
        context.game.state.wave = context.game.state.wave + 1
    end
end

function love.mousepressed(x, y, button, istouch, presses) --TODO: needs to go to input module
    if button == 1 then
        local dp = context.game.components.ui:get("decreepicker")
        table.insert(context.game.state.inventory, dp:select(x, y))
    end
end

function pick_decrees(options) --TODO: This could potentially stay here. Needs consideration
    local dp = context.game.components.ui:get("decreepicker")
    dp:show(options)
end

function get_random_decrees() --TODO: move this into a inventory function table?
    math.randomseed(os.time())
    local choices = {unpack(context.game.state.decrees)}

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
