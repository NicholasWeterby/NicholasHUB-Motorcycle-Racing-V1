--// NicholasHUB Motorcycle Racing V1 - Main Loader
--// by NicholasV 2025

-- 🧠 ตั้งค่าฐาน GitHub URL (ต้องใช้แบบ raw)
local baseURL = "https://raw.githubusercontent.com/NicholasWetherby/NicholasHUB-Motorcycle-Racing-V1/main/NicholasHUB-MotorcycleRacingV1/src/"

-- 🔁 ฟังก์ชันสำหรับโหลด module จาก GitHub
local function import(path)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(baseURL .. path))()
    end)
    if not ok then
        warn("[NicholasHUB] ❌ โหลดไฟล์ล้มเหลว:", path)
        warn(result)
    else
        print("[NicholasHUB] ✅ โหลดสำเร็จ:", path)
    end
    return result
end

-- ⚙️ โหลดระบบหลัก
local Core = import("core/init.lua")
local GUI = import("gui/main.lua")
local Admin = import("admin/admin.lua")

-- 🚀 เริ่มการทำงาน
if Core and Core.Start then
    Core.Start()
end

if GUI and GUI.Init then
    GUI.Init()
end

if Admin and Admin.Init then
    Admin.Init()
end

print("[NicholasHUB] 🏁 NicholasV Control Hub 2025 เริ่มทำงานเรียบร้อย!")
