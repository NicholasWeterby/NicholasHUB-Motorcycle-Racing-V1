--// NicholasV HUB Loader (Full Debug)
print("[NV] Loader started")

local BASE = "https://raw.githubusercontent.com/NicholasWeterby/NicholasHUB-Motorcycle-Racing-V1/main/NicholasHUB-MotorcycleRacingV1/src/"

-- ฟังก์ชันโหลดไฟล์จาก GitHub
local function import(path)
    print("[NV] Importing:", path)
    local url = BASE..path.."?v="..tostring(os.time())
    local ok, src = pcall(function() return game:HttpGet(url) end)
    if not ok then
        warn("[NV] ❌ HttpGet failed for", path, ":", src)
        return nil
    end
    print("[NV] ✅ Got code:", #src, "bytes")

    local fn, err = loadstring(src)
    if not fn then
        warn("[NV] ❌ loadstring failed:", err)
        return nil
    end
    local result = nil
    local ok2, msg = pcall(function()
        result = fn()
    end)
    if not ok2 then
        warn("[NV] ❌ Error executing file:", msg)
    else
        print("[NV] ✅ Executed:", path)
    end
    return result
end

-- โหลด GUI module
local GUI = import("gui/main.lua")

-- รัน GUI
if GUI and type(GUI.Init) == "function" then
    print("[NV] 🚀 Running GUI.Init() ...")
    local ok, msg = pcall(GUI.Init)
    if ok then
        print("[NV] ✅ GUI.Init() executed successfully!")
    else
        warn("[NV] ❌ GUI.Init() error:", msg)
    end
else
    warn("[NV] ❌ GUI.Init not found or GUI nil")
end

print("[NV] Loader done")
