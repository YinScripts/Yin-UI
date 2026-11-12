local function LoadThemes()
    local dlOk, rawData = pcall(function()
        return game:HttpGet(THEMES_URL, true)
    end)

    if not (dlOk and type(rawData) == "string" and #rawData > 20) then
        print("[YinYang Themes] ⚠️ Descarga falló; se mantienen los temas embebidos")
        return false
    end

    local parseOk, data = pcall(function()
        return loadstring(rawData)()
    end)
    rawData = nil

    if not (parseOk and type(data) == "table" and data.Themes) then
        print("[YinYang Themes] ❌ Error al parsear datos; se mantienen los temas embebidos")
        return false
    end

    local count = 0
    for name, theme in pairs(data.Themes) do
        if theme.Palette then
            ThemePalettes[name] = theme.Palette
        end
        if theme.Sound then
            ThemeClickSounds[name] = theme.Sound
        end
        if type(theme.Background) == "string" and theme.Background ~= "" then
            ThemeBackgroundImages[name] = theme.Background
        elseif type(theme.Images) == "table" then
            local firstImage = theme.Images[1]
            if type(firstImage) == "string" and firstImage ~= "" then
                ThemeBackgroundImages[name] = firstImage
            end
        end
        if theme.Video and theme.Video ~= "" then
            local rawVideoId = tostring(theme.Video):match("^%s*(.-)%s*$")
            local numericVideoId = rawVideoId and rawVideoId:match("(%d+)")
            ThemeBackgroundVideos[name] = {
                Id = numericVideoId and ("rbxassetid://" .. numericVideoId) or rawVideoId,
                Looped = theme.VideoLooped ~= false,
                Volume = math.clamp(tonumber(theme.VideoVolume) or 0, 0, 1),
            }
        end
        if theme.Effect and theme.Effect ~= "Off" then
            ThemeAutoEffects[name] = theme.Effect
        end
        if theme.TitleBarImage and theme.TitleBarImage ~= "" then
            ThemeTitleBarImages[name] = theme.TitleBarImage
        end
        if theme.TabListImage and theme.TabListImage ~= "" then
            ThemeTabListImages[name] = theme.TabListImage
        end
        local mergedTabIcons = nil
        if type(theme.TabIconPack) == "string" then
            local pack = type(data.IconPacks) == "table" and data.IconPacks[theme.TabIconPack] or nil
            if type(pack) == "table" then
                mergedTabIcons = {}
                for iconKey, iconId in pairs(pack) do
                    mergedTabIcons[iconKey] = iconId
                end
            else
                warn("[YinYang Themes] El tema " .. tostring(name) .. " usa TabIconPack '" .. theme.TabIconPack .. "' pero ese pack no existe")
            end
        end
        if type(theme.TabIcons) == "table" then
            mergedTabIcons = mergedTabIcons or {}
            for iconKey, iconId in pairs(theme.TabIcons) do
                mergedTabIcons[iconKey] = iconId
            end
        end
        if mergedTabIcons then
            ThemeTabIcons[name] = mergedTabIcons
        end
        if type(theme.WindowIcons) == "table" or type(theme.IconSizes) == "table" or theme.TransparentTabs == true then
            ThemeExtras[name] = { WindowIcons = theme.WindowIcons, IconSizes = theme.IconSizes, TransparentTabs = theme.TransparentTabs == true }
        end
        if type(theme.Sprite) == "table" then
            ThemeSprites[name] = theme.Sprite
        else
            ThemeSprites[name] = nil
        end
        count = count + 1
    end

    if data.Order then
        ThemeOrder = data.Order
    end
    print("[YinYang Themes] ✅ " .. count .. " temas cargados en memoria (v" .. tostring(data.Version or "?") .. ")")
    return true
end