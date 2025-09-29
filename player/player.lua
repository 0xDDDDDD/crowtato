local playerSprite = love.graphics.newImage("assets/img/player/player_sheet.png")


local Player = {}
Player.__index = Player

function Player:new(context, opts)

    local pl = setmetatable({}, Player)

    assert(opts and opts.data, "Player options missing...")

    pl.opts = opts

    --Modules
    pl.context = context
    pl.animator = nil

    --pl.state = context.state (table with wave, points, etc? unimplemented as of yet)
    --pl.entity = context.entity 
    pl.weapon = nil
    pl.weaponPos = {nil, nil}

    local w, h = love.graphics.getDimensions()
    pl.posX, pl.posY = w * 0.5, h * 0.5

    --Player data
    pl.health = opts.data.health or 100
    pl.movSpeed = opts.data.movSpeed or 300
    pl.hitboxSize = opts.data.hitboxSize or 32 --In each direction from center
    pl.atkSpeed = opts.data.atkSpeed or 0.5
    pl.atkRange = opts.data.atkRange or 150

    --Player state
    pl.moving = false
    pl.attacking = false

    pl.timers = {
        tick = 0.0,
        attack = 0.0,
    }

    pl.base = {
        movSpeed = opts.data.movSpeed or 100,
        atkSpeed = opts.data.atkSpeed or 0.5,
        atkRange = opts.data.atkRange or 150
    }

    pl.modifiers = {
        movSpeed = 0,
        atkSpeed = 0,
        atkRange = 0
    }

    pl.decreeBehaviour = {
        perFrame = {},
        perTick = {},
        onAtk = {},
        onHit = {}
    }

    return pl
end


function Player:load(state, entity, weapon)
    self.state = state
    self.state = entity
    self.state = weapon
    self.animator = self.context.animation:new(self.opts)
end


function Player:calculate()
    self.movSpeed = self.base.movSpeed + self.modifiers.movSpeed
    self.atkSpeed = self.base.atkSpeed + self.modifiers.atkSpeed
    self.atkRange = self.base.atkRange + self.modifiers.atkRange
end


function Player:update(dt)

    self.animator:update(dt)
end


function Player:draw()
    love.graphics.draw(self.animator.sheet, self.animator:getQuad(), self.posX, self.posY)
end


Player.defaultOpts = {
    animator = {
        animType = "spriteAnimator",
        sheet = playerSprite,
        frameW = 64,
        frameH = 64,
        anims = {
            idle = {1, 2},
            walk = {2, 3},
            attack = {4}
        },
        startAnim = "idle",
        animSpeed = 0.5,
        loop = true
    },
    data = {
        health = 100,
        movSpeed = 300,
        hitboxSize = 32,
        defaultWeapon = nil,
        atkSpeed = 0.5,
        atkRange = 150
    },
    decreeBehaviour = {
        perFrame = {},
        perTick = {},
        onHit = {},
        onATK = {}
    }
}

return Player
