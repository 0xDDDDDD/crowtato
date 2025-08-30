local UITypes = require("ui.uitypes")

local ui = {}
local state = {counter = 0}

function love.load()

    --test healthbar
    local hbopts = {
        
    }

    --test counter
    local ctropts = {
        x = 1100,
        y = 50,
        w = 200,
        h = 30,
        val = 0,
        font = "assets/fonts/Cartoon.ttf",
        size = 50,
        datasrc = state,
        datakey = "counter"
    }
    table.insert(ui, UITypes.counter:new(ctropts))
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        state.counter = state.counter + 10
    end
    print("state counter = ", state.counter)
end

function love.update(dt)
    for i, item in ipairs(ui) do
        item:update(dt)
    end
end

function love.draw()
    for i, item in ipairs(ui) do
        item:draw()
    end
end
