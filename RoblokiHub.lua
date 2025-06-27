--[[
  🐉 Robloki Hub Premium - Versão Otimizada V5.1 (CORRIGIDA)
  -- Código otimizado, mais compacto e robusto para evitar erros --
  
  Correções:
  - Sistema de arrastar reescrito com UserInputService.
  - Funções obsoletas removidas e substituídas por métodos modernos.
  - Lógica de minimização e restauração aprimorada.
  - Funções de UI ajustadas para maior compatibilidade.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===== CONFIGURAÇÃO GLOBAL =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumHub_" .. math.random(1, 100)
ScreenGui.Parent = PlayerGui -- Coloca na PlayerGui para maior compatibilidade

local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    Primary = Color3.fromRGB(0, 255, 255),
    Secondary = Color3.fromRGB(0, 150, 150),
    Accent = Color3.fromRGB(200, 200, 200),
    Text = Color3.fromRGB(255, 255, 255),
    Error = Color3.fromRGB(255, 50, 50),
    TitleBar = Color3.fromRGB(25, 25, 25),
    TabBackground = Color3.fromRGB(20, 20, 20),
    ButtonHover = Color3.fromRGB(40, 40, 40),
    ButtonBackground = Color3.fromRGB(25, 25, 25)
}

-- ===== FUNÇÕES AUXILIARES =====
local function Notify(title, text, duration)
    local success, err = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
    if not success then
        warn("Failed to send notification: " .. tostring(err))
    end
end

-- ===== CRIAÇÃO DA INTERFACE =====
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 700, 0, 450)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderColor3 = Theme.Primary
MainFrame.BorderSizePixel = 2
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = false -- Desativar o Draggable padrão

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Título e barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Theme.TitleBar
TitleBar.Parent = MainFrame
TitleBar.Active = true
TitleBar.Draggable = false -- Desativar o Draggable padrão

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -90, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Text = "🐉 Robloki Hub Premium"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.TextColor3 = Theme.Primary
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = TitleBar
TitleLabel.Active = true

-- Botões de controle
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.TextColor3 = Theme.Text
CloseButton.BackgroundColor3 = Theme.Error
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.AnchorPoint = Vector2.new(1, 0)
MinimizeButton.Text = "-"
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20
MinimizeButton.TextColor3 = Theme.Text
MinimizeButton.BackgroundColor3 = Theme.ButtonBackground
MinimizeButton.Parent = TitleBar

local MinimizeButtonCorner = Instance.new("UICorner")
MinimizeButtonCorner.CornerRadius = UDim.new(0, 5)
MinimizeButtonCorner.Parent = MinimizeButton

-- Floating button (para quando a UI é minimizada)
local floatingButton = Instance.new("TextButton")
floatingButton.Name = "FloatingButton"
floatingButton.Size = UDim2.new(0, 60, 0, 60)
floatingButton.Position = UDim2.new(1, -70, 0.05, 0)
floatingButton.Text = "🐉"
floatingButton.Font = Enum.Font.SourceSansBold
floatingButton.TextSize = 40
floatingButton.TextColor3 = Theme.Text
floatingButton.BackgroundColor3 = Theme.Primary
floatingButton.Visible = false
floatingButton.Parent = ScreenGui

local FloatingButtonCorner = Instance.new("UICorner")
FloatingButtonCorner.CornerRadius = UDim.new(1, 0)
FloatingButtonCorner.Parent = floatingButton

-- Painel de abas
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 150, 1, -40)
TabsFrame.Position = UDim2.new(0, 10, 0, 40)
TabsFrame.BackgroundColor3 = Theme.TabBackground
TabsFrame.Parent = MainFrame

local TabsListLayout = Instance.new("UIListLayout")
TabsListLayout.Padding = UDim.new(0, 5)
TabsListLayout.FillDirection = Enum.FillDirection.Vertical
TabsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
TabsListLayout.Parent = TabsFrame

-- Painel de conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -180, 1, -50)
ContentFrame.Position = UDim2.new(0, 170, 0, 45)
ContentFrame.BackgroundColor3 = Theme.Background
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ContentScrollingFrame = Instance.new("ScrollingFrame")
ContentScrollingFrame.Name = "ContentScrollingFrame"
ContentScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ContentScrollingFrame.BackgroundColor3 = Theme.Background
ContentScrollingFrame.BackgroundTransparency = 1
ContentScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScrollingFrame.Parent = ContentFrame
ContentScrollingFrame.Active = true

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.FillDirection = Enum.FillDirection.Vertical
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentLayout.Parent = ContentScrollingFrame

-- Gerador de botões
local function CreateButton(text, parent, callback)
    local button = Instance.new("TextButton")
    button.Name = text:gsub("%s+", "").."Button"
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.TextColor3 = Theme.Text
    button.BackgroundColor3 = Theme.ButtonBackground
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = button
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    -- Efeito de hover
    button.MouseEnter:Connect(function()
        button:TweenSize(UDim2.new(1, -15, 0, 45), "Out", "Quad", 0.2)
        button.BackgroundColor3 = Theme.ButtonHover
    end)
    button.MouseLeave:Connect(function()
        button:TweenSize(UDim2.new(1, -20, 0, 40), "Out", "Quad", 0.2)
        button.BackgroundColor3 = Theme.ButtonBackground
    end)
    
    return button
end

-- Gerador de abas
local function CreateTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name.."Tab"
    tabButton.Size = UDim2.new(1, 0, 0, 30)
    tabButton.Text = name
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 18
    tabButton.TextColor3 = Theme.Text
    tabButton.BackgroundColor3 = Theme.Primary
    tabButton.BackgroundTransparency = 0.5
    tabButton.Parent = TabsFrame

    local tabContent = Instance.new("Frame")
    tabContent.Name = name.."Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundColor3 = Theme.Background
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = ContentScrollingFrame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.FillDirection = Enum.FillDirection.Vertical
    contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    contentLayout.Parent = tabContent

    return tabButton, tabContent, contentLayout
end

-- Lógica para trocar de aba
local function SwitchTab(tabContentFrame)
    for _, content in pairs(ContentScrollingFrame:GetChildren()) do
        if content:IsA("Frame") and content.Name:find("Content") then
            content.Visible = (content == tabContentFrame)
        end
    end
    
    -- Ajustar o CanvasSize para o conteúdo visível
    task.wait() -- Pequeno delay para renderizar
    local contentHeight = 0
    if tabContentFrame then
        for _, child in ipairs(tabContentFrame:GetChildren()) do
            contentHeight = contentHeight + child.Size.Y.Offset + ContentLayout.Padding.Offset
        end
        ContentScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    end
end

-- ===== CRIAÇÃO DAS ABAS E CONTEÚDOS =====
local HomeTabButton, HomeTabContent = CreateTab("Home")
CreateButton("Testar Funcionalidade", HomeTabContent, function()
    Notify("Status", "Funcionalidade testada!")
end)

local PlayerTabButton, PlayerTabContent = CreateTab("Player")
CreateButton("Kill", PlayerTabContent, function()
    LocalPlayer.Character.Humanoid.Health = 0
    Notify("Player", "Você foi morto!")
end)

local WorldTabButton, WorldTabContent = CreateTab("World")
CreateButton("Gravidade Zero", WorldTabContent, function()
    game.Workspace.Gravity = 0
    Notify("World", "Gravidade definida para zero!")
end)

local TeleportTabButton, TeleportTabContent = CreateTab("Teleport")
CreateButton("Teleportar para Spawn", TeleportTabContent, function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.SpawnLocation.Position)
    Notify("Teleport", "Teleportado para o spawn!")
end)

-- Conectar os botões das abas à lógica de troca
HomeTabButton.MouseButton1Click:Connect(function() SwitchTab(HomeTabContent) end)
PlayerTabButton.MouseButton1Click:Connect(function() SwitchTab(PlayerTabContent) end)
WorldTabButton.MouseButton1Click:Connect(function() SwitchTab(WorldTabContent) end)
TeleportTabButton.MouseButton1Click:Connect(function() SwitchTab(TeleportTabContent) end)

-- Ativa a primeira aba por padrão
SwitchTab(HomeTabContent)

-- ===== LÓGICA DE INTERAÇÃO (DRAG, MINIMIZE, CLOSE) =====
local isDragging = false
local dragStartPos
local dragStartInputPos

-- Nova lógica de arrastar usando InputBegan/InputChanged
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStartPos = MainFrame.Position
        dragStartInputPos = input.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
        local delta = input.Position - dragStartInputPos
        MainFrame.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- Lógica de minimizar/restaurar
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    floatingButton.Visible = isMinimized
    if isMinimized then
        Notify("Robloki Hub", "Hub minimizado", 1)
        TweenService:Create(floatingButton, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(1, -70, 0.05, 0)}):Play()
    else
        Notify("Robloki Hub", "Hub restaurado", 1)
    end
end)

floatingButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    floatingButton.Visible = isMinimized
    Notify("Robloki Hub", "Hub restaurado", 1)
end)

-- Conexão do botão de fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    floatingButton:Destroy()
    Notify("Robloki Hub", "UI fechada.", 2)
end)

Notify("Robloki Hub", "Hub carregado com sucesso!", 3)
