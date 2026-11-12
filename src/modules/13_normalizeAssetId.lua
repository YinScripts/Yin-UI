local function normalizeAssetId(value)
    value = tostring(value or ""):match("^%s*(.-)%s*$")
    if value == "" then return "" end
    local numericId = value:match("(%d+)")
    if not numericId then return nil end
    return "rbxassetid://" .. numericId
end