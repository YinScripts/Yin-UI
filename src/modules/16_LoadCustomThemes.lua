local function LoadCustomThemes()
    if not (readfile and isfile and isfile(CUSTOM_THEMES_FILE)) then return end

    pcall(function()
        local decoded = HttpService:JSONDecode(readfile(CUSTOM_THEMES_FILE))
        if type(decoded) ~= "table" or type(decoded.Themes) ~= "table" then return end

        CustomThemes = decoded.Themes
        CustomThemeOrder = type(decoded.Order) == "table" and decoded.Order or {}

        local seen = {}
        local cleanOrder = {}
        for _, name in ipairs(CustomThemeOrder) do
            if type(name) == "string" and CustomThemes[name] and not OfficialThemeNames[name] and not seen[name] then
                seen[name] = true
                table.insert(cleanOrder, name)
            end
        end
        for name, data in pairs(CustomThemes) do
            if type(name) == "string" and not OfficialThemeNames[name] then
                if not seen[name] then
                    seen[name] = true
                    table.insert(cleanOrder, name)
                end
                applyCustomThemeToRuntime(name, data)
            end
        end
        CustomThemeOrder = cleanOrder
    end)
end