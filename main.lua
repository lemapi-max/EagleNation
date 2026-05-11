--//======================================================
--// LenApi | Eagle Nation Premium
--// Complete GUI Script
--//======================================================

repeat task.wait() until game:IsLoaded()

------------------------------------------------
-- SERVICES
------------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- DELETE OLD GUI
------------------------------------------------

pcall(function()
    game.CoreGui:FindFirstChild("LenApiLoader"):Destroy()
    game.CoreGui:FindFirstChild("LenApiToggle"):Destroy()
end)

------------------------------------------------
-- LOADING SCREEN
------------------------------------------------

local Loader = Instance.new("ScreenGui")
Loader.Name = "LenApiLoader"
Loader.Parent = game.CoreGui

local Main = Instance.new("Frame", Loader)
Main.Size = UDim2.new(0,320,0,170)
Main.Position = UDim2.new(0.5,-160,0.5,-85)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,15)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0,255,120)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,50)
Title.Font = Enum.Font.GothamBlack
Title.Text = "LAWLIET"
Title.TextSize = 30
Title.TextColor3 = Color3.fromRGB(0,255,120)

local BarBG = Instance.new("Frame", Main)
BarBG.Position = UDim2.new(0.1,0,0.6,0)
BarBG.Size = UDim2.new(0.8,0,0,18)
BarBG.BackgroundColor3 = Color3.fromRGB(35,35,35)

Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame", BarBG)
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(0,255,120)

Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

local Percent = Instance.new("TextLabel", Main)
Percent.BackgroundTransparency = 1
Percent.Position = UDim2.new(0,0,0.75,0)
Percent.Size = UDim2.new(1,0,0,30)
Percent.Font = Enum.Font.GothamBold
Percent.TextSize = 18
Percent.TextColor3 = Color3.fromRGB(255,255,255)

for i = 1,100 do

    Bar:TweenSize(
        UDim2.new(i/100,0,1,0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Linear,
        0.03,
        true
    )

    Percent.Text = i.."/100"

    task.wait(0.02)

end

task.wait(1)
Loader:Destroy()

------------------------------------------------
-- LOAD UI LIBRARY
------------------------------------------------

local Fluent = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/dawid-scripts/Fluent/master/source.lua"
))()

------------------------------------------------
-- FLOAT BUTTON
------------------------------------------------

local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "LenApiToggle"
ToggleGui.Parent = game.CoreGui

local OpenButton = Instance.new("TextButton", ToggleGui)
OpenButton.Size = UDim2.new(0,55,0,55)
OpenButton.Position = UDim2.new(0.03,0,0.3,0)
OpenButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
OpenButton.Text = "L"
OpenButton.Font = Enum.Font.GothamBlack
OpenButton.TextSize = 32
OpenButton.TextColor3 = Color3.fromRGB(0,255,120)
OpenButton.Active = true
OpenButton.Draggable = true

Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1,0)

local ButtonStroke = Instance.new("UIStroke", OpenButton)
ButtonStroke.Color = Color3.fromRGB(0,255,120)
ButtonStroke.Thickness = 2

------------------------------------------------
-- WINDOW
------------------------------------------------

local Window = Fluent:CreateWindow({
    Title = "LenApi",
    SubTitle = "Eagle Nation",
    TabWidth = 160,
    Size = UDim2.fromOffset(620,420),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

------------------------------------------------
-- GUI TOGGLE
------------------------------------------------

local GuiVisible = true

OpenButton.MouseButton1Click:Connect(function()

    GuiVisible = not GuiVisible

    pcall(function()
        game.CoreGui.Fluent.Enabled = GuiVisible
    end)

end)

------------------------------------------------
-- TABS
------------------------------------------------

local Tabs = {

    Main = Window:AddTab({
        Title = "Main",
        Icon = "home"
    }),

    Teleport = Window:AddTab({
        Title = "Teleport",
        Icon = "map-pinned"
    }),

    Movement = Window:AddTab({
        Title = "Movement",
        Icon = "zap"
    }),

    Player = Window:AddTab({
        Title = "Player",
        Icon = "user"
    })

}

------------------------------------------------
-- VARIABLES
------------------------------------------------

getgenv().AutoFarm = false
getgenv().Fly = false
getgenv().Noclip = false
getgenv().InfiniteJump = false

local FlySpeed = 50

------------------------------------------------
-- ANTI AFK
------------------------------------------------

LocalPlayer.Idled:Connect(function()

    VirtualUser:Button2Down(
        Vector2.new(0,0),
        workspace.CurrentCamera.CFrame
    )

    task.wait(1)

    VirtualUser:Button2Up(
        Vector2.new(0,0),
        workspace.CurrentCamera.CFrame
    )

end)

------------------------------------------------
-- MAIN TAB
------------------------------------------------

Tabs.Main:AddParagraph({
    Title = "LenApi",
    Content = "Premium Eagle Nation Script"
})

Tabs.Main:AddToggle("AutoFarm", {

    Title = "Auto Farm Money",
    Default = false

}):OnChanged(function(Value)

    getgenv().AutoFarm = Value

    while getgenv().AutoFarm do

        pcall(function()

            local Character = LocalPlayer.Character
            local HRP = Character:FindFirstChild("HumanoidRootPart")

            if HRP then

                local pos1 = HRP.CFrame
                local pos2 = pos1 + (HRP.CFrame.LookVector * 600)

                local tween = TweenService:Create(

                    HRP,

                    TweenInfo.new(
                        5,
                        Enum.EasingStyle.Linear
                    ),

                    {CFrame = pos2}

                )

                tween:Play()
                tween.Completed:Wait()

                HRP.CFrame = pos1

            end

        end)

        task.wait(1)

    end

end)

------------------------------------------------
-- TELEPORT TAB
------------------------------------------------

local Locations = {

    ["SPBU"] = CFrame.new(120,10,-300),
    ["Bar"] = CFrame.new(-500,15,220),
    ["Dealer"] = CFrame.new(300,10,100)

}

local function TweenTP(Pos)

    local Character = LocalPlayer.Character
    if not Character then return end

    local HRP = Character:FindFirstChild("HumanoidRootPart")

    if HRP then

        local Tween = TweenService:Create(

            HRP,

            TweenInfo.new(
                3,
                Enum.EasingStyle.Linear
            ),

            {CFrame = Pos}

        )

        Tween:Play()

    end

end

for Name,Pos in pairs(Locations) do

    Tabs.Teleport:AddButton({

        Title = "Teleport "..Name,

        Callback = function()

            TweenTP(Pos)

        end

    })

end

------------------------------------------------
-- MOVEMENT TAB
------------------------------------------------

Tabs.Movement:AddSlider("WalkSpeed", {

    Title = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 200,
    Rounding = 0

}):OnChanged(function(Value)

    pcall(function()

        LocalPlayer.Character:
        FindFirstChildOfClass("Humanoid")
        .WalkSpeed = Value

    end)

end)

Tabs.Movement:AddSlider("FlySpeed", {

    Title = "Fly Speed",
    Default = 50,
    Min = 20,
    Max = 300,
    Rounding = 0

}):OnChanged(function(Value)

    FlySpeed = Value

end)

------------------------------------------------
-- FLY
------------------------------------------------

Tabs.Movement:AddToggle("Fly", {

    Title = "Fly",
    Default = false

}):OnChanged(function(Value)

    getgenv().Fly = Value

    if Value then

        local Character = LocalPlayer.Character
        local HRP = Character:WaitForChild("HumanoidRootPart")

        local BV = Instance.new("BodyVelocity")
        BV.MaxForce = Vector3.new(999999,999999,999999)
        BV.Parent = HRP

        local BG = Instance.new("BodyGyro")
        BG.MaxTorque = Vector3.new(999999,999999,999999)
        BG.P = 1000
        BG.Parent = HRP

        task.spawn(function()

            while getgenv().Fly do

                task.wait()

                local Camera = workspace.CurrentCamera

                BG.CFrame = Camera.CFrame

                local Velocity = Vector3.zero

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Velocity += Camera.CFrame.LookVector
                end

                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Velocity -= Camera.CFrame.LookVector
                end

                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Velocity -= Camera.CFrame.RightVector
                end

                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Velocity += Camera.CFrame.RightVector
                end

                BV.Velocity = Velocity * FlySpeed

            end

            BV:Destroy()
            BG:Destroy()

        end)

    end

end)

------------------------------------------------
-- NOCLIP
------------------------------------------------

Tabs.Movement:AddToggle("Noclip", {

    Title = "Noclip",
    Default = false

}):OnChanged(function(Value)

    getgenv().Noclip = Value

    task.spawn(function()

        while getgenv().Noclip do

            pcall(function()

                for _,v in pairs(
                    LocalPlayer.Character:GetDescendants()
                ) do

                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end

                end

            end)

            task.wait()

        end

    end)

end)

------------------------------------------------
-- INFINITE JUMP
------------------------------------------------

Tabs.Movement:AddToggle("InfiniteJump", {

    Title = "Infinite Jump",
    Default = false

}):OnChanged(function(Value)

    getgenv().InfiniteJump = Value

end)

UserInputService.JumpRequest:Connect(function()

    if getgenv().InfiniteJump then

        pcall(function()

            LocalPlayer.Character:
            FindFirstChildOfClass("Humanoid"):
            ChangeState("Jumping")

        end)

    end

end)

------------------------------------------------
-- PLAYER TAB
------------------------------------------------

local FPSLabel = Tabs.Player:AddParagraph({
    Title = "FPS",
    Content = "0"
})

local MoneyLabel = Tabs.Player:AddParagraph({
    Title = "Money",
    Content = "$0"
})

task.spawn(function()

    local Frames = 0

    RunService.RenderStepped:Connect(function()
        Frames += 1
    end)

    while true do

        FPSLabel:SetDesc(tostring(Frames))
        Frames = 0

        pcall(function()

            local leaderstats =
            LocalPlayer:FindFirstChild("leaderstats")

            if leaderstats then

                local Money =
                leaderstats:FindFirstChild("Money")

                if Money then
                    MoneyLabel:SetDesc(
                        "$"..Money.Value
                    )
                end

            end

        end)

        task.wait(1)

    end

end)

------------------------------------------------
-- REJOIN
------------------------------------------------

Tabs.Player:AddButton({

    Title = "Rejoin Server",

    Callback = function()

        TeleportService:Teleport(
            game.PlaceId,
            LocalPlayer
        )

    end

})

------------------------------------------------
-- NOTIFY
------------------------------------------------

Fluent:Notify({

    Title = "LenApi",
    Content = "GUI Loaded Successfully",
    Duration = 5

})
