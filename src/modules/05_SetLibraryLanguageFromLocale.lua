local function SetLibraryLanguageFromLocale(localeId)
    YLang.System = GetLibraryLanguage(localeId)
    return YLang.Apply()
end