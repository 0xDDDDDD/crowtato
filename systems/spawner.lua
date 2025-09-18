local Enemy = require("entity.enemy")
local Spawner = {}
Spawner.__index = Spawner

function Spawner:new(context, entity)
    local spawn = setmetatable({}, Spawner)

    spawn.context = context
    spawn.entity = entity

    spawn.currentWave = context.game.state.wave
    spawn.finished = true
    spawn.waveTimer = 0.0

    spawn.recipe = nil
    spawn.activeEvents = {}

    spawn.tgtx, spawn.tgty = 0, 0

    return spawn
end

function Spawner:load()
    self.recipe = {
        [1] = {
            {time = 3.0, type="Maggot", count = 30, interval = 1.0}
        },
        [2] = {
            {time = 3.0, type="Maggot", count = 40, interval = 1.0},
            {time = 15.0, type="Slime", count = 4, interval = 8.0}
        },
        [3] = {
            {time = 3.0, type="Maggot", count = 60, interval = 1.0},
            {time = 10.0, type="Slime", count = 15, interval = 5.0}
        }
    }

    math.randomseed(os.time())
end

function Spawner:update(dt)
    self.waveTimer = self.waveTimer + dt
    local waveIndex = self.context.game.state.wave
    local wave = self.recipe[waveIndex]

    if not wave then return end

    self.finished = false

    --Set the spawn targetter
    self.tgtx, self.tgty = self.getSpawnBand() 

    for _, event in ipairs(wave) do
        if not event.active and self.waveTimer >= event.time then
            event.active = true
            event.spawnTimer = 0
            event.remaining = event.count
        end

        if event.active and event.remaining > 0 then
            event.spawnTimer = event.spawnTimer + dt
            while event.spawnTimer >= event.interval and event.remaining > 0 do
                self.tgtx, self.tgty = self.getSpawnBand() 
                event.remaining = event.remaining - 1
                event.spawnTimer = event.spawnTimer - event.interval
                self:spawn(event.type)
            end
        end
    end

    local waveFinished = true
    for _, event in ipairs(wave) do
        if not event.active or (event.remaining and event.remaining > 0) then
            waveFinished = false
            break
        end
    end

    if waveFinished then
        self.waveTimer = 0
        self.finished = true
    end
end


function Spawner:spawn(enemyType)
    pos = {
        posX = self.tgtx,
        posY = self.tgty
    }
    self.entity:addEnemy(enemyType, pos)
end

function Spawner:getSpawnBand()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local gap = 100
    local band = 100

    local bands = {
        {-gap - band, -gap, 0, h,},
        {w + gap, w + gap + band, 0, h},
        {0, w, -gap - band, -gap},
        {0, w, h + gap, h + gap + band}
    }

    local bandIndex = math.random(#bands)
    local b = bands[bandIndex]

    local x = math.random(b[1], b[2])
    local y = math.random(b[3], b[4])
    return x, y
end

return Spawner
