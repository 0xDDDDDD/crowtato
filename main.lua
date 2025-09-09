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
        }
        speed   = 0.2,
        loop    = true
    }

    pl.currentAnim = "walk"
    pl.playerX, pl.playerY = 300, 300

    return pl
end

function Player:update(dt)
    self.animator:update(dt)
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
