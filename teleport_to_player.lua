-- Script educativo: teletransportarse a otro jugador en Roblox
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPlayers()[1]

-- Función para mostrar jugadores en consola
local function listPlayers()
    print("Jugadores disponibles:")
    for _, player in ipairs(Players:GetPlayers()) do
        print(" - " .. player.Name)
    end
end

-- Mostrar la lista
listPlayers()

-- Instrucciones para el usuario
warn("Usa el comando:")
warn('teleportTo("NombreDelJugador")')

-- Función global para teletransportarse
_G.teleportTo = function(targetName)
    local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local myHRP = myChar:WaitForChild("HumanoidRootPart")

    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer or not targetPlayer.Character then
        warn("Jugador no encontrado.")
        return
    end

    local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then
        warn("El jugador no tiene HumanoidRootPart.")
        return
    end

    myHRP.CFrame = targetHRP.CFrame + Vector3.new(3, 0, 0)  -- al lado
    print("Teletransportado a " .. targetPlayer.Name)
end
