local function getPooledSound()
    for _, s in ipairs(SoundPool) do
        if not s.IsPlaying then
            return s
        end
    end
    if #SoundPool < POOL_SIZE then
        local s = Instance.new("Sound")
        s.Parent = SoundService
        table.insert(SoundPool, s)
        return s
    end
    poolCursor = (poolCursor % #SoundPool) + 1
    return SoundPool[poolCursor]
end