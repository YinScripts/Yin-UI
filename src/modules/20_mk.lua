local function mk(cls, props, parent)
    local o = Instance.new(cls)
    pcall(function() o.Selectable = false end)
    if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
        pcall(function() o.AutoLocalize = false end)
    end
    if o:IsA("TextButton") or o:IsA("ImageButton") then
        pcall(function() o.AutoButtonColor = false end)
    end
    for k, v in pairs(props) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end