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

    au.sfxSrc = {}

    return au
end

function Audio:playMusic(path, volume)

    if self.musicSrc then
        self.musicSrc:stop()
    end

    self.musicSrc = love.audio.newSource(path, "stream")
    self.musicSrc:setLooping(true)
    self.musicSrc:setVolume(volume or 1.0)
    self.musicSrc:play()
end


function Audio:playSFX(path, volume)
    local sfx = love.audio.newSource(path, "static")
    sfx:setVolume(volume or 1.0)
    sfx:play()
    table.insert(self.sfxSrc, sfx)
end

return Audio
