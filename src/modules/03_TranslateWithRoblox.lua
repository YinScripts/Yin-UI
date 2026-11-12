local function TranslateWithRoblox(englishText, spanishText)
    if not LibraryTranslator then
        return nil
    end

    local cacheKey = tostring(LibraryLanguage) .. "\0" .. tostring(englishText)
    if LibraryTranslationCache[cacheKey] ~= nil then
        return LibraryTranslationCache[cacheKey] or nil
    end

    local translated = nil
    pcall(function()
        translated = LibraryTranslator:Translate(game, tostring(englishText))
    end)

    if not translated or translated == "" or translated == englishText then
        pcall(function()
            local spanishTranslation = LibraryTranslator:Translate(game, tostring(spanishText))
            if spanishTranslation and spanishTranslation ~= "" and spanishTranslation ~= spanishText then
                translated = spanishTranslation
            end
        end)
    end

    if translated and translated ~= "" then
        LibraryTranslationCache[cacheKey] = translated
        return translated
    end

    LibraryTranslationCache[cacheKey] = false
    return nil
end