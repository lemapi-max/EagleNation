--// LENAPI LEGIT CLEAN VERSION

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- LEADERSTATS
------------------------------------------------
game.Players.PlayerAdded:Connect(function(p)
    local stats = Instance.new("Folder", p)
    stats.Name = "leaderstats"

    local money = Instance.new("IntValue", stats)
    money.Name = "Money"
    money.Value = 0
end)

------------------------------------------------
-- SIMPLE DISTANCE MONEY
------------------------------------------------
local lastPos = {}

RunService.Heartbeat:Connect(function()
    for _,p in pairs(Players:GetPlayers()) do
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") then

            local hrp = char.HumanoidRootPart
            local stats = p:FindFirstChild("leaderstats")

            if stats and stats:FindFirstChild("Money") then
                if lastPos[p] then
                    local dist = (hrp.Position - lastPos[p]).Magnitude
                    stats.Money.Value += math.floor(dist * 0.02)
                end
                lastPos[p] = hrp.Position
            end
        end
    end
end)

------------------------------------------------
-- GUI (CLEAN STYLE)
------------------------------------------------
local GUI = Instance.new("ScreenGui", game.CoreGui)
GUI.Name = "LenApiGUI"

local Main = Instance.new("Frame", GUI)
Main.Size = UDim2.new(0,300,0,280)
Main.Position = UDim2.new(0.5,-150,0.5,-140)
Main.BackgroundColor3 = Color3.fromRGB(30,30,30)
Main.Visible = false
Instance.new("UICorner", Main)

------------------------------------------------
-- TITLE
------------------------------------------------
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "LenApi Legit System"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

------------------------------------------------
-- TOGGLE BUTTON
------------------------------------------------
local Toggle = Instance.new("TextButton", GUI)
Toggle.Size = UDim2.new(0,45,0,45)
Toggle.Position = UDim2.new(0.03,0,0.4,0)
Toggle.Text = "L"
Toggle.BackgroundColor3 = Color3.fromRGB(20,20,20)
Toggle.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", Toggle)

local open = false

Toggle.MouseButton1Click:Connect(function()
    open = not open
    Main.Visible = open
end)

------------------------------------------------
-- TELEPORT FUNCTION
------------------------------------------------
local function TP(part)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,3,0)
    end
end

------------------------------------------------
-- SIMPLE BUTTON STYLE
------------------------------------------------
local function MakeButton(name, pos, text, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0,260,0,28)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

------------------------------------------------
-- BUTTONS
------------------------------------------------
MakeButton("SPBU", UDim2.new(0.06,0,0.25,0), "Teleport SPBU", function()
    local p = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("SPBU_Point")
    if p then TP(p) end
end)

MakeButton("BAR", UDim2.new(0.06,0,0.38,0), "Teleport BAR", function()
    local p = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Bar_Point")
    if p then TP(p) end
end)

MakeButton("SPEED", UDim2.new(0.06,0,0.51,0), "Speed Boost", function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 50 end
end)

MakeButton("JUMP", UDim2.new(0.06,0,0.64,0), "Jump Boost", function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 80 end
end)

MakeButton("REJOIN", UDim2.new(0.06,0,0.77,0), "Rejoin Server", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

------------------------------------------------
-- ANTI AFK (CLEAN)
------------------------------------------------
LocalPlayer.Idled:Connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
end)

------------------------------------------------
-- DONE
------------------------------------------------
print("LenApi Clean Loaded")
