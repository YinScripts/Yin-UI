local function addGlowSibling(frame, thickness, transparency, color, cornerRadius)
    local container = frame.Parent
    if not container or container:IsA("ScreenGui") or container:IsA("PlayerGui") then
        return nil, nil
    end

    local tag = "GLOW_" .. tostring(frame)
    local layer = Instance.new("Frame")
    layer.Name = "GlowLayer"
    layer:SetAttribute("GlowOwner", tag)
    layer.BackgroundTransparency = 1
    layer.Size = frame.Size
    layer.Position = frame.Position
    layer.AnchorPoint = frame.AnchorPoint
    layer.ZIndex = math.max(1, frame.ZIndex - 1)
    layer.Parent = container

    local c = Instance.new("UICorner")
    c.CornerRadius = cornerRadius or UDim.new(0, 10)
    c.Parent = layer

    local s = Instance.new("UIStroke")
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Thickness = thickness
    s.Transparency = transparency
    s.Color = color
    s.LineJoinMode = Enum.LineJoinMode.Round
    s.Parent = layer

    return layer, s
end