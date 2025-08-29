local UITypes = require("ui.uitypes")

local UI = {}
UI.__index = UI

function UI:new(context)
    local ui = {}
    setmetatable(ui, UI)

    ui.context = context
    ui.elements = {}

    return ui
end

function UI:add(typeName, opts)
    local ctor = UITypes[typeName]
    assert(ctor, "Unknown UI type: " .. tostring(typeName))
    table.insert(self.elements, ctor:new(opts))
end

function UI:update(dt)
    for _, e in ipairs(self.elements) do
        if e.update then e:update(dt) end
    end
end

function UI:draw()
    for _, e in ipairs(self.elements) do
        if e.draw then e:draw() end
    end
end

return UI
