local function createSpriteSheetLabels(parent, config, size, position, zIndex)
    local cfg = normalizeSpriteSheetConfig(config)
    if not cfg then
        return nil
    end

    local labels = {}
    for i, id in ipairs(cfg.SheetIds) do
        local label = mk("ImageLabel", {
            Parent = parent,
            Size = size,
            Position = position,
            BackgroundTransparency = 1,
            Image = tostring(id):find("rbxassetid://", 1, true) and tostring(id) or ("rbxassetid://" .. tostring(id)),
            ImageRectSize = Vector2.new(cfg.FrameWidth, cfg.RectHeight),
            ImageRectOffset = Vector2.new(0, cfg.RectYShift),
            ImageTransparency = (i == 1) and 0 or 1,
            ScaleType = config.ScaleType or Enum.ScaleType.Fit,
            ZIndex = zIndex or 30,
        })
        labels[i] = label
    end

    task.spawn(function()
        for _, label in ipairs(labels) do
            if label.Parent then
                pcall(function()
                    ContentProvider:PreloadAsync({ label })
                end)
            end
        end
    end)

    local state = {
        Config = cfg,
        Labels = labels,
        Frame = 0,
        Acc = 0,
        CurrentSheet = 1,
    }

    return labels[1], state
end