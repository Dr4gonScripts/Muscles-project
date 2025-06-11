--[[
  🐉 Robloki Hub Premium - Versão Estilo Dr4gonHub
  Modificações:
    - Design premium com tema azul/roxo
    - Bola minimizada personalizada
    - Interface completa com todas as abas funcionais
    - Efeitos visuais melhorados
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DA UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Configuração do tema premium
local Theme = {
    Background = Color3.fromRGB(15, 15, 25),
    Primary = Color3.fromRGB(80, 50, 180),  -- Roxo premium
    Secondary = Color3.fromRGB(0, 150, 255), -- Azul brilhante
    Accent = Color3.fromRGB(200, 200, 255),
    Text = Color3.fromRGB(240, 240, 255)
}

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.45, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Efeito de borda gradiente
local GradientBorder = Instance.new("Frame")
GradientBorder.Size = UDim2.new(1, 6, 1, 6)
GradientBorder.Position = UDim2.new(0, -3, 0, -3)
GradientBorder.BackgroundColor3 = Color3.new(1, 1, 1)
GradientBorder.BorderSizePixel = 0
GradientBorder.ZIndex = 0
GradientBorder.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Primary),
    ColorSequenceKeypoint.new(1, Theme.Secondary)
})
UIGradient.Rotation = 45
UIGradient.Parent = GradientBorder

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "ROBLOKI HUB PREMIUM"
Title.TextColor3 = Theme.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Parent = TitleBar

-- Botões de controle da janela
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Theme.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Theme.Primary
MinimizeButton.TextColor3 = Theme.Text
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar

-- Barra de abas
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

-- Configuração das abas
local function CreateTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Text = name
    tab.Size = UDim2.new(0.2, 0, 1, 0)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.Gotham
    tab.TextSize = 12
    tab.Parent = TabBar
    
    tab.MouseEnter:Connect(function()
        if tab.BackgroundColor3 ~= Theme.Primary then
            tab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
    end)
    
    tab.MouseLeave:Connect(function()
        if tab.BackgroundColor3 ~= Theme.Primary then
            tab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        end
    end)
    
    return tab
end

local UniversalTab = CreateTab("Universal", UDim2.new(0, 0, 0, 0))
local BloxFruitsTab = CreateTab("Blox Fruits", UDim2.new(0.2, 0, 0, 0))
local GrowGardenTab = CreateTab("Grow Garden", UDim2.new(0.4, 0, 0, 0))
local ArsenalTab = CreateTab("Arsenal", UDim2.new(0.6, 0, 0, 0))
local MusclesTab = CreateTab("Muscles Legends", UDim2.new(0.8, 0, 0, 0))

-- Áreas de conteúdo
local function CreateContentFrame(name)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, -65)
    frame.Position = UDim2.new(0, 0, 0, 65)
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 5
    frame.ScrollBarImageColor3 = Theme.Primary
    frame.Visible = false
    frame.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = frame
    
    return frame
end

local UniversalContent = CreateContentFrame("UniversalContent")
UniversalContent.CanvasSize = UDim2.new(0, 0, 0, 700)
UniversalContent.Visible = true

local BloxFruitsContent = CreateContentFrame("BloxFruitsContent")
BloxFruitsContent.CanvasSize = UDim2.new(0, 0, 0, 1200)

local GrowGardenContent = CreateContentFrame("GrowGardenContent")
GrowGardenContent.CanvasSize = UDim2.new(0, 0, 0, 700)

local ArsenalContent = CreateContentFrame("ArsenalContent")
ArsenalContent.CanvasSize = UDim2.new(0, 0, 0, 500)

local MusclesContent = CreateContentFrame("MusclesContent")
MusclesContent.CanvasSize = UDim2.new(0, 0, 0, 500)

-- ===== FUNÇÕES AUXILIARES =====
local function CreateButton(name, callback, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderColor3 = Theme.Primary
    button.BorderSizePixel = 1
    button.Parent = parent
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    end)
    
    local isActive = false
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    
    button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    return button
end

local function CreateDivider(text, parent)
    local divider = Instance.new("TextLabel")
    divider.Text = " "..text.." "
    divider.TextColor3 = Theme.Primary
    divider.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    divider.Size = UDim2.new(0.9, 0, 0, 25)
    divider.Position = UDim2.new(0.05, 0, 0, 0)
    divider.Font = Enum.Font.GothamBold
    divider.TextSize = 14
    divider.TextXAlignment = Enum.TextXAlignment.Center
    divider.BorderSizePixel = 1
    divider.BorderColor3 = Theme.Primary
    divider.Parent = parent
    
    return divider
end

-- ===== CONTROLES DE JANELA =====
local minimized = false
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

-- Botão de bola quando minimizado
local BallButton = Instance.new("ImageButton")
BallButton.Image = "rbxassetid://0" -- Substitua pelo ID da imagem desejada
BallButton.Size = UDim2.new(0, 50, 0, 50)
BallButton.Position = originalPosition
BallButton.BackgroundColor3 = Theme.Primary
BallButton.BorderSizePixel = 0
BallButton.Visible = false
BallButton.ZIndex = 10
BallButton.Parent = ScreenGui

-- Tornar a imagem redonda
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = BallButton

-- Arrastar a janela principal
local dragging = false
local dragInput, dragStart, startPos

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function UpdateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
    BallButton.Position = MainFrame.Position
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging and not minimized then
        UpdateInput(input)
    end
end)

-- Arrastar a bola minimizada
local draggingBall = false
local dragInputBall, dragStartBall, startPosBall

local function UpdateBallInput(input)
    local delta = input.Position - dragStartBall
    BallButton.Position = UDim2.new(
        startPosBall.X.Scale, 
        startPosBall.X.Offset + delta.X, 
        startPosBall.Y.Scale, 
        startPosBall.Y.Offset + delta.Y
    )
end

BallButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingBall = true
        dragStartBall = input.Position
        startPosBall = BallButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingBall = false
            end
        end)
    end
end)

BallButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInputBall = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInputBall and draggingBall then
        UpdateBallInput(input)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Visible = false
        BallButton.Visible = true
        BallButton.Position = MainFrame.Position
    else
        MainFrame.Visible = true
        BallButton.Visible = false
    end
end)

BallButton.MouseButton1Click:Connect(function()
    minimized = false
    MainFrame.Visible = true
    BallButton.Visible = false
end)

-- Controle de abas
local function SwitchTab(selectedTab)
    UniversalTab.BackgroundColor3 = (selectedTab == UniversalTab) and Theme.Primary or Color3.fromRGB(40, 40, 60)
    BloxFruitsTab.BackgroundColor3 = (selectedTab == BloxFruitsTab) and Theme.Primary or Color3.fromRGB(40, 40, 60)
    GrowGardenTab.BackgroundColor3 = (selectedTab == GrowGardenTab) and Theme.Primary or Color3.fromRGB(40, 40, 60)
    ArsenalTab.BackgroundColor3 = (selectedTab == ArsenalTab) and Theme.Primary or Color3.fromRGB(40, 40, 60)
    MusclesTab.BackgroundColor3 = (selectedTab == MusclesTab) and Theme.Primary or Color3.fromRGB(40, 40, 60)
    
    UniversalContent.Visible = (selectedTab == UniversalTab)
    BloxFruitsContent.Visible = (selectedTab == BloxFruitsTab)
    GrowGardenContent.Visible = (selectedTab == GrowGardenTab)
    ArsenalContent.Visible = (selectedTab == ArsenalTab)
    MusclesContent.Visible = (selectedTab == MusclesTab)
end

UniversalTab.MouseButton1Click:Connect(function() SwitchTab(UniversalTab) end)
BloxFruitsTab.MouseButton1Click:Connect(function() SwitchTab(BloxFruitsTab) end)
GrowGardenTab.MouseButton1Click:Connect(function() SwitchTab(GrowGardenTab) end)
ArsenalTab.MouseButton1Click:Connect(function() SwitchTab(ArsenalTab) end)
MusclesTab.MouseButton1Click:Connect(function() SwitchTab(MusclesTab) end)

-- ===== UNIVERSAL TAB CONTENT =====
CreateDivider("Ferramentas Gerais", UniversalContent)

-- Noclip
local noclip = false
CreateButton("Ativar Noclip", function()
    noclip = not noclip
    
    if Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclip
            end
        end
    end
    
    if noclip then
        local noclipConnection
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if not noclip then
                noclipConnection:Disconnect()
                return
            end
            
            if Player.Character then
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robloki Hub",
        Text = "Noclip " .. (noclip and "ativado" or "desativado"),
        Duration = 2,
    })
end, UniversalContent)

-- Voo Universal
CreateButton("Ativar Voo Universal", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robloki Hub",
        Text = "Voo universal ativado!",
        Duration = 3,
    })
end, UniversalContent)

-- Infinite Yield
CreateButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robloki Hub",
        Text = "Infinite Yield carregado!",
        Duration = 3,
    })
end, UniversalContent)

-- ===== BLOX FRUITS TAB CONTENT =====
CreateDivider("Hubs Completos", BloxFruitsContent)

local BFHubs = {
    {Name = "Hoho Hub", URL = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"},
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "banana hub", URL = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/refs/heads/main/BananaCatHub.lua"},
    {Name = "Tsou hub", URL = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"},
    {Name = "Solix hub", URL = "https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"},
    {Name = "Alchemy Hub", URL = "https://scripts.alchemyhub.xyz"}
}

for _, hub in ipairs(BFHubs) do
    CreateButton(hub.Name, function()
        loadstring(game:HttpGet(hub.URL))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Robloki Hub",
            Text = hub.Name .. " carregado!",
            Duration = 3,
        })
    end, BloxFruitsContent)
end

-- ===== GROW GARDEN TAB CONTENT =====
CreateDivider("Auto Farm", GrowGardenContent)

local GGHubs = {
    {Name = "No-lag hub", URL = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"},
    {Name = "Solix Hub", URL = "https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"},
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "Lunor hub", URL = "https://lunor.dev/loader"}
}

for _, hub in ipairs(GGHubs) do
    CreateButton(hub.Name, function()
        loadstring(game:HttpGet(hub.URL))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Robloki Hub",
            Text = hub.Name .. " carregado!",
            Duration = 3,
        })
    end, GrowGardenContent)
end

-- ===== ARSENAL TAB CONTENT =====
CreateDivider("Hacks", ArsenalContent)

local ArsenalHubs = {
    {Name = "Soluna Hub", URL = "https://soluna-script.vercel.app/arsenal.lua"},
    {Name = "Aether hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Arsenal"},
    {Name = "Nodoll hub", URL = "https://raw.githubusercontent.com/NoDollManB/roblox_scripts/refs/heads/main/arsenal.lua"},
    {Name = "Ronix Hub", URL = "https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"},
    {Name = "Tbao hub", URL = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"}
}

for _, hub in ipairs(ArsenalHubs) do
    CreateButton(hub.Name, function()
        loadstring(game:HttpGet(hub.URL))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Robloki Hub",
            Text = hub.Name .. " carregado!",
            Duration = 3,
        })
    end, ArsenalContent)
end

-- ===== MUSCLES LEGENDS TAB CONTENT =====
CreateDivider("Auto Farm", MusclesContent)

local MLHubs = {
    {Name = "Speed hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "ML V1 hub", URL = "https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"},
    {Name = "Nox hub", URL = "https://pastebin.com/raw/2Cuza2mr"},
    {Name = "KTM hub", URL = "https://raw.githubusercontent.com/zapstreams123/KTMHUB/refs/heads/main/PublicVersion"},
    {Name = "CriShoux Hub", URL = "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"}
}

for _, hub in ipairs(MLHubs) do
    CreateButton(hub.Name, function()
        loadstring(game:HttpGet(hub.URL))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Robloki Hub",
            Text = hub.Name .. " carregado!",
            Duration = 3,
        })
    end, MusclesContent)
end

-- Notificação de inicialização
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Robloki Hub Premium",
    Text = "Hub carregado com sucesso!",
    Duration = 5,
})

print("🐉 Robloki Hub Premium - Versão Estilo Dr4gonHub carregada com sucesso!")
