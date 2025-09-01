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

    prg.datasrc = opts.datasrc
    prg.datakey = opts.datakey

    prg.x = opts.x
    prg.y = opts.y
    prg.w = opts.w
    prg.h = opts.h
    prg.pad = 5
    prg.val = opts.val

    --TODO: Check to see if I need more than 1 image for this
    prg.img = opts.img
    return prg
end

function ProgressBar:update(dt)

    local liveValue = self.datasrc[self.datakey]
    self.val = (self.w / 100) * liveValue

end

function ProgressBar:draw()
    --the fill needs a custom color/shader
    love.graphics.rectangle("fill", self.x + self.pad, self.y + self.pad, self.val, self.h)
    love.graphics.rectangle("line", self.x + self.pad, self.y + self.pad, self.w, self.h)
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
    --TODO: add optional title
    love.graphics.printf(self.val, self.x, self.y, self.w, "center")
end


-- ==== DECREE Stack ==== --
-- Behaves as a container with "slots", key/value pairs
local Stack = {}
Stack.__index = Stack

function Stack:new(opts)
    local st = setmetatable({}, Stack)

    st.datasrc = opts.datasrc
    st.datakey = opts.datakey

    st.centx = opts.centx
    st.centy = opts.centy
    st.w = opts.w
    st.h = opts.h
    st.x = st.centx - (st.w * 0.5)
    st.y = st.centy - (st.h * 0.5)

    return st
end

function Stack:update(dt)
end

function Stack:draw()

    for i, decree in ipairs(self.datasrc[self.datakey]) do
        love.graphics.rectangle("fill", self.x + (36 * i), self.y, 32, 48)
    end
end


-- ==== DECREE PICKER ==== --
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
UITypes.stack = Stack
UITypes.decree = Decree  

return UITypes
