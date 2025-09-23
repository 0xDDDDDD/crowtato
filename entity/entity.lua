local Animation = require("core.animation")
local Player = require("entity.player")
local Weapon = require("entity.weapon")
local WTypes = require("entity.weaponTypes")
local Enemy = require("entity.enemy")
local ETypes = require("entity.enemyTypes")
local Spawner = require("systems.spawner")


local Entity = {}
Entity.__index = Entity

function Entity:new(context)
    local ent = setmetatable({}, Entity)

    self.context = context
    self.spawner = nil

    ent.player = nil
    ent.enemies = {}
    ent.projectiles = {}

    return ent
end

function Entity:load()
    self.spawner = Spawner:new(self.context, self)
    self.spawner:load()
    self:addPlayer()
    self:addWeapon("Claws")
end

function Entity:addPlayer()
    local anim = self.context.animation:add("player", Player.defaultOpts)
    self.player = Player:new(self.context, self, Player.defaultOpts, anim)
end

function Entity:addWeapon(weaponType)
    local opts = WTypes[weaponType]
    assert(opts, "Unknown weapon type: " .. tostring(weaponType))
    local anim = self.context.animation:add("weapon", opts)
    local weapon = Weapon:new(anim, self.player, self, opts)
    self.weapon = weapon
    self.player:equip(weapon)
end


function Entity:addEnemy(typeName, overrides)
    local base = ETypes[typeName]
    assert(base, "Unknown enemy type: " .. tostring(typeName))

    local opts = {}
    for k,v in pairs(base) do opts[k] = v end
    for k,v in pairs(overrides or {}) do opts[k] = v end

    local animator = self.context.animation:add("enemy", opts)

    local enemy = Enemy:new(self, opts, animator)
    table.insert(self.enemies, enemy)
    return enemy
end

function Entity:update(dt, px, py)
    self.player:update(dt)
    self.weapon:update(dt)

    self.spawner:update(dt)

    for i = #self.enemies, 1, -1 do
        local e = self.enemies[i]
        e:update(dt, self.player.posX, self.player.posY)
        if e.dead then
            table.remove(self.enemies, i)
        end
    end
end

function Entity:draw()
    self.player:draw()
    for _, e in ipairs(self.enemies) do
        e:draw(self.player.posX)
    end
    if self.weapon then
        self.weapon:draw()
    end
end

function Entity:nearestEnemy(x, y)
    local nearest = nil
    local nearestDistSq = math.huge

    for _, enemy in ipairs(self.enemies) do
        local dx = enemy.posX - x
        local dy = enemy.posY - y

        local distSq = dx * dx + dy * dy

        if distSq < nearestDistSq then
            nearestDistSq = distSq
            nearest = enemy
        end
    end

    if nearest then
        return nearest, math.sqrt(nearestDistSq)
    else
        return nil, nil
    end
end

function Entity:processHit(data)
    for i = #self.enemies, 1, -1 do
        local enemy = self.enemies[i]

        if data:containsPoint(enemy.posX, enemy.posY) then
            enemy.health = enemy.health - data.damage
            if enemy.health <= 0 then
                table.remove(self.enemies, i)
            end
        end
    end
end

return Entity
