local function buildAnimatedBorder(frame, accentColor, cornerRadius, forceStrokeOnly)
    local key = tostring(frame)
    stopGlowTweens(key)
    cleanGlowLayers(frame)

    local cr = cornerRadius or UDim.new(0, 10)
    local h, s, v = Color3.toHSV(accentColor)
    local accentLight = Color3.fromHSV(h, math.max(0, s - 0.3), math.min(1, v + 0.25))
    local accentDark  = Color3.fromHSV(h, math.min(1, s + 0.1), math.max(0, v - 0.25))

    local parentIsScreenGui = frame.Parent and (frame.Parent:IsA("ScreenGui") or frame.Parent:IsA("PlayerGui"))
    
    if forceStrokeOnly or parentIsScreenGui then
        buildGlowOnStroke(frame, accentColor, cr)
        return
    end

    local _, outerStroke = addGlowSibling(frame, 16, 0.45, accentColor, cr)
    local _, innerStroke = addGlowSibling(frame, 5, 0.10, accentLight, cr)

    if not outerStroke or not innerStroke then
        buildGlowOnStroke(frame, accentColor, cr)
        return
    end

    local _bDark2  = Color3.fromRGB(15, 15, 15)
    local _bWhite2 = Color3.fromRGB(255, 255, 255)

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,     _bDark2),
        ColorSequenceKeypoint.new(0.330, _bDark2),
        ColorSequenceKeypoint.new(0.335, _bWhite2),
        ColorSequenceKeypoint.new(0.665, _bWhite2),
        ColorSequenceKeypoint.new(0.670, _bDark2),
        ColorSequenceKeypoint.new(1,     _bDark2),
    })
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 0),
    })
    grad.Offset = Vector2.new(-1.5, 0)
    grad.Parent = innerStroke

    local sweepTween = TweenService:Create(
        grad,
        TweenInfo.new(3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
        { Offset = Vector2.new(1.5, 0) }
    )
    sweepTween:Play()

    local pulseTween = TweenService:Create(
        outerStroke,
        TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        { Transparency = 0.20, Thickness = 22 }
    )
    pulseTween:Play()

    ActiveGlowTweens[key] = { sweepTween, pulseTween }
end