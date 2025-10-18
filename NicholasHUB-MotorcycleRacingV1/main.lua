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

    -- สร้าง ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NicholasV_HUB"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- ตัวอย่าง Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 10, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    print("[NicholasV] ✅ GUI Initialized Successfully!")
end

GUI.Init()
