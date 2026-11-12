local function arrayToColor(value, fallback)
    if type(value) == "table" then
        local r = tonumber(value[1] or value.R)
        local g = tonumber(value[2] or value.G)
        local b = tonumber(value[3] or value.B)
        if r and g and b then
            return Color3.fromRGB(
                math.clamp(math.floor(r + 0.5), 0, 255),
                math.clamp(math.floor(g + 0.5), 0, 255),
                math.clamp(math.floor(b + 0.5), 0, 255)
            )
        end
    end
    return fallback
end