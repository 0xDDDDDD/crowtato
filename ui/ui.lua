local UITypes = require("ui.uitypes")

local UI = {}
UI.__index = UI

function UI:new(context)
    local ui = {}
    setmetatable(ui, UI)

    ui.context = context or nil
    ui.elements = {}
    ui.imgCache = {}

    return ui
end

function UI:add(typeName, opts)
    local class = UITypes[typeName]
    if not class then
        error("Unknown UI type: " .. tostring(typeName))
    end
    table.insert(self.elements, class:new(opts))
end

function UI:get(id)
    for i, item in ipairs(self.elements) do
        if item.id == id then
            return item
        end
    end
end

function UI:update(dt)
    for i, item in ipairs(self.elements) do
        item:update(dt)
    end
end

function UI:draw()
    for i, item in ipairs(self.elements) do
        item:draw()
    end
end

return UI
