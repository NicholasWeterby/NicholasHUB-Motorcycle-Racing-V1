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

    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NicholasV_HUB"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 15, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 150, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "⚡ NicholasV HUB 2025"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Parent = mainFrame

    -- Button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 40)
    button.Position = UDim2.new(0.5, -80, 0.5, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    button.Text = "Click Me!"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        button.Text = "✅ Working!"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
        task.wait(1)
        button.Text = "Click Me!"
        button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end)

    print("[NicholasV] ✅ GUI Initialized Successfully!")
end

GUI.Init()
