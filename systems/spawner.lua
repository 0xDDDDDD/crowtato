local Spawner = {}
Spawner.__index = Spawner

function Spawner:new(context)
    local spawn = setmetatable({}, Spawner)

    spawn.context = context

    spawn.currentWave = context.game.waveCounter
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
            {time = 3.0, type="typeA", count = 30, interval = 1.0}
        },
        [2] = {
            {time = 3.0, type="typeA", count = 40, interval = 1.0},
            {time = 15.0, type="typeB", count = 4, interval = 8.0}
        },
        [3] = {
            {time = 3.0, type="typeA", count = 60, interval = 1.0},
            {time = 10.0, type="typeB", count = 15, interval = 5.0}
        }
    }

    math.randomseed(os.time())
end

function Spawner:update(dt)
    self.waveTimer = self.waveTimer + dt
    local waveIndex = self.context.game.waveCounter
    local wave = self.recipe[waveIndex]
    if not wave then return end

    self.finished = false

    for _, event in ipairs(wave) do
        if not event.active and self.waveTimer >= event.time then
            event.active = true
            event.spawnTimer = 0
            event.remaining = event.count
        end

        if event.active and event.remaining > 0 then
            event.spawnTimer = event.spawnTimer + dt
            while event.spawnTimer >= event.interval and event.remaining > 0 do
                self:spawn(event.type)
                event.remaining = event.remaining - 1
                event.spawnTimer = event.spawnTimer - event.interval
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


function Spawner:spawn(eventType)
    
end
