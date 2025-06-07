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

-- Solução para chamadas remotas seguras
local function SafeRemoteCall(remote, ...)
    local success, err = pcall(function()
        if remote:IsA("RemoteEvent") then
            remote:FireServer(...)
        elseif remote:IsA("RemoteFunction") then
            remote:InvokeServer(...)
        end
    end)
    if not success then
        warn("Erro no remote call:", err)
    end
end

-- Função para criar botões personalizados
local function AddWindowControls()
    while not OrionLib.Instance or not OrionLib.Instance.MainUI do
        task.wait()
    end
    
    local MainUI = OrionLib.Instance.MainUI
    local TitleBar = MainUI:FindFirstChild("TopBar")
    
    if TitleBar then
        -- Botão Minimizar
        local MinimizeBtn = Instance.new("TextButton")
        MinimizeBtn.Name = "MinimizeButton"
        MinimizeBtn.Text = "_"
        MinimizeBtn.TextSize = 18
        MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
        MinimizeBtn.Size = UDim2.new(0, 30, 0, 25)
        MinimizeBtn.Position = UDim2.new(1, -60, 0, 0)
        MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        MinimizeBtn.BorderSizePixel = 0
        MinimizeBtn.Parent = TitleBar
        
        MinimizeBtn.MouseButton1Click:Connect(function()
            MainUI.Visible = not MainUI.Visible
        end)

        -- Botão Fechar
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Name = "CloseButton"
        CloseBtn.Text = "X"
        CloseBtn.TextSize = 14
        CloseBtn.TextColor3 = Color3.new(1, 1, 1)
        CloseBtn.Size = UDim2.new(0, 30, 0, 25)
        CloseBtn.Position = UDim2.new(1, -30, 0, 0)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        CloseBtn.BorderSizePixel = 0
        CloseBtn.Parent = TitleBar
        
        CloseBtn.MouseButton1Click:Connect(function()
            OrionLib:Destroy()
        end)
        
        TitleBar.Size = UDim2.new(1, -90, 0, 25)
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
        if Character:FindFirstChild("Humanoid") then
            Character.Humanoid.BodyHeightScale.Value = Value
            Character.Humanoid.BodyWidthScale.Value = Value
        end
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
-- Aba: Auto Farm (Atualizada)
-------------------------
local AutoFarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://7734053491"
})

-- Configuração do Auto Farm de Força
local ExerciseEquipment = {
    ["Soco-1"] = "PunchingBag",
    ["Peso-2"] = "Dumbbell",
    ["Suporte-3"] = "ParallelBars",
    ["Pushups-4"] = "PushupStation",
    ["Situações-5"] = "SitupBench"
}

local CurrentExercise = "PunchingBag"
local ExerciseRemotes = {
    PunchingBag = "Punch",
    Dumbbell = "Lift",
    ParallelBars = "Hold",
    PushupStation = "Push",
    SitupBench = "Sit"
}

AutoFarmTab:AddDropdown({
    Name = "Tipo de Exercício",
    Default = "Soco-1",
    Options = {"Soco-1", "Peso-2", "Suporte-3", "Pushups-4", "Situações-5"},
    Callback = function(Value)
        CurrentExercise = ExerciseEquipment[Value]
    end
})

AutoFarmTab:AddToggle({
    Name = "Auto Farm de Força",
    Default = false,
    Callback = function(Value)
        _G.StrengthFarm = Value
        while _G.StrengthFarm do
            -- Equipa o item primeiro
            if Player.Backpack:FindFirstChild(CurrentExercise) then
                Humanoid:EquipTool(Player.Backpack[CurrentExercise])
            end
            
            -- Executa o exercício
            local remoteName = ExerciseRemotes[CurrentExercise] or "Train"
            local remote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild(remoteName)
            if remote then
                SafeRemoteCall(remote)
            else
                SafeRemoteCall(game:GetService("ReplicatedStorage").Remotes.Training)
            end
            
            task.wait()
        end
    end
})

AutoFarmTab:AddToggle({
    Name = "Farm de Músculo (No Delay)",
    Default = false,
    Callback = function(Value)
        _G.MuscleFarm = Value
        while _G.MuscleFarm do
            SafeRemoteCall(game:GetService("ReplicatedStorage").Remotes.Training)
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
            SafeRemoteCall(game:GetService("ReplicatedStorage").Remotes.EggOpening, "Basic Egg", 1)
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
            SafeRemoteCall(game:GetService("ReplicatedStorage").Remotes.GemFarm)
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
            SafeRemoteCall(game:GetService("ReplicatedStorage").Remotes.Rebirth)
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
coroutine.wrap(function()
    AddWindowControls()
end)()

ToggleAntiAFK(true)

OrionLib:MakeNotification({
    Name = "Robloki Legends",
    Content = "Script carregado com sucesso!\nVersão 2.0 com Auto Farm aprimorado",
    Time = 5,
    Icon = "rbxassetid://100680172728539"
})

OrionLib:Init()
