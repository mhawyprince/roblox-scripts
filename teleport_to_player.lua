-- GUI para teletransportarse a otros jugadores

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Crear pantalla GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Marco de botones
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 10, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Teletransportarse a:"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- Layout para los botones
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = frame

-- Crear botón por jugador
local function createPlayerButton(player)
    if player == LocalPlayer then return end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Text = player.Name
    btn.Parent = frame

    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local targetChar = player.Character

        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = targetChar.HumanoidRootPart.CFrame + Vector3.new(3, 0, 0)
            print("Teletransportado a " .. player.Name)
        else
            warn("No se pudo teletransportar a " .. player.Name)
        end
    end)
end

-- Añadir todos los jugadores actuales
for _, player in ipairs(Players:GetPlayers()) do
    createPlayerButton(player)
end

-- Añadir botones para nuevos jugadores que entren
Players.PlayerAdded:Connect(createPlayerButton)
