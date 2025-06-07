local Flux = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robloxian-Studio/FluxLib/main/source.lua'))()

-- Variáveis essenciais
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configuração da Janela
local Window = Flux:Window({
    Title = "Robloki Legends",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark"
})

-- Função para chamadas remotas seguras
local function SafeRemote(remoteName, ...)
    local remote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild(remoteName)
    if remote then
        if remote:IsA("RemoteEvent") then
            remote:FireServer(...)
        elseif remote:IsA("RemoteFunction") then
            remote:InvokeServer(...)
        end
    else
        warn("Remote não encontrado:", remoteName)
    end
end

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
local PlayerTab = Window:Tab("Player", "rbxassetid://7734065396")

PlayerTab:Slider("Velocidade (WalkSpeed)", 16, 200, 16, function(Value)
    Humanoid.WalkSpeed = Value
end)

PlayerTab:Slider("Tamanho (Scale)", 0.5, 5, 1, function(Value)
    if Character:FindFirstChild("Humanoid") then
        Character.Humanoid.BodyHeightScale.Value = Value
        Character.Humanoid.BodyWidthScale.Value = Value
    end
end)

PlayerTab:Toggle("Anti-AFK Automático", true, function(Value)
    ToggleAntiAFK(Value)
end)

-------------------------
-- Aba: Auto Farm
-------------------------
local AutoFarmTab = Window:Tab("Auto Farm", "rbxassetid://7734053491")

-- Configuração do Auto Farm
local ExerciseData = {
    ["Soco"] = {Tool = "PunchingBag", Remote = "Punch"},
    ["Peso"] = {Tool = "Dumbbell", Remote = "Lift"},
    ["Suporte"] = {Tool = "ParallelBars", Remote = "Hold"},
    ["Pushups"] = {Tool = "PushupStation", Remote = "Push"},
    ["Situações"] = {Tool = "SitupBench", Remote = "Sit"}
}

local CurrentExercise = "Soco"

AutoFarmTab:Dropdown("Tipo de Exercício", {"Soco", "Peso", "Suporte", "Pushups", "Situações"}, function(Value)
    CurrentExercise = Value
end)

AutoFarmTab:Toggle("Auto Farm de Força", false, function(Value)
    _G.StrengthFarm = Value
    while _G.StrengthFarm and task.wait() do
        local exercise = ExerciseData[CurrentExercise]
        if exercise then
            -- Equipar a ferramenta
            local tool = Player.Backpack:FindFirstChild(exercise.Tool)
            if tool then
                Humanoid:EquipTool(tool)
            end
            
            -- Executar o exercício
            SafeRemote(exercise.Remote or "Training")
        end
    end
end)

AutoFarmTab:Toggle("Farm de Músculo (No Delay)", false, function(Value)
    _G.MuscleFarm = Value
    while _G.MuscleFarm and task.wait() do
        SafeRemote("Training")
    end
end)

-------------------------
-- Aba: Egg & Gems
-------------------------
local EggTab = Window:Tab("Egg & Gems", "rbxassetid://9432217880")

EggTab:Toggle("Auto Abrir Ovos", false, function(Value)
    _G.AutoOpenEggs = Value
    while _G.AutoOpenEggs and task.wait(0.5) do
        SafeRemote("EggOpening", "Basic Egg", 1)
    end
end)

EggTab:Toggle("Farm de Gems", false, function(Value)
    _G.GemFarm = Value
    while _G.GemFarm and task.wait(0.1) do
        SafeRemote("GemFarm")
    end
end)

-------------------------
-- Aba: Renascimento
-------------------------
local RebirthTab = Window:Tab("Renascimento", "rbxassetid://7733955741")

RebirthTab:Toggle("Auto Renascimento", false, function(Value)
    _G.AutoRebirth = Value
    while _G.AutoRebirth and task.wait(0.5) do
        SafeRemote("Rebirth")
    end
end)

RebirthTab:Slider("Quantidade por Vez", 1, 10, 1, function(Value)
    _G.RebirthAmount = Value
end)

-- Notificação inicial
Flux:Notification({
    Title = "Robloki Legends",
    Text = "Script carregado com sucesso!",
    Duration = 5,
    Icon = "rbxassetid://100680172728539"
})

-- Atualizar personagem quando morrer
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
end)
