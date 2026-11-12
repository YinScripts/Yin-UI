local function buildGlowOnStroke(frame, accentColor, cornerRadius)
    local key = tostring(frame)
    stopGlowTweens(key)

    local existingStroke = frame:FindFirstChildOfClass("UIStroke")
    if not existingStroke then return end

    local _isMainFrame = frame.Name == "Main"
    existingStroke.Color = _isMainFrame and accentColor or Color3.fromRGB(15, 15, 15)

    local oldGrad = existingStroke:FindFirstChildOfClass("UIGradient")
    if oldGrad then oldGrad:Destroy() end

    local _bDark  = _isMainFrame and accentColor or Color3.fromRGB(15, 15, 15)
    local _bWhite = _isMainFrame and (Theme.BorderLight or Color3.fromRGB(255, 150, 40)) or Color3.fromRGB(255, 255, 255)

    local grad = Instance.new("UIGradient")
    if _isMainFrame and Theme.BorderLight2 then
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,     _bDark),
            ColorSequenceKeypoint.new(0.330, _bDark),
            ColorSequenceKeypoint.new(0.335, _bWhite),
            ColorSequenceKeypoint.new(0.665, Theme.BorderLight2),
            ColorSequenceKeypoint.new(0.670, _bDark),
            ColorSequenceKeypoint.new(1,     _bDark),
        })
    else
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,     _bDark),
            ColorSequenceKeypoint.new(0.330, _bDark),
            ColorSequenceKeypoint.new(0.335, _bWhite),
            ColorSequenceKeypoint.new(0.665, _bWhite),
            ColorSequenceKeypoint.new(0.670, _bDark),
            ColorSequenceKeypoint.new(1,     _bDark),
        })
    end
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 0),
    })
    grad.Offset = Vector2.new(-1.5, 0)
    grad.Parent = existingStroke

    local sweepTween = TweenService:Create(
        grad,
        TweenInfo.new(3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
        { Offset = Vector2.new(1.5, 0) }
    )
    sweepTween:Play()

    local pulseTween = TweenService:Create(
        existingStroke,
        TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        { Transparency = 0.0 }
    )
    pulseTween:Play()

    ActiveGlowTweens[key] = { sweepTween, pulseTween }
end