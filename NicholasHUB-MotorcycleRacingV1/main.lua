--// NicholasV HUB GUI System (Dark Blue Neon Theme)
local GUI = {}

function GUI.Init()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    if playerGui:FindFirstChild("NicholasV_HUB") then
        playerGui:FindFirstChild("NicholasV_HUB"):Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NicholasV_HUB"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainPanel"
    mainFrame.Size = UDim2.new(0, 420, 0, 260)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local uiStroke = Instance.new("UIStroke", mainFrame)
    uiStroke.Color = Color3.fromRGB(0, 180, 255)
    uiStroke.Thickness = 2
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundTransparency = 1
    title.Text = "⚡ NicholasV Control Hub 2025 ⚡"
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Parent = mainFrame

    local testButton = Instance.new("TextButton")
    testButton.Size = UDim2.new(0, 160, 0, 40)
    testButton.Position = UDim2.new(0.5, -80, 0.7, -20)
    testButton.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    testButton.Text = "Click Me!"
    testButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    testButton.Font = Enum.Font.GothamSemibold
    testButton.TextScaled = true
    testButton.Parent = mainFrame

    local corner2 = Instance.new("UICorner", testButton)
    corner2.CornerRadius = UDim.new(0, 6)

    testButton.MouseButton1Click:Connect(function()
        testButton.Text = "✅ Working!"
        testButton.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        task.wait(0.6)
        testButton.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
        testButton.Text = "Click Me!"
    end)

    print("[NicholasV_HUB] GUI Initialized Successfully.")
end

return GUI
