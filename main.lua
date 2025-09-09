--TODO: Go over context.lua.  Should that be a class? or a dumb data table? 

AnimTypes = require("core.animationtypes")

local Game = require("gamestate")
context = {}
local player = nil


--PLAYER SCAFFOLD
--Create the player
local Player = {}
Player.__index = Player

function Player:new()
    local pl = setmetatable({}, Player)

    
    pl.animator = AnimTypes.spriteAnimator:new{
        sheet   = love.graphics.newImage("assets/img/player/player_sheet.png"),
        frameW  = 32,
        frameH  = 32,
        anims  = {
            idle = {1, 2},
            walk = {2, 3},
            attack = {4}
        },
        startAnim = "idle",
        speed   = 0.2,
        loop    = true
    }

    pl.currentAnim = "idle"
    pl.playerX, pl.playerY = 300, 300
    pl.movSpeed = 200

    return pl
end

function Player:update(dt)
    self.animator:update(dt)
end

function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.playerX, self.playerY)
end

function love.load()
        context.game = Game:new(context)
        context.game:load()


        player = Player:new()

end

function love.update(dt)
    context.game:update(dt)
    player.animator.currentAnim = "idle"
    --Temporary input polling
    if love.keyboard.isDown("w") then
        player.playerY = player.playerY - (player.movSpeed * dt)
        player.animator.currentAnim = "walk"
    end

    if love.keyboard.isDown("a") then
        player.playerX = player.playerX - (player.movSpeed * dt)
        player.animator.currentAnim = "walk"
    end

    if love.keyboard.isDown("s") then
        player.playerY = player.playerY + (player.movSpeed * dt)
        player.animator.currentAnim = "walk"
    end

    if love.keyboard.isDown("d") then
        player.playerX = player.playerX + (player.movSpeed * dt)
        player.animator.currentAnim = "walk"
    end

    player:update(dt)

    print("\nCurrent anim = ", player.animator.currentAnim)
end

function love.draw()
    player:draw()
    context.game:draw()

end

--Enemy
local Enemy = {}
Enemy.__index = Enemy

function Enemy:new()
end

function Enemy:update()
end

function Enemy:draw()
end
