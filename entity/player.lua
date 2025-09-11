local Player = {}
Player.__index = Player

function Player:new(context, opts)
    local pl = setmetatable({}, Player)

    pl.animator = context.animation:add("player", opts)

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
