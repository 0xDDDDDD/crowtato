local Animation = require("core.animation")
local Player = require("entity.player")
local Enemy = require("entity.enemy")
local ETypes = require("entity.enemyTypes")


local Entity = {}
Entity.__index = Entity

function Entity:new(context)
    local ent = setmetatable({}, Entity)

    self.context = context

    ent.player = nil
    ent.enemies = {}
    ent.projectiles = {}

    return ent
end

function Entity:load()
--TODO: Set up the entity, potentially load the player here
    self:addPlayer()
    self:addEnemy("Maggot", {posX = 200, posY = 200})
end

function Entity:addPlayer()
    local anim = self.context.animation:add("player", Player.defaultOpts)
    self.player = Player:new(self, Player.defaultOpts, anim)
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
    for i = #self.enemies, 1, -1 do
        local e = self.enemies[i]
        e:update(dt, self.player.posX, self.player.posY) --TODO: get player position when necessary
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
end

return Entity
