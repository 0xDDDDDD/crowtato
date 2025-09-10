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

return Player
