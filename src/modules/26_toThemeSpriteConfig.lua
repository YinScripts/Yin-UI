local function toThemeSpriteConfig(raw)
    if type(raw) ~= "table" then return nil end
    local ids = raw.SheetIds or raw.Ids
    if type(ids) ~= "table" or #ids == 0 then return nil end

    local columns = tonumber(raw.Columns)
    local rows = tonumber(raw.Rows)
    if not (columns and rows and tonumber(raw.FrameWidth) and tonumber(raw.FrameHeight)) then
        return nil
    end
    local perSheet = math.max(1, math.floor(columns) * math.floor(rows))

    local counts = {}
    if type(raw.FramesPerSheet) == "table" then
        for i = 1, #ids do
            counts[i] = tonumber(raw.FramesPerSheet[i]) or perSheet
        end
    elseif tonumber(raw.FrameCount) then
        local remaining = tonumber(raw.FrameCount)
        for i = 1, #ids do
            if remaining <= 0 then break end
            counts[i] = math.min(perSheet, remaining)
            remaining = remaining - counts[i]
        end
    else
        for i = 1, #ids do
            counts[i] = perSheet
        end
    end

    -- Solo se usan las hojas con frames; una hoja vacia corta la lista.
    local sheetIds, framesPerSheet = {}, {}
    for i = 1, #ids do
        local n = counts[i]
        if not n or n <= 0 then break end
        sheetIds[#sheetIds + 1] = ids[i]
        framesPerSheet[#framesPerSheet + 1] = math.min(math.floor(n), perSheet)
    end
    if #sheetIds == 0 then return nil end

    local cfg = {
        SheetIds = sheetIds,
        Columns = raw.Columns,
        Rows = raw.Rows,
        FrameWidth = raw.FrameWidth,
        FrameHeight = raw.FrameHeight,
        FramesPerSheet = framesPerSheet,
        FPS = raw.FPS or 24,
        CropContent = raw.CropContent == true,
        CropY = raw.CropY,
        CropHeight = raw.CropHeight,
        ScaleType = Enum.ScaleType.Crop,
    }
    if not normalizeSpriteSheetConfig(cfg) then return nil end
    return cfg
end