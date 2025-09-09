
-- Animation Types
AnimTypes = {}


-- ==== STATE MACHINE ==== --
local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine:new(opts)
end

function StateMachine:update(dt)
end

function StateMachine:setState(state)
end

function StateMachine:draw()
end


-- ==== Sprite Animator ==== --
local SpriteAnimator = {}
SpriteAnimator.__index = SpriteAnimator

function SpriteAnimator:new(opts)
    local spr = setmetatable({}, SpriteAnimator)

    --Sprite Sheet
    spr.sheet = opts.sheet
    spr.frameW = opts.frameW
    spr.frameH = opts.frameH
    spr.quads = spr:sliceSheet()

    --Animation
    spr.anims = opts.anims or {default = {1}}
    spr.currentAnim = opts.startAnim or next(spr.anims)
    spr.frames = spr.anims[spr.currentAnim]
    spr.currentFrame = 1

    --Settings/Data
    spr.speed = opts.speed or 0.1
    spr.loop = opts.loop ~= false
    spr.timer = 0
    spr.playing = true

    return spr
end

function SpriteAnimator:sliceSheet()
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
    if self.anims[name] then

        if name ~= self.currentAnim then reset = true end

        self.currentAnim = name
        self.frames = self.anims[name]

        if reset then
            self.currentFrame = 1
            self.timer = 0
            self.playing = true
        end
    end
end

function SpriteAnimator:update(dt)

    if not self.playing or not self.frames or #self.frames == 0 then return end

    self.timer = self.timer + dt

    if self.timer >= self.speed then
        self.timer = self.timer - self.speed
        self.currentFrame = self.currentFrame + 1

        if self.currentFrame > #self.frames then
            if self.loop then
                self.currentFrame = 1
            else
                self.currentFrame = #self.frames
                self.playing = false
            end
        end
    end
end

function SpriteAnimator:getQuad()
    return self.quads[self.frames[self.currentFrame]]
end


-- ==== Tween Queue ==== --

local TweenQueue = {}
TweenQueue.__index = TweenQueue

function TweenQueue:new(opts)
end

function TweenQueue:update(dt)
end

function TweenQueue:draw()
end


-- === Tween ==== --

local Tween = {}
Tween.__index = Tween

function Tween:new(target, key, from, to, easing, elapsed)
    tw = setmetatable({}, Tween)

    tw.target = target
    tw.key = key
    tw.from = from
    tw.to = to
    tw.easing = easing
    tw.elapsed = elapsed

    return tw
end


AnimTypes.stateMachine = StateMachine
AnimTypes.spriteAnimator = SpriteAnimator
AnimTypes.tweenQueue = TweenQueue
AnimTypes.tween = Tween

return AnimTypes
