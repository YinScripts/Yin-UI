local function LoadIcons()
    local rawData = nil

    local dlOk, dlResult = pcall(function()
        return game:HttpGet(ICONS_URL, true)
    end)

    if dlOk and type(dlResult) == "string" and #dlResult > 20 then
        rawData = dlResult
        print("[YinYang Icons] ✅ Iconos descargados desde repo")
    else
        print("[YinYang Icons] ⚠️ Descarga falló; se mantiene ClassicYinYang embebido")
    end

    if rawData then
        local parseOk, data = pcall(function()
            return loadstring(rawData)()
        end)

        if parseOk and type(data) == "table" and data.Icons then
            IconCatalog.Icons   = data.Icons
            IconCatalog.Version = data.Version or 1
            if data.Order then
                IconCatalog.Order = data.Order
            end
            local count = 0
            for _ in pairs(data.Icons) do count = count + 1 end
            print("[YinYang Icons] ✅ " .. count .. " iconos cargados (v" .. tostring(data.Version or "?") .. ")")
            return true
        else
            print("[YinYang Icons] ❌ Error al parsear datos de iconos")
        end
    else
        print("[YinYang Icons] ❌ Sin datos, usando fallback embebido")
    end

    return false
end