--// NicholasV Core Initialization
local Core = {}

local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Utils = require(script.Parent.utils)
local Config = require(script.Parent.config)

function Core.Start()
	print("[NicholasHUB] Initializing...")

	-- โหลด GUI
	local GUI = require(script.Parent.Parent.gui.main)
	GUI:Create(PlayerGui)

	print("[NicholasHUB] GUI Loaded Successfully!")
end

return Core
