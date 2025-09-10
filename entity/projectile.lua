local Projectile = {}
Projectile.__index = Projectile

function Projectile:new()
    prj = setmetatable({}, Projectile)

    
    return prj
end

return Projectile
