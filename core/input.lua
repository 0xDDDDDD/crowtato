local Input = {}
Input.__index = Input

function Input:new(context)
    local input = setmetatable({}, Input)

    input.context = context

    input.actions = {
        moveX = 0,
        moveY = 0
    }

    input.mouse = {
        posX = 0,
        posY = 0,
        lmb = false
    }

    return input
end

function Input:update()

    self.actions.moveX  = (love.keyboard.isDown("d") and 1 or 0)
                        - (love.keyboard.isDown("a") and 1 or 0)
    self.actions.moveY  = (love.keyboard.isDown("s") and 1 or 0)
                        - (love.keyboard.isDown("w") and 1 or 0)

    self.mouse.posX, self.mouse.posY = love.mouse.getPosition()
    self.mouse.lmb = love.mouse.isDown(1)
end

function Input:get()
end

return Input
