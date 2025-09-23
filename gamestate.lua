local Entity = require("entity.entity")
local Decrees = require("data.decrees")
local gameScene = require("scenes.gamescene")

--global vars
local mousepos

GameState = {}
GameState.__index = GameState

function GameState:new(context)
    local gs = setmetatable({}, GameState)

    self.context = context
    self.entity = nil

    gs.state = {
        coins = 0,
        wave = 0, 
        health = 100,
        decrees = {},
        inventory = {}
    }
    gs.state.decrees = Decrees

    gs.bindings = {
        state = gs.state
    }

    return gs
end

function GameState:load()
    self.entity = Entity:new(self.context)
    
    self.context.audio:playMusic("assets/audio/crowtato.mp3")

    --load the player in
    self.entity:load()

    self:loadUI()
end

function GameState:loadUI()

    for _, uiDef in ipairs(gameScene.UI) do
        local src = uiDef.datasrc
        if type(src) == "string" and self.bindings[src] then
            uiDef.datasrc = self.bindings[src]
        end
        context.ui:add(uiDef.type, uiDef)
    end
end

function GameState:update(dt)

    context.input:update()
    context.ui:update(dt)
    self.entity:update(dt)

end

function GameState:draw()
    self.entity:draw()
    context.ui:draw()
end



-- Utility functions, disorganized for now

function love.keypressed(key) --TODO: needs to go to input module
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        context.game.state.coins = context.game.state.coins + 10
    elseif key == "h" and context.game.state.health >= 10 then
        context.game.state.health = context.game.state.health - 10
    elseif key == "t" then
        pick_decrees(get_random_decrees(context))
    elseif key == "p" then
        context.game.state.wave = context.game.state.wave + 1
    end
end

function love.mousepressed(x, y, button, istouch, presses) --TODO: needs to go to input module
    if button == 1 and context.ui:get("decreepicker").visible then
        local dp = context.ui:get("decreepicker")
        table.insert(context.game.state.inventory, dp:select(x, y))
    end
end

function pick_decrees(options) --TODO: This could potentially stay here. Needs consideration
    local dp = context.ui:get("decreepicker")
    dp:show(options)
end

function get_random_decrees(context)

    local allDecrees = context.game.state.decrees
    local inventory  = context.game.state.inventory


    local filtered = {}
    for _, decree in ipairs(allDecrees) do
        if decree.multi == true then
            table.insert(filtered, decree)
        else
            if not inventory[decree.id] then
                table.insert(filtered, decree)
            end
        end
    end

    for i = #filtered, 2, -1 do
        local j = math.random(i)
        filtered[i], filtered[j] = filtered[j], filtered[i]
    end

    local choice = {}
    for i = 1, math.min(3, #filtered) do
        table.insert(choice, filtered[i])
    end

    return choice
end

return GameState
