--// NicholasHUB Motorcycle Racing V1 Loader
--// By NicholasV 2025

-- ตัว URL base
local BASE = "https://raw.githubusercontent.com/NicholasWeterby/NicholasHUB-Motorcycle-Racing-V1/main/NicholasHUB-MotorcycleRacingV1/src/"

-- โหลดไฟล์จาก GitHub
local function import(path)
    local url = BASE..path.."?v="..tostring(os.time())
    local ok, src = pcall(function() return game:HttpGet(url) end)
    if not ok then
        warn("[NicholasV] Failed to load:", path)
        return nil
    end
    local fn, err = loadstring(src)
    if not fn then
        warn("[NicholasV] loadstring error:", err)
        return nil
    end
    local result = fn()
    print("[NicholasV] Loaded:", path)
    return result
end

-- โหลด modules
local GUI = import("gui/main.lua")

-- รัน GUI
if GUI and GUI.Init then
    print("[NicholasV] Initializing GUI...")
    GUI.Init()
else
    warn("[NicholasV] GUI not found or missing Init()")
end
