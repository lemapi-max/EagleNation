--[[

    Eagle Nation Ultimate GUI
    Delta Executor
    by Albani

    FITUR:
    - Modern UI
    - Auto Farm Money/KM
    - Auto Claim Quest
    - Realtime Money & KM
    - Teleport System
    - Tween Teleport
    - Auto Rejoin
    - Save Config
    - Anti AFK

]]

------------------------------------------------
-- LIBRARY
------------------------------------------------

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/source.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

------------------------------------------------
-- SERVICES
------------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- GLOBALS
------------------------------------------------

getgenv().AutoFarm = false
getgenv().AutoQuest = false

------------------------------------------------
-- ANTI AFK
------------------------------------------------

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

------------------------------------------------
-- WINDOW
------------------------------------------------

local Window = Fluent:CreateWindow({
    Title = "Eagle Nation Ultimate",
    SubTitle = "by Albani",
    TabWidth = 160,
    Size = UDim2.fromOffset(560, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

------------------------------------------------
-- TABS
------------------------------------------------

local Tabs = {
    Main = Window:AddTab({
        Title = "Main",
        Icon = "bike"
    }),

    Teleport = Window:AddTab({
        Title = "Teleport",
        Icon = "map-pinned"
    }),

    Info = Window:AddTab({
        Title = "Player Info",
        Icon = "info"
    }),

    Settings = Window:AddTab({
        Title = "Settings",
        Icon = "settings"
    })
}

------------------------------------------------
-- NOTIFY
------------------------------------------------

Fluent:Notify({
    Title = "Loaded",
    Content = "Eagle Nation Ultimate Loaded",
    Duration = 5
})

------------------------------------------------
-- PLAYER INFO
------------------------------------------------

local MoneyParagraph = Tabs.Info:AddParagraph({
    Title = "Money",
    Content = "$0"
})

local KMParagraph = Tabs.Info:AddParagraph({
    Title = "KM",
    Content = "0 KM"
})

task.spawn(function()
    while true do
        pcall(function()

            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")

            if leaderstats then

                local Money = leaderstats:FindFirstChild("Money")
                local KM = leaderstats:FindFirstChild("KM")

                if Money then
                    MoneyParagraph:SetDesc("$" .. tostring(Money.Value))
                end

                if KM then
                    KMParagraph:SetDesc(tostring(KM.Value) .. " KM")
                end

            end

        end)

        task.wait(1)
    end
end)

------------------------------------------------
-- TWEEN TELEPORT FUNCTION
------------------------------------------------

local function TweenTP(Position)

    local Character = LocalPlayer.Character
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

    if HRP then

        local Distance = (HRP.Position - Position.Position).Magnitude

        local Tween = TweenService:Create(
            HRP,
            TweenInfo.new(Distance / 120, Enum.EasingStyle.Linear),
            {CFrame = Position}
        )

        Tween:Play()

    end
end

------------------------------------------------
-- AUTO FARM
------------------------------------------------

Tabs.Main:AddToggle("AutoFarm", {
    Title = "Auto Farm Money/KM",
    Default = false
}):OnChanged(function(Value)

    getgenv().AutoFarm = Value

    while getgenv().AutoFarm do
        pcall(function()

            local Character = LocalPlayer.Character
            local HRP = Character:WaitForChild("HumanoidRootPart")

            local pos1 = HRP.CFrame
            local pos2 = pos1 + (HRP.CFrame.LookVector * 700)

            local tween = TweenService:Create(
                HRP,
                TweenInfo.new(5, Enum.EasingStyle.Linear),
                {CFrame = pos2}
            )

            tween:Play()
            tween.Completed:Wait()

            HRP.CFrame = pos1

        end)

        task.wait(1)
    end
end)

------------------------------------------------
-- AUTO QUEST
------------------------------------------------

Tabs.Main:AddToggle("AutoQuest", {
    Title = "Auto Claim Quest",
    Default = false
}):OnChanged(function(Value)

    getgenv().AutoQuest = Value

    while getgenv().AutoQuest do
        pcall(function()

            for _,v in pairs(game:GetDescendants()) do

                if v:IsA("ProximityPrompt") then

                    if string.find(string.lower(v.Name), "claim") then
                        fireproximityprompt(v)
                    end

                end

            end

        end)

        task.wait(3)
    end
end)

------------------------------------------------
-- TELEPORT BUTTONS
------------------------------------------------

Tabs.Teleport:AddButton({
    Title = "Teleport SPBU",
    Callback = function()

        -- GANTI KOORDINAT
        TweenTP(CFrame.new(120,10,-300))

    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Bar",
    Callback = function()

        -- GANTI KOORDINAT
        TweenTP(CFrame.new(-500,15,220))

    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Dealer",
    Callback = function()

        -- GANTI KOORDINAT
        TweenTP(CFrame.new(300,10,100))

    end
})

------------------------------------------------
-- UTILITIES
------------------------------------------------

Tabs.Main:AddButton({
    Title = "Copy Position",
    Callback = function()

        local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if HRP then
            setclipboard(tostring(HRP.Position))
            Fluent:Notify({
                Title = "Copied",
                Content = "Position copied to clipboard",
                Duration = 3
            })
        end

    end
})

Tabs.Main:AddButton({
    Title = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

------------------------------------------------
-- SETTINGS
------------------------------------------------

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

InterfaceManager:SetFolder("EagleNation")
SaveManager:SetFolder("EagleNation/config")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()
