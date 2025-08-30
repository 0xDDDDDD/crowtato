local UITypes = {}
--datasrc/datakey are expected to be a table and key within it. 

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
    btn.image = love.graphics.newImage(opts.image)
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
    local prg = setmetatable({}, ProgressBar)
    prg.x = opts.x
    prg.y = opts.y
    prg.w = opts.w
    prg.h = opts.h
    prg.val = opts.val
    prg.prevVal = opts.val --used for tweening?

    --TODO: Check to see if I need more than 1 image for this
    prg.img = opts.img
    return prg
end

function ProgressBar:update(dt)
    --TODO: tween and update logic
end

function ProgressBar:draw()
end


-- ==== COUNTER ==== --
local Counter = {}
Counter.__index = Counter

function Counter:new(opts)
    local ctr = setmetatable({}, Counter)

    ctr.datasrc = opts.datasrc
    ctr.datakey = opts.datakey

    ctr.font = love.graphics.newFont(opts.font, opts.size)

    ctr.x = opts.x
    ctr.y = opts.y
    ctr.w = opts.w
    ctr.h = opts.h
    ctr.val = opts.val
    ctr._accum = opts.val * 1.0
    ctr.nextVal = opts.val

    return ctr
end

function Counter:update(dt)
    local liveValue = self.datasrc[self.datakey]
    if liveValue ~= self.nextVal then
        self.nextVal = liveValue
    end

    if self.val ~= self.nextVal then
        local smoothing = 5
        self._accum = self._accum + (self.nextVal - self._accum) * math.min(1, smoothing * dt)
        self.val = math.floor(self._accum + 0.5)
    end
end

function Counter:draw()
    if self.font then
        love.graphics.setFont(self.font)
    end
    love.graphics.printf(self.val, self.x, self.y, self.w, "center")
end


-- ==== ICON ==== --
local Icon = {}
Icon.__index = Icon

function Icon:new(opts)
    local ic = setmetatable(ic, Icon)
    ic.x = opts.x
    ic.y = opts.y
    ic.w = opts.w
    ic.h = opts.h
    ic.img = opts.img

    return ic
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
    local dc = setmetatable({}, Decree)
    dc.x = opts.x
    dc.y = opts.y
    dc.w = opts.w
    dc.h = opts.h
    return dc
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
