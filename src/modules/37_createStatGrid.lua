local function createStatGrid(parent)
    local Grid = mk("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundTransparency = 1,
        ZIndex = 9
    })
    mk("UIGridLayout", {
        CellPadding = UDim2.new(0, 8, 0, 8),
        CellSize = UDim2.new(0.5, -4, 0, 54),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, Grid)
    return Grid
end