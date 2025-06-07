local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Variáveis essenciais
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configuração da Janela com botões personalizados
local Window = OrionLib:MakeWindow({
    Name = "Robloki Legends",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "RoblokiConfig",
    IntroEnabled = true,
    IntroText = "Robloki Legends",
    IntroIcon = "rbxassetid://100680172728539",
    Icon = "rbxassetid://100680172728539",
    
    -- Configurações dos botões
    CloseCallback = function() 
        OrionLib:MakeNotification({
            Name = "Robloki Legends",
            Content = "Interface fechada. Use o executor para reabrir.",
            Time = 3
        })
    end
})

-- Criação dos botões customizados
local function CreateCustomButtons()
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
    MinimizeBtn.Parent = OrionLib.Instance.MainUI
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        OrionLib.Instance.MainUI.Visible = false
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
    CloseBtn.Parent = OrionLib.Instance.MainUI
    
    CloseBtn.MouseButton1Click:Connect(function()
        OrionLib:Destroy()
    end)
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

-- [...] (O resto do código das abas permanece IGUAL ao anterior)

-- Inicialização
CreateCustomButtons() -- Cria os botões minimizar/fechar
ToggleAntiAFK(true) -- Ativa Anti-AFK automaticamente

OrionLib:MakeNotification({
    Name = "Robloki Legends",
    Content = "Interface carregada com sucesso!",
    Time = 5
})

OrionLib:Init()
