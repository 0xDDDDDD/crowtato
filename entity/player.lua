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
    pl.hitboxSize = 20

    pl.weapon = Weapons.Claws
    pl.weaponPosX = nil
    pl.weaponPosY = nil
    pl.attacking = false
    pl.atkSpeed = 0.5
    pl.atkRange = 150

    pl.base = {
        movSpeed = 300,
        atkSpeed = 0.5,
        atkRange = 150
    }

    pl.modifiers = {
        movSpeed = 0,
        atkSpeed = 0,
        atkRange = 0
    }

    --Misc
    pl.timers = {
        attack = 0.0,
        takeHit = 0.0
    }
    pl:calculate()
    return pl
end

function Player:calculate()
    self.movSpeed = self.base.movSpeed + self.modifiers.movSpeed
    self.atkSpeed = self.base.atkSpeed + self.modifiers.atkSpeed
    self.atkRange = self.base.atkRange + self.modifiers.atkRange
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
    self.timers.attack = math.max(0, self.timers.attack - dt)
    self.timers.takeHit = math.max(0, self.timers.takeHit - dt)

    local enmPosX, enmPosY, enmDist = self:scan()
    if enmPosX then
        if self.timers.attack <= 0 then
            self.context.audio:playSFX("assets/audio/atk.mp3", 1.0)
            self.weapon:attack(enmPosX, enmPosY, enmDist)
            self.timers.attack = self.atkSpeed
        end

        if self.timers.takeHit <= 0 and enmDist <= self.hitboxSize then
            self.health = self.health - 10
            self.timers.takeHit = 1.0
        end
    end

    self.animator:update(dt)

end

function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX, self.posY)
end

function Player:equip(weapon)
    self.weapon = weapon
    weapon.player = self
end

function Player:scan() --This could be done inline, but wrapping it in function for adding new features in future
    local enemy, dist = self.entity:nearestEnemy(self.posX, self.posY)

    if enemy and dist <= self.atkRange then
        return enemy.posX, enemy.posY, dist
    else
        return nil
    end
end


return Player
