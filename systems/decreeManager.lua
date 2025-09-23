local decreeManager = {}
decreeManager.__index = decreeManager

function decreeManager:new(context)
    dm = setmetatable({}, decreeManager)

    dm.context = context

    decrees = {}
end

function decreeManager:addDecree(decree)
end

return decreeManager
