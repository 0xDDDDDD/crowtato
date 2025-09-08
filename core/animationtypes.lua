
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
end

function SpriteAnimator:update(dt)
end

function SpriteAnimator:draw()
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

Tween = {
    target = nil,
    key = nil,
    from = nil,
    to = nil,
    easing = nil,
    elapsed = nil
}


AnimTypes.stateMachine = StateMachine
AnimTypes.spriteAnimator = SpriteAnimator
AnimTypes.tweenQueue = TweenQueue
AnimTypes.tween = Tween

return AnimTypes
