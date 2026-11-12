local function setGlowLayersVisible(frame, visible)
    if not frame.Parent then return end
    local tag = "GLOW_" .. tostring(frame)
    for _, child in ipairs(frame.Parent:GetChildren()) do
        if child:GetAttribute("GlowOwner") == tag then
            child.Visible = visible
        end
    end
end