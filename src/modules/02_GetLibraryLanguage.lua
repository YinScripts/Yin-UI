local function GetLibraryLanguage(localeId)
    local language = string.lower(tostring(localeId or "en")):match("^(%a+)") or "en"
    return language
end