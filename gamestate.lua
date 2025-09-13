local Entity = require("entity.entity")
local Decrees = require("data.decrees")
local gameScene = require("scenes.gamescene")
local Spawner = require("systems.spawner")

--global vars
local mousepos

GameState = {}
GameState.__index = GameState

function GameState:new(context)
    local gs = setmetatable({}, GameState)

    self.context = context

    gs.actors = {
        player = nil,
        enemies = {},
        projectiles = {}
    }

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
    self.actors.player = Entity.Player:new(self.context, gameScene.PlayerOpts)
    
    self:loadUI()

    self.spawner = Spawner:new(context, self)
    self.spawner:load()
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

    local spawnResult = self.spawner:update(dt)
    if spawnResult then
        print(spawnResult[2] .. " " .. spawnResult[3])
        self:add_actor("enemy", spawnResult[2], spawnResult[3])
    end

    local moving = false

    if love.keyboard.isDown("w") then
        self.actors.player.posY = self.actors.player.posY - (self.actors.player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("a") then
        self.actors.player.posX = self.actors.player.posX - (self.actors.player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("s") then
        self.actors.player.posY = self.actors.player.posY + (self.actors.player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("d") then
        self.actors.player.posX = self.actors.player.posX + (self.actors.player.movSpeed * dt)
        moving = true
    end

    if moving then
        if self.actors.player.animator.currentAnim ~= "walk" then
            self.actors.player.animator:setAnimation("walk")
        end
    else
        if self.actors.player.animator.currentAnim ~= "idle" then
            self.actors.player.animator:setAnimation("idle")
        end
    end


    self.actors.player:update(dt)
    context.ui:update(dt)

    for i, item in ipairs(self.actors.enemies) do
        item:update(dt, self.actors.player.posX, self.actors.player.posY)
    end

end

function GameState:draw()
    self.actors.player:draw()

    for i, item in ipairs(self.actors.enemies) do
        item:draw(self.actors.player.posX)
    end

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

--Refer to "TODO" in entity/entity.lua
function GameState:add_actor(type, x, y)
    print("ADDING ACTOR " .. type)
    if type == "enemy" then
        local opts = gameScene.EnemyOpts
        opts.posX, opts.posY = x, y
        local enm = Entity.Enemy:new(self.context, opts)
        table.insert(self.actors.enemies, enm)
    end
end

return GameState
