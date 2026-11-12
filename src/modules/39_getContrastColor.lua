local function getContrastColor(bgColor)
    local luminance = 0.299 * bgColor.R + 0.587 * bgColor.G + 0.114 * bgColor.B
    if luminance > 0.6 then
        return Color3.fromRGB(25, 25, 25)
    end
    return Color3.fromRGB(255, 255, 255)
end