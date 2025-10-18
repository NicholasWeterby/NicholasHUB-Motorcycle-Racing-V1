--// NicholasV HUB GUI (Blue-Black Theme)
local GUI = {}

function GUI.Init()
    print("[NicholasV] GUI.Init() starting...")

    local player = game.Players.LocalPlayer
    local playerGui

    repeat
        playerGui = player:FindFirstChild("PlayerGui")
        task.wait(0.5)
    until playerGui

    print("[NicholasV] PlayerGui found, building UI...")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NicholasV_HUB"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- 🌌 Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 420, 0, 240)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.Parent = screenGui

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 180, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame

    -- ⚡ Title bar
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
    title.Text = "⚡ NicholasV HUB 2025"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = title

    local titleStroke = Instance.new("UIStroke")
    titleStroke.Thickness = 1
    titleStroke.Color = Color3.fromRGB(0, 255, 255)
    titleStroke.Parent = title

    -- 🔘 Button example
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 45)
    button.Position = UDim2.new(0.5, -80, 0.5, -10)
    button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    button.Text = "Activate Magnet"
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 20
    button.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button

    -- 🪄 Button effect
    button.MouseButton1Click:Connect(function()
        button.Text = "✅ Activated"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
        task.wait(1.5)
        button.Text = "Activate Magnet"
        button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end)

    print("[NicholasV] ✅ GUI Initialized Successfully!")
end

GUI.Init()
