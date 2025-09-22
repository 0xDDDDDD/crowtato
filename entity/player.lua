local Weapons = require("entity.weaponTypes")

local playerSprite = love.graphics.newImage("assets/img/player/player_sheet.png")

local Player = {}
Player.__index = Player

Player.defaultOpts = {
    animType = "spriteAnimator",
    sheet   = playerSprite,
    frameW  = 64,
    frameH  = 64,
    anims  = {
        idle = {1, 2},
        walk = {2, 3},
        attack = {4}
    },
    startAnim = "idle",
    animSpeed   = 0.5,
    loop    = true
}

function Player:new(context, entity, opts, animator)
    local pl = setmetatable({}, Player)

    --Modules
    pl.context = context
    pl.entity = entity
    pl.animator = context.animation:add("player", opts)

    --Player data
    pl.posX, pl.posY = 300, 300
    pl.health = 100
    pl.movSpeed = 300
    pl.moving = false

    pl.weapon = Weapons.Claws
    pl.weaponPosX = nil
    pl.weaponPosY = nil
    pl.attacking = false
    pl.atkSpeed = 0.5
    pl.atkRange = 100

    --Misc
    pl.timers = {
        attack = 0.0
    }

    return pl
end

function Player:update(dt)

    --MOVEMENT CODE
    self.posX = self.posX + ((self.context.input.actions.moveX * self.movSpeed) * dt)
    self.posY = self.posY + ((self.context.input.actions.moveY * self.movSpeed) * dt)

    if self.context.input.actions.moveX == 0 and self.context.input.actions.moveY == 0 then
        self.moving = false
    else
        self.moving = true
    end

    if self.moving then
        if self.animator.currentAnim ~= "walk" then
            self.animator:setAnimation("walk")
        end
    else
        if self.animator.currentAnim ~= "idle" then
            self.animator:setAnimation("idle")
        end
    end

    --SCAN CODE
    self:scan()
    
    self.animator:update(dt)

end

function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX, self.posY)
end

function Player:equip(weapon)
    self.weapon = weapon
    weapon.player = self
end

function Player:scan()
    --based on reach, the player detects if and how many enemies are in the circle of reach.
end


--OBSOLETE, just using as reference now
--[[
function Player:attack()

    local target, dist = self.entity:nearestEnemy(self.posX, self.posY)

    if not target then
        return
    end

    local dx = target.posX - self.posX
    local dy = target.posY - self.posY

    if (dx*dx + dy*dy) <= self.atkRange * self.atkRange then
        local angle = math.atan2(dy, dx)


        if self.weaponAnimator then
            self.weaponAnimator.rotation = angle + 90
            self.weaponPosX = self.posX + math.cos(angle) * self.atkRange
            self.weaponPosY = self.posY + math.sin(angle) * self.atkRange
        end

        if self.weaponAnimator then
            self.weaponAnimator:playOnce("swing")
        end

        self.attacking = true

    end
end
]]--

return Player
