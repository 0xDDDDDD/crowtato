local UITypes = require("ui.uitypes")

local ui = {}
local state = {counter = 0, health = 100}

function love.load()

    --test healthbar
    local hbopts = {
        x = 100,
        y = 50,
        w = 200,
        h = 30,
        val = 100,
        col = {0.9, 0.0, 0.0},
        datasrc = state,
        datakey = "health"        
    }
    table.insert(ui, UITypes.progressBar:new(hbopts))

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
    elseif key == "h" and state.health >= 10 then
        state.health = state.health - 10
    end
    print("\nstate counter = ", state.counter)
    print("\nhealth = ", state.health)
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
