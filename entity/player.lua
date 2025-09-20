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
    pl.movSpeed = 300
    pl.moving = false

    --Misc
    pl.timers = {}

    return pl
end

function Player:update(dt)

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

    self.animator:update(dt)
end

function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX, self.posY)
end

return Player
