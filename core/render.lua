local Render = {}
Render.__index = Render
Render.instance = nil

function Render:new(context)
    if Render.instance then
        return Render.instance
    end

    local r = {}
    setmetatable(r, Render)

    r.context = context
    r.renderQueue = {}

    return r
end

function Render:add_to_queue(item)
    table.insert(item, self.renderQueue)
end

function Render:draw()
    --Need to separate background, scene contents, FX and UI
    for i = 1, #self.renderQueue do
        self.renderQueue[i].draw()
    end
end

return Render
