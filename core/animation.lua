--Crowtato v0.5

local AnimTypes = require("core.animationtypes")

local Animation = {}
Animation.__index = Animation

function Animation:new(context)
    local anim = setmetatable({}, Animation)

    anim.context = context

    --Data
    anim.sprites = {}
    anim.hosted = {}

    --State
    anim.timeScale = 1
    anim.paused = false

    return anim
end

function Animation:create(opts)
    local type = AnimTypes[opts.animType]
    assert(type, "Unknown animType: " .. tostring(opts.animType))
    return type:new(opts)
end

function Animation:createHosted(opts)
    local anim = self:create(opts)
    table.insert(self.hosted, anim)
end

function Animation:update(dt)

    if self.paused then return end

    for i = #self.hosted, 1, -1 do
        local anim = self.hosted[i]
        anim:update(dt)
        if anim.finished then
            table.remove(self.hosted, i)
        end
    end
end

return Animation
