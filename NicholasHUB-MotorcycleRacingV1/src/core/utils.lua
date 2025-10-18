--// Utility Functions

local Utils = {}
local TweenService = game:GetService("TweenService")

function Utils:tween(obj, goal, time)
	return TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal)
end

function Utils:dragify(frame)
	local UIS = game:GetService("UserInputService")
	local dragging, dragInput, startPos, startMousePos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			startMousePos = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - startMousePos
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

return Utils
