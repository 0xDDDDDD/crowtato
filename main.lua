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

    pl.spriteSheet = love.graphics.newImage("assets/img/player/player_sheet.png")
    pl.sheetWidth = pl.spriteSheet:getWidth()
    pl.sheetHeight = pl.spriteSheet:getHeight()
    pl.frameWidth = pl.sheetWidth * 0.5
    pl.frameHeight = pl.sheetHeight * 0.5

    pl.quads = {}
    local index = 1
    for row = 0, 1 do
        for col = 0, 1 do
            pl.quads[index] = love.graphics.newQuad(
                col * pl.frameWidth,
                row * pl.frameHeight,
                pl.frameWidth,
                pl.frameHeight,
                pl.sheetWidth,
                pl.sheetHeight
            )
            index = index + 1
        end
    end

    pl.currentAnim = "walk"
    pl.currentFrame = 1
    pl.frameTimer = 0
    pl.frameDuration = 0.2

    pl.actionPlaying = false
    pl.actionFrameIndex = 3
    pl.actionTime = 0
    pl.actionDuration = pl.frameDuration * 2

    pl.playerX, pl.playerY = 300, 300

    return pl
end

function Player:update()
end

function Player:draw()
    love.graphics.draw(self.spriteSheet, self.quads[self.currentFrame], self.playerX, self.playerY)
end



function love.load()
        context.game = Game:new(context)
        context.game:load()

        -- Implement a player
        player = Player:new()

        -- implement an enemy
        -- implement a curved projectile from the enemy to the player
end

function love.update(dt)
    context.game:update(dt)
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
