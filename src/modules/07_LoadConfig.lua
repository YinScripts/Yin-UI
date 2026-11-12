local function LoadConfig()
    local result = {
        theme = nil,
        effect = nil,
        volume = nil,
        libMode = nil,
        libHeight = nil,
        hideSliders = nil,
        favorites = nil,
        spotifyFavorites = nil,
        logoIcon = nil,
        platformMode = nil,
        floatStyle = nil,
        tabIconLayout = nil,
        chatCorner = nil,
        keybinds = {},
    }

    pcall(function()
        if readfile(ConfigFile) then
            local content = readfile(ConfigFile)
            if content and content ~= "" then
                for part in content:gmatch("([^|]+)") do
                    local key, value = part:match("([^:]+):(.+)")
                    if key == "theme" then
                        result.theme = value
                    elseif key == "effect" then
                        result.effect = value
                    elseif key == "volume" then
                        result.volume = tonumber(value)
                    elseif key == "libMode" then
                        result.libMode = value
                    elseif key == "libHeight" then
                        result.libHeight = tonumber(value)
                    elseif key == "hideSliders" then
                        result.hideSliders = (value == "true")
                    elseif key == "favorites" then
                        result.favorites = value
                    elseif key == "spotifyFavorites" then
                        local okFavorites, decodedFavorites = pcall(function()
                            return HttpService:JSONDecode(value)
                        end)
                        if okFavorites and type(decodedFavorites) == "table" then
                            result.spotifyFavorites = decodedFavorites
                        end
                    elseif key == "logoIcon" then
                        result.logoIcon = value
                    elseif key == "platformMode" then
                        result.platformMode = value
                    elseif key == "floatStyle" then
                        result.floatStyle = value
                    elseif key == "tabIconLayout" then
                        result.tabIconLayout = value
                    elseif key == "chatCorner" then
                        result.chatCorner = (value == "true")
                    elseif key == "keybinds" then
                        for pair in value:gmatch("([^,]+)") do
                            local id, keyName = pair:match("^(.-)~([^~]+)$")
                            if id and keyName and id ~= "" and keyName ~= "" then
                                result.keybinds[id] = keyName
                            end
                        end
                    end
                end
            end
        end
    end)
    return result
end