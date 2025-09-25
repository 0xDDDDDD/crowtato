local Render = {}
Render.__index = Render

function Render:new(context)
    rn = setmetatable({}, Render)

    rn.context = context

    rn.queue = {}

    return rn
end

--Consider re-ordering queue so Z doesn't need to be stored and instead infered from list order
function Render:add(item, z)
end

function Render:draw()
end

return Render
