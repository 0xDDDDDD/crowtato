local Enemy = {}
Enemy.__index = Enemy

function Enemy:new()
    local enm = setmetatable({}, Enemy)

    enm.animator = context.animation:add("enemy", {
        type = "spriteAnimator",
        sheet = love.graphics.newImage("assets/img/enemy/enemy_minion.png"),
        frameW = 64,
        frameH = 64,
        anims = {
            typeA = {1, 2},
            typeB = {3, 4}
        },
        startAnim = "typeA",
        speed = 0.5,
        loop = true
    })

    enm.posX, enm.posY = 300, 500
    enm.movSpeed = 200
    enm.dead = false
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


function Enemy:draw(playerX)
    local scaleX = 1
    local offsetX = 0

    if playerX > self.posX then
        scaleX = -1
        offsetX = self.animator.frameW
    end

    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX + offsetX, self.posY, 0, scaleX, 1)
end

return Enemy
