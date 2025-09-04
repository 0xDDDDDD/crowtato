local UITypes = require("ui.uitypes")

-- Simplification layer for creating and managing the UI

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

end

function UI:update(dt)

end

function UI:draw()

end

return UI
