--// LENAPI FULL REVISI (STABLE LEGIT VERSION)

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- CLEAN OLD GUI
------------------------------------------------
pcall(function()
    game.CoreGui:FindFirstChild("LenApiGUI"):Destroy()
end)

------------------------------------------------
-- LOADING SCREEN
------------------------------------------------
local Loader = Instance.new("ScreenGui", game.CoreGui)
Loader.Name = "LenApiLoader"

local LoadFrame = Instance.new("Frame", Loader)
LoadFrame.Size = UDim2.new(0,300,0,150)
LoadFrame.Position = UDim2.new(0.5,-150,0.5,-75)
LoadFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", LoadFrame)

local LoadText = Instance.new("TextLabel", LoadFrame)
LoadText.Size = UDim2.new(1,0,1,0)
LoadText.BackgroundTransparency = 1
LoadText.Text = "LenApi Loading..."
LoadText.TextColor3 = Color3.fromRGB(0,255,120)
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18

task.wait(1)
Loader:Destroy()

------------------------------------------------
-- MAIN GUI
------------------------------------------------
local GUI = Instance.new("ScreenGui", game.CoreGui)
GUI.Name = "LenApiGUI"

------------------------------------------------
-- MAIN FRAME
------------------------------------------------
local Main = Instance.new("Frame", GUI)
Main.Size = UDim2.new(0,320,0,300)
Main.Position = UDim2.new(0.5,-160,0.5,-150)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Visible = false

Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "LenApi Private Server"
Title.TextColor3 = Color3.fromRGB(0,255,120)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

------------------------------------------------
-- TOGGLE BUTTON
------------------------------------------------
local Toggle = Instance.new("TextButton", GUI)
Toggle.Size = UDim2.new(0,50,0,50)
Toggle.Position = UDim2.new(0.02,0,0.4,0)
Toggle.Text = "L"
Toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
Toggle.TextColor3 = Color3.fromRGB(0,255,120)

Instance.new("UICorner", Toggle)

local open = false

Toggle.MouseButton1Click:Connect(function()
    open = not open
    Main.Visible = open
end)

------------------------------------------------
-- TELEPORT FUNCTION
------------------------------------------------
local function Teleport(cf)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cf
    end
end

------------------------------------------------
-- TELEPORT BUTTONS
------------------------------------------------
local SPBU = Instance.new("TextButton", Main)
SPBU.Size = UDim2.new(0,280,0,30)
SPBU.Position = UDim2.new(0.05,0,0.25,0)
SPBU.Text = "Teleport SPBU"
SPBU.BackgroundColor3 = Color3.fromRGB(40,40,40)
SPBU.TextColor3 = Color3.fromRGB(255,255,255)

SPBU.MouseButton1Click:Connect(function()
    Teleport(CFrame.new(120,10,-300))
end)

local BAR = Instance.new("TextButton", Main)
BAR.Size = UDim2.new(0,280,0,30)
BAR.Position = UDim2.new(0.05,0,0.40,0)
BAR.Text = "Teleport Bar"
BAR.BackgroundColor3 = Color3.fromRGB(40,40,40)
BAR.TextColor3 = Color3.fromRGB(255,255,255)

BAR.MouseButton1Click:Connect(function()
    Teleport(CFrame.new(-500,15,220))
end)

------------------------------------------------
-- SPEED SYSTEM
------------------------------------------------
local Speed = Instance.new("TextButton", Main)
Speed.Size = UDim2.new(0,280,0,30)
Speed.Position = UDim2.new(0.05,0,0.55,0)
Speed.Text = "Increase Speed"
Speed.BackgroundColor3 = Color3.fromRGB(40,40,40)
Speed.TextColor3 = Color3.fromRGB(255,255,255)

Speed.MouseButton1Click:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = math.clamp(hum.WalkSpeed + 5, 16, 100)
    end
end)

------------------------------------------------
-- JUMP BOOST
------------------------------------------------
local Jump = Instance.new("TextButton", Main)
Jump.Size = UDim2.new(0,280,0,30)
Jump.Position = UDim2.new(0.05,0,0.70,0)
Jump.Text = "Jump Boost"
Jump.BackgroundColor3 = Color3.fromRGB(40,40,40)
Jump.TextColor3 = Color3.fromRGB(255,255,255)

Jump.MouseButton1Click:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.JumpPower = 80
    end
end)

------------------------------------------------
-- REJOIN
------------------------------------------------
local Rejoin = Instance.new("TextButton", Main)
Rejoin.Size = UDim2.new(0,280,0,30)
Rejoin.Position = UDim2.new(0.05,0,0.85,0)
Rejoin.Text = "Rejoin Server"
Rejoin.BackgroundColor3 = Color3.fromRGB(40,40,40)
Rejoin.TextColor3 = Color3.fromRGB(255,255,255)

Rejoin.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

------------------------------------------------
-- ANTI AFK
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
print("LenApi FULL REVISI LOADED")
