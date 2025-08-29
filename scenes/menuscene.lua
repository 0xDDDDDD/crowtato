local UI = require("ui.ui")

local MenuScene = {}
MenuScene.__index = MenuScene

function MenuScene:new(context)
    local ms = {}
    setmetatable(ms, MenuScene)

    self.context = context

    return ms
end

--Maybe i should move this to a json file? unsure
function MenuScene:initialize_UI()
    self.ui = UI:new()
    self.ui:add("button", {
        x = 100, y = 100, w = 120, h = 40,
        text = "play",
        onClick = function() SceneManager.switch() end
    })
    context.render.add_to_queue(self.ui)
end

function MenuScene:update()
    self.ui:updateAll(dt)
end

return MenuScene
