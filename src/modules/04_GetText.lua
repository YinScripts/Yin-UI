local function GetText(spanishText, englishText)
    spanishText = tostring(spanishText or "")
    englishText = tostring(englishText or "")

    if LibraryLanguage == "es" then
        return spanishText
    end

    if LibraryLanguage == "en" then
        return englishText
    end

    return TranslateWithRoblox(englishText, spanishText) or englishText
end