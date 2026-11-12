local function swapThemeColor(obj, palette)
    local bgRole = obj:GetAttribute("ThemeRole")
    if bgRole and palette[bgRole] then
        if obj:IsA("UIStroke") then
            obj.Color = palette[bgRole]
        elseif obj:IsA("GuiObject") then
            pcall(function() obj.BackgroundColor3 = palette[bgRole] end)
        end
    end

    local textRole = obj:GetAttribute("ThemeTextRole")
    if textRole and palette[textRole] then
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            obj.TextColor3 = palette[textRole]
        end
    end

    local textStrokeRole = obj:GetAttribute("ThemeTextStrokeRole")
    if textStrokeRole and palette[textStrokeRole] then
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            pcall(function() obj.TextStrokeColor3 = palette[textStrokeRole] end)
        end
    end

    local imageRole = obj:GetAttribute("ThemeImageRole")
    if imageRole and palette[imageRole] then
        if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            obj.ImageColor3 = palette[imageRole]
        end
    end
end