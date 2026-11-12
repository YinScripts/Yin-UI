local function normalizeSpriteSheetConfig(config)
    if type(config) ~= "table" or type(config.SheetIds) ~= "table" or #config.SheetIds == 0 then
        return nil
    end

    local columns = math.max(1, math.floor(tonumber(config.Columns) or 1))
    local rows = math.max(1, math.floor(tonumber(config.Rows) or 1))
    local frameWidth = math.max(1, math.floor(tonumber(config.FrameWidth) or 1))
    local frameHeight = math.max(1, math.floor(tonumber(config.FrameHeight) or 1))
    local fps = math.clamp(tonumber(config.FPS) or 24, 1, 60)

    local framesPerSheet = {}
    local totalFrames = 0
    for i = 1, #config.SheetIds do
        local n = tonumber(type(config.FramesPerSheet) == "table" and config.FramesPerSheet[i]) or (columns * rows)
        n = math.clamp(math.floor(n), 1, columns * rows)
        framesPerSheet[i] = n
        totalFrames = totalFrames + n
    end

    if totalFrames <= 0 then
        return nil
    end

    local cropContent = config.CropContent == true
    local rectHeight = cropContent and math.max(1, math.floor(tonumber(config.CropHeight) or frameHeight)) or frameHeight
    local rectYShift = cropContent and math.floor(tonumber(config.CropY) or 0) or 0

    return {
        SheetIds = config.SheetIds,
        Columns = columns,
        Rows = rows,
        FrameWidth = frameWidth,
        FrameHeight = frameHeight,
        FramesPerSheet = framesPerSheet,
        FPS = fps,
        RectHeight = rectHeight,
        RectYShift = rectYShift,
        TotalFrames = totalFrames,
    }
end