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

function Player:new(entity, opts, animator)
    local pl = setmetatable({}, Player)

    --Modules
    pl.entity = entity
    pl.animator = context.animation:add("player", opts)

    --Player data
    pl.posX, pl.posY = 300, 300
    pl.movSpeed = 300

    --Misc
    pl.timers = {}

    return pl
end

function Player:update(dt)
    self.animator:update(dt)
end

function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX, self.posY)
end

return Player
