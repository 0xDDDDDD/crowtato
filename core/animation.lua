local Animation = {}
Animation.__index = Animation

function Animation:new(context)
    local anim = setmetatable({}, Animation)



    return anim
end

function Animation:update(dt)

end
