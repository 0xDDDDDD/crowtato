--TODO: Go over context.lua.  Should that be a class? or a dumb data table? 

AnimTypes = require("core.animationtypes")
Animation = require("core.animation")
local Game = require("gamestate")
context = {}
local player = nil
local enemy = nil


--PLAYER SCAFFOLD
--Create the player
local Player = {}
Player.__index = Player

function Player:new()
    local pl = setmetatable({}, Player)

    pl.animator = context.animation:add("player", {
        type = "spriteAnimator",
        sheet   = love.graphics.newImage("assets/img/player/player_sheet.png"),
        frameW  = 64,
        frameH  = 64,
        anims  = {
            idle = {1, 2},
            walk = {2, 3},
            attack = {4}
        },
        startAnim = "idle",
        speed   = 0.5,
        loop    = true
    })

    pl.posX, pl.posY = 300, 300
    pl.movSpeed = 300

    return pl
end

function Player:update(dt)
    self.animator:update(dt)
end

function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX, self.posY)
end


--ENEMY SCAFFOLD
--Single temporary enemy
local Enemy = {}
Enemy.__index = Enemy

function Enemy:new()
    local enm = setmetatable({}, Enemy)

    enm.animator = context.animation:add("enemy", {
        type = "spriteAnimator",
        sheet = love.graphics.newImage("assets/img/enemy/enemy_minion.png"),
        frameW = 64,
        frameH = 64,
        anims = {
            typeA = {1, 2},
            typeB = {3, 4}
        },
        startAnim = "typeA",
        speed = 0.5,
        loop = true
    })

    enm.posX, enm.posY = 300, 500
    enm.movSpeed = 200
    enm.dead = false
    return enm
end

function Enemy:update(dt, px, py)

    self.animator:update(dt)

    local dx = px - self.posX
    local dy = py - self.posY

    local dist = math.sqrt(dx*dx + dy*dy)

    if dist > 0 then
        local step = self.movSpeed * dt
        self.posX = self.posX + (dx / dist) * step
        self.posY = self.posY + (dy / dist) * step
    end
end


function Enemy:draw(playerX)
    local scaleX = 1
    local offsetX = 0

    if playerX > self.posX then
        scaleX = -1
        offsetX = self.animator.frameW
    end

    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX + offsetX, self.posY, 0, scaleX, 1)
end



function love.load()
        context.game = Game:new(context)
        context.game:load()

        context.animation = Animation:new()


        --PLAYER AND ENEMY SCAFFOLD


        player = Player:new()
        enemy = Enemy:new()

end

function love.update(dt)
    context.game:update(dt)
    context.animation:update(dt)

    local moving = false

    if love.keyboard.isDown("w") then
        player.posY = player.posY - (player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("a") then
        player.posX = player.posX - (player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("s") then
        player.posY = player.posY + (player.movSpeed * dt)
        moving = true
    end
    if love.keyboard.isDown("d") then
        player.posX = player.posX + (player.movSpeed * dt)
        moving = true
    end

    if moving then
        if player.animator.currentAnim ~= "walk" then
            player.animator:setAnimation("walk")
        end
    else
        if player.animator.currentAnim ~= "idle" then
            player.animator:setAnimation("idle")
        end
    end

    player:update(dt)
    enemy:update(dt, player.posX, player.posY)
end


function love.draw()
    love.graphics.setColor(0.0, 0.3, 0.1, 1.0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    player:draw()
    enemy:draw(player.posX)
    context.game:draw()

end
