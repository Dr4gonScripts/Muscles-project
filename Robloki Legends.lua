local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Configuração da Janela Principal
local Window = OrionLib:MakeWindow({
    Name = "Robloki Legends",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "RoblokiConfig",
    IntroEnabled = true,
    IntroText = "Robloki Legends",
    IntroIcon = "rbxassetid://100680172728539",
    Icon = "rbxassetid://100680172728539"
})

-- Variáveis de controle
local TrainingRemote = game:GetService("ReplicatedStorage").Remotes.Training
local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

-- Aba de Auto Farm
local AutoFarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://7734053491",
    PremiumOnly = false
})

AutoFarmTab:AddToggle({
    Name = "Farm de Músculo (SEM DELAY) 💪",
    Default = false,
    Callback = function(Value)
        _G.MuscleFarm = Value
        
        -- Conexão otimizada para evitar delays
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not _G.MuscleFarm then
                connection:Disconnect()
                return
            end
            
            -- Envia o request de treino sem delay
            TrainingRemote:FireServer()
            
            -- Opcional: Pequena pausa para evitar crash
            task.wait()
        end)
    end
})

AutoFarmTab:AddLabel("Configurações Avançadas")

AutoFarmTab:AddSlider({
    Name = "Intensidade do Farm",
    Min = 1,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(255, 165, 0),
    Increment = 1,
    Callback = function(Value)
        _G.FarmIntensity = Value
    end
})

-- Inicializa a Interface
OrionLib:Init()
