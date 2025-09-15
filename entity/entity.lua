local Animation = require("core.animation")
local Player = require("entity.player")
local Enemy = require("entity.enemy")
local ETypes = require("entity.enemyTypes")


local Entity = {}
Entity.__index = Entity

function Entity:new(context)
    local ent = setmetatable({}, Entity)

    ent.player = nil
    ent.enemies = {}
    ent.projectiles = {}

    return ent
end

function Entity:load()
--TODO: Set up the entity, potentially load the player here
end

function Entity:add(opts)
--TODO: same workings as the UI add function
end

function Entity:update(dt, px, py)
end

function Entity:draw()
end

return Entity
