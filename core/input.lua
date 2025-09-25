local Input = {}
Input.__index = Input

function Input:new(context)
    local input = setmetatable({}, Input)

    input.context = context

    input.actions = {
        moveX = 0,
        moveY = 0,
        pressed = {}
    }

    input.mouse = {
        posX = 0,
        posY = 0,
        lmb = false
    }

    input.prev = {}

    return input
end

function Input:update()

    --movement input
    self.actions.moveX  = (love.keyboard.isDown("d") and 1 or 0)
                        - (love.keyboard.isDown("a") and 1 or 0)
    self.actions.moveY  = (love.keyboard.isDown("s") and 1 or 0)
                        - (love.keyboard.isDown("w") and 1 or 0)

    --Mouse input
    self.mouse.posX, self.mouse.posY = love.mouse.getPosition()
    self.mouse.lmb = love.mouse.isDown(1)


    --Discrete input
    self.actions.pressed = {}
    for _, key in ipairs({"space", "escape"}) do
        local isDown = love.keyboard.isDown(key)
        if isDown and not self.prev[key] then
            table.insert(self.actions.pressed, key)
        end
        self.prev[key] = isDown
    end
end


function Input:get(key)
    if key then
        return self.actions[key] or self.mouse[key]
    end

    return {
        actions = {moveX = self.actions.moveX, moveY = self.actions.moveY},
        mouse = {posX = self.mouse.posX, posY = self.mouse.posY, lmb = self.mouse.lmb}
    }
end

return Input
