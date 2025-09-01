local UITypes = require("ui.uitypes")

local ui = {}
local state = {
    counter = 0, 
    health = 100,
    decrees = {
        {
            name = "fireatk",
            tooltip = "adds fire to attack",
            icon = "assets/img/decrees/test_01.png"
        },
        {
            name = "iceatk",
            tooltip = "adds ice to attack",
            icon = "assets/img/decrees/test_02.png"
        },
            {
            name = "double edge",
            tooltip = "every attack hits twice",
            icon = "assets/img/decrees/test_03.png"
        },
            {
            name = "move fast",
            tooltip = "move speed + 20%",
            icon = "assets/img/decrees/test_04.png"
        },
            {
            name = "iframe",
            tooltip = "taking hit gives twice as many ice frames",
            icon = "assets/img/decrees/test_05.png"
        },
            {
            name = "double death",
            tooltip = "lethal damage has a chance to restore health instead",
            icon = "assets/img/decrees/test_01.png"
        }
    }
}

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

    --test stack
    local stopts = {
        centx = (love.graphics.getWidth() * 0.5),
        centy = (love.graphics.getHeight() * 0.9),
        w = 400,
        h = 32,
        datasrc = state,
        datakey = "decrees"
    }
    table.insert(ui, UITypes.stack:new(stopts))
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
