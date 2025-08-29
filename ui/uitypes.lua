local UITypes = {}

UITypes.button = function(opts)
    --construct button
    local btn = {
        x = opts.x, y = opts.y,
        w = opts.w, h = opts.y,
        text = opts.text or "",
        onClick = opts.onClick or function() end
    }

    --Click detection
    function btn:update(dt)
        local mx, my = love.mouse.getPosition()

        if love.mouse.isDown(1) 
        and mx >= self.x and mx <= self.x + self.w
        and my >= self.y and my <= self.y + self.h then
            self.onClick()
        end
    end

    function btn:draw()
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
        love.graphics.print(self.text, self.x + (self.w * 0.25), self.y + (self.y * 0.25))
    end

    return btn
end

return UITypes
