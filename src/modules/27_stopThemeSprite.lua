local function stopThemeSprite(owner)
    local st = owner and owner._themeSprite
    if not st then return end
    owner._themeSprite = nil
    if st.Connection then
        st.Connection:Disconnect()
    end
    for _, lbl in ipairs(st.Labels) do
        if lbl then
            lbl:Destroy()
        end
    end
end