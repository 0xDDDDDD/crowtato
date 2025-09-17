local Input = {}
Input.__index = Input

function Input:new(context)
    local input = setmetatable({}, Input)

    input.context = context

    return input
end
