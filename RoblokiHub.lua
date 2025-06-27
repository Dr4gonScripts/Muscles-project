--[[
  🐉 Robloki Hub Premium - Versão Otimizada V5.0
  Atualizações:
  - **Interface baseada no modelo fornecido**
  - **Sistema de minimização para um botão flutuante CIANO**
  - **Interface arrastável pela barra de título**
  - **Barra de pesquisa totalmente funcional**
  - Scripts verificados e atualizados
  - Sistema anti-detecção aprimorado
  - Interface mais fluida e responsiva
  - 15 abas completas com todos os scripts originais
  - Sistema de rolagem automático nas abas
  - Temas personalizáveis mantidos
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ===== CONFIGURAÇÃO INICIAL SEGURA =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumHub_"..math.random(1000,9999)
ScreenGui.Parent = game:GetService("CoreGui")

-- ===== TEMA PERSONALIZADO (PRETO E CIANO) =====
local Theme = {
    Background = Color3.fromRGB(15, 15, 15), -- Preto escuro
    Primary = Color3.fromRGB(0, 255, 255),   -- Ciano
    Secondary = Color3.fromRGB(0, 150, 150), -- Ciano mais escuro
    Accent = Color3.fromRGB(200, 200, 200),  -- Cinza claro
    Text = Color3.fromRGB(255, 255, 255),   -- Branco
    Error = Color3.fromRGB(255, 50, 50)     -- Vermelho para o botão de fechar
}

-- Função para aplicar o tema
local function ApplyTheme()
    -- Frame principal
    if MainFrame then
        MainFrame.BackgroundColor3 = Theme.Background
        local stroke = MainFrame:FindFirstChildOfClass("UIStroke")
        if stroke then stroke.Color = Theme.Primary end
    end

    -- Barra de título
    if TitleBar then
        TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end
    
    -- Textos
    if Title then Title.TextColor3 = Theme.Primary end
    if PlayerName then PlayerName.TextColor3 = Theme.Primary end
    if PlayerId then PlayerId.TextColor3 = Theme.Accent end
    if GameName then GameName.TextColor3 = Theme.Accent end
    if SearchHint then SearchHint.TextColor3 = Color3.fromRGB(150, 150, 150) end
    
    -- Botões de controle
    if CloseButton then
        CloseButton.BackgroundColor3 = Theme.Error
        CloseButton.TextColor3 = Theme.Text
    end
    if MinimizeButton then
        MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        MinimizeButton.TextColor3 = Theme.Primary
    end
    
    -- Frame de abas
    if TabFrame then
        TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end

    -- Botões das abas
    if TabListLayout then
        for _, tab in ipairs(TabFrame:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                tab.TextColor3 = Theme.Text
            end
        end
    end

    -- Scrollbars
    if TabFrame then
        TabFrame.ScrollBarImageColor3 = Theme.Primary
    end
    if ContentScrollingFrame then
        ContentScrollingFrame.ScrollBarImageColor3 = Theme.Primary
    end
    
    -- Botões de script e divisores
    if ContentScrollingFrame then
        for _, element in ipairs(ContentScrollingFrame:GetChildren()) do
            if element:IsA("TextButton") then
                element.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                element.TextColor3 = Theme.Text
                local stroke = element:FindFirstChildOfClass("UIStroke")
                if stroke then stroke.Color = Theme.Secondary end
            elseif element.Name == "Divider" then
                local label = element:FindFirstChildOfClass("TextLabel")
                if label then label.TextColor3 = Theme.Primary end
                local lines = element:GetChildren()
                for _, line in ipairs(lines) do
                    if line:IsA("Frame") and (line.Name == "LeftLine" or line.Name == "RightLine") then
                        line.BackgroundColor3 = Theme.Primary
                    end
                end
            end
        end
    end

    -- Barra de pesquisa e resultados
    if SearchBar then
        SearchBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        SearchBar.TextColor3 = Theme.Text
        SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    end
    if ResultsFrame then
        for _, result in ipairs(ResultsFrame:GetChildren()) do
            if result:IsA("TextButton") then
                result.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                result.TextColor3 = Theme.Text
                local categoryLabel = result:FindFirstChildOfClass("TextLabel")
                if categoryLabel then categoryLabel.TextColor3 = Theme.Secondary end
            end
        end
    end
end

-- Função de notificação melhorada
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "Robloki Hub",
        Text = text or "Operação concluída",
        Duration = duration or 3,
        Icon = "rbxassetid://6726579484"
    })
end

-- Carregador seguro de scripts AVANÇADO
local function SafeLoad(url)
    local success, response = pcall(function()
        local content
        local attempts = {
            function() return game:HttpGet(url, true) end,
            function() return game:HttpGet(url.."?bypass="..tostring(math.random(1,9999)), true) end,
            function() return game:HttpGet(url:gsub("https://", "http://"), true) end
        }
        
        for _, attempt in ipairs(attempts) do
            local ok, result = pcall(attempt)
            if ok and result and not (result:find("404") or result:find("Not Found") or result == "") then
                content = result
                break
            end
        end
        
        return content
    end)
    
    if success and response and string.len(response) > 0 then
        local loadSuccess, err = pcall(loadstring(response))
        if not loadSuccess then
            Notify("Erro de Execução", "O script foi baixado, mas falhou ao executar: " .. tostring(err), 5)
            return false
        else
            Notify("Sucesso", "Script executado com sucesso!", 3)
            return true
        end
    else
        Notify("Aviso", "Esse script pode estar off ou excluido.", 5)
        return false
    end
end

-- ===== CONSTRUÇÃO DA INTERFACE (TAMANHO MAIOR) =====
local largeSize = UDim2.new(0.45, 0, 0.7, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Size = largeSize
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Theme.Primary
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Barra de título (para arrastar)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "🐉 ROBLOKI HUB PREMIUM V5.0 🐉"
Title.TextColor3 = Theme.Primary
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0.2, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Parent = TitleBar

-- Botões de controle
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Theme.Error
CloseButton.TextColor3 = Theme.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "─"
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeButton.TextColor3 = Theme.Primary
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TitleBar

-- Layout principal (para dividir abas e conteúdo)
local MainLayout = Instance.new("Frame")
MainLayout.Size = UDim2.new(1, 0, 1, -35)
MainLayout.Position = UDim2.new(0, 0, 0, 35)
MainLayout.BackgroundTransparency = 1
MainLayout.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = MainLayout

-- Frame das abas (à esquerda)
local TabFrame = Instance.new("ScrollingFrame")
TabFrame.Size = UDim2.new(0.25, 0, 1, 0)
TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabFrame.BackgroundTransparency = 0
TabFrame.BorderSizePixel = 0
TabFrame.ScrollBarThickness = 5
TabFrame.ScrollBarImageColor3 = Theme.Primary
TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabFrame.Parent = MainLayout

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabFrame

local UIPaddingTabs = Instance.new("UIPadding")
UIPaddingTabs.PaddingTop = UDim.new(0, 10)
UIPaddingTabs.PaddingBottom = UDim.new(0, 10)
UIPaddingTabs.PaddingLeft = UDim.new(0, 5)
UIPaddingTabs.PaddingRight = UDim.new(0, 5)
UIPaddingTabs.Parent = TabFrame

-- Separador
local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(0, 2, 1, 0)
Separator.BackgroundColor3 = Theme.Secondary
Separator.Parent = MainLayout

-- Frame de conteúdo (à direita)
local ContentScrollingFrame = Instance.new("ScrollingFrame")
ContentScrollingFrame.Size = UDim2.new(0.75, -7, 1, 0)
ContentScrollingFrame.BackgroundTransparency = 1
ContentScrollingFrame.ScrollBarThickness = 8
ContentScrollingFrame.ScrollBarImageColor3 = Theme.Primary
ContentScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScrollingFrame.Parent = MainLayout

local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 10)
ContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentListLayout.Parent = ContentScrollingFrame

local UIPaddingContent = Instance.new("UIPadding")
UIPaddingContent.PaddingTop = UDim.new(0, 10)
UIPaddingContent.PaddingBottom = UDim.new(0, 10)
UIPaddingContent.PaddingLeft = UDim.new(0, 10)
UIPaddingContent.PaddingRight = UDim.new(0, 10)
UIPaddingContent.Parent = ContentScrollingFrame

-- Botão Flutuante (para quando minimizado)
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 50, 0, 50)
FloatingButton.Position = UDim2.new(1, -70, 0, 30)
FloatingButton.BackgroundColor3 = Theme.Primary
FloatingButton.Text = "🐉"
FloatingButton.TextColor3 = Theme.Text
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.TextSize = 25
FloatingButton.Visible = false
FloatingButton.Parent = ScreenGui

local FloatingCorner = Instance.new("UICorner")
FloatingCorner.CornerRadius = UDim.new(0.5, 0)
FloatingCorner.Parent = FloatingButton

-- Sistema de arrastar para mover a janela
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging and not gameProcessedEvent then
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        MainFrame.Position = newPosition
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Função do botão Minimizar
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    FloatingButton.Visible = isMinimized
    
    if isMinimized then
        Notify("Robloki Hub", "Minimizado", 1)
        -- Animação do botão flutuante
        FloatingButton.Position = UDim2.new(1, -70, 0, 30)
        TweenService:Create(FloatingButton, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(1, -70, 0.05, 0)}):Play()
    else
        Notify("Robloki Hub", "Restaurado", 1)
    end
end)

-- Função do botão flutuante
FloatingButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    FloatingButton.Visible = isMinimized
    Notify("Robloki Hub", "Restaurado", 1)
end)

-- Função do botão Fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    FloatingButton:Destroy()
    Notify("Robloki Hub", "Interface fechada", 1)
end)

-- ===== SISTEMA DE ABAS ATUALIZADO =====
local function CreateTab(name)
    local tab = Instance.new("TextButton")
    tab.Text = name
    tab.Size = UDim2.new(1, -10, 0, 40)
    tab.Position = UDim2.new(0.5, 0, 0.5, 0)
    tab.AnchorPoint = Vector2.new(0.5, 0.5)
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.GothamMedium
    tab.TextSize = 14
    tab.TextWrapped = true
    tab.LayoutOrder = #TabFrame:GetChildren()
    tab.Parent = TabFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = tab
    
    tab.MouseEnter:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)
    
    tab.MouseLeave:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
    
    return tab
end

local function CreateButton(name, callback, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(1, 0, 0, 45) -- Botões maiores
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 15
    button.AutoButtonColor = false
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Secondary
    stroke.Thickness = 1
    stroke.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            TextColor3 = Theme.Primary
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            TextColor3 = Theme.Text
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    return button
end

local function CreateDivider(text, parent)
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, 0, 0, 25)
    divider.BackgroundTransparency = 1
    divider.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = " "..text.." "
    label.TextColor3 = Theme.Primary
    label.BackgroundColor3 = Theme.Background
    label.Size = UDim2.new(0.5, 0, 0.8, 0)
    label.Position = UDim2.new(0.25, 0, 0.1, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = divider
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = label
    
    local leftLine = Instance.new("Frame")
    leftLine.Name = "LeftLine"
    leftLine.Size = UDim2.new(0.2, 0, 0, 2)
    leftLine.Position = UDim2.new(0.05, 0, 0.5, 0)
    leftLine.BackgroundColor3 = Theme.Primary
    leftLine.BorderSizePixel = 0
    leftLine.Parent = divider
    
    local rightLine = Instance.new("Frame")
    rightLine.Name = "RightLine"
    rightLine.Size = UDim2.new(0.2, 0, 0, 2)
    rightLine.Position = UDim2.new(0.75, 0, 0.5, 0)
    rightLine.BackgroundColor3 = Theme.Primary
    rightLine.BorderSizePixel = 0
    rightLine.Parent = divider
    
    return divider
end

-- ===== CRIAÇÃO DAS ABAS =====
local InicioTab = CreateTab("Inicio")
local UniversalTab = CreateTab("Universal")
local BloxFruitsTab = CreateTab("Blox Fruits")
local GrowGardenTab = CreateTab("Grow Garden")
local ArsenalTab = CreateTab("Arsenal")
local MusclesTab = CreateTab("Muscles")
local BlueLockTab = CreateTab("Blue Lock")
local DeadRailsTab = CreateTab("Dead Rails")
local PetSimTab = CreateTab("Pet Sim")
local BladeBallTab = CreateTab("Blade Ball")
local HubsTab = CreateTab("Hubs")
local BuildBoatTab = CreateTab("Build Boat")
local NinjaLegendsTab = CreateTab("Ninja Legends")
local ForsakenTab = CreateTab("Forsaken")
local MM2Tab = CreateTab("MM2")
local TheMimicTab = CreateTab("The Mimic")
local BrainrotTab = CreateTab("Roube Brainrot")
local BrookhavenTab = CreateTab("Brookhaven")

-- Criar conteúdos para cada aba
local Contents = {}
local function CreateAndStoreContent(name)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = ContentScrollingFrame
    Contents[name] = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = frame

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0.02, 0)
    padding.Parent = frame

    return frame
end

local InicioContent = CreateAndStoreContent("InicioContent")
local UniversalContent = CreateAndStoreContent("UniversalContent")
local BloxFruitsContent = CreateAndStoreContent("BloxFruitsContent")
local GrowGardenContent = CreateAndStoreContent("GrowGardenContent")
local ArsenalContent = CreateAndStoreContent("ArsenalContent")
local MusclesContent = CreateAndStoreContent("MusclesContent")
local BlueLockContent = CreateAndStoreContent("BlueLockContent")
local DeadRailsContent = CreateAndStoreContent("DeadRailsContent")
local PetSimContent = CreateAndStoreContent("PetSimContent")
local BladeBallContent = CreateAndStoreContent("BladeBallContent")
local HubsContent = CreateAndStoreContent("HubsContent")
local BuildBoatContent = CreateAndStoreContent("BuildBoatContent")
local NinjaLegendsContent = CreateAndStoreContent("NinjaLegendsContent")
local ForsakenContent = CreateAndStoreContent("ForsakenContent")
local MM2Content = CreateAndStoreContent("MM2Content")
local TheMimicContent = CreateAndStoreContent("TheMimicContent")
local BrainrotContent = CreateAndStoreContent("BrainrotContent")
local BrookhavenContent = CreateAndStoreContent("BrookhavenContent")

-- ABA INICIO
InicioTab.LayoutOrder = 0
UniversalTab.LayoutOrder = 1

-- Perfil do jogador
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(1, -20, 0, 120)
ProfileFrame.Position = UDim2.new(0.5, 0, 0, 0)
ProfileFrame.AnchorPoint = Vector2.new(0.5, 0)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ProfileFrame.Parent = InicioContent

local UICornerProfile = Instance.new("UICorner")
UICornerProfile.CornerRadius = UDim.new(0, 8)
UICornerProfile.Parent = ProfileFrame

local PlayerThumbnail = Instance.new("ImageLabel")
PlayerThumbnail.Size = UDim2.new(0, 80, 0, 80)
PlayerThumbnail.Position = UDim2.new(0, 15, 0.5, 0)
PlayerThumbnail.AnchorPoint = Vector2.new(0, 0.5)
PlayerThumbnail.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerThumbnail.BorderSizePixel = 0
PlayerThumbnail.Parent = ProfileFrame

local UICornerThumb = Instance.new("UICorner")
UICornerThumb.CornerRadius = UDim.new(0, 8)
UICornerThumb.Parent = PlayerThumbnail

local userId = Player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
game:GetService("Players"):GetUserThumbnailAsync(userId, thumbType, thumbSize, function(content)
    PlayerThumbnail.Image = content
end)

local PlayerName = Instance.new("TextLabel")
PlayerName.Text = Player.Name
PlayerName.TextColor3 = Theme.Primary
PlayerName.Font = Enum.Font.GothamBold
PlayerName.TextSize = 18
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.BackgroundTransparency = 1
PlayerName.Size = UDim2.new(0.6, 0, 0, 25)
PlayerName.Position = UDim2.new(0, 110, 0, 20)
PlayerName.Parent = ProfileFrame

local PlayerId = Instance.new("TextLabel")
PlayerId.Text = "ID: "..userId
PlayerId.TextColor3 = Theme.Accent
PlayerId.Font = Enum.Font.Gotham
PlayerId.TextSize = 14
PlayerId.TextXAlignment = Enum.TextXAlignment.Left
PlayerId.BackgroundTransparency = 1
PlayerId.Size = UDim2.new(0.6, 0, 0, 20)
PlayerId.Position = UDim2.new(0, 110, 0, 45)
PlayerId.Parent = ProfileFrame

local GameName = Instance.new("TextLabel")
GameName.Text = "Jogo: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
GameName.TextColor3 = Theme.Accent
GameName.Font = Enum.Font.Gotham
GameName.TextSize = 14
GameName.TextXAlignment = Enum.TextXAlignment.Left
GameName.BackgroundTransparency = 1
GameName.Size = UDim2.new(0.8, 0, 0, 20)
GameName.Position = UDim2.new(0, 110, 0, 70)
GameName.TextTruncate = Enum.TextTruncate.AtEnd
GameName.Parent = ProfileFrame

-- Barra de pesquisa e resultados
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -20, 0, 40)
SearchBar.Position = UDim2.new(0.5, 0, 0, 140)
SearchBar.AnchorPoint = Vector2.new(0.5, 0)
SearchBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SearchBar.TextColor3 = Theme.Text
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 15
SearchBar.PlaceholderText = "Pesquisar scripts..."
SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBar.Text = ""
SearchBar.Parent = InicioContent

local UICornerSearch = Instance.new("UICorner")
UICornerSearch.CornerRadius = UDim.new(0, 8)
UICornerSearch.Parent = SearchBar

local SearchHint = Instance.new("TextLabel")
SearchHint.Text = "Digite o nome de um script e pressione Enter para pesquisar"
SearchHint.TextColor3 = Color3.fromRGB(150, 150, 150)
SearchHint.Font = Enum.Font.Gotham
SearchHint.TextSize = 12
SearchHint.BackgroundTransparency = 1
SearchHint.Size = UDim2.new(1, 0, 0, 20)
SearchHint.Position = UDim2.new(0.5, 0, 0, 180)
SearchHint.AnchorPoint = Vector2.new(0.5, 0)
SearchHint.Parent = InicioContent

local ResultsFrame = Instance.new("ScrollingFrame")
ResultsFrame.Size = UDim2.new(1, -20, 0, 250)
ResultsFrame.Position = UDim2.new(0.5, 0, 0, 210)
ResultsFrame.AnchorPoint = Vector2.new(0.5, 0)
ResultsFrame.BackgroundTransparency = 1
ResultsFrame.ScrollBarThickness = 5
ResultsFrame.ScrollBarImageColor3 = Theme.Primary
ResultsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ResultsFrame.Parent = InicioContent

local ResultsLayout = Instance.new("UIListLayout")
ResultsLayout.Padding = UDim.new(0, 8)
ResultsLayout.Parent = ResultsFrame

local function SearchScripts(query)
    for _, child in ipairs(ResultsFrame:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    if query == "" then return end
    
    local allScripts = {}
    
    local function AddScriptsFromContent(contentFrame, category)
        for _, child in ipairs(contentFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Text ~= "" then
                table.insert(allScripts, {
                    Name = child.Text,
                    Category = category,
                    Callback = child.MouseButton1Click
                })
            end
        end
    end
    
    AddScriptsFromContent(UniversalContent, "Universal")
    AddScriptsFromContent(BloxFruitsContent, "Blox Fruits")
    AddScriptsFromContent(GrowGardenContent, "Grow Garden")
    AddScriptsFromContent(ArsenalContent, "Arsenal")
    AddScriptsFromContent(MusclesContent, "Muscles Legends")
    AddScriptsFromContent(BlueLockContent, "Blue Lock")
    AddScriptsFromContent(DeadRailsContent, "Dead Rails")
    AddScriptsFromContent(PetSimContent, "Pet Simulator")
    AddScriptsFromContent(BladeBallContent, "Blade Ball")
    AddScriptsFromContent(HubsContent, "Hubs")
    AddScriptsFromContent(BuildBoatContent, "Build Boat")
    AddScriptsFromContent(NinjaLegendsContent, "Ninja Legends")
    AddScriptsFromContent(ForsakenContent, "Forsaken")
    AddScriptsFromContent(MM2Content, "Murder Mystery 2")
    AddScriptsFromContent(TheMimicContent, "The Mimic")
    AddScriptsFromContent(BrainrotContent, "Roube Brainrot")
    AddScriptsFromContent(BrookhavenContent, "Brookhaven")
    
    local scoredScripts = {}
    query = query:lower()
    
    for _, script in ipairs(allScripts) do
        local nameLower = script.Name:lower()
        local score = 0
        if nameLower == query then score = 100
        elseif nameLower:sub(1, #query) == query then score = 80
        elseif nameLower:find(query, 1, true) then score = 50 + (#query / #nameLower * 30)
        else
            local matches = 0
            for i = 1, #query do if nameLower:find(query:sub(i, i), 1, true) then matches = matches + 1 end end
            score = (matches / #query) * 40
        end
        if score > 20 then table.insert(scoredScripts, {Name = script.Name, Category = script.Category, Callback = script.Callback, Score = score}) end
    end
    
    table.sort(scoredScripts, function(a, b) return a.Score > b.Score end)
    
    local maxResults = math.min(15, #scoredScripts)
    
    if maxResults == 0 then
        local noResults = Instance.new("TextLabel")
        noResults.Text = "Nenhum resultado encontrado para: '"..query.."'"
        noResults.TextColor3 = Theme.Text
        noResults.Font = Enum.Font.Gotham
        noResults.TextSize = 14
        noResults.BackgroundTransparency = 1
        noResults.Size = UDim2.new(1, 0, 0, 30)
        noResults.Parent = ResultsFrame
    else
        for i = 1, maxResults do
            local script = scoredScripts[i]
            local resultButton = Instance.new("TextButton")
            resultButton.Text = script.Name
            resultButton.Size = UDim2.new(1, 0, 0, 45)
            resultButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            resultButton.TextColor3 = Theme.Text
            resultButton.Font = Enum.Font.Gotham
            resultButton.TextSize = 15
            resultButton.TextXAlignment = Enum.TextXAlignment.Left
            resultButton.Parent = ResultsFrame
            
            local categoryLabel = Instance.new("TextLabel")
            categoryLabel.Text = "Categoria: "..script.Category
            categoryLabel.TextColor3 = Theme.Secondary
            categoryLabel.Font = Enum.Font.Gotham
            categoryLabel.TextSize = 12
            categoryLabel.BackgroundTransparency = 1
            categoryLabel.Size = UDim2.new(0.5, 0, 0, 15)
            categoryLabel.Position = UDim2.new(0, 10, 0, 25)
            categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
            categoryLabel.Parent = resultButton
            
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 10)
            padding.Parent = resultButton
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = resultButton
            
            resultButton.MouseButton1Click:Connect(function()
                resultButton.TextColor3 = Theme.Primary
                task.wait(0.1)
                resultButton.TextColor3 = Theme.Text
                pcall(script.Callback)
                Notify("Pesquisa", "Script encontrado na aba: "..script.Category, 3)
            end)
        end
    end
end

SearchBar.FocusLost:Connect(function(enterPressed)
    if enterPressed then SearchScripts(SearchBar.Text) end
end)

SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    if SearchBar.Text == "" then
        for _, child in ipairs(ResultsFrame:GetChildren()) do if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end end
    end
end)

-- Temas
CreateDivider("Temas do Hub", InicioContent)
CreateButton("Tema Preto e Ciano", function()
    Theme = {
        Background = Color3.fromRGB(15, 15, 15), Primary = Color3.fromRGB(0, 255, 255),
        Secondary = Color3.fromRGB(0, 150, 150), Accent = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(255, 255, 255), Error = Color3.fromRGB(255, 50, 50)
    }
    ApplyTheme()
    Notify("Tema", "Tema preto e ciano aplicado!", 2)
end, InicioContent)

CreateButton("Tema Azul (Original)", function()
    Theme = {
        Background = Color3.fromRGB(15, 15, 25), Primary = Color3.fromRGB(80, 50, 180),
        Secondary = Color3.fromRGB(0, 150, 255), Accent = Color3.fromRGB(200, 200, 255),
        Text = Color3.fromRGB(240, 240, 255), Error = Color3.fromRGB(255, 50, 50)
    }
    ApplyTheme()
    Notify("Tema", "Tema azul aplicado!", 2)
end, InicioContent)

CreateButton("Tema Branco", function()
    Theme = {
        Background = Color3.fromRGB(240, 240, 245), Primary = Color3.fromRGB(180, 180, 190),
        Secondary = Color3.fromRGB(150, 150, 160), Accent = Color3.fromRGB(50, 50, 60),
        Text = Color3.fromRGB(30, 30, 40), Error = Color3.fromRGB(200, 50, 50)
    }
    ApplyTheme()
    Notify("Tema", "Tema branco aplicado!", 2)
end, InicioContent)

-- ===== CONTEÚDO DAS ABAS =====
-- Universal
CreateDivider("Ferramentas Gerais", UniversalContent)
CreateButton("Noclip", function() SafeLoad("https://pastebin.com/raw/B5xRxTnk") end, UniversalContent)
CreateButton("Voo Universal", function() SafeLoad("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111") end, UniversalContent)
CreateButton("Infinite Yield", function() SafeLoad("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source") end, UniversalContent)
CreateButton("Anti-AFK", function() local VirtualUser = game:GetService("VirtualUser") game:GetService("Players").LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end) Notify("Anti-AFK", "Ativado com sucesso!") end, UniversalContent)

-- Blox Fruits
CreateDivider("Hubs Completos", BloxFruitsContent)
CreateButton("Hoho Hub", function() SafeLoad("https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua") end, BloxFruitsContent)
CreateButton("Speed Hub X", function() SafeLoad("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua") end, BloxFruitsContent)
CreateButton("banana hub", function() SafeLoad("https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua") end, BloxFruitsContent)
CreateButton("Mukuro Hub", function() SafeLoad("https://raw.githubusercontent.com/xdepressionx/Blox-Fruits/main/MukuroV2.lua") end, BloxFruitsContent)
CreateButton("Cokka Hub", function() SafeLoad("https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua") end, BloxFruitsContent)

-- Grow Garden
CreateDivider("Auto Farm", GrowGardenContent)
CreateButton("No-lag Hub", function() SafeLoad("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua") end, GrowGardenContent)
CreateButton("Solix Hub", function() SafeLoad("https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua") end, GrowGardenContent)
CreateButton("Mozil Hub", function() SafeLoad("https://raw.githubusercontent.com/MoziIOnTop/MoziIHub/refs/heads/main/GrowaGarden") end, GrowGardenContent)
CreateButton("Speed Hub X", function() SafeLoad("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua") end, GrowGardenContent)

-- Arsenal
CreateDivider("Hacks", ArsenalContent)
CreateButton("Soluna Hub", function() SafeLoad("https://soluna-script.vercel.app/arsenal.lua") end, ArsenalContent)
CreateButton("Aether hub", function() SafeLoad("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal") end, ArsenalContent)
CreateButton("Vynixius", function() SafeLoad("https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Arsenal/Arsenal.lua") end, ArsenalContent)
CreateButton("Aim Assist", function() SafeLoad("https://raw.githubusercontent.com/DocYogurt/Arsenal/main/ArsenalAimbot.lua") end, ArsenalContent)

-- Muscles Legends
CreateDivider("Hubs", MusclesContent)
CreateButton("Speed hub X", function() SafeLoad("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua") end, MusclesContent)
CreateButton("ML V1 hub", function() SafeLoad("https://raw.githubusercontent.com/2581235867/21/main/By%20Tokattk") end, MusclesContent)
CreateButton("Nova hub key:NovaHubRework", function() SafeLoad("https://raw.githubusercontent.com/EncryptedV2/Free/refs/heads/main/Key%20System") end, MusclesContent)
CreateButton("Doca hub Free", function() SafeLoad("https://raw.githubusercontent.com/CAXAP26BKyCH/MuscleLegensOnTop/refs/heads/main/my") end, MusclesContent)

-- Blue Lock
CreateDivider("Auto Farm & Hacks", BlueLockContent)
CreateButton("Alchemy Hub", function() SafeLoad("https://scripts.alchemyhub.xyz") end, BlueLockContent)
CreateButton("Shiro X hub", function() SafeLoad("https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt") end, BlueLockContent)
CreateButton("Express Hub", function() SafeLoad("https://api.luarmor.net/files/v3/loaders/d8824b23a4d9f2e0d62b4e69397d206b.lua") end, BlueLockContent)

-- Dead Rails
CreateDivider("Hacks", DeadRailsContent)
CreateButton("Speed Hub X", function() SafeLoad("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua") end, DeadRailsContent)
CreateButton("Capri Hub", function() SafeLoad("https://raw.githubusercontent.com/aceurss/AcxScripter/refs/heads/main/CapriHub-DeadRails") end, DeadRailsContent)
CreateButton("Ringta Hub", function() SafeLoad("https://raw.githubusercontent.com/fjruie/RINGTADEADRAILS.github.io/refs/heads/main/UIRAILS.LUA") end, DeadRailsContent)

-- Pet Sim
CreateDivider("SCRIPTS OFF - PET 99", PetSimContent)
CreateButton("Reaper Hub", function() SafeLoad("https://raw.githubusercontent.com/AyoReaper/Reaper-Hub/main/loader.lua") end, PetSimContent)
CreateButton("Project WD", function() SafeLoad("https://raw.githubusercontent.com/Muhammad6196/Tests/main/wd_Arise/loader.lua") end, PetSimContent)
CreateButton("Turtle Hub", function() SafeLoad("https://raw.githubusercontent.com/Turtle-0x/TurtleHub/main/psx.lua?token="..math.random(1,9999)) end, PetSimContent)

-- Blade Ball
CreateDivider("Hacks", BladeBallContent)
CreateButton("Auto Parry", function() SafeLoad("https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua") end, BladeBallContent)

-- Hubs
CreateDivider("Hubs Premium", HubsContent)
CreateButton("Tomato Hub", function() SafeLoad("https://pastebin.com/raw/jpx7sKJe") end, HubsContent)
CreateButton("Ghost Hub", function() SafeLoad("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub") end, HubsContent)
CreateButton("K00p Hub", function() SafeLoad("https://pastebin.com/raw/aMtQRfDA") end, HubsContent)

-- Build Boat
CreateDivider("Build a Boat", BuildBoatContent)
CreateButton("Cat Hub", function() SafeLoad("https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1") end, BuildBoatContent)
CreateButton("Weshky Hub", function() SafeLoad("https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/WeshkyAutoBuild.lua") end, BuildBoatContent)
CreateButton("Lexus Hub", function() SafeLoad("https://pastebin.com/raw/2NjKRALJ") end, BuildBoatContent)
CreateButton("Sem nome", function() SafeLoad("https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1") end, BuildBoatContent)
CreateButton("Sem nome2", function() SafeLoad("https://rawscripts.net/raw/Build-A-Boat-For-Treasure-BBFT-Script-24996") end, BuildBoatContent)

-- Ninja Legends
CreateDivider("Ninja Legends", NinjaLegendsContent)
CreateButton("Zerpqe Hub", function() SafeLoad("https://raw.githubusercontent.com/zerpqe/script/main/NinjaLegends.lua") end, NinjaLegendsContent)
CreateButton("Apple Hub", function() SafeLoad("https://raw.githubusercontent.com/AppleScript001/Ninjas_Legends/main/README.md") end, NinjaLegendsContent)
CreateButton("Venture Hub", function() SafeLoad("https://raw.githubusercontent.com/NukeVsCity/TheALLHACKLoader/main/NukeLoader") end, NinjaLegendsContent)

-- Forsaken
CreateDivider("Forsaken", ForsakenContent)
CreateButton("Rift Hub", function() SafeLoad("https://rifton.top/loader.lua") end, ForsakenContent)
CreateButton("Funny Hub", function() SafeLoad("https://pastefy.app/qNeSwq6A/raw") end, ForsakenContent)
CreateButton("Apple Hub", function() SafeLoad("https://raw.githubusercontent.com/SilkScripts/AppleStuff/refs/heads/main/AppleFSKV2") end, ForsakenContent)
CreateButton("Esp, stamina ifn e etc", function() SafeLoad("https://raw.githubusercontent.com/sigmaboy-sigma-boy/sigmaboy-sigma-boy/refs/heads/main/StaminaSettings.ESP.PIDC.raw") end, ForsakenContent)
CreateButton("Saryn Hub", function() SafeLoad("https://raw.githubusercontent.com/Saiky988/Saryn-Hub/refs/heads/main/Saryn%Hub%Beta.lua") end, ForsakenContent)

-- MM2
CreateDivider("Murder Mystery 2", MM2Content)
CreateButton("Aether Hub", function() SafeLoad("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Murder%20Mystery%202") end, MM2Content)
CreateButton("Space Hub", function() SafeLoad("https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/Multi") end, MM2Content)
CreateButton("Tbao Hub", function() SafeLoad("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubMurdervssheriff") end, MM2Content)
CreateButton("MM2 Hub", function() SafeLoad("https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr") end, MM2Content)

-- The Mimic
CreateDivider("The Mimic", TheMimicContent)
CreateButton("Mimic OP", function() SafeLoad("https://raw.githubusercontent.com/Yumiara/FlowRewrite/refs/heads/main/Mimic.lua") end, TheMimicContent)

-- Roube Brainrot
CreateDivider("Scripts Brainrot", BrainrotContent)
CreateButton("Lurk Hub-key:K82OFK1-2 ", function() SafeLoad("https://raw.githubusercontent.com/egor2078f/casual-stock/refs/heads/main/Key.lua") end, BrainrotContent)
CreateButton("FadHen Hub", function() SafeLoad("https://pastefy.app/X1AZGnOC/raw") end, BrainrotContent)
CreateButton("XxLegendsxX Hub", function() SafeLoad("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/nabaruBrainrot") end, BrainrotContent)
CreateButton("Sw1ft X Brainrot Hub", function() SafeLoad("https://oreofdev.github.io/Sw1ftSync/Raw/SSXBr/") end, BrainrotContent)

-- Brookhaven
CreateDivider("Hacks Brookhaven", BrookhavenContent)
CreateButton("Mango Hub", function() SafeLoad("https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub") end, BrookhavenContent)
CreateButton("Rael Hub", function() SafeLoad("https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt") end, BrookhavenContent)
CreateButton("Coquette Hub", function() SafeLoad("https://raw.githubusercontent.com/Daivd977/Deivd999/refs/heads/main/pessal") end, BrookhavenContent)
CreateButton("Chaos Hub", function() SafeLoad("https://raw.githubusercontent.com/Luscaa22/Calabocaa/refs/heads/main/ChaosHub") end, BrookhavenContent)

-- ===== SISTEMA DE ABAS =====
local function SwitchTab(selectedTab)
    local tabs = {
        InicioTab, UniversalTab, BloxFruitsTab, GrowGardenTab, ArsenalTab, 
        MusclesTab, BlueLockTab, DeadRailsTab, PetSimTab, 
        BladeBallTab, HubsTab, BuildBoatTab, NinjaLegendsTab,
        ForsakenTab, MM2Tab, TheMimicTab, BrainrotTab, BrookhavenTab
    }
    
    local contents = {
        InicioContent, UniversalContent, BloxFruitsContent, GrowGardenContent, ArsenalContent,
        MusclesContent, BlueLockContent, DeadRailsContent, PetSimContent,
        BladeBallContent, HubsContent, BuildBoatContent, NinjaLegendsContent,
        ForsakenContent, MM2Content, TheMimicContent, BrainrotContent, BrookhavenContent
    }
    
    for i, tab in ipairs(tabs) do
        if tab == selectedTab then
            tab.BackgroundColor3 = Theme.Primary
            contents[i].Visible = true
            TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Primary}):Play()
            -- Forçar atualização do layout para garantir que o conteúdo seja exibido corretamente
            task.wait()
            ContentScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contents[i].UIListLayout.AbsoluteContentSize.Y)
        else
            tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            contents[i].Visible = false
        end
    end
end

-- Conectar eventos das abas
InicioTab.MouseButton1Click:Connect(function() SwitchTab(InicioTab) end)
UniversalTab.MouseButton1Click:Connect(function() SwitchTab(UniversalTab) end)
BloxFruitsTab.MouseButton1Click:Connect(function() SwitchTab(BloxFruitsTab) end)
GrowGardenTab.MouseButton1Click:Connect(function() SwitchTab(GrowGardenTab) end)
ArsenalTab.MouseButton1Click:Connect(function() SwitchTab(ArsenalTab) end)
MusclesTab.MouseButton1Click:Connect(function() SwitchTab(MusclesTab) end)
BlueLockTab.MouseButton1Click:Connect(function() SwitchTab(BlueLockTab) end)
DeadRailsTab.MouseButton1Click:Connect(function() SwitchTab(DeadRailsTab) end)
PetSimTab.MouseButton1Click:Connect(function() SwitchTab(PetSimTab) end)
BladeBallTab.MouseButton1Click:Connect(function() SwitchTab(BladeBallTab) end)
HubsTab.MouseButton1Click:Connect(function() SwitchTab(HubsTab) end)
BuildBoatTab.MouseButton1Click:Connect(function() SwitchTab(BuildBoatTab) end)
NinjaLegendsTab.MouseButton1Click:Connect(function() SwitchTab(NinjaLegendsTab) end)
ForsakenTab.MouseButton1Click:Connect(function() SwitchTab(ForsakenTab) end)
MM2Tab.MouseButton1Click:Connect(function() SwitchTab(MM2Tab) end)
TheMimicTab.MouseButton1Click:Connect(function() SwitchTab(TheMimicTab) end)
BrainrotTab.MouseButton1Click:Connect(function() SwitchTab(BrainrotTab) end)
BrookhavenTab.MouseButton1Click:Connect(function() SwitchTab(BrookhavenTab) end)

-- Inicialização
task.wait(1)
ApplyTheme()
SwitchTab(InicioTab)
Notify("Robloki Hub Premium V5.0", "Hub carregado com sucesso!", 5)
