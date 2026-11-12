local function IsPlayerBanned(player)
    local nameLower = tostring(player.Name):lower()
    local userId    = player.UserId
    for _, entry in ipairs(BanList) do
        if type(entry) == "string" and tostring(entry):lower() == nameLower then
            return true
        elseif type(entry) == "number" and entry == userId then
            return true
        end
    end
    return false
end