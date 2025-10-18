local GUI = {}

function GUI.Init()
    print("[GUI] ✅ สร้าง GUI สำเร็จ!")

    local player = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "NicholasV_HUB"
    gui.Parent = player:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 350, 0, 80)
    label.Position = UDim2.new(0.5, -175, 0.5, -40)
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.BorderSizePixel = 0
    label.TextColor3 = Color3.fromRGB(0, 200, 255)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Text = "🚀 NicholasV HUB Loaded!"
    label.Parent = gui
end

return GUI
