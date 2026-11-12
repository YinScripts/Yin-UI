local function stroke(p, col, th, trans)
    local s = mk("UIStroke", {Color = col, Thickness = th or 1.5, Transparency = trans or 0}, p)
    s:SetAttribute("ThemeRole", "Stroke")
    return s
end