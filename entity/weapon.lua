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

function Weapon:attack(enmPosX, enmPosY, enmDist)
    print("Attacking...")

    local reach = self.player.atkRange

    local logicAngle = math.atan2(enmPosY - self.player.posY, enmPosX - self.player.posX)

    local visualAngle = logicAngle + (self.opts.rotationOffset or 0)

    self.posX = self.player.posX + math.cos(logicAngle) * reach
    self.posY = self.player.posY + math.sin(logicAngle) * reach

    self.rotation = visualAngle
    self.animator.rotation = visualAngle
    self.animator:playOnce("swing")
end

return Weapon
