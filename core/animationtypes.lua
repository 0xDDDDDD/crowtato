--Crowtato v0.5

AnimTypes = {}

-- ==== Sprite Animator ==== --
local SpriteAnimator = {}
SpriteAnimator.__index = SpriteAnimator

function SpriteAnimator:new(opts)
    local spr = setmetatable({}, SpriteAnimator)

    --Sprite Sheet
    spr.sheet           = opts.sheet
    spr.frameW          = opts.frameW
    spr.frameH          = opts.frameH
    spr.quads           = spr:_sliceSheet()

    --Animation
    spr.anims           = opts.anims or {default = {1}}
    spr.currentAnim     = opts.startAnim or next(spr.anims)
    spr.frames          = spr.anims[spr.currentAnim]
    spr.currentFrame    = 1

    --Settings/Data
    spr.animSpeed       = opts.animSpeed or 0.1
    spr.loop            = opts.loop ~= false
    spr.loopDelay       = opts.loopDelay or 0.0
    spr.timer           = 0
    spr.playing         = true
    spr.finished        = false

    return spr
end

function SpriteAnimator:_sliceSheet()
    local quads = {}
    local sheetW, sheetH = self.sheet:getDimensions()

    for y = 0, sheetH - self.frameH, self.frameH do
        for x = 0, sheetW - self.frameW, self.frameW do
            table.insert(quads, love.graphics.newQuad(x, y, self.frameW, self.frameH, sheetW, sheetH))
        end
    end
    return quads
end

function SpriteAnimator:setAnimation(name, reset)

    assert(self.anims[name], ("Animation '%s' not found"):format(name))

    if name ~= self.currentAnim or reset then
        self.currentAnim = name
        self.frames = self.anims[name]
        self.currentFrame = 1
        self.timer = 0
        self.playing = true
    end
end

function SpriteAnimator:playOnce(anim)
    self:setAnimation(anim, true)
    self.loop = false
    self.playing = true
    self.finished = false
    self.currentFrame = 1
    self.timer = 0
end

function SpriteAnimator:update(dt)

    if not self.playing then return end

    self.timer = self.timer + dt

    if self.timer >= self.animSpeed then
        self.timer = self.timer - self.animSpeed
        self.currentFrame = self.currentFrame + 1

        if self.currentFrame > #self.frames then
            if self.loop then
                self.currentFrame = 1
                self.finished = false
            else
                self.currentFrame = #self.frames
                self.playing = false
                self.finished = true
            end
        end
    end
end

function SpriteAnimator:getQuad()
    local frameIndex = self.frames[self.currentFrame]
    return frameIndex and self.quads[frameIndex] or nil
end


-- ==== Tween Queue ==== --

local TweenQueue = {}
TweenQueue.__index = TweenQueue

function TweenQueue:new(opts)
    return setmetatable({ tweens = {}}, TweenQueue)
end

function TweenQueue:add(tween)
    table.insert(self.tweens, tween)
end

function TweenQueue:update(dt)
    for i = #self.tweens, 1, -1 do
        local tw = self.tweens[i]
        tw:update(dt)
        if tw.finished then table.remove(self.tweens, i) end
    end
end

-- === Tween ==== --

local Tween = {}
Tween.__index = Tween

function Tween:new(target, key, from, to, duration, easing, elapsed)
    tw = setmetatable({}, Tween)

    tw.target = target
    tw.key = key
    tw.from = from
    tw.to = to
    tw.duration = duration
    tw.easing = easing or function(t) return t end
    tw.elapsed = elapsed or 0
    tw.finished = false

    return tw
end

function Tween:update(dt)
    if self.finished then return end
    self.elapsed = self.elapsed + dt

    local t = math.min(self.elapsed / self.duration, 1)
    local eased = self.easing(t)
    self.target[self.key] = self.from + (self.to - self.from) * eased
    
    if t >= 1 then
        self.finished = true
    end
end

AnimTypes.spriteAnimator = SpriteAnimator
AnimTypes.tweenQueue = TweenQueue
AnimTypes.tween = Tween

return AnimTypes
