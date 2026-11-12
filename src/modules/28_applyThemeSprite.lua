local function applyThemeSprite(owner, parent, raw)
    stopThemeSprite(owner)
    if parent then
        parent.ClipsDescendants = false
    end
    local cfg = toThemeSpriteConfig(raw)
    if raw ~= nil and not cfg then
        warn("[YinYang Sprite] Configuración de sprite inválida; se usa la imagen de fondo")
    end
    if not cfg or not parent then return false end

    -- El sprite reemplaza la imagen de fondo mientras este activo.
    parent.Image = ""
    parent.ClipsDescendants = true

    -- ZIndex = el de BackgroundArt (parent.ZIndex). El ScreenGui usa ZIndexBehavior.Global:
    -- con un ZIndex menor (antes 1) el sprite quedaba dibujado DEBAJO de Main/BackgroundArt
    -- y no se veia, aunque el log dijera "Activo".
    local _, state = createSpriteSheetLabels(parent, cfg, UDim2.fromScale(1, 1), UDim2.fromScale(0, 0), parent.ZIndex)
    if not state then return false end
    updateSpriteSheetFrame(state, 0)

    local runService = game:GetService("RunService")
    local conn
    conn = runService.RenderStepped:Connect(function(dt)
        if not parent.Parent then
            conn:Disconnect()
            return
        end
        -- Si el fondo esta oculto (por ejemplo, con video) no avanza ni acumula tiempo.
        if not parent.Visible or PerfOpt.Flags.StaticBackground then
            state.Acc = 0
            return
        end
        state.Acc = state.Acc + dt
        if state.Acc > 0.25 then
            state.Acc = 0.25
        end
        local step = 1 / state.Config.FPS
        local moved = false
        while state.Acc >= step do
            state.Acc = state.Acc - step
            state.Frame = (state.Frame + 1) % state.Config.TotalFrames
            moved = true
        end
        if moved then
            updateSpriteSheetFrame(state, state.Frame)
        end
    end)

    owner._themeSprite = { Labels = state.Labels, Connection = conn }
    local total = 0
    for _, n in ipairs(cfg.FramesPerSheet) do
        total = total + n
    end
    print("[YinYang Sprite] Activo: " .. #cfg.SheetIds .. " hojas, " .. total .. " frames a " .. cfg.FPS .. " FPS")
    return true
end