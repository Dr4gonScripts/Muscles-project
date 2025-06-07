-- Robloki Legends Script (Versão Estável)
-- Baseado no estilo Dr4gonHUB mas otimizado para evitar erros

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Robloki Legends", "DarkTheme")

-- Variáveis essenciais
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Função segura para chamadas remotas
local function SafeRemote(remoteName, ...)
    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
    if not remotes then return end
    
    local remote = remotes:FindFirstChild(remoteName)
    if not remote then return end
    
    if remote:IsA("RemoteEvent") then
        pcall(function() remote:FireServer(...) end)
    elseif remote:IsA("RemoteFunction") then
        pcall(function() remote:InvokeServer(...) end)
    end
end

-- Atualizar personagem quando respawnar
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
end)

-- Aba Player
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Configurações")

PlayerSection:NewSlider("WalkSpeed", "Altera velocidade", 200, 16, function(s)
    Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("JumpPower", "Altera pulo", 200, 50, function(s)
    Humanoid.JumpPower = s
end)

PlayerSection:NewToggle("Anti-AFK", "Evita kick por AFK", function(state)
    if state then
        getgenv().AntiAFK = true
        coroutine.wrap(function()
            while getgenv().AntiAFK do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                wait(1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                wait(1)
            end
        end)()
    else
        getgenv().AntiAFK = false
    end
end)

-- Aba Auto Farm
local FarmTab = Window:NewTab("Auto Farm")
local FarmSection = FarmTab:NewSection("Treinamento")

FarmSection:NewToggle("Auto Treinar", "Farm automático", function(state)
    getgenv().AutoTrain = state
    while getgenv().AutoTrain do
        SafeRemote("Training")
        wait()
    end
end)

-- Aba Ovos (Simplificada)
local EggsTab = Window:NewTab("Ovos")
local EggsSection = EggsTab:NewSection("Auto Egg")

EggsSection:NewToggle("Auto Abrir Ovos", "Abre ovos automaticamente", function(state)
    getgenv().AutoEgg = state
    while getgenv().AutoEgg do
        SafeRemote("EggOpening", "Basic Egg", 1)
        wait(0.5)
    end
end)

-- Notificação inicial
Library:Notify("Robloki Legends", "Script carregado com sucesso!", 5)

-- Proteção contra memory leaks
game:GetService("RunService").Heartbeat:Connect(function()
    if not Character or not Character.Parent then
        Character = Player.Character or Player.CharacterAdded:Wait()
        Humanoid = Character:WaitForChild("Humanoid")
    end
end)
