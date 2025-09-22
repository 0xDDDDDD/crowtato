local Weapon = {}
Weapon.__index = Weapon

function Weapon:new(animator, player, entity, opts)
    local w = setmetatable({}, Weapon)

    --modules
    w.animator = animator
    w.player = player
    w.entity = entity

    --Data
    w.opts = opts
    w.posX, w.posY = 0, 0
    w.rotation = 0

    return w
end

function Weapon:update(dt)
    self.animator:update(dt)
end

function Weapon:draw()
    if not self.animator.finished then
        love.graphics.draw(
            self.animator.sheet,
            self.animator:getQuad(),
            self.posX, self.posY,
            self.rotation,
            4, 4,
            self.opts.originX or self.opts.frameW / 2,
            self.opts.originY or self.opts.frameH / 2
        )
    end
end

--Needs rigorous testing...
function Weapon:attackFrom(playerX, playerY, targetX, targetY)
    local reach = self.opts.range or 0
    local angle = math.atan2(targetY - playerY, targetX - playerX) + (self.opts.rotationOffset or 0)
    self.rotation = angle
    self.posX = playerX + math.cos(angle) * reach
    self.posY = playerY + math.sin(angle) * reach
    self.animator.rotation = angle
    self.animator:playOnce("swing")
end

return Weapon
