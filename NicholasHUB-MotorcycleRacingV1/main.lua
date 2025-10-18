--// NicholasV HUB GUI (Blue–Black Theme)
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

	-- Fade animation
	local blur = Instance.new("Frame")
	blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blur.BackgroundTransparency = 1
	blur.Size = UDim2.new(1, 0, 1, 0)
	blur.Parent = screenGui
	game:GetService("TweenService"):Create(blur, TweenInfo.new(1), {BackgroundTransparency = 0.6}):Play()

	-- Main frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.Size = UDim2.new(0, 460, 0, 260)
	mainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = mainFrame

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(0, 170, 255)
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = mainFrame

	-- Logo
	local logo = Instance.new("ImageLabel")
	logo.Size = UDim2.new(0, 60, 0, 60)
	logo.Position = UDim2.new(0, 15, 0, 10)
	logo.BackgroundTransparency = 1
	logo.Image = "rbxassetid://<ใส่โลโก้ตัว N ของคุณ>" -- ใส่ asset id ตรงนี้
	logo.Parent = mainFrame

	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -100, 0, 40)
	title.Position = UDim2.new(0, 80, 0, 10)
	title.BackgroundTransparency = 1
	title.Text = "⚡ NicholasV Control Hub 2025"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 22
	title.TextColor3 = Color3.fromRGB(0, 200, 255)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = mainFrame

	-- Button template function
	local function createButton(name, text, yPos, color)
		local btn = Instance.new("TextButton")
		btn.Name = name
		btn.Size = UDim2.new(0, 180, 0, 45)
		btn.Position = UDim2.new(0.5, -90, 0, yPos)
		btn.BackgroundColor3 = color or Color3.fromRGB(0, 120, 255)
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 20
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Parent = mainFrame

		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, 6)
		c.Parent = btn

		btn.MouseButton1Click:Connect(function()
			btn.Text = "✅ " .. text .. " ON"
			btn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
			task.wait(1.5)
			btn.Text = text
			btn.BackgroundColor3 = color or Color3.fromRGB(0, 120, 255)
		end)
	end

	-- Buttons
	createButton("Magnet", "Auto Magnet", 80)
	createButton("Rebirth", "Auto Rebirth", 140, Color3.fromRGB(0, 100, 200))

	print("[NicholasV] ✅ GUI Initialized Successfully!")
end

GUI.Init()
