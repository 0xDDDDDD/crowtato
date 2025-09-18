local Input = {}
Input.__index = Input

function Input:new(context)
    local input = setmetatable({}, Input)

    input.context = context

    input.actions = {
        movex = 0,
        movey = 0
    }

    input.mouse = {
        posX = 0,
        posY = 0,
        lmb = false
    }

    return input
end

function Input:update(raw)
end

function Input:get()
end

return Input
