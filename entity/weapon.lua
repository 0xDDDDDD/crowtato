local Shapes = require("types.shapes")

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
    w.scale = (w.player.atkRange / 100) * w.opts.scale

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
            self.scale, self.scale,
            self.opts.originX or self.opts.frameW / 2,
            self.opts.originY or self.opts.frameH / 2
        )
    end
end

function Weapon:attack(enmPosX, enmPosY, enmDist)
    print("Attacking...")

    local reach = self.player.atkRange

    local logicAngle = math.atan2(enmPosY - self.player.posY,
                                  enmPosX - self.player.posX)

    local visualAngle = logicAngle + (self.opts.rotationOffset or 0)

    self.posX = self.player.posX + math.cos(logicAngle) * reach
    self.posY = self.player.posY + math.sin(logicAngle) * reach
    self.rotation = visualAngle
    self.animator.rotation = visualAngle
    self.animator:playOnce("atk")

    local thickness = self.opts.hitThickness or 20
    local cx = self.player.posX + math.cos(logicAngle) * (reach / 2)
    local cy = self.player.posY + math.sin(logicAngle) * (reach / 2)

    local hitShape = Shapes.obb(cx, cy, reach / 2, thickness / 2, logicAngle)
    hitShape.damage = self.opts.damage

    self.player.entity:processHit(hitShape)
end

return Weapon
