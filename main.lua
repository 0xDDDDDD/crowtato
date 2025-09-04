local UITypes = require("ui.uitypes")
local decrees = require("data.decrees")

local ui = {}
local state = {
    counter = 0,
    wave = 0, 
    health = 100,
    decrees = {},
    owned_decrees = {}
}

function love.load()

    --Set up decrees
        state.decrees = decrees

    --test healthbar
    local hbopts = {
        x = 50,
        y = 50,
        w = 200,
        h = 30,
        val = 100,
        col = {1.0, 1.0, 1.0, 1.0},
        crtCol = {0.9, 0.1, 0.1, 1.0},
        crtThreshold = 20,
        datasrc = state,
        datakey = "health"        
    }
    ui.healthbar =  UITypes.progressBar:new(hbopts)

    --test counter
    local ctropts = {
        x = 1200,
        y = 50,
        w = 200,
        h = 30,
        val = 0,
        font = "assets/fonts/Cartoon.ttf",
        size = 50,
        datasrc = state,
        datakey = "counter",
    }
    ui.counter = UITypes.counter:new(ctropts)


    --wave counter
    local wavopts = {
        x = love.graphics.getWidth() * 0.5,
        y = 50,
        w = 200,
        h = 30,
        val = 0,
        font = "assets/fonts/Cartoon.ttf",
        size = 50,
        datasrc = state,
        datakey = "wave",
        title = "wave"
    }
    ui.wavecounter = UITypes.counter:new(wavopts)

    --test stack
    local stopts = {
        centx = (love.graphics.getWidth() * 0.5),
        centy = (love.graphics.getHeight() * 0.9),
        w = 400,
        h = 96,
        datasrc = state,
        datakey = "owned_decrees"
    }
    ui.decreestack = UITypes.stack:new(stopts)

    --Test Decree Picker
    local dpopts = {
        centx = (love.graphics.getWidth() * 0.5),
        centy = (love.graphics.getHeight() * 0.5),
        w = 600,
        h = 400,
        choice = {},

        font = "assets/fonts/Cartoon.ttf",
        tsize = 25,
        size = 20,

        datasrc = state,
        datakey = "decrees"
    }
    ui.decreepicker = UITypes.decree:new(dpopts)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        state.counter = state.counter + 10
    elseif key == "h" and state.health >= 10 then
        state.health = state.health - 10
    elseif key == "d" then
        pick_decrees(get_random_decrees())
    elseif key == "w" then
        state.wave = state.wave + 1
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        table.insert(state.owned_decrees, ui.decreepicker:select(x, y))
    end
end

function love.update(dt)
    for i, item in pairs(ui) do
        item:update(dt)
    end
end

function love.draw()
    for i, item in pairs(ui) do
        item:draw()
    end
end

function pick_decrees(options)
    ui.decreepicker:show(options)
end

function get_random_decrees()

    local choices = {unpack(state.decrees)}

    --Fisher-Yates Shuffle
    for i = #choices, 2, -1 do
        local j = math.random(i)
        choices[i], choices[j] = choices[j], choices[i]
    end

    local choice = {}
    for i = 1, math.min(3, #choices) do
        table.insert(choice, choices[i])
    end

    return choice
end
