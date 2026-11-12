local function resetScrollTop(scrollingFrame)
    task.defer(function()
        if scrollingFrame and scrollingFrame.Parent then
            scrollingFrame.CanvasPosition = Vector2.new(0, 0)
        end
    end)
end