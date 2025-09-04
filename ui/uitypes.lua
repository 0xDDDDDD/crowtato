local UITypes = {} 

-- ==== BUTTON ==== --
local TextButton = {}
TextButton.__index = TextButton

function TextButton:new(opts)
    local btn = setmetatable({}, TextButton)

    btn.id = opts.id

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

    btn.id = opts.id

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
    love.graphics.draw(self.image, self.x, self.y, self.w, self.h)
    love.graphics.print(self.text, self.x + (self.w * 0.25), self.y + (self.h * 0.25))
end


-- ==== PROGRESS BAR ==== --
local ProgressBar = {}
ProgressBar.__index = ProgressBar

function ProgressBar:new(opts)
    local prg = setmetatable({}, ProgressBar)
    prg.datasrc = opts.datasrc
    prg.datakey = opts.datakey

    prg.id = opts.id

    prg.x = opts.x
    prg.y = opts.y
    prg.w = opts.w
    prg.h = opts.h
    prg.pad = opts.pad or 5
    prg.val = opts.val or 0

    prg.col = opts.col or {1, 1, 1, 1}

    prg.crtThreshold = opts.crtThreshold or 0
    prg.crtCol = opts.crtCol or nil

    prg.min = opts.min or 0
    prg.max = opts.max or 100

    return prg
end

function ProgressBar:update(dt)
    local liveValue = self.datasrc[self.datakey] or 0
    local range = self.max - self.min
    local normalized = 0

    if range > 0 then
        normalized = (liveValue - self.min) / range
        normalized = math.max(0, math.min(1, normalized))
    end

    self.val = self.w * normalized
end


function ProgressBar:draw()

    if self.crtCol and self.datasrc[self.datakey] <= self.crtThreshold then
        love.graphics.setColor(self.crtCol)
    else
        love.graphics.setColor(self.col)
    end
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

    ctr.id = opts.id

    ctr.font = love.graphics.newFont(opts.font, opts.size)
    ctr.titleFont = love.graphics.newFont(opts.font, (opts.size * 0.5))

    ctr.x = opts.x - (opts.w * 0.5)
    ctr.y = opts.y
    ctr.w = opts.w
    ctr.h = opts.h

    ctr.title = opts.title or nil

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
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    if self.title then
        love.graphics.setFont(self.titleFont)
        love.graphics.printf(self.title, self.x, self.y - 20, self.w, "center")
    end
    if self.font then
        love.graphics.setFont(self.font)
    end
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

    st.id = opts.id

    st.centx = opts.centx
    st.centy = opts.centy
    st.w = opts.w
    st.h = opts.h
    st.x = st.centx - (st.w * 0.5)
    st.y = st.centy - (st.h * 0.5)

    st.cardw = 64
    st.cardh = 96
    st.pad = 8

    st.collision = {}

    return st
end

function Stack:update(dt) -- Read from the context.input.mouse.xy and display tooltip if collision hit
end

function Stack:set_collision() --TODO:  set the collision and update each time a decree is added

end

function Stack:draw()
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    local decrees = self.datasrc[self.datakey]
    local count = #decrees

    local totalWidth = (self.cardw * count) + (self.pad * (count - 1))

    local leftX = self.centx - totalWidth / 2
    local cardY = self.centy - (self.cardh / 2)

    for i, decree in ipairs(decrees) do
        local cardX = leftX + (self.cardw + self.pad) * (i - 1)

        local icon = decree.icon
        if icon then
            local iw, ih = icon:getWidth(), icon:getHeight()
            local cx = cardX + self.cardw / 2
            local cy = cardY + self.cardh / 2
            local scale = math.min(self.cardw / iw, self.cardh / ih)
            love.graphics.draw(icon, cx, cy, 0, scale, scale, iw / 2, ih / 2)
        end
    end
end

-- ==== DECREE PICKER ==== --
local Decree = {}
Decree.__index = Decree

function Decree:new(opts)
    local dc = setmetatable({}, Decree)

    dc.datasrc = opts.datasrc
    dc.datakey = opts.datakey

    dc.id = opts.id

    dc.titleFont = love.graphics.newFont(opts.font, opts.tsize)
    dc.font = love.graphics.newFont(opts.font, opts.size)

    dc.x = opts.centx - (opts.w * 0.5)
    dc.y = opts.centy - (opts.h * 0.5)
    dc.w = opts.w
    dc.h = opts.h
    dc.visible = false

    dc.options = {}
    dc.columnw = opts.w / 3
    dc.cardw = 64 * 2
    dc.cardh = 96 * 2

    return dc
end

function Decree:show(options)
    self.options = options
    self.displayList = self:buildDisplayList(options)
    self.visible = true
end

function Decree:hide()
    self.visible = false
end

function Decree:select(mx, my)
    if not self.visible then return nil end

    for i, item in ipairs(self.displayList) do
        local hb = item.hitbox
        if mx >= hb.l and mx <= hb.r and my >= hb.t and my <= hb.b then
            self:hide()
            return item
        end
    end
    return nil
end

function Decree:buildDisplayList(options)
    local list = {}
    local numCols = 3
    local colSpacing = self.w / numCols

    for i, opt in ipairs(options) do

        local cx = self.x + (colSpacing * (i - 0.5))
        local imgX = cx - (self.cardw / 2)
        local imgY = self.y + 20

        list[i] = {
            icon      = opt.icon,
            name      = opt.name,
            tooltip   = opt.tooltip,
            hitbox    = {l = imgX, r = imgX + self.cardw, t = imgY, b = imgY + self.cardh}
        }
    end

    return list
end

function Decree:update(dt)
end

function Decree:draw()
    if not self.visible then return end

    love.graphics.setColor(0.0, 0.9, 0.2, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 20, 20)

    love.graphics.setColor(1, 1, 1, 1)

    for _, item in ipairs(self.displayList) do

        love.graphics.draw(item.icon,
            item.hitbox.l,
            item.hitbox.t,
            0,
            self.cardw / item.icon:getWidth(),
            self.cardh / item.icon:getHeight()
        )

        love.graphics.setFont(self.titleFont)
        local titleY = item.hitbox.t + self.cardh + 5
        love.graphics.printf(item.name, item.hitbox.l, titleY, (self.cardw * 1.1), "center")

        love.graphics.setFont(self.font)
        local descY = titleY + self.font:getHeight() + 40
        love.graphics.printf(item.tooltip, item.hitbox.l, descY, (self.cardw * 1.1), "center")
    end
end

UITypes.textButton = TextButton
UITypes.imageButton = ImageButton
UITypes.progressBar = ProgressBar 
UITypes.counter = Counter 
UITypes.stack = Stack
UITypes.decreePicker = Decree  

return UITypes
