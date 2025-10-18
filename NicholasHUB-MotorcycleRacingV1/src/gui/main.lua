--// NicholasV HUB GUI Main
local GUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Utils = require(script.Parent.Parent.core.utils)
local Config = require(script.Parent.Parent.core.config)

function GUI:Create(PlayerGui)
	local Screen = Instance.new("ScreenGui")
	Screen.Name = "NicholasHUB"
	Screen.ResetOnSpawn = false
	Screen.IgnoreGuiInset = true
	Screen.Parent = PlayerGui

	-- Main Frame
	local Frame = Instance.new("Frame", Screen)
	Frame.Size = UDim2.new(0, 500, 0, 300)
	Frame.Position = UDim2.new(0.5, -250, 0.5, -150)
	Frame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
	Frame.BorderSizePixel = 0
	Frame.BackgroundTransparency = 0.15
	Utils:dragify(Frame)

	local UICorner = Instance.new("UICorner", Frame)
	UICorner.CornerRadius = UDim.new(0, 12)

	local UIStroke = Instance.new("UIStroke", Frame)
	UIStroke.Thickness = 2
	UIStroke.Color = Color3.fromRGB(0, 255, 255)

	-- Header
	local Header = Instance.new("TextLabel", Frame)
	Header.Text = "🏍️ NicholasHUB - Motorcycle Racing V1"
	Header.Font = Enum.Font.GothamBold
	Header.TextSize = 20
	Header.TextColor3 = Color3.fromRGB(0, 255, 255)
	Header.BackgroundTransparency = 1
	Header.Size = UDim2.new(1, -20, 0, 40)
	Header.Position = UDim2.new(0, 10, 0, 10)
	Header.TextXAlignment = Enum.TextXAlignment.Left

	-- ปุ่มปิด / ย่อ
	local Close = Instance.new("TextButton", Frame)
	Close.Size = UDim2.new(0, 30, 0, 30)
	Close.Position = UDim2.new(1, -40, 0, 10)
	Close.Text = "✖"
	Close.Font = Enum.Font.GothamBold
	Close.TextColor3 = Color3.fromRGB(255, 100, 100)
	Close.BackgroundTransparency = 1

	Close.MouseButton1Click:Connect(function()
		Utils:tween(Frame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.4):Play()
		wait(0.4)
		Screen:Destroy()
	end)

	-- Animation Fade-In
	Frame.Size = UDim2.new(0, 0, 0, 0)
	Utils:tween(Frame, {Size = UDim2.new(0, 500, 0, 300)}, Config.AnimationSpeed):Play()
end

return GUI
