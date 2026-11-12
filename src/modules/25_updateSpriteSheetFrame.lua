local function updateSpriteSheetFrame(state, frame)
    if not state or not state.Config then return end

    local cfg = state.Config
    local target = math.clamp(math.floor(frame or 0), 0, cfg.TotalFrames - 1)
    local remaining = target
    local sheetIndex = 1

    for i, count in ipairs(cfg.FramesPerSheet) do
        if remaining < count then
            sheetIndex = i
            break
        end
        remaining = remaining - count
    end

    local localIndex = remaining
    local column = localIndex % cfg.Columns
    local row = math.floor(localIndex / cfg.Columns)

    if sheetIndex ~= state.CurrentSheet then
        if state.Labels[state.CurrentSheet] then
            state.Labels[state.CurrentSheet].ImageTransparency = 1
        end
        if state.Labels[sheetIndex] then
            state.Labels[sheetIndex].ImageTransparency = 0
        end
        state.CurrentSheet = sheetIndex
    end

    local label = state.Labels[sheetIndex]
    if label then
        label.ImageRectOffset = Vector2.new(
            column * cfg.FrameWidth,
            row * cfg.FrameHeight + cfg.RectYShift
        )
    end

    state.Frame = target
end