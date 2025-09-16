local Enemy = {}

Enemy.__index = Enemy

function Enemy:new(entity, opts, animator)
    local enm = setmetatable({}, Enemy)

    --Modules
    enm.entity = entity
    enm.animator = animator
    enm.behaviors = nil --for now, add when this is implemented

    --Enemy Data
    enm.posX, enm.posY = opts.posX or 0, opts.posY or 0
    enm.health = opts.health or 100
    enm.movSpeed = opts.movSpeed or 200
    enm.stun = false
    enm.dead = false

    --Misc
    enm.timers = {}

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


function Enemy:draw(px)
    local scaleX = 1
    local offsetX = 0

    if px > self.posX then
        scaleX = -1
        offsetX = self.animator.frameW
    end

    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX + offsetX, self.posY, 0, scaleX, 1)
end

return Enemy
