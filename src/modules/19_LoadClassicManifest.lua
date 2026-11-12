local function LoadClassicManifest()
    local dlOk, rawData = pcall(function()
        return game:HttpGet(CLASSIC_MANIFEST_URL, true)
    end)
    if not (dlOk and type(rawData) == "string" and #rawData > 10) then
        print("[YinYang Classic] ❌ No se pudo descargar el manifest; la pestaña quedará vacía")
        return {}
    end

    local parseOk, data = pcall(function()
        return loadstring(rawData)()
    end)
    rawData = nil
    if not (parseOk and type(data) == "table") then
        print("[YinYang Classic] ❌ Error al parsear el manifest")
        return {}
    end

    local count = 0
    for _, entry in ipairs(data) do
        if type(entry) == "table" then
            count = count + 1
        end
    end
    print("[YinYang Classic] ✅ " .. count .. " scripts externos en el manifest")
    return data
end