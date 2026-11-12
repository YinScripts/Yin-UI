local function SaveCustomThemes()
    pcall(function()
        if writefile then
            writefile(CUSTOM_THEMES_FILE, HttpService:JSONEncode({
                Themes = CustomThemes,
                Order = CustomThemeOrder,
            }))
        end
    end)
end