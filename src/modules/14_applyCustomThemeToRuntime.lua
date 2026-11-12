local function applyCustomThemeToRuntime(name, data)
    if type(data) ~= "table" or type(data.Palette) ~= "table" then return false end

    local fallback = ThemePalettes.Dark
    local palette = {
        Background = arrayToColor(data.Palette.Background, fallback.Background),
        Secondary = arrayToColor(data.Palette.Secondary, fallback.Secondary),
        AccentOff = arrayToColor(data.Palette.AccentOff, fallback.AccentOff),
        Text = arrayToColor(data.Palette.Text, fallback.Text),
        TextDim = arrayToColor(data.Palette.TextDim, fallback.TextDim),
        Stroke = arrayToColor(data.Palette.Stroke, fallback.Stroke),
        Accent = arrayToColor(data.Palette.Accent, fallback.Accent),
        ToggleOn = arrayToColor(data.Palette.ToggleOn, fallback.ToggleOn),
    }

    ThemePalettes[name] = palette

    if data.Background and data.Background ~= "" then
        ThemeBackgroundImages[name] = data.Background
    else
        ThemeBackgroundImages[name] = nil
    end

    if data.Video and data.Video ~= "" then
        ThemeBackgroundVideos[name] = {
            Id = normalizeAssetId(data.Video) or data.Video,
            Looped = data.VideoLooped ~= false,
            Volume = math.clamp(tonumber(data.VideoVolume) or 0, 0, 1),
        }
    else
        ThemeBackgroundVideos[name] = nil
    end

    if data.Sound and data.Sound ~= "" then
        ThemeClickSounds[name] = data.Sound
    else
        ThemeClickSounds[name] = nil
    end

    return true
end