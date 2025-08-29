local UITypes = {}

-- ==== BUTTON ==== --
local TextButton = {}
TextButton.__index = TextButton

function TextButton:new(opts)
    local btn = setmetatable({}, TextButton)
    btn.x = opts.x
    btn.y = opts.y
    btn.w = opts.w
    btn.h = opts.h
    btn.text = opts.text or ""
    btn.onClick = opts.onClick or function() end
    btn.wasPressed = false
    return btn
end

function TextButton:update(dt)
    local mx, my = love.mouse.getPosition()
    local pressed = love.mouse.isDown(1)

    if pressed and not self.wasPressed
    and mx >= self.x and mx <= self.x + self.w
    and my >= self.y and my <= self.y + self.h then
        self.onClick()
    end

    self.wasPressed = pressed
end

function TextButton:draw()
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.print(self.text, self.x + (self.w * 0.25), self.y + (self.h * 0.25))
end


-- ==== IMAGE BUTTON ==== --
local ImageButton = {}
ImageButton.__index = ImageButton

function ImageButton:new(opts)
    local btn = setmetatable({}, ImageButton)
    btn.x = opts.x
    btn.y = opts.y
    btn.w = opts.w
    btn.h = opts.h
    btn.image = opts.image
    btn.onClick = opts.onClick or function() end
    btn.wasPressed = false
    return btn
end

function ImageButton:update(dt)
    local mx, my = love.mouse.getPosition()
    local pressed = love.mouse.isDown(1)

    if pressed and not self.wasPressed
    and mx >= self.x and mx <= self.x + self.w
    and my >= self.y and my <= self.y + self.h then
        self.onClick()
    end

    self.wasPressed = pressed
end

--TODO: replace this with image logic later
function ImageButton:draw()
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.print(self.text, self.x + (self.w * 0.25), self.y + (self.h * 0.25))
end


-- ==== PROGRESS BAR ==== --
local ProgressBar = {}
ProgressBar.__index = ProgressBar

function ProgressBar:new(opts)
end

function ProgressBar:update(dt)
end

function ProgressBar:draw()
end


-- ==== COUNTER ==== --
local Counter = {}
Counter.__index = Counter

function Counter:new(opts)
end

function Counter:update(dt)
end

function Counter:draw()
end


-- ==== ICON ==== --
local Icon = {}
Icon.__index = Icon

function Icon:new(opts)
end

function Icon:update(dt)
end

function Icon:draw()
end


-- ==== DECREE ==== --
--Different from icon because it will have its own shader
local Decree = {}
Decree.__index = Decree

function Decree:new(opts)
end

function Decree:update(dt)
end

function Decree:draw()
end

UITypes.textButton = TextButton
UITypes.imageButton = ImageButton
UITypes.progressBar = ProgressBar 
UITypes.counter = Counter 
UITypes.icon = Icon
UITypes.decree = Decree  

return UITypes
