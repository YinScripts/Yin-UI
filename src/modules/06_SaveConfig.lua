local function SaveConfig()
    pcall(function()
        local keybindParts = {}
        for id, keyName in pairs(SavedConfig.Keybinds or {}) do
            if type(id) == "string" and type(keyName) == "string" and keyName ~= "" then
                table.insert(keybindParts, id .. "~" .. keyName)
            end
        end
        table.sort(keybindParts)

        local configData = table.concat({
            "theme:" .. tostring(SavedConfig.CurrentTheme or CurrentTheme or "Senju"),
            "effect:" .. tostring(SavedConfig.CurrentEffect or "Normal"),
            "volume:" .. tostring(SavedConfig.Volume or 0.5),
            "libMode:" .. tostring(SavedConfig.LibrarySizeMode or "Small"),
            "libHeight:" .. tostring(SavedConfig.LibraryHeight or 340),
            "hideSliders:" .. tostring(SavedConfig.HideSliders or false),
            "favorites:" .. tostring(SavedConfig.Favorites or ""),
            "spotifyFavorites:" .. HttpService:JSONEncode(SavedConfig.SpotifyFavorites or {}),
            "logoIcon:" .. tostring(SavedConfig.SelectedLogoIcon or "ClassicYinYang"),
            "platformMode:" .. tostring(SavedConfig.PlatformMode or "Auto"),
            "floatStyle:" .. tostring(SavedConfig.FloatingToggleStyle or "Pill"),
            "tabIconLayout:" .. tostring(SavedConfig.TabIconLayout or "Original"),
            "chatCorner:" .. tostring(SavedConfig.ChatCornerMessages ~= false),
            "keybinds:" .. table.concat(keybindParts, ","),
            "time:" .. tostring(os.time()),
        }, "|")
        writefile(ConfigFile, configData)
    end)
end