local function BuildAjustesExtras(Window, AutoTabAjustes, getSlidersHidden, setSlidersHidden, getChatCornerMessagesEnabled, setChatCornerMessagesEnabled)
    local page = AutoTabAjustes._ContentParent or AutoTabAjustes.Page

    RowKit.SettingsHeader(page, 74530897423840, "Idioma", "Language", "Idioma de toda la interfaz", "Language of the whole interface")
    RowKit.Segmented(page, {
        { key = "auto", es = "Auto", en = "Auto" },
        { key = "es", es = "Español", en = "Español" },
        { key = "en", es = "English", en = "English" },
    }, YLang.Mode or "auto", function(mode)
        YLang.SetMode(mode)
    end)

    RowKit.SettingsHeader(page, 138141460046805, "Ícono flotante", "Floating icon", "Bloqueá el ícono para que no se mueva", "Lock the icon so it can't be moved")
    AutoTabAjustes:CreateToggle("Freeze Icono", "Freeze Icon", false, function(state)
        IconoCongelado = state
        if Window.Dragon and Window.Dragon.Draggable then
            Window.Dragon.Draggable = not state
        end
        if state then
            AutoTabAjustes:CreateLabel("Icono congelado (No se puede mover)", "Icon frozen (Cannot be moved)", 11)
        end
    end)

    RowKit.SettingsHeader(page, 110031536363644, "Chat", "Chat", "Avisos del chat en la esquina de la pantalla", "Chat notices in the screen corner")
    AutoTabAjustes:CreateToggle(
        "Mensajes del Chat en esquina",
        "Chat Corner Messages",
        getChatCornerMessagesEnabled(),
        function(state)
            setChatCornerMessagesEnabled(state)
            SavedConfig.ChatCornerMessages = state
            SaveConfig()
        end
    )

    RowKit.SettingsHeader(page, 72126043741813, "Sonidos", "Sounds", "Sonidos de clic según el tema activo", "Click sounds based on the active theme")
    AutoTabAjustes:CreateToggle("Sonidos Dinámicos", "Dynamic Sounds", DynamicClickSoundsEnabled, function(state)
        DynamicClickSoundsEnabled = state
        AutoTabAjustes:CreateLabel(
            state and " Sonidos por tema activados" or " Sonidos desactivados",
            state and " Theme sounds enabled"      or " Sounds disabled",
            11
        )
    end)

    RowKit.SettingsHeader(page, 76854672555792, "Sliders", "Sliders", "Mostrá u ocultá todos los sliders", "Show or hide every slider")
    AutoTabAjustes:CreateToggle("Ocultar Sliders", "Hide Sliders", getSlidersHidden(), function(state)
        setSlidersHidden(state)
        for _, obj in ipairs(Window.ScreenGui:GetDescendants()) do
            if obj:GetAttribute("IsSliderHolder") then
                obj.Visible = not state
            end
        end
        SavedConfig.HideSliders = state
        SaveConfig()
    end)

    RowKit.SettingsHeader(page, 92038302677245, "Plataforma", "Platform", "Ajusta el tamaño de la ventana al dispositivo", "Fits the window size to your device")
    RowKit.Segmented(page, {
        { key = "Auto",   es = "Auto",  en = "Auto"   },
        { key = "PC",     es = "PC",    en = "PC"     },
        { key = "Mobile", es = "Móvil", en = "Mobile" },
    }, SavedConfig.PlatformMode or "Auto", function(mode)
        SavedConfig.PlatformMode = mode
        SaveConfig()
        Window.UpdateWindowSize()
    end)

    RowKit.SettingsHeader(page, 91328661401828, "Estilo de Toggle Flotante", "Floating Toggle Style",
        "Se aplica al instante, incluso a los toggles que ya tenés flotando",
        "Applies instantly, even to toggles you already have floating")
    RowKit.Segmented(page, {
        { key = "Pill",   es = "Píldora", en = "Pill"   },
        { key = "Circle", es = "Círculo", en = "Circle" },
    }, SavedConfig.FloatingToggleStyle or "Pill", function(styleValue)
        SavedConfig.FloatingToggleStyle = styleValue
        SaveConfig()
        Window.ApplyFloatingStyle()
    end)
    FloatingPillV5.Studio.BuildEntry(page, Window)

    RowKit.SettingsHeader(page, 131461432895733, "Estilo de pestañas", "Tab Style",
        "Por defecto usa la pestaña original. El carrusel es opcional.",
        "The original tab layout is the default. The carousel is optional.")
    RowKit.Segmented(page, {
        { key = "Original", es = "Originales", en = "Original" },
        { key = "Carousel", es = "Carrusel",   en = "Carousel" },
    }, SavedConfig.TabIconLayout or "Original", function(layoutValue)
        if Window.SetTabIconLayout then
            Window:SetTabIconLayout(layoutValue)
        end
    end)

    RowKit.SettingsHeader(page, 81463911885004, "Apariencia", "Appearance")
    RowKit.InfoCard(page, {
        { "Versión", "Version", "v28 ULTRA MEJORADA", "v28 ULTRA IMPROVED" },
        { "Chat Fullscreen", "Chat Fullscreen", "ACTIVO", "ACTIVE" },
        { "Colores Dinámicos", "Dynamic Colors", "ACTIVO", "ACTIVE" },
    })

    -- ==================== OPTIMIZACIÓN ====================
    RowKit.SettingsHeader(page, "⚡", "Optimización", "Optimization",
        "Para equipos que no aguantan el script: apagá lo que da lag. Todo se guarda y se puede volver atrás.",
        "For devices that can't handle the script: turn off what causes lag. Everything is saved and reversible.")

    PerfOpt.Hooks.NoTextEffects = function()
        if Window.SetTextEffect then Window:SetTextEffect(Window.CurrentTextEffect or "Off") end
    end
    PerfOpt.Hooks.StaticBackground = function(on)
        local video = Window.BackgroundVideo
        if video then
            pcall(function()
                if on then video:Pause() elseif video.Visible then video:Play() end
            end)
        end
    end
    PerfOpt.Hooks.LiteShaders = function(on)
        local overdrive = Window.Shaders and Window.Shaders.Overdrive
        if not overdrive then return end
        if on then
            local current = overdrive.GetQuality()
            if current ~= "Lite" then PerfOpt.PrevQuality = current end
            overdrive.SetQuality("Lite")
        else
            overdrive.SetQuality(PerfOpt.PrevQuality or "Balanced")
            PerfOpt.PrevQuality = nil
        end
    end
    PerfOpt.Hooks.NoShaders = function(on)
        if on and Window.Shaders then Window.Shaders.Restore() end
    end
    -- al iniciar: shaders en Lite si quedó guardado (el resto ya se respeta solo)
    if PerfOpt.Flags.LiteShaders and Window.Shaders and Window.Shaders.Overdrive.GetQuality() ~= "Lite" then
        pcall(PerfOpt.Hooks.LiteShaders, true)
    end

    local perfToggles = {}
    local perfOrder = {}
    local function perfToggle(key, es, en)
        table.insert(perfOrder, key)
        perfToggles[key] = AutoTabAjustes:CreateToggle(es, en, PerfOpt.Flags[key], function(state)
            PerfOpt.Set(key, state)
        end)
    end

    AutoTabAjustes:CreateLabel("Interfaz", "Interface", 12)
    perfToggle("NoAnimations", "Sin animaciones de interfaz", "No interface animations")
    perfToggle("NoTextEffects", "Sin efectos de texto", "No text effects")
    perfToggle("StaticBackground", "Fondo animado quieto", "Static animated background")
    perfToggle("NoLogoAnim", "Logo flotante sin animación", "Floating logo without animation")
    perfToggle("NoHomeAvatar", "Avatar de Inicio quieto", "Still Home avatar")
    perfToggle("NoDecorAnim", "Título, banner y vistas previas quietos", "Still title, banner and previews")
    perfToggle("NoUISounds", "Sin sonidos de clic", "No click sounds")

    AutoTabAjustes:CreateLabel("Shaders", "Shaders", 12)
    perfToggle("LiteShaders", "Shaders en modo ligero", "Shaders in lite mode")
    perfToggle("NoPostFX", "Sin desenfoque, profundidad ni rayos", "No blur, depth of field or sun rays")
    perfToggle("NoShaders", "Shaders apagados (también al iniciar)", "Shaders off (also on start)")

    AutoTabAjustes:CreateLabel("Juego", "Game", 12)
    perfToggle("NoShadows", "Sin sombras del juego", "No game shadows")
    perfToggle("NoParticles", "Sin partículas, humo ni fuego", "No particles, smoke or fire")
    perfToggle("MapBoost", "Mapa liviano (sin texturas ni materiales)", "Light map (no textures or materials)")
    perfToggle("LowGraphics", "Gráficos al mínimo", "Lowest graphics")
    perfToggle("FpsCap30", "Limitar a 30 FPS (ahorro de batería)", "Cap at 30 FPS (battery saver)")
    AutoTabAjustes:CreateLabel(
        "Gráficos al mínimo y el límite de FPS dependen de tu executor: si no los permite, no hacen nada.",
        "Lowest graphics and the FPS cap depend on your executor: if it doesn't allow them, they do nothing.",
        10
    )

    local function perfSetAll(value)
        -- los sonidos se silencian primero y se devuelven al final, para no disparar 15 clics juntos
        PerfOpt.Flags.NoUISounds = true
        for _, key in ipairs(perfOrder) do
            if key ~= "NoUISounds" and PerfOpt.Flags[key] ~= value then
                PerfOpt.Set(key, value)
            end
            if perfToggles[key] then perfToggles[key].SetValue(value) end
        end
        PerfOpt.Set("NoUISounds", value)
    end
    AutoTabAjustes:CreateButton("⚡ Modo rendimiento máximo", "⚡ Maximum performance mode", function()
        perfSetAll(true)
    end)
    AutoTabAjustes:CreateButton("Volver todo a la normalidad", "Restore everything to normal", function()
        perfSetAll(false)
    end)
end