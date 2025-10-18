-- NicholasV HUB Loader (Debug)
local BASE = "https://raw.githubusercontent.com/NicholasWeterby/NicholasHUB-Motorcycle-Racing-V1/main/NicholasHUB-MotorcycleRacingV1/src/"

local function import(path)
    local url = BASE..path.."?nv="..tostring(os.time()) -- กันแคช
    local ok, src = pcall(function() return game:HttpGet(url) end)
    if not ok then
        warn("[NV] GET FAIL:", path, src)
        return nil
    end
    print("[NV] GET OK:", path, "bytes:", #src)
    local ok2, mod = pcall(function() return loadstring(src)() end)
    if not ok2 then
        warn("[NV] LOADSTRING FAIL:", path, mod)
        return nil
    end
    print("[NV] LOAD OK:", path)
    return mod
end

local Core = import("core/init.lua")
local GUI  = import("gui/main.lua")
local Adm  = import("admin/admin.lua")

if Core and Core.Start then
    print("[NV] calling Core.Start()")
    pcall(Core.Start)
else
    warn("[NV] Core missing Start")
end

if GUI and GUI.Init then
    print("[NV] calling GUI.Init()")
    local ok, err = pcall(GUI.Init)
    if not ok then warn("[NV] GUI.Init error:", err) end
else
    warn("[NV] GUI missing Init")
end

if Adm and Adm.Init then
    print("[NV] calling Admin.Init()")
    pcall(Adm.Init)
else
    warn("[NV] Admin missing Init")
end

-- Fallback: ถ้า GUI ไม่ขึ้น ให้ดันกล่องทดสอบขึ้นมาเลย
task.delay(0.3, function()
    local lp = game.Players.LocalPlayer
    local pg = lp:FindFirstChildOfClass("PlayerGui")
    if pg and not pg:FindFirstChild("NicholasV_HUB") then
        warn("[NV] Fallback GUI spawn")
        local g = Instance.new("ScreenGui", pg) g.Name = "NicholasV_HUB"
        local f = Instance.new("Frame", g)
        f.Size = UDim2.new(0,420,0,220)
        f.Position = UDim2.new(0.5,-210,0.5,-110)
        f.BackgroundColor3 = Color3.fromRGB(10,10,25)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)
        local lbl = Instance.new("TextLabel", f)
        lbl.Size = UDim2.new(1,0,0,50)
        lbl.BackgroundTransparency = 1
        lbl.Text = "NV Fallback GUI ✓"
        lbl.Font = Enum.Font.GothamBold
        lbl.TextScaled = true
        lbl.TextColor3 = Color3.fromRGB(0,200,255)
    end
end)

print("[NV] loader finished")
