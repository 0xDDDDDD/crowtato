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

    gs.mode = "game"

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

function GameState:startDecreeSelection(opts)
    self.mode = "decree_selection"
    pick_decrees(opts)
end

function GameState:endDecreeSelection()
    self.mode = "game"
end

function GameState:update(dt)

    context.input:update()
    context.ui:update(dt)

    if self.mode == "game" then
        self.entity:update(dt)
    else
        --pass
    end

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
        context.game:startDecreeSelection(get_random_decrees(context))
    elseif key == "p" then
        context.game.state.wave = context.game.state.wave + 1
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and context.ui:get("decreepicker").visible then
        local dp = context.ui:get("decreepicker")
        local selected = dp:select(x, y)

        if selected then
            -- Find the full decree object by matching name or id
            local decreeObj = nil
            for _, d in ipairs(context.game.state.decrees) do
                if d.name == selected.name then  -- or d.id == selected.id if it exists
                    decreeObj = d
                    break
                end
            end

            if decreeObj then
                table.insert(context.game.state.inventory, decreeObj)
                context.game:endDecreeSelection()
            else
                print("Warning: selected decree not found in master list:", selected.name)
            end
        end
    end
end

function pick_decrees(options)
    local dp = context.ui:get("decreepicker")
    dp:show(options)
end

local function hasDecree(inventory, id)
    for _, d in ipairs(inventory) do
        if d.id == id then
            return true
        end
    end
    return false
end

function get_random_decrees(context)
    local allDecrees = context.game.state.decrees
    local inventory  = context.game.state.inventory

    print("Inventory contents before filtering:")
    for _, d in ipairs(context.game.state.inventory) do
        print("id:", d.id, "type:", type(d.id), "name:", d.name)
    end


    local filtered = {}
    for _, decree in ipairs(allDecrees) do
        if decree.multi == true or not hasDecree(inventory, decree.id) then
            table.insert(filtered, decree)
        end
    end

    -- shuffle
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
