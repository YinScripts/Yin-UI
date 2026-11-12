local function playSound(soundId, volume)
    if PerfOpt.Flags.NoUISounds then return end
    volume = volume or 0.5
    
    local finalSoundId = soundId
    
    if DynamicClickSoundsEnabled and (soundId == Sounds.Click or not soundId) then
        if CurrentTheme and ThemeClickSounds[CurrentTheme] then
            finalSoundId = ThemeClickSounds[CurrentTheme]
        else
            finalSoundId = Sounds.Click
        end
    end
    
    if not finalSoundId or finalSoundId == "" then 
        finalSoundId = Sounds.Click
    end
    
    local sound = getPooledSound()
    if sound then
        pcall(function()
            sound.SoundId = finalSoundId
            sound.Volume = math.clamp(volume, 0, 1)
            sound.TimePosition = 0
            sound.Playing = false
            sound:Play()
        end)
    end
end