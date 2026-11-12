local function setActiveTheme(name)
    local palette = ThemePalettes[name]
    if not palette then return false end
    Theme = table.clone(palette)
    Theme.AccentText = getContrastColor(Theme.Accent)
    Theme.TextStroke = getContrastColor(Theme.Text)
    Theme.ThemeName = name
    Theme.SliderTrack = Theme.SliderTrack or Theme.AccentOff
    Theme.SliderFill = Theme.SliderFill or Theme.Accent
    Theme.SliderThumb = Theme.SliderThumb or Theme.Accent
    Theme.Border = Theme.Border or Theme.Accent
    Theme.TabActive = Theme.TabActive or Color3.fromRGB(225, 100, 0)
    local function lighten(c)
        local h, sat, val = Color3.toHSV(c)
        return Color3.fromHSV(h, math.max(0, sat - 0.3), math.min(1, val + 0.25))
    end
    Theme.BorderLight = Theme.BorderLight or lighten(Theme.Border)
    Theme.TitleText = Theme.TitleText or Theme.Accent
    Theme.SubText = Theme.SubText or Theme.Accent
    Theme.Counter = Theme.Counter or Theme.Accent
    Theme.WindowIcon = Theme.WindowIcon or Theme.Text
    Theme.PillBackground = Theme.PillBackground or Theme.AccentOff
    Theme.PillBorder = Theme.PillBorder or Theme.Accent
    Theme.PillBorderAlt = Theme.PillBorderAlt or lighten(Theme.PillBorder)
    local extras = ThemeExtras[name]
    Theme.WindowIcons = extras and extras.WindowIcons or {}
    Theme.IconSizes = extras and extras.IconSizes or {}
    Theme.TransparentTabs = extras and extras.TransparentTabs == true or false
    Theme.FullBackground = (name == "Navidad") -- exclusivo de Navidad: el fondo cubre toda la ventana
    return true
end