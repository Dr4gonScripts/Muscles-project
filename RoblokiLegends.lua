-- Muscle Legends Hacks (Educational Purposes Only)
-- Este script requer um executor como Synapse X, Krnl ou outros

--[[
  Funcionalidades incluídas:
  1. Auto-Treino (Farm automático)
  2. Status Máximos
  3. Moedas e Gemas ilimitadas
  4. Batalhas automáticas
  5. Sem dano
]]

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Função para encontrar os remotes
local function findRemote(name)
    for _, remote in pairs(Remotes:GetChildren()) do
        if remote.Name == name then
            return remote
        end
    end
    return nil
end

-- Interface gráfica simples
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Muscle Legends Hacks", "Sentinel")

-- Aba principal
local MainTab = Window:NewTab("Principal")
local MainSection = MainTab:NewSection("Hacks Principais")

-- Auto Farm
MainSection:NewToggle("Auto Treino", "Treina automaticamente", function(state)
    getgenv().autoTrain = state
    while autoTrain and task.wait(1) do
        local remotes = {
            RequestTrain = findRemote("RequestTrain"),
            UpdateStats = findRemote("UpdateStats")
        }
        
        if remotes.RequestTrain then
            -- Treinar todos os atributos
            for _, trainingType in pairs({"Strength", "Speed", "Stamina"}) do
                remotes.RequestTrain:InvokeServer(trainingType)
            end
        end
    end
end)

-- Status Máximos
MainSection:NewButton("Max Stats", "Define todos status para valores máximos", function()
    local remotes = {
        UpdateStats = findRemote("UpdateStats")
    }
    
    if remotes.UpdateStats then
        local fakeStats = {
            Level = 999,
            Strength = 9999,
            Speed = 9999,
            Stamina = 9999,
            XP = 0,
            Coins = 999999,
            Gems = 9999,
            Muscles = {"All"}, -- Todos músculos desbloqueados
            Equipment = {
                Gloves = "Golden",
                Shoes = "Golden",
                Outfit = "Legendary"
            }
        }
        
        -- Enviar stats falsos para o servidor
        remotes.UpdateStats:FireServer(fakeStats)
        
        -- Também modifica localmente para evitar dessincronização
        if LocalPlayer:FindFirstChild("PlayerStats") then
            local stats = LocalPlayer.PlayerStats
            stats.Level.Value = 999
            stats.Strength.Value = 9999
            stats.Speed.Value = 9999
            stats.Stamina.Value = 9999
            stats.Coins.Value = 999999
            stats.Gems.Value = 9999
        end
    end
end)

-- Aba de Batalha
local BattleTab = Window:NewTab("Batalha")
local BattleSection = BattleTab:NewSection("Hacks de Batalha")

-- Sem Dano
BattleSection:NewToggle("God Mode", "Nenhum dano recebido", function(state)
    getgenv().godMode = state
    if godMode then
        LocalPlayer.CharacterAdded:Connect(function(character)
            if character:FindFirstChild("Humanoid") then
                character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if character.Humanoid.Health < character.Humanoid.MaxHealth then
                        character.Humanoid.Health = character.Humanoid.MaxHealth
                    end
                end)
            end
        end)
    end
end)

-- Vitória Automática
BattleSection:NewToggle("Auto Win", "Vence todas batalhas automaticamente", function(state)
    getgenv().autoWin = state
    if autoWin then
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if tostring(self) == "EndBattle" and method == "FireServer" then
                -- Forçar vitória
                local args = {...}
                args[2] = true -- Sobrescrever resultado para vitória
                return oldNamecall(self, unpack(args))
            end
            return oldNamecall(self, ...)
        end)
    else
        if oldNamecall then
            hookmetamethod(game, "__namecall", oldNamecall)
        end
    end
end)

-- Aba de Coletáveis
local CurrencyTab = Window:NewTab("Moedas/Gemas")
local CurrencySection = CurrencyTab:NewSection("Hacks de Moeda")

-- Moedas ilimitadas
CurrencySection:NewButton("Moedas MAX", "Define moedas para 999.999", function()
    local remotes = {
        UpdateStats = findRemote("UpdateStats")
    }
    
    if remotes.UpdateStats then
        local currentStats = remotes.UpdateStats:InvokeServer("GetStats")
        currentStats.Coins = 999999
        remotes.UpdateStats:FireServer(currentStats)
    end
    
    -- Modificação local
    if LocalPlayer:FindFirstChild("PlayerStats") and LocalPlayer.PlayerStats:FindFirstChild("Coins") then
        LocalPlayer.PlayerStats.Coins.Value = 999999
    end
end)

-- Gemas ilimitadas
CurrencySection:NewButton("Gemas MAX", "Define gemas para 9.999", function()
    local remotes = {
        UpdateStats = findRemote("UpdateStats")
    }
    
    if remotes.UpdateStats then
        local currentStats = remotes.UpdateStats:InvokeServer("GetStats")
        currentStats.Gems = 9999
        remotes.UpdateStats:FireServer(currentStats)
    end
    
    -- Modificação local
    if LocalPlayer:FindFirstChild("PlayerStats") and LocalPlayer.PlayerStats:FindFirstChild("Gems") then
        LocalPlayer.PlayerStats.Gems.Value = 9999
    end
end)

-- Notificação de inicialização
Library:Notify("Hacks carregados com sucesso!", 5)
