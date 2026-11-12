local function cleanGlowLayers(frame)
    local tag = "GLOW_" .. tostring(frame)
    if frame.Parent then
        for _, child in ipairs(frame.Parent:GetChildren()) do
            if child:GetAttribute("GlowOwner") == tag then
                child:Destroy()
            end
        end
    end
end