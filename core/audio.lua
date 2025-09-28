local Audio = {}
Audio.__index = Audio

function Audio:new(context)
    au = setmetatable({}, Audio)

    au.context = context
    au.musicSrc = nil
    au.filterState = {
        active = false,
        timer = 0,
        duration = 2.0,
        targetGainHF = 1.0,
        startGainHF = 1.0
    }

    --cache
    au.musicCache = {}
    au.sfxCache = {}

    --active sources
    au.activeMusicIndex = nil
    au.activeMusic = nil
    au.activeSFX = {}
    print("Audio module created\n")
    return au
end

function Audio:loadSound(path, type, volume)
    assert(type == "music" or type == "sfx", "Type must be music or sfx")
    local sound

    if type == "sfx" then
        sound = love.audio.newSource(path, "static")
        sound:setVolume(volume or 1.0)
        table.insert(self.sfxCache, sound)
        return #self.sfxCache
    elseif type == "music" then
        sound = love.audio.newSource(path, "stream")
        sound:setVolume(volume or 1.0)
        sound:setLooping(true)
        table.insert(self.musicCache, sound)
        return #self.musicCache
    end
end

function Audio:playMusic(index, volume)
    local entry = self.musicCache[index]
    if entry == nil then
        error("Invalid music index: " .. tostring(index))
    end

    --If index is already playing
    if self.activeMusic and self.activeMusicIndex == index and self.activeMusic:isPlaying() then
        self.activeMusic:stop()
        self.activeMusicIndex = nil
        self.activeMusic = nil
        return
    end

    --Stop any other songs playing
    if self.activeMusic and self.activeMusic:isPlaying() then
        self.activeMusic:stop()
    end

    --Play the chosen song
    self.activeMusic = self.musicCache[index]
    self.activeMusicIndex = index
    self.activeMusic:setVolume(volume or 1.0)
    self.activeMusic:play()
    return 
end

function Audio:playSFX(index, volume)
    local entry = self.sfxCache[index]
    if entry == nil then
        error("Invalid sound index: " .. tostring(index))
    end

    local sfx = entry:clone()
    sfx:setVolume(volume or 1.0)
    sfx:play()
    table.insert(self.activeSFX, sfx)
end

function Audio:toggleFilter()
    if not self.activeMusic then return end

    self.filterState.active = true
    self.filterState.timer = 0.0
    self.filterState.duration = 2.0
    self.filterState.startGainHF = self.activeMusic:getFilter() and self.activeMusic:getFilter().highgain or 1.0
    self.filterState.targetGainHF = enable and 0.2 or 1.0
end

function Audio:update(dt)

    --GC
    for i = #self.activeSFX, 1, -1 do
        if not self.activeSFX[i]:isPlaying() then
            table.remove(self.activeSFX, i)
        end
    end

    --Filter tweening
    if self.filterState.active and self.activeMusic then
        self.filterState.timer = self.filterState.timer + dt

        local t = math.min(self.filterState.timer / self.filterState.duration, 1.0)
        local gainHF = self.filterState.startGainHF + ((self.filterState.targetGainHF - self.startGainHF) * t)

        self.activeMusic:setFilter({
            type = "lowpass",
            volume = 1.0,
            highgain = gainHF
        })

        if t >= 1.0 then
            self.filterState.active = false
        end
    end
end

return Audio
