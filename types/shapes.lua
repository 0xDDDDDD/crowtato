local Shapes = {}

function Shapes.obb(cx, cy, hw, hh, angle)
    local shape = {
        shape = "obb",
        cx = cx,
        cy = cy,
        hw = hw,
        hh = hh,
        angle = angle
    }

    function shape:containsPoint(px, py)

        local dx = px - self.cx
        local dy = py - self.cy

        local cosA = math.cos(-self.angle)
        local sinA = math.sin(-self.angle)
        local localX = dx * cosA - dy * sinA
        local localY = dx * sinA + dy * cosA

        return math.abs(localX) <= self.hw and math.abs(localY) <= self.hh
    end

    return shape
end

function Shapes.capsule(x1, y1, x2, y2, radius)
    return {
        shape = "capsule",
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2,
        radius
    }
end

return Shapes
