local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Variáveis essenciais
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configuração da Janela
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

-- Anti-AFK Automático
local antiAFKConnection
local function ToggleAntiAFK(state)
    if state then
        antiAFKConnection = game:GetService("RunService").Heartbeat:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
            task.wait(1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
        end)
    elseif antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
end

-------------------------
-- Aba: Player
-------------------------
local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://7734065396"
})

PlayerTab:AddSlider({
    Name = "Velocidade (WalkSpeed)",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(0, 170, 255),
    Increment = 1,
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
    end
})

PlayerTab:AddSlider({
    Name = "Tamanho (Scale)",
    Min = 0.5,
    Max = 5,
    Default = 1,
    Color = Color3.fromRGB(255, 85, 255),
    Increment = 0.1,
    Callback = function(Value)
        Character:FindFirstChild("Humanoid").BodyHeightScale.Value = Value
        Character:FindFirstChild("Humanoid").BodyWidthScale.Value = Value
    end
})

PlayerTab:AddToggle({
    Name = "Anti-AFK Automático",
    Default = true,
    Callback = function(Value)
        ToggleAntiAFK(Value)
    end
})

-------------------------
-- Aba: Auto Farm
-------------------------
local AutoFarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://7734053491"
})

AutoFarmTab:AddToggle({
    Name = "Farm de Músculo (No Delay)",
    Default = false,
    Callback = function(Value)
        _G.MuscleFarm = Value
        while _G.MuscleFarm do
            game:GetService("ReplicatedStorage").Remotes.Training:FireServer()
            task.wait()
        end
    end
})

-------------------------
-- Aba: Egg & Gems
-------------------------
local EggTab = Window:MakeTab({
    Name = "Egg & Gems",
    Icon = "rbxassetid://9432217880"
})

EggTab:AddToggle({
    Name = "Auto Abrir Ovos",
    Default = false,
    Callback = function(Value)
        _G.AutoOpenEggs = Value
        while _G.AutoOpenEggs do
            game:GetService("ReplicatedStorage").Remotes.EggOpening:InvokeServer("Basic Egg", 1)
            task.wait(0.5)
        end
    end
})

EggTab:AddToggle({
    Name = "Farm de Gems",
    Default = false,
    Callback = function(Value)
        _G.GemFarm = Value
        while _G.GemFarm do
            -- (Substitua pelo remote correto do seu jogo)
            game:GetService("ReplicatedStorage").Remotes.GemFarm:FireServer()
            task.wait(0.1)
        end
    end
})

-------------------------
-- Aba: Renascimento
-------------------------
local RebirthTab = Window:MakeTab({
    Name = "Renascimento",
    Icon = "rbxassetid://7733955741"
})

RebirthTab:AddToggle({
    Name = "Auto Renascimento",
    Default = false,
    Callback = function(Value)
        _G.AutoRebirth = Value
        while _G.AutoRebirth do
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            task.wait(0.5)
        end
    end
})

RebirthTab:AddSlider({
    Name = "Quantidade por Vez",
    Min = 1,
    Max = 10,
    Default = 1,
    Color = Color3.fromRGB(255, 215, 0),
    Callback = function(Value)
        _G.RebirthAmount = Value
    end
})

-- Inicialização
ToggleAntiAFK(true) -- Ativa Anti-AFK automaticamente
OrionLib:MakeNotification({
    Name = "Robloki Legends",
    Content = "Script carregado com sucesso!",
    Time = 5
})
OrionLib:Init()
