local function LoadStickers()
    local dlOk, rawData = pcall(function()
        return game:HttpGet(STICKERS_URL, true)
    end)
    if not (dlOk and type(rawData) == "string" and #rawData > 20) then
        print("[YinYang Stickers] ⚠️ Descarga falló; se mantienen los stickers embebidos")
        return false
    end

    local parseOk, data = pcall(function()
        return loadstring(rawData)()
    end)
    rawData = nil
    if not (parseOk and type(data) == "table" and data.Stickers) then
        print("[YinYang Stickers] ❌ Error al parsear; se mantienen los stickers embebidos")
        return false
    end

    local count = 0
    for name, sticker in pairs(data.Stickers) do
        if sticker.Image then
            StickerPalettes[name] = {
                Image = sticker.Image,
                Frames = sticker.Frames,
                Interval = sticker.Interval,
                LabelES = sticker.LabelES or name,
                LabelEN = sticker.LabelEN or name,
            }
            count = count + 1
        end
    end
    if data.Order then
        StickerOrder = data.Order
    end
    print("[YinYang Stickers] ✅ " .. count .. " stickers cargados en memoria (v" .. tostring(data.Version or "?") .. ")")
    return true
end