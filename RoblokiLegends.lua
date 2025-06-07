-- Carrega a biblioteca FluxLib
local success, Flux = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/Robloxian-Studio/FluxLib/main/source.lua'))()
end)

if not success then
    error("Falha ao carregar a FluxLib. Verifique sua conexão com a internet.")
end

-- Configurações iniciais
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Cria a janela principal
local Window = Flux:Window({
    Title = "Robloki Legends",
    SubTitle = "Premium Script v3.0",
    Size = UDim2.new(0, 500, 0, 450),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Theme = "Dark",
    Acrylic = true,
    Blur = true
})

-- Sistema de proteção contra erros
local function SafeRemote(remoteName, ...)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
    if remote then
        remote = remote:FindFirstChild(remoteName)
        if remote then
            if remote:IsA("RemoteEvent") then
                return remote:FireServer(...)
            elseif remote:IsA("RemoteFunction") then
                return remote:InvokeServer(...)
            end
        end
    end
    warn("Remote não encontrado:", remoteName)
    return nil
end

-- Atualiza o personagem quando respawnar
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
end)

-- Anti-AFK
local VirtualInput = game:GetService("VirtualInputManager")
local antiAFKConnection
local function ToggleAntiAFK(state)
    if state then
        antiAFKConnection = game:GetService("RunService").Heartbeat:Connect(function()
            VirtualInput:SendKeyEvent(true, "F", false, game)
            task.wait(1)
            VirtualInput:SendKeyEvent(false, "F", false, game)
        end)
    elseif antiAFKConnection then
        antiAFKConnection:Disconnect()
        antiAFKConnection = nil
    end
end

-------------------------
-- ABA: PLAYER
-------------------------
local PlayerTab = Window:Tab("Jogador", "rbxassetid://7734065396")

-- WalkSpeed
PlayerTab:Slider("Velocidade", 16, 200, 16, function(value)
    Humanoid.WalkSpeed = value
end)

-- JumpPower
PlayerTab:Slider("Pulo", 50, 200, 50, function(value)
    Humanoid.JumpPower = value
end)

-- Size
PlayerTab:Slider("Tamanho", 0.5, 5, 1, function(value)
    Humanoid.BodyHeightScale.Value = value
    Humanoid.BodyWidthScale.Value = value
end)

-- Anti-AFK
PlayerTab:Toggle("Anti-AFK", true, function(state)
    ToggleAntiAFK(state)
end)

-------------------------
-- ABA: AUTO FARM
-------------------------
local AutoFarmTab = Window:Tab("Auto Farm", "rbxassetid://7734053491")

-- Configuração dos exercícios
local Exercises = {
    {
        Name = "Soco",
        Tool = "PunchingBag",
        Remote = "Punch"
    },
    {
        Name = "Peso",
        Tool = "Dumbbell",
        Remote = "Lift"
    },
    {
        Name = "Suporte",
        Tool = "ParallelBars",
        Remote = "Hold"
    },
    {
        Name = "Pushups",
        Tool = "PushupStation",
        Remote = "Push"
    },
    {
        Name = "Situações",
        Tool = "SitupBench",
        Remote = "Sit"
    }
}

-- Dropdown de exercícios
local selectedExercise = 1
AutoFarmTab:Dropdown("Exercício", {
    "Soco",
    "Peso",
    "Suporte",
    "Pushups",
    "Situações"
}, function(index)
    selectedExercise = index
end)

-- Auto Farm
AutoFarmTab:Toggle("Ativar Auto Farm", false, function(state)
    _G.AutoFarm = state
    
    while _G.AutoFarm and task.wait() do
        local exercise = Exercises[selectedExercise]
        
        -- Equipa a ferramenta
        local tool = Player.Backpack:FindFirstChild(exercise.Tool)
        if tool then
            Humanoid:EquipTool(tool)
        end
        
        -- Executa o exercício
        SafeRemote(exercise.Remote)
    end
end)

-------------------------
-- ABA: OVOS & GEMAS
-------------------------
local EggsTab = Window:Tab("Ovos & Gemas", "rbxassetid://9432217880")

-- Auto Abrir Ovos
EggsTab:Toggle("Auto Abrir Ovos", false, function(state)
    _G.AutoOpenEggs = state
    
    while _G.AutoOpenEggs and task.wait(0.5) do
        SafeRemote("EggOpening", "Basic Egg", 1)
    end
end)

-- Farm de Gemas
EggsTab:Toggle("Farm de Gemas", false, function(state)
    _G.GemFarm = state
    
    while _G.GemFarm and task.wait(0.1) do
        SafeRemote("GemFarm")
    end
end)

-------------------------
-- ABA: RENASCIMENTO
-------------------------
local RebirthTab = Window:Tab("Renascimento", "rbxassetid://7733955741")

-- Auto Rebirth
RebirthTab:Toggle("Auto Renascimento", false, function(state)
    _G.AutoRebirth = state
    
    while _G.AutoRebirth and task.wait(0.5) do
        SafeRemote("Rebirth")
    end
end)

-- Quantidade de Rebirth
local rebirthAmount = 1
RebirthTab:Slider("Quantidade", 1, 10, 1, function(value)
    rebirthAmount = value
end)

-------------------------
-- ABA: CONFIGURAÇÕES
-------------------------
local SettingsTab = Window:Tab("Configurações", "rbxassetid://6031091004")

-- Notificações
SettingsTab:Toggle("Notificações", true, function(state)
    Flux.Notifications = state
end)

-- Tema
SettingsTab:Dropdown("Tema", {
    "Dark",
    "Light",
    "Aqua",
    "Jester"
}, function(theme)
    Flux:SetTheme(theme)
end)

-- Notificação inicial
Flux:Notification({
    Title = "Robloki Legends",
    Text = "Script carregado com sucesso!",
    Duration = 5,
    Icon = "rbxassetid://100680172728539"
})

-- Atualiza o título da janela periodicamente
task.spawn(function()
    while task.wait(10) do
        Window:SetTitle("Robloki Legends | " .. os.date("%H:%M:%S"))
    end
end)
