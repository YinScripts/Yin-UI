local function createStatTile(grid, labelSpanish, labelEnglish)
    labelEnglish = labelEnglish or labelSpanish
    local Tile = mk("Frame", {
        Parent = grid,
        BackgroundColor3 = Theme.Secondary,
        ZIndex = 9
    })
    Tile:SetAttribute("ThemeRole", "Secondary")
    corner(Tile, 6)
    stroke(Tile, Color3.fromRGB(0, 0, 0), 1, 0.6)

    local TileLabel = mk("TextLabel", {
        Parent = Tile,
        Size = UDim2.new(1, -16, 0, 16),
        Position = UDim2.new(0, 8, 0, 6),
        BackgroundTransparency = 1,
        Text = GetText(labelSpanish, labelEnglish),
        TextColor3 = Theme.TextDim,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 10
    })
    TileLabel:SetAttribute("ThemeRole", "TextDim")
    TileLabel:SetAttribute("TextSpanish", labelSpanish)
    TileLabel:SetAttribute("TextEnglish", labelEnglish)

    local ValueText = mk("TextLabel", {
        Parent = Tile,
        Size = UDim2.new(1, -16, 0, 22),
        Position = UDim2.new(0, 8, 0, 24),
        BackgroundTransparency = 1,
        Text = "...",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 10
    })
    ValueText:SetAttribute("ThemeRole", "Text")

    return Tile, ValueText
end