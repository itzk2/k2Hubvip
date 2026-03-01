loadstring(game:HttpGet("https://raw.githubusercontent.com/itzk2/k2Hubvip/refs/heads/main/k2modhub.lua"))()

-- k2modhub ULTRA VIP FULL

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local SaveFile = "k2modhub_theme.json"

-- ===== SAVE =====
local Theme = {R = 170, G = 0, B = 255}

if writefile and isfile and isfile(SaveFile) then
    Theme = HttpService:JSONDecode(readfile(SaveFile))
end

local function Save()
    if writefile then
        writefile(SaveFile, HttpService:JSONEncode(Theme))
    end
end

local function Accent()
    return Color3.fromRGB(Theme.R, Theme.G, Theme.B)
end

-- ===== SCRIPT LIST =====
local ScriptList = {
    {Name="Banana Hub", Url="https://raw.githubusercontent.com/hdanhvip/hdanhhub/refs/heads/main/BananaHub.lua.txt"},
    {Name="Maru Hub", Url="https://raw.githubusercontent.com/longhihilonghihi-hub/MaruHubV1/refs/heads/main/MainV1.Lua"},
    {Name="Gravity Hub", Url="https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"}
}
-- ===== BLUR =====
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0
TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 18}):Play()

-- ===== UI =====
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,0,0,0)
Main.Position = UDim2.new(0.5,-260,0.5,-180)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

-- Rainbow glow
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2

task.spawn(function()
    local hue = 0
    while true do
        hue += 0.005
        if hue > 1 then hue = 0 end
        Stroke.Color = Color3.fromHSV(hue,1,1)
        task.wait()
    end
end)

-- Animation mở
TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
    Size = UDim2.new(0,520,0,360)
}):Play()

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,45)
Title.Text = "k2modhub ULTRA"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Accent()
Title.BackgroundTransparency = 1

-- ===== SCRIPT CONTAINER =====
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(0.5,-15,1,-70)
Container.Position = UDim2.new(0,10,0,60)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0,8)

local Buttons = {}

local function LoadScript(url)
    local s, r = pcall(function()
        return game:HttpGet(url)
    end)
    if s then
        loadstring(r)()
    end
end

for _, v in pairs(ScriptList) do
    local B = Instance.new("TextButton", Container)
    B.Size = UDim2.new(1,0,0,38)
    B.Text = v.Name
    B.Font = Enum.Font.Gotham
    B.TextSize = 14
    B.TextColor3 = Color3.new(1,1,1)
    B.BackgroundColor3 = Accent()

    Instance.new("UICorner", B).CornerRadius = UDim.new(0,10)

    B.MouseButton1Click:Connect(function()
        LoadScript(v.Url)
    end)

    table.insert(Buttons, B)
end

-- ===== RGB SLIDER =====
local Picker = Instance.new("Frame", Main)
Picker.Size = UDim2.new(0.5,-15,1,-70)
Picker.Position = UDim2.new(0.5,5,0,60)
Picker.BackgroundTransparency = 1

local function CreateSlider(name, y)
    local Label = Instance.new("TextLabel", Picker)
    Label.Text = name
    Label.Size = UDim2.new(1,0,0,20)
    Label.Position = UDim2.new(0,0,0,y)
    Label.TextColor3 = Color3.new(1,1,1)
    Label.BackgroundTransparency = 1

    local Bar = Instance.new("Frame", Picker)
    Bar.Size = UDim2.new(1,0,0,8)
    Bar.Position = UDim2.new(0,0,0,y+25)
    Bar.BackgroundColor3 = Color3.fromRGB(60,60,60)

    local Knob = Instance.new("Frame", Bar)
    Knob.Size = UDim2.new(0,14,0,14)
    Knob.Position = UDim2.new(Theme[name]/255,-7,-0.4,0)
    Knob.BackgroundColor3 = Accent()
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local drag = false

    Knob.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
        end
    end)

    Knob.InputEnded:Connect(function()
        drag = false
    end)

    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = (i.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X
            pos = math.clamp(pos,0,1)

            Knob.Position = UDim2.new(pos,-7,-0.4,0)
            Theme[name] = math.floor(pos*255)
            Save()

            Title.TextColor3 = Accent()

            for _, b in pairs(Buttons) do
                TweenService:Create(b, TweenInfo.new(0.2), {
                    BackgroundColor3 = Accent()
                }):Play()
            end

            Knob.BackgroundColor3 = Accent()
        end
    end)
end

CreateSlider("R",10)
CreateSlider("G",90)
CreateSlider("B",170)

-- ===== PARTICLES =====
local ParticleFrame = Instance.new("Frame", Main)
ParticleFrame.Size = UDim2.new(1,0,1,0)
ParticleFrame.BackgroundTransparency = 1

task.spawn(function()
    while true do
        local p = Instance.new("Frame", ParticleFrame)
        p.Size = UDim2.new(0,4,0,4)
        p.Position = UDim2.new(math.random(),0,1,0)
        p.BackgroundColor3 = Accent()
        Instance.new("UICorner", p).CornerRadius = UDim.new(1,0)

        TweenService:Create(p, TweenInfo.new(math.random(2,4)), {
            Position = UDim2.new(math.random(),0,0,0),
            BackgroundTransparency = 1
        }):Play()

        task.delay(4,function()
            p:Destroy()
        end)

        task.wait(0.1)
    end
end)

-- ===== CLOSE =====
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,8)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(120,0,0)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
    Blur:Destroy()
    ScreenGui:Destroy()
end)
