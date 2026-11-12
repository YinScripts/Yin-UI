local function stopGlowTweens(key)
    if ActiveGlowTweens[key] then
        for _, tw in ipairs(ActiveGlowTweens[key]) do
            pcall(function() tw:Cancel() end)
        end
        ActiveGlowTweens[key] = nil
    end
end