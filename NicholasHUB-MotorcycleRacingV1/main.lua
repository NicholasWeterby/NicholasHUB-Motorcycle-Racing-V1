--// NicholasV Control Hub v1.1 - Nicholas Signature (Blue/Gold)
--// Single-file drop-in. Parent safe (gethui/CoreGui/PlayerGui), animation, sidebar, toggles.

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Rep = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- =========================
-- THEME
-- =========================
local theme = {
    bg       = Color3.fromRGB(10,14,30),
    card     = Color3.fromRGB(12,18,34),
    header   = Color3.fromRGB(14,22,45),
    sidebar  = Color3.fromRGB(14,20,36),
    text     = Color3.fromRGB(220,235,255),
    subtext  = Color3.fromRGB(160,180,200),
    accent   = Color3.fromRGB(0,185,255),  -- blue neon
    accent2  = Color3.fromRGB(255,200,40), -- gold edge
    pillOff  = Color3.fromRGB(28,42,70),
    pillOn   = Color3.fromRGB(26,120,250),
    knob     = Color3.fromRGB(245,250,255),
    stroke   = Color3.fromRGB(0,170,255)
}

-- =========================
-- SAFE PARENT
-- =========================
local function safeParent()
    local ok, ui = pcall(gethui) ; if ok and ui then return ui end
    local cg = game:FindFirstChildOfClass("CoreGui") ; if cg then return cg end
    local pg = LP:FindFirstChild("PlayerGui") or LP:WaitForChild("PlayerGui") ; return pg
end

-- destroy old
for _,g in ipairs(safeParent():GetChildren()) do
    if g.Name == "NicholasV_HUB" then g:Destroy() end
end

-- root
local gui = Instance.new("ScreenGui")
gui.Name = "NicholasV_HUB"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = safeParent()

-- =========================
-- DROP SHADOW
-- =========================
local function addShadow(obj, transparency)
    local s = Instance.new("ImageLabel")
    s.Name = "Shadow"
    s.AnchorPoint = Vector2.new(0.5,0.5)
    s.Position = UDim2.fromScale(0.5,0.5)
    s.BackgroundTransparency = 1
    s.Image = "rbxassetid://6014261993"
    s.ImageColor3 = Color3.fromRGB(0,0,0)
    s.ImageTransparency = transparency or 0.35
    s.ScaleType = Enum.ScaleType.Slice
    s.SliceCenter = Rect.new(49,49,450,450)
    s.ZIndex = obj.ZIndex - 1
    s.Parent = obj
    s.Size = UDim2.new(1,40,1,40)
end

-- =========================
-- WINDOW
-- =========================
local win = Instance.new("Frame")
win.Name = "Window"
win.AnchorPoint = Vector2.new(0.5,0.5)
win.Position = UDim2.new(0.5,0,0.5,0)
win.Size = UDim2.fromOffset(780, 420)
win.BackgroundColor3 = theme.bg
win.BorderSizePixel = 0
win.ZIndex = 10
win.Parent = gui

Instance.new("UICorner", win).CornerRadius = UDim.new(0,14)
local stroke = Instance.new("UIStroke", win)
stroke.Thickness = 2
stroke.Color = theme.stroke
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
addShadow(win)

-- header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1,0,0,56)
header.BackgroundColor3 = theme.header
header.BorderSizePixel = 0
header.ZIndex = 11
header.Parent = win
Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

-- logo
local logo = Instance.new("ImageLabel")
logo.BackgroundTransparency = 1
logo.Size = UDim2.fromOffset(40,40)
logo.Position = UDim2.new(0,16,0,8)
logo.Image = "rbxassetid://0" -- TODO: ใส่ asset id โลโก้ N ของคุณ
logo.ZIndex = 12
logo.Parent = header

-- title
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0,64,0,0)
title.Size = UDim2.new(0.5,0,1,0)
title.Font = Enum.Font.GothamBold
title.Text = "NicholasV"
title.TextColor3 = theme.accent
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 12
title.Parent = header

local titleR = Instance.new("TextLabel")
titleR.BackgroundTransparency = 1
titleR.AnchorPoint = Vector2.new(1,0)
titleR.Position = UDim2.new(1,-110,0,0)
titleR.Size = UDim2.fromOffset(170,56)
titleR.Font = Enum.Font.Gotham
titleR.Text = "Control Hub v1.1"
titleR.TextColor3 = theme.subtext
titleR.TextSize = 18
titleR.ZIndex = 12
titleR.Parent = header

-- window controls
local function makeHeaderBtn(txt, offsetX)
    local b = Instance.new("TextButton")
    b.BackgroundColor3 = theme.card
    b.Size = UDim2.fromOffset(32,32)
    b.Position = UDim2.new(1,offsetX,0,12)
    b.AnchorPoint = Vector2.new(1,0)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextColor3 = theme.text
    b.AutoButtonColor = false
    b.ZIndex = 12
    b.Parent = header
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    local s = Instance.new("UIStroke", b)
    s.Color = theme.stroke
    s.Thickness = 1
    b.MouseEnter:Connect(function() TS:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = theme.sidebar}):Play() end)
    b.MouseLeave:Connect(function() TS:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = theme.card}):Play() end)
    return b
end

local btnMin = makeHeaderBtn("—", -60)
local btnClose = makeHeaderBtn("×", -16)

-- sidebar
local side = Instance.new("Frame")
side.Name = "Sidebar"
side.Position = UDim2.new(0,0,0,56)
side.Size = UDim2.new(0,240,1,-56)
side.BackgroundColor3 = theme.sidebar
side.BorderSizePixel = 0
side.ZIndex = 10
side.Parent = win

local sep = Instance.new("Frame")
sep.Size = UDim2.new(0,2,1,0)
sep.Position = UDim2.new(0,240,0,56)
sep.BackgroundColor3 = theme.stroke
sep.BorderSizePixel = 0
sep.ZIndex = 10
sep.Parent = win

-- content area
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0,242,0,56)
content.Size = UDim2.new(1,-244,1,-56)
content.BackgroundColor3 = theme.card
content.BorderSizePixel = 0
content.ZIndex = 10
content.Parent = win

-- heading
local heading = Instance.new("TextLabel")
heading.BackgroundTransparency = 1
heading.Position = UDim2.new(0,22,0,16)
heading.Size = UDim2.new(1,-44,0,36)
heading.Font = Enum.Font.GothamBlack
heading.Text = "Main Operations"
heading.TextColor3 = theme.text
heading.TextSize = 26
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = content

-- make draggable
do
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = win.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging=false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - dragStart
            win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- minimize / close
local minimized = false
btnMin.MouseButton1Click:Connect(function()
    minimized = not minimized
    TS:Create(win, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = minimized and UDim2.fromOffset(260, 72) or UDim2.fromOffset(780, 420)}):Play()
    content.Visible = not minimized
    side.Visible = not minimized
    sep.Visible = not minimized
end)
btnClose.MouseButton1Click:Connect(function() gui:Destroy() end)

-- =========================
-- SIDEBAR BUTTONS
-- =========================
local tabs = { "Main", "Player", "Auto", "Settings", "Credits" }
local currentTab = "Main"

local function makeSideBtn(text, order, icon)
    local btn = Instance.new("TextButton")
    btn.Name = text
    btn.Size = UDim2.new(1,-20,0,44)
    btn.Position = UDim2.new(0,10,0, 14 + (order-1)*50)
    btn.BackgroundColor3 = theme.sidebar
    btn.AutoButtonColor = false
    btn.Text = (icon or "• ") .. text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = theme.subtext
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 11
    btn.Parent = side
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    local s = Instance.new("UIStroke", btn) s.Thickness=1 s.Color=theme.stroke
    btn.MouseEnter:Connect(function()
        if currentTab ~= text then TS:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = theme.card}):Play() end
    end)
    btn.MouseLeave:Connect(function()
        if currentTab ~= text then TS:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = theme.sidebar}):Play() end
    end)
    return btn
end

local sideButtons = {}
for i,name in ipairs(tabs) do
    local icon = ({["Main"]="🏠 ",["Player"]="⚡ ",["Auto"]="🌀 ",["Settings"]="⚙️ ",["Credits"]="👤 "})[name]
    sideButtons[name] = makeSideBtn(name,i,icon)
end

local function selectTab(name)
    currentTab = name
    for n,btn in pairs(sideButtons) do
        local active = (n==name)
        TS:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = active and theme.card or theme.sidebar,
            TextColor3 = active and theme.text or theme.subtext
        }):Play()
    end
    heading.Text = (name=="Main" and "Main Operations")
                    or (name=="Player" and "Player Tweaks")
                    or (name=="Auto" and "Automation")
                    or (name=="Settings" and "Settings")
                    or "Credits"
    -- swap content pages (simple visibility for v1.1)
    for _,child in ipairs(content:GetChildren()) do
        if child:IsA("Frame") and child.Name:match("^page_") then child.Visible = false end
    end
    local page = content:FindFirstChild("page_"..name)
    if page then page.Visible = true end
end

for name,btn in pairs(sideButtons) do
    btn.MouseButton1Click:Connect(function() selectTab(name) end)
end

-- =========================
-- CONTENT PAGES
-- =========================

local function newPage(name)
    local p = Instance.new("Frame")
    p.Name = "page_"..name
    p.BackgroundTransparency = 1
    p.Size = UDim2.new(1, -44, 1, -70)
    p.Position = UDim2.new(0, 22, 0, 54)
    p.Visible = false
    p.Parent = content
    return p
end

-- toggle pill
local function makeToggle(parent, label, order, callback)
    local holder = Instance.new("Frame")
    holder.BackgroundTransparency = 1
    holder.Size = UDim2.new(1,0,0,58)
    holder.Position = UDim2.new(0,0,0,(order-1)*68)
    holder.Parent = parent

    local card = Instance.new("Frame")
    card.Size = UDim2.new(1,0,0,54)
    card.BackgroundColor3 = Color3.fromRGB(18,26,48)
    card.Parent = holder
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)
    local s = Instance.new("UIStroke", card) s.Color = theme.stroke s.Thickness=1

    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 20
    lbl.TextColor3 = theme.text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Size = UDim2.new(1,-160,1,0)
    lbl.Position = UDim2.new(0,16,0,0)
    lbl.Parent = card

    local pill = Instance.new("TextButton")
    pill.AutoButtonColor = false
    pill.BackgroundColor3 = theme.pillOff
    pill.Size = UDim2.fromOffset(112,36)
    pill.Position = UDim2.new(1,-124,0.5,-18)
    pill.Text = ""
    pill.Parent = card
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1,999)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(32,32)
    knob.Position = UDim2.new(0,2,0.5,-16)
    knob.BackgroundColor3 = theme.knob
    knob.Parent = pill
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,999)
    local ks = Instance.new("UIStroke", knob) ks.Color = Color3.fromRGB(220,230,255) ks.Thickness=1

    local state = false
    local function set(on)
        state = on
        TS:Create(pill, TweenInfo.new(0.18), {BackgroundColor3 = on and theme.pillOn or theme.pillOff}):Play()
        TS:Create(knob, TweenInfo.new(0.18), {Position = on and UDim2.new(1,-34,0.5,-16) or UDim2.new(0,2,0.5,-16)}):Play()
        if callback then task.spawn(function() callback(on) end) end
    end
    pill.MouseButton1Click:Connect(function() set(not state) end)
    return {set=set}
end

-- =========================
-- AUTO LOGIC (game-agnostic best-effort)
-- =========================
local flags = { autoMagnet=false, autoRebirth=false }

-- Auto Magnet: ดึง BasePart ที่ชื่อมีคำว่า "Orb" เข้าหาเราในระยะ 120
local function startMagnet()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    while flags.autoMagnet do
        hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _,v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("orb") then
                    local dist = (v.Position - hrp.Position).Magnitude
                    if dist < 120 then
                        v.AssemblyLinearVelocity = Vector3.zero
                        v.Position = v.Position:Lerp(hrp.Position + Vector3.new(0,2,0), 0.25)
                    end
                end
            end
        end
        task.wait(0.05)
    end
end

-- Auto Rebirth: พยายามยิงรีโมตแบบที่เคยใช้ (ห่อด้วย pcall ทุกแบบที่เจอ)
local function fireRebirth()
    local tried = 0
    local function try(fn)
        tried += 1
        local ok,err = pcall(fn)
        if ok then return true end
        return false
    end
    return
        try(function() Rep.Packages.Network.RE.Rebirth:FireServer(1) end) or
        try(function() ReplicatedStorage.Packages.Network.RE.Rebirth:FireServer(1) end) or
        try(function() Rep:WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("RE"):WaitForChild("Rebirth"):FireServer(1) end)
end

local function startRebirth()
    while flags.autoRebirth do
        fireRebirth()
        task.wait(1.2)
    end
end

-- =========================
-- PAGES + WIRING
-- =========================
-- Main
local pageMain = newPage("Main")
local togMag = makeToggle(pageMain, "Auto Magnet", 1, function(on)
    flags.autoMagnet = on
    if on then task.spawn(startMagnet) end
end)
local togReb = makeToggle(pageMain, "Auto Rebirth", 2, function(on)
    flags.autoRebirth = on
    if on then task.spawn(startRebirth) end
end)

-- Player (placeholder for future)
local pagePlayer = newPage("Player")

-- Auto (placeholder for future)
local pageAuto = newPage("Auto")

-- Settings
local pageSettings = newPage("Settings")
-- (add settings later: theme switch, sounds, save)

-- Credits
local pageCredits = newPage("Credits")
do
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Size = UDim2.new(1,0,0,24)
    t.Position = UDim2.new(0,0,0,0)
    t.Font = Enum.Font.GothamSemibold
    t.Text = "Created by NicholasV • 2025"
    t.TextColor3 = theme.subtext
    t.TextSize = 18
    t.Parent = pageCredits
end

-- init
selectTab("Main")

-- window reveal animation
win.Size = UDim2.fromOffset(780, 0)
win.Visible = true
TS:Create(win, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(780,420)}):Play()
print("[NicholasV] Control Hub v1.1 Ready.")
