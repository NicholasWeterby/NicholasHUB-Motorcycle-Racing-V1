--// NicholasV HUB GUI (Blue-Black Theme)
local GUI = {}

function GUI.Init()
    print("[NicholasV] GUI.Init() starting...")

    -- รอให้ PlayerGui โหลดแน่นอน
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui", 10)
    if not playerGui then
        warn("[NicholasV] ❌ PlayerGui not found!")
        return
    end

    -- ลบ GUI เดิมถ้ามี
    if playerGui:FindFirstChild("NicholasV_HUB") then
        playerGui.NicholasV_HUB:Destroy()
    end

    -- สร้าง GUI ใหม่
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NicholasV_HUB"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 10, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Corner & Border
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 10)
    uicorner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 140, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = "⚡ NicholasV HUB 2025 ⚡"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Parent = mainFrame

    -- Test Button
    local testButton = Instance.new("TextButton")
    testButton.Size = UDim2.new(0, 160, 0, 40)
    testButton.Position = UDim2.new(0.5, -80, 0.7, -20)
    testButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    testButton.Text = "Click Me!"
    testButton.Font = Enum.Font.GothamBold
    testButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    testButton.Parent = mainFrame

    -- Corner for Button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = testButton

    testButton.MouseButton1Click:Connect(function()
        testButton.Text = "✅ Working!"
        testButton.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
        task.wait(1)
        testButton.Text = "Click Me!"
        testButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end)

    print("[NicholasV] ✅ GUI Initialized Successfully!")
end

return GUI
