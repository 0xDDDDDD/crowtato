local AnimTypes = require("core.animationtypes")

local Animation = {}
Animation.__index = Animation

function Animation:new(context)
    local anim = setmetatable({}, Animation)

    anim.player = nil
    
    anim.enemies = {}
    anim.projectiles = {}

    return anim
end

function Animation:add(typeName, opts)
    local class = AnimTypes[opts.type]
    if not class then error("Unknown type: " .. tostring(typeName)) end

    local comp = class:new(opts)
    
    if category == "player" then
        self.player = comp
    elseif category == "enemy" then
        table.insert(self.enemies, comp)
    elseif category == "projectile" then
        table.insert(self.projectiles, comp)
    else
        table.insert(self.misc, comp)
    end

    return comp
end


function Animation:update(dt)
    self.player:update(dt)

    for i = #self.enemies, 1, -1 do
        local enemy = self.enemies[i]
        enemy:update(dt)
        if enemy.dead then --Refactor potentially since death may not be stored directly on enemy
            table.remove(self.enemies, i)
        end
    end

    for projectile in ipairs(self.projectiles) do
        projectile:update(dt)
    end
end

return Animation
