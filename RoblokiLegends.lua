-- Robloki Legends - Speed Hub X Edition
-- Versão estável e simplificada

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "Robloki Legends",
   LoadingTitle = "Carregando...",
   LoadingSubtitle = "by Scripting Team",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   }
})

-- Variáveis essenciais
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Função ultra-segura para chamadas remotas
local function SuperSafeRemote(remoteName, ...)
    local success, result = pcall(function()
        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        if not remotes then return nil end
        
        local remote = remotes:FindFirstChild(remoteName)
        if not remote then return nil end
        
        if remote:IsA("RemoteEvent") then
            return remote:FireServer(...)
        elseif remote:IsA("RemoteFunction") then
            return remote:InvokeServer(...)
        end
        return nil
    end)
    
    if not success then
        warn("Remote call failed:", result)
        return nil
    end
    return result
end

-- Atualizar personagem automaticamente
local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
end

Player.CharacterAdded:Connect(UpdateCharacter)

-- Tab Principal
local MainTab = Window:CreateTab("Principal", 4483362458)

-- Seção Player
local PlayerSection = MainTab:CreateSection("Configurações do Jogador")

PlayerSection:CreateSlider("Velocidade", 16, 200, 16, false, function(Value)
    pcall(function() Humanoid.WalkSpeed = Value end)
end)

PlayerSection:CreateSlider("Força do Pulo", 50, 200, 50, false, function(Value)
    pcall(function() Humanoid.JumpPower = Value end)
end)

PlayerSection:CreateToggle("Anti-AFK", false, function(State)
    if State then
        getgenv().AntiAFK = true
        coroutine.wrap(function()
            while getgenv().AntiAFK do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                task.wait(1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                task.wait(1)
            end
        end)()
    else
        getgenv().AntiAFK = false
    end
end)

-- Seção Auto Farm
local AutoFarmSection = MainTab:CreateSection("Auto Farm")

AutoFarmSection:CreateToggle("Farm Automático", false, function(State)
    getgenv().AutoFarm = State
    while getgenv().AutoFarm do
        SuperSafeRemote("Training")
        task.wait()
    end
end)

-- Tab Ovos
local EggsTab = Window:CreateTab("Ovos", 9432217880)

local EggsSection = EggsTab:CreateSection("Auto Ovos")

EggsSection:CreateToggle("Abrir Ovos Automático", false, function(State)
    getgenv().AutoEgg = State
    while getgenv().AutoEgg do
        SuperSafeRemote("EggOpening", "Basic Egg", 1)
        task.wait(0.5)
    end
end)

-- Inicialização segura
task.spawn(function()
    Rayfield:Notify({
        Title = "Robloki Legends",
        Content = "Script carregado com sucesso!",
        Duration = 5,
        Image = 4483362458,
    })
    
    -- Verificação contínua
    while task.wait(5) do
        if not Character or not Character.Parent then
            UpdateCharacter()
        end
    end
end)

-- Filtro de proteção contra erros
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if tostring(self) == "ThirdPartyUserService" then
        return nil
    end
    return __namecall(self, ...)
end)
