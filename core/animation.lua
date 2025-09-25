local AnimTypes = require("core.animationtypes")

local Animation = {}
Animation.__index = Animation

function Animation:new(context)
    local anim = setmetatable({}, Animation)

    anim.context = context

    anim.hosted = {}

    return anim
end

function Animation:create(opts)
    local class = AnimTypes[opts.animType]
    assert(class, "Unknown animType: " .. tostring(opts.animType))
    return class:new(opts)
end

function Animation:createHosted(opts)
    local anim = self:create(opts)
    table.insert(self.hosted, anim)
end

function Animation:update(dt)
    for i = #self.hosted, 1, -1 do
        local anim = self.hosted[i]
        anim:update(dt)
        if anim.finished then
            table.remove(self.hosted, i)
        end
    end
end

return Animation
