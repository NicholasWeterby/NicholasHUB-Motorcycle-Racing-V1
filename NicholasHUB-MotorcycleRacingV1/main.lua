--// NicholasV Control Hub v1.2 - Nicholas Signature
--   - RightShift to toggle
--   - Player sliders (WalkSpeed / JumpPower)
--   - Auto Magnet / Auto Rebirth toggles
--   - Themes + Save/Load (if file APIs available)
--   - Logo fetched from GitHub raw => custom asset (if supported)

-- ====== SHORTCUTS ======
local TS, UIS, RS = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("RunService")
local Rep, Players, Http = game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("HttpService")
local LP = Players.LocalPlayer

-- ====== EXECUTOR FEATURES (optional) ======
local hasWrite  = typeof(writefile) == "function"
local hasRead   = typeof(readfile)  == "function"
local hasIsFile = typeof(isfile)    == "function"
local getasset  = getcustomasset or getsynasset
local function safeParent()
    local ok,ui = pcall(gethui); if ok and ui then return ui end
    return game:FindFirstChildOfClass("CoreGui") or LP:WaitForChild("PlayerGui")
end

-- ====== SETTINGS (persist if possible) ======
local SETTINGS_PATH = "NicholasV/nichub_settings.json"
local settings = {
  theme = "signature",  -- signature / neon / cyan / gold
  autos = { magnet=false, rebirth=false },
  player = { ws = 16, jp = 50 }
}
local function loadSettings()
  if hasIsFile and hasRead and isfile(SETTINGS_PATH) then
    local ok, data = pcall(function() return Http:JSONDecode(readfile(SETTINGS_PATH)) end)
    if ok and type(data)=="table" then for k,v in pairs(data) do settings[k]=v end end
  end
end
local function saveSettings()
  if not (hasWrite) then return end
  pcall(function()
    if not isfile("NicholasV") then writefile("NicholasV/.keep","") end
  end)
  pcall(function() writefile(SETTINGS_PATH, Http:JSONEncode(settings)) end)
end
loadSettings()

-- ====== THEMES ======
local themes = {
  signature = {bg=Color3.fromRGB(10,14,30), card=Color3.fromRGB(12,18,34), header=Color3.fromRGB(14,22,45),
               sidebar=Color3.fromRGB(14,20,36), text=Color3.fromRGB(225,235,255), sub=Color3.fromRGB(160,180,200),
               stroke=Color3.fromRGB(0,170,255), pillOff=Color3.fromRGB(28,42,70), pillOn=Color3.fromRGB(26,120,250),
               knob=Color3.fromRGB(245,250,255) },
  neon = {bg=Color3.fromRGB(12,10,22), card=Color3.fromRGB(18,16,32), header=Color3.fromRGB(22,18,44),
           sidebar=Color3.fromRGB(20,16,40), text=Color3.fromRGB(235,240,255), sub=Color3.fromRGB(170,170,210),
           stroke=Color3.fromRGB(180,80,255), pillOff=Color3.fromRGB(40,30,70), pillOn=Color3.fromRGB(160,60,255),
           knob=Color3.fromRGB(250,245,255) },
  cyan = {bg=Color3.fromRGB(8,14,18), card=Color3.fromRGB(10,18,22), header=Color3.fromRGB(14,22,26),
           sidebar=Color3.fromRGB(12,20,24), text=Color3.fromRGB(220,245,250), sub=Color3.fromRGB(150,190,200),
           stroke=Color3.fromRGB(0,200,220), pillOff=Color3.fromRGB(24,40,44), pillOn=Color3.fromRGB(0,160,180),
           knob=Color3.fromRGB(245,255,255) },
  gold = {bg=Color3.fromRGB(16,12,8), card=Color3.fromRGB(22,18,12), header=Color3.fromRGB(28,22,14),
          sidebar=Color3.fromRGB(26,20,12), text=Color3.fromRGB(255,240,210), sub=Color3.fromRGB(210,190,160),
          stroke=Color3.fromRGB(255,200,60), pillOff=Color3.fromRGB(40,30,16), pillOn=Color3.fromRGB(255,170,40),
          knob=Color3.fromRGB(255,245,220) },
}
local T = themes[settings.theme] or themes.signature

-- ====== DESTROY OLD & ROOT ======
for _,g in ipairs(safeParent():GetChildren()) do if g.Name=="NicholasV_HUB" then g:Destroy() end end
local gui = Instance.new("ScreenGui"); gui.Name="NicholasV_HUB"; gui.IgnoreGuiInset=true; gui.ResetOnSpawn=false; gui.Parent=safeParent()

-- ====== UTILS ======
local function shadow(parent, alpha)
  local s = Instance.new("ImageLabel")
  s.BackgroundTransparency = 1; s.AnchorPoint=Vector2.new(0.5,0.5); s.Position=UDim2.fromScale(0.5,0.5)
  s.Image="rbxassetid://6014261993"; s.ImageColor3=Color3.new(0,0,0); s.ImageTransparency=alpha or .35
  s.ScaleType=Enum.ScaleType.Slice; s.SliceCenter=Rect.new(49,49,450,450); s.ZIndex=parent.ZIndex-1
  s.Size=UDim2.new(1,40,1,40); s.Parent=parent
end
local function tween(o,t,props) TS:Create(o,TweenInfo.new(t or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),props):Play() end

-- ====== WINDOW ======
local win = Instance.new("Frame"); win.Name="Window"; win.AnchorPoint=Vector2.new(.5,.5); win.Position=UDim2.fromScale(.5,.5)
win.Size=UDim2.fromOffset(780,420); win.BackgroundColor3=T.bg; win.BorderSizePixel=0; win.ZIndex=10; win.Parent=gui
Instance.new("UICorner",win).CornerRadius=UDim.new(0,14)
local st=Instance.new("UIStroke",win); st.Thickness=2; st.Color=T.stroke; st.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
shadow(win)

-- header
local header=Instance.new("Frame"); header.Size=UDim2.new(1,0,0,56); header.BackgroundColor3=T.header; header.BorderSizePixel=0; header.ZIndex=11; header.Parent=win
Instance.new("UICorner",header).CornerRadius=UDim.new(0,14)

-- logo from GitHub (optional via custom asset)
local logo=Instance.new("ImageLabel"); logo.BackgroundTransparency=1; logo.Size=UDim2.fromOffset(40,40); logo.Position=UDim2.new(0,16,0,8); logo.ZIndex=12; logo.Parent=header
do
  local LOGO_URL = "https://raw.githubusercontent.com/NicholasWeterby/NicholasHUB-Motorcycle-Racing-V1/main/NicholasHUB-MotorcycleRacingV1/src/assets/logo512.png"
  if getasset and hasWrite then
    local ok,bytes = pcall(game.HttpGet,game,LOGO_URL)
    if ok and bytes and #bytes>0 then
      pcall(function()
        if not isfile("NicholasV") then writefile("NicholasV/.keep","") end
        writefile("NicholasV/logo.png",bytes)
        logo.Image = getasset("NicholasV/logo.png")
      end)
    end
  end
  if logo.Image=="" then
    logo.Image = "rbxassetid://0" -- fallback (ใส่ asset id ทีหลังได้)
  end
end

local title=Instance.new("TextLabel"); title.BackgroundTransparency=1; title.Position=UDim2.new(0,64,0,0)
title.Size=UDim2.new(0.5,0,1,0); title.Font=Enum.Font.GothamBold; title.Text="NicholasV"; title.TextColor3=T.stroke; title.TextSize=22; title.TextXAlignment=Enum.TextXAlignment.Left; title.ZIndex=12; title.Parent=header
local titleR=Instance.new("TextLabel"); titleR.BackgroundTransparency=1; titleR.AnchorPoint=Vector2.new(1,0); titleR.Position=UDim2.new(1,-110,0,0)
titleR.Size=UDim2.fromOffset(170,56); titleR.Font=Enum.Font.Gotham; titleR.Text="Control Hub v1.2"; titleR.TextColor3=themes.signature.sub; titleR.TextSize=18; titleR.ZIndex=12; titleR.Parent=header
local function headerBtn(txt,ox)
  local b=Instance.new("TextButton"); b.AutoButtonColor=false; b.BackgroundColor3=T.card; b.Size=UDim2.fromOffset(32,32)
  b.Position=UDim2.new(1,ox,0,12); b.AnchorPoint=Vector2.new(1,0); b.Text=txt; b.Font=Enum.Font.GothamBold; b.TextSize=16; b.TextColor3=themes.signature.text; b.ZIndex=12; b.Parent=header
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,8); local s=Instance.new("UIStroke",b); s.Color=themes.signature.stroke; s.Thickness=1
  b.MouseEnter:Connect(function() tween(b,.12,{BackgroundColor3=T.sidebar}) end)
  b.MouseLeave:Connect(function() tween(b,.12,{BackgroundColor3=T.card}) end)
  return b
end
local btnMin = headerBtn("—",-60)
local btnClose = headerBtn("×",-16)

-- sidebar & content
local side=Instance.new("Frame"); side.Position=UDim2.new(0,0,0,56); side.Size=UDim2.new(0,240,1,-56); side.BackgroundColor3=T.sidebar; side.BorderSizePixel=0; side.ZIndex=10; side.Parent=win
local sep=Instance.new("Frame"); sep.Size=UDim2.new(0,2,1,0); sep.Position=UDim2.new(0,240,0,56); sep.BackgroundColor3=T.stroke; sep.BorderSizePixel=0; sep.ZIndex=10; sep.Parent=win
local content=Instance.new("Frame"); content.Position=UDim2.new(0,242,0,56); content.Size=UDim2.new(1,-244,1,-56); content.BackgroundColor3=T.card; content.BorderSizePixel=0; content.ZIndex=10; content.Parent=win
local heading=Instance.new("TextLabel"); heading.BackgroundTransparency=1; heading.Position=UDim2.new(0,22,0,16); heading.Size=UDim2.new(1,-44,0,36)
heading.Font=Enum.Font.GothamBlack; heading.Text="Main Operations"; heading.TextColor3=themes.signature.text; heading.TextSize=26; heading.TextXAlignment=Enum.TextXAlignment.Left; heading.Parent=content

-- drag window
do
  local dragging=false, dragStart, startPos
  header.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; dragStart=i.Position; startPos=win.Position
      i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
    end
  end)
  UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
      local d=i.Position-dragStart; win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
  end)
end

-- minimize/close + hotkey toggle
local minimized=false
local function setVisible(v) gui.Enabled=v end
btnMin.MouseButton1Click:Connect(function()
  minimized=not minimized; tween(win,.22,{Size=minimized and UDim2.fromOffset(260,72) or UDim2.fromOffset(780,420)})
  content.Visible=not minimized; side.Visible=not minimized; sep.Visible=not minimized
end)
btnClose.MouseButton1Click:Connect(function() gui:Destroy() end)
UIS.InputBegan:Connect(function(i,gp)
  if not gp and i.KeyCode==Enum.KeyCode.RightShift then setVisible(not gui.Enabled) end
end)

-- ====== TABS ======
local tabs={"Main","Player","Auto","Settings","Credits"}; local tabBtns={}; local currentTab="Main"
local function makeTab(name,order,icon)
  local btn=Instance.new("TextButton"); btn.Name=name; btn.Size=UDim2.new(1,-20,0,44); btn.Position=UDim2.new(0,10,0,14+(order-1)*50)
  btn.BackgroundColor3=T.sidebar; btn.AutoButtonColor=false; btn.Text=(icon or "• ")..name; btn.Font=Enum.Font.GothamBold; btn.TextSize=18
  btn.TextColor3=themes.signature.sub; btn.TextXAlignment=Enum.TextXAlignment.Left; btn.ZIndex=11; btn.Parent=side
  Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8); local s=Instance.new("UIStroke",btn); s.Color=themes.signature.stroke; s.Thickness=1
  btn.MouseEnter:Connect(function() if currentTab~=name then tween(btn,.12,{BackgroundColor3=T.card}) end end)
  btn.MouseLeave:Connect(function() if currentTab~=name then tween(btn,.12,{BackgroundColor3=T.sidebar}) end end)
  return btn
end
local icons={Main="🏠 ",Player="⚡ ",Auto="🌀 ",Settings="⚙️ ",Credits="👤 "}
for i,n in ipairs(tabs) do tabBtns[n]=makeTab(n,i,icons[n]) end

local function newPage(name)
  local p=Instance.new("Frame"); p.Name="page_"..name; p.BackgroundTransparency=1; p.Size=UDim2.new(1,-44,1,-70); p.Position=UDim2.new(0,22,0,54)
  p.Visible=false; p.Parent=content; return p
end
local function selectTab(name)
  currentTab=name
  for n,b in pairs(tabBtns) do
    local active=(n==name)
    tween(b,.15,{BackgroundColor3=active and T.card or T.sidebar, TextColor3=active and themes.signature.text or themes.signature.sub})
  end
  heading.Text = name=="Main" and "Main Operations" or name=="Player" and "Player Tweaks" or name=="Auto" and "Automation" or name=="Settings" and "Settings" or "Credits"
  for _,c in ipairs(content:GetChildren()) do if c:IsA("Frame") and c.Name:match("^page_") then c.Visible=false end end
  local page=content:FindFirstChild("page_"..name) if page then page.Visible=true end
end
for n,b in pairs(tabBtns) do b.MouseButton1Click:Connect(function() selectTab(n) end) end

-- ====== TOGGLE UI ======
local function makeToggle(parent,label,order,onToggle)
  local holder=Instance.new("Frame"); holder.BackgroundTransparency=1; holder.Size=UDim2.new(1,0,0,58); holder.Position=UDim2.new(0,0,0,(order-1)*68); holder.Parent=parent
  local card=Instance.new("Frame"); card.Size=UDim2.new(1,0,0,54); card.BackgroundColor3=Color3.fromRGB(18,26,48); card.Parent=holder
  Instance.new("UICorner",card).CornerRadius=UDim.new(0,10); local s=Instance.new("UIStroke",card); s.Color=T.stroke; s.Thickness=1
  local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1; lbl.Text=label; lbl.Font=Enum.Font.GothamSemibold; lbl.TextSize=20; lbl.TextColor3=themes.signature.text; lbl.TextXAlignment=Enum.TextXAlignment.Left
  lbl.Size=UDim2.new(1,-160,1,0); lbl.Position=UDim2.new(0,16,0,0); lbl.Parent=card
  local pill=Instance.new("TextButton"); pill.AutoButtonColor=false; pill.BackgroundColor3=T.pillOff; pill.Size=UDim2.fromOffset(112,36); pill.Position=UDim2.new(1,-124,0.5,-18); pill.Text=""; pill.Parent=card
  Instance.new("UICorner",pill).CornerRadius=UDim.new(1,999)
  local knob=Instance.new("Frame"); knob.Size=UDim2.fromOffset(32,32); knob.Position=UDim2.new(0,2,0.5,-16); knob.BackgroundColor3=T.knob; knob.Parent=pill
  Instance.new("UICorner",knob).CornerRadius=UDim.new(1,999); Instance.new("UIStroke",knob).Thickness=1
  local state=false
  local function set(v)
    state=v; tween(pill,.18,{BackgroundColor3=v and T.pillOn or T.pillOff}); tween(knob,.18,{Position=v and UDim2.new(1,-34,0.5,-16) or UDim2.new(0,2,0.5,-16)})
    if onToggle then task.spawn(onToggle,v) end
  end
  pill.MouseButton1Click:Connect(function() set(not state); saveSettings() end)
  return {set=set}
end

-- ====== SLIDER UI ======
local function makeSlider(parent,label,order,min,max,step,default,onChange)
  local holder=Instance.new("Frame"); holder.BackgroundTransparency=1; holder.Size=UDim2.new(1,0,0,72); holder.Position=UDim2.new(0,0,0,(order-1)*80); holder.Parent=parent
  local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1; lbl.Text=label; lbl.Font=Enum.Font.GothamSemibold; lbl.TextSize=18; lbl.TextColor3=themes.signature.text; lbl.TextXAlignment=Enum.TextXAlignment.Left
  lbl.Size=UDim2.new(1,0,0,22); lbl.Position=UDim2.new(0,4,0,0); lbl.Parent=holder
  local bar=Instance.new("Frame"); bar.Size=UDim2.new(1,-20,0,10); bar.Position=UDim2.new(0,10,0,34); bar.BackgroundColor3=Color3.fromRGB(26,36,60); bar.Parent=holder
  Instance.new("UICorner",bar).CornerRadius=UDim.new(0,6)
  local fill=Instance.new("Frame"); fill.BackgroundColor3=T.stroke; fill.Size=UDim2.new(0,0,1,0); fill.Parent=bar; Instance.new("UICorner",fill).CornerRadius=UDim.new(0,6)
  local knob=Instance.new("ImageButton"); knob.BackgroundColor3=Color3.fromRGB(250,250,255); knob.Size=UDim2.fromOffset(16,16); knob.AnchorPoint=Vector2.new(.5,.5); knob.Position=UDim2.new(0,0,0.5,0); knob.Parent=bar
  Instance.new("UICorner",knob).CornerRadius=UDim.new(1,999)
  local valText=Instance.new("TextLabel"); valText.BackgroundTransparency=1; valText.Position=UDim2.new(1,-60,0,14); valText.Size=UDim2.fromOffset(60,22)
  valText.Font=Enum.Font.Gotham; valText.TextColor3=themes.signature.sub; valText.TextSize=14; valText.TextXAlignment=Enum.TextXAlignment.Right; valText.Parent=holder
  local value = default
  local function setFromAlpha(a)
    a = math.clamp(a,0,1)
    local v = math.floor((min + (max-min)*a)/step+0.5)*step
    value = math.clamp(v,min,max)
    local x = a*(bar.AbsoluteSize.X)
    fill.Size = UDim2.new(a,0,1,0)
    knob.Position = UDim2.new(a,0,0.5,0)
    valText.Text = tostring(value)
    if onChange then onChange(value) end
  end
  local function set(v) local a=(v-min)/(max-min); setFromAlpha(a) end
  -- drag
  local dragging=false
  local function update(input) local rel=(input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X; setFromAlpha(rel) end
  knob.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
  UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false; saveSettings() end end)
  UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then update(i) end end)
  -- init
  set(default)
  return {set=set, get=function() return value end}
end

-- ====== AUTO LOGIC ======
local flags = settings.autos
local function startMagnet()
  while flags.magnet do
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
      for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("orb") then
          local d=(v.Position-hrp.Position).Magnitude
          if d<120 then v.AssemblyLinearVelocity=Vector3.zero; v.Position=v.Position:Lerp(hrp.Position+Vector3.new(0,2,0),0.25) end
        end
      end
    end
    task.wait(0.05)
  end
end
local function fireRebirth()
  local ok=false
  local function try(fn) local s=pcall(fn); ok = ok or s end
  try(function() Rep.Packages.Network.RE.Rebirth:FireServer(1) end)
  try(function() game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("RE"):WaitForChild("Rebirth"):FireServer(1) end)
  return ok
end
local function startRebirth() while flags.rebirth do fireRebirth(); task.wait(1.2) end end

-- ====== PAGES ======
local pageMain = newPage("Main")
local mainMag = makeToggle(pageMain,"Auto Magnet",1,function(on) flags.magnet=on; settings.autos.magnet=on; if on then task.spawn(startMagnet) end end)
local mainReb = makeToggle(pageMain,"Auto Rebirth",2,function(on) flags.rebirth=on; settings.autos.rebirth=on; if on then task.spawn(startRebirth) end end)
mainMag.set(flags.magnet); mainReb.set(flags.rebirth)

local pagePlayer = newPage("Player")
local humanoid = function() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end
local defaultWS, defaultJP = settings.player.ws, settings.player.jp
local sWS = makeSlider(pagePlayer,"WalkSpeed",1,8,200,1, defaultWS, function(v) settings.player.ws=v; local h=humanoid(); if h then h.WalkSpeed=v end end)
local sJP = makeSlider(pagePlayer,"JumpPower",2,10,300,1, defaultJP, function(v) settings.player.jp=v; local h=humanoid(); if h then h.JumpPower=v end end)
-- apply current to character
task.spawn(function() while RS.Heartbeat:Wait() do local h=humanoid(); if h then h.WalkSpeed=settings.player.ws; h.JumpPower=settings.player.jp end end end)
-- reset button
do
  local b=Instance.new("TextButton"); b.Size=UDim2.fromOffset(120,36); b.Position=UDim2.new(0,10,0,160); b.BackgroundColor3=T.pillOn; b.Text="Reset"; b.Font=Enum.Font.GothamBold; b.TextColor3=Color3.new(1,1,1); b.Parent=pagePlayer
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
  b.MouseButton1Click:Connect(function()
    settings.player.ws, settings.player.jp = 16, 50
    sWS.set(16); sJP.set(50); saveSettings()
  end)
end

local pageAuto = newPage("Auto")
do
  local t=Instance.new("TextLabel"); t.BackgroundTransparency=1; t.Size=UDim2.new(1,0,0,24); t.Text="(เตรียมช่องสำหรับ Auto อื่น ๆ เพิ่มเติม)"; t.Font=Enum.Font.Gotham; t.TextColor3=themes.signature.sub; t.TextSize=16; t.Parent=pageAuto
end

local pageSettings = newPage("Settings")
-- theme picker
local y=0
for key,_ in pairs(themes) do
  y += 1
  local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,160,0,36); btn.Position=UDim2.new(0,10,0,(y-1)*44)
  btn.BackgroundColor3=T.pillOff; btn.Text="Theme: "..key; btn.TextColor3=themes.signature.text; btn.Font=Enum.Font.GothamSemibold; btn.TextSize=14; btn.Parent=pageSettings
  Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
  btn.MouseButton1Click:Connect(function()
    settings.theme = key; saveSettings()
    -- simple notice
    btn.Text = "Theme: "..key.." ✓ (reload)"
  end)
end
local hint=Instance.new("TextLabel"); hint.BackgroundTransparency=1; hint.Position=UDim2.new(0,10,0, y*44+8); hint.Size=UDim2.new(1,-20,0,20)
hint.Text="* เปลี่ยนธีมจะใช้เมื่อรันสคริปต์ครั้งถัดไป"; hint.Font=Enum.Font.Gotham; hint.TextColor3=themes.signature.sub; hint.TextXAlignment=Enum.TextXAlignment.Left; hint.TextSize=14; hint.Parent=pageSettings

local pageCredits = newPage("Credits")
do
  local t1=Instance.new("TextLabel"); t1.BackgroundTransparency=1; t1.Size=UDim2.new(1,0,0,24); t1.Text="Created by NicholasV • 2025"; t1.Font=Enum.Font.GothamSemibold; t1.TextColor3=themes.signature.sub; t1.TextSize=18; t1.Parent=pageCredits
end

-- init
selectTab("Main")
-- reveal animation
win.Size=UDim2.fromOffset(780,0); tween(win,.22,{Size=UDim2.fromOffset(780,420)})
print("[NicholasV] Control Hub v1.2 ready.")

-- auto-resume running toggles
if flags.magnet then task.spawn(startMagnet) end
if flags.rebirth then task.spawn(startRebirth) end

