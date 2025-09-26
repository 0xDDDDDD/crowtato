local Render = {}
Render.__index = Render

function Render:new(context)
    rn = setmetatable({}, Render)

    rn.context = context

    rn.envQueue = {}
    rn.chrQueue = {}
    rn.fxQueue = {}
    rn.uiQueue = {}
    return rn
end

function Render:add(item, queueName)
    assert(type(item.draw) == "function", "Item must implement draw()")
    assert(self[queueName], "Invalid queue: " .. tostring(queueName))
    table.insert(self[queueName], item)
end

function Render:draw()
    for _, item in ipairs(self.envQueue) do item:draw() end
    for _, item in ipairs(self.chrQueue) do item:draw() end
    for _, item in ipairs(self.fxQueue)  do item:draw() end
    for _, item in ipairs(self.uiQueue)  do item:draw() end
end

return Render
