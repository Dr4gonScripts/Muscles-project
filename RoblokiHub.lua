--[
  🐉 Robloki Hub Premium - Versão Completa Otimizada V5.0
  Atualizações:
  - **Interface TOTALMENTE REMODELADA para o novo design.**
  - **Sistema de minimização para um botão flutuante ciano.**
  - **Interface arrastável pela barra de título.**
  - **Barra de pesquisa funcional corrigida.**
  - Scripts verificados e atualizados
  - Sistema anti-detecção aprimorado
  - Interface mais fluida e responsiva
  - 15 abas completas com todos os scripts originais
  - Sistema de rolagem automático nas abas
  - Sistema de temas personalizáveis
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
    if MainFrame then
        MainFrame.BackgroundColor3 = Theme.Background
        local stroke = MainFrame:FindFirstChildOfClass("UIStroke")
        if stroke then stroke.Color = Theme.Primary end
    end
    if TitleBar then TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25) end
    if Title then Title.TextColor3 = Theme.Primary end
    if PlayerName then PlayerName.TextColor3 = Theme.Primary end
    if PlayerId then PlayerId.TextColor3 = Theme.Accent end
    if GameName then GameName.TextColor3 = Theme.Accent end
    if SearchHint then SearchHint.TextColor3 = Color3.fromRGB(150, 150, 150) end
    if CloseButton then CloseButton.BackgroundColor3 = Theme.Error; CloseButton.TextColor3 = Theme.Text end
    if MinimizeButton then MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); MinimizeButton.TextColor3 = Theme.Primary end
    if TabFrame then
        TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabFrame.ScrollBarImageColor3 = Theme.Primary
    end
    if ContentScrollingFrame then ContentScrollingFrame.ScrollBarImageColor3 = Theme.Primary end
    if SearchBar then
        SearchBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        SearchBar.TextColor3 = Theme.Text
        SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    end
    
    -- Update tab button colors
    if TabFrame then
        for _, tab in ipairs(TabFrame:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                tab.TextColor3 = Theme.Text
            end
        end
    end
    
    -- Update content buttons/dividers
    if ContentScrollingFrame then
        for _, content in ipairs(ContentScrollingFrame:GetChildren()) do
            if content.Visible then
                for _, element in ipairs(content:GetChildren()) do
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
        end
    end
end

-- Função de notificação aprimorada
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "Robloki Hub",
        Text = text or "Operação concluída",
        Duration = duration or 3,
        Icon = "rbxassetid://6726579484"
    })
end

-- Carregador seguro de scripts
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

-- ===== CONSTRUÇÃO DA INTERFACE (NOVO MODELO) =====
local largeSize = UDim2.new(0.45, 0, 0.7, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Size = largeSize
MainFrame.Position = UDim2.new(0.5, -largeSize.X.Offset/2, 0.5, -largeSize.Y.Offset/2)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = Theme.Primary
UIStrokeMain.Thickness = 2
UIStrokeMain.Parent = MainFrame

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

local UIListLayoutMain = Instance.new("UIListLayout")
UIListLayoutMain.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutMain.Padding = UDim.new(0, 5)
UIListLayoutMain.Parent = MainLayout

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

-- Sistema de arrastar para mover a janela (MainFrame)
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
        Notify("Robloki Hub", "Hub minimizado", 1)
        TweenService:Create(FloatingButton, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(1, -70, 0.05, 0)}):Play()
    else
        Notify("Robloki Hub", "Hub restaurado", 1)
    end
end)

-- Função do botão flutuante
FloatingButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    FloatingButton.Visible = isMinimized
    Notify("Robloki Hub", "Hub restaurado", 1)
end)

-- Função do botão Fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    FloatingButton:Destroy()
    Notify("Robloki Hub", "Interface fechada", 1)
end)

-- ===== SISTEMA DE ABAS E CONTEÚDO (ajustado para o novo layout) =====
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

local function CreateContentFrame(name)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = ContentScrollingFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = frame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0.02, 0)
    padding.Parent = frame
    
    return frame, listLayout
end

local function CreateButton(name, callback, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(1, -20, 0, 45)
    button.Position = UDim2.new(0.5, 0, 0, 0)
    button.AnchorPoint = Vector2.new(0.5, 0)
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
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 40), TextColor3 = Theme.Primary}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25, 25, 25), TextColor3 = Theme.Text}):Play()
    end)
    
    button.MouseButton1Click:Connect(function() pcall(callback) end)
    
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
    label.Position = UDim2.new(0.5, 0, 0.1, 0)
    label.AnchorPoint = Vector2.new(0.5, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = divider
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = label
    
    local leftLine = Instance.new("Frame")
    leftLine.Name = "LeftLine"
    leftLine.Size = UDim2.new(0.3, 0, 0, 2)
    leftLine.Position = UDim2.new(0, 10, 0.5, 0)
    leftLine.AnchorPoint = Vector2.new(0, 0.5)
    leftLine.BackgroundColor3 = Theme.Primary
    leftLine.BorderSizePixel = 0
    leftLine.Parent = divider
    
    local rightLine = Instance.new("Frame")
    rightLine.Name = "RightLine"
    rightLine.Size = UDim2.new(0.3, 0, 0, 2)
    rightLine.Position = UDim2.new(1, -10, 0.5, 0)
    rightLine.AnchorPoint = Vector2.new(1, 0.5)
    rightLine.BackgroundColor3 = Theme.Primary
    rightLine.BorderSizePixel = 0
    rightLine.Parent = divider
    
    return divider
end

-- Criar abas e seus conteúdos
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

local tabContents = {}
tabContents[InicioTab] = CreateContentFrame("InicioContent")
tabContents[UniversalTab] = CreateContentFrame("UniversalContent")
tabContents[BloxFruitsTab] = CreateContentFrame("BloxFruitsContent")
tabContents[GrowGardenTab] = CreateContentFrame("GrowGardenContent")
tabContents[ArsenalTab] = CreateContentFrame("ArsenalContent")
tabContents[MusclesTab] = CreateContentFrame("MusclesContent")
tabContents[BlueLockTab] = CreateContentFrame("BlueLockContent")
tabContents[DeadRailsTab] = CreateContentFrame("DeadRailsContent")
tabContents[PetSimTab] = CreateContentFrame("PetSimContent")
tabContents[BladeBallTab] = CreateContentFrame("BladeBallContent")
tabContents[HubsTab] = CreateContentFrame("HubsContent")
tabContents[BuildBoatTab] = CreateContentFrame("BuildBoatContent")
tabContents[NinjaLegendsTab] = CreateContentFrame("NinjaLegendsContent")
tabContents[ForsakenTab] = CreateContentFrame("ForsakenContent")
tabContents[MM2Tab] = CreateContentFrame("MM2Content")
tabContents[TheMimicTab] = CreateContentFrame("TheMimicContent")
tabContents[BrainrotTab] = CreateContentFrame("BrainrotContent")
tabContents[BrookhavenTab] = CreateContentFrame("BrookhavenContent")

-- Conteúdo da aba Inicio
local InicioContent, InicioLayout = tabContents[InicioTab][1], tabContents[InicioTab][2]

-- Perfil do jogador
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(1, -20, 0, 120)
ProfileFrame.Position = UDim2.new(0.5, 0, 0, 0)
ProfileFrame.AnchorPoint = Vector2.new(0.5, 0)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ProfileFrame.Parent = InicioContent
local UICornerProfile = Instance.new("UICorner"); UICornerProfile.CornerRadius = UDim.new(0, 8); UICornerProfile.Parent = ProfileFrame
local PlayerThumbnail = Instance.new("ImageLabel")
PlayerThumbnail.Size = UDim2.new(0, 80, 0, 80)
PlayerThumbnail.Position = UDim2.new(0, 15, 0.5, 0)
PlayerThumbnail.AnchorPoint = Vector2.new(0, 0.5)
PlayerThumbnail.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerThumbnail.BorderSizePixel = 0
PlayerThumbnail.Parent = ProfileFrame
local UICornerThumb = Instance.new("UICorner"); UICornerThumb.CornerRadius = UDim.new(0, 8); UICornerThumb.Parent = PlayerThumbnail
local userId = Player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
game:GetService("Players"):GetUserThumbnailAsync(userId, thumbType, thumbSize, function(content) PlayerThumbnail.Image = content end)
local PlayerName = Instance.new("TextLabel"); PlayerName.Text = Player.Name; PlayerName.TextColor3 = Theme.Primary; PlayerName.Font = Enum.Font.GothamBold; PlayerName.TextSize = 18; PlayerName.TextXAlignment = Enum.TextXAlignment.Left; PlayerName.BackgroundTransparency = 1; PlayerName.Size = UDim2.new(0.6, 0, 0, 25); PlayerName.Position = UDim2.new(0, 110, 0, 20); PlayerName.Parent = ProfileFrame
local PlayerId = Instance.new("TextLabel"); PlayerId.Text = "ID: "..userId; PlayerId.TextColor3 = Theme.Accent; PlayerId.Font = Enum.Font.Gotham; PlayerId.TextSize = 14; PlayerId.TextXAlignment = Enum.TextXAlignment.Left; PlayerId.BackgroundTransparency = 1; PlayerId.Size = UDim2.new(0.6, 0, 0, 20); PlayerId.Position = UDim2.new(0, 110, 0, 45); PlayerId.Parent = ProfileFrame
local GameName = Instance.new("TextLabel"); GameName.Text = "Jogo: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name; GameName.TextColor3 = Theme.Accent; GameName.Font = Enum.Font.Gotham; GameName.TextSize = 14; GameName.TextXAlignment = Enum.TextXAlignment.Left; GameName.BackgroundTransparency = 1; GameName.Size = UDim2.new(0.8, 0, 0, 20); GameName.Position = UDim2.new(0, 110, 0, 70); GameName.TextTruncate = Enum.TextTruncate.AtEnd; GameName.Parent = ProfileFrame

-- Barra de pesquisa e resultados
local SearchBar = Instance.new("TextBox"); SearchBar.Size = UDim2.new(1, -20, 0, 40); SearchBar.Position = UDim2.new(0.5, 0, 0, 140); SearchBar.AnchorPoint = Vector2.new(0.5, 0); SearchBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); SearchBar.TextColor3 = Theme.Text; SearchBar.Font = Enum.Font.Gotham; SearchBar.TextSize = 15; SearchBar.PlaceholderText = "Pesquisar scripts..."; SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150); SearchBar.Text = ""; SearchBar.Parent = InicioContent
local UICornerSearch = Instance.new("UICorner"); UICornerSearch.CornerRadius = UDim.new(0, 8); UICornerSearch.Parent = SearchBar
local SearchHint = Instance.new("TextLabel"); SearchHint.Text = "Digite o nome de um script e pressione Enter para pesquisar"; SearchHint.TextColor3 = Color3.fromRGB(150, 150, 150); SearchHint.Font = Enum.Font.Gotham; SearchHint.TextSize = 12; SearchHint.BackgroundTransparency = 1; SearchHint.Size = UDim2.new(1, 0, 0, 20); SearchHint.Position = UDim2.new(0.5, 0, 0, 180); SearchHint.AnchorPoint = Vector2.new(0.5, 0); SearchHint.Parent = InicioContent

local ResultsFrame = Instance.new("ScrollingFrame"); ResultsFrame.Size = UDim2.new(1, -20, 0, 250); ResultsFrame.Position = UDim2.new(0.5, 0, 0, 210); ResultsFrame.AnchorPoint = Vector2.new(0.5, 0); ResultsFrame.BackgroundTransparency = 1; ResultsFrame.ScrollBarThickness = 5; ResultsFrame.ScrollBarImageColor3 = Theme.Primary; ResultsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; ResultsFrame.Parent = InicioContent
local ResultsLayout = Instance.new("UIListLayout"); ResultsLayout.Padding = UDim.new(0, 8); ResultsLayout.Parent = ResultsFrame

local function SearchScripts(query)
    for _, child in ipairs(ResultsFrame:GetChildren()) do if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end end
    if query == "" then return end
    
    local allScripts = {}
    local function AddScriptsFromContent(contentFrame, category)
        for _, child in ipairs(contentFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Text ~= "" then
                table.insert(allScripts, {Name = child.Text, Category = category, Callback = child.MouseButton1Click})
            end
        end
    end
    
    AddScriptsFromContent(tabContents[UniversalTab][1], "Universal")
    AddScriptsFromContent(tabContents[BloxFruitsTab][1], "Blox Fruits")
    AddScriptsFromContent(tabContents[GrowGardenTab][1], "Grow Garden")
    AddScriptsFromContent(tabContents[ArsenalTab][1], "Arsenal")
    AddScriptsFromContent(tabContents[MusclesTab][1], "Muscles Legends")
    AddScriptsFromContent(tabContents[BlueLockTab][1], "Blue Lock")
    AddScriptsFromContent(tabContents[DeadRailsTab][1], "Dead Rails")
    AddScriptsFromContent(tabContents[PetSimTab][1], "Pet Simulator")
    AddScriptsFromContent(tabContents[BladeBallTab][1], "Blade Ball")
    AddScriptsFromContent(tabContents[HubsTab][1], "Hubs")
    AddScriptsFromContent(tabContents[BuildBoatTab][1], "Build Boat")
    AddScriptsFromContent(tabContents[NinjaLegendsTab][1], "Ninja Legends")
    AddScriptsFromContent(tabContents[ForsakenTab][1], "Forsaken")
    AddScriptsFromContent(tabContents[MM2Tab][1], "Murder Mystery 2")
    AddScriptsFromContent(tabContents[TheMimicTab][1], "The Mimic")
    AddScriptsFromContent(tabContents[BrainrotTab][1], "Roube Brainrot")
    AddScriptsFromContent(tabContents[BrookhavenTab][1], "Brookhaven")
    
    local scoredScripts = {}
    query = query:lower()
    
    for _, script in ipairs(allScripts) do
        local nameLower = script.Name:lower(); local score = 0
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
        local noResults = Instance.new("TextLabel"); noResults.Text = "Nenhum resultado encontrado para: '"..query.."'"; noResults.TextColor3 = Theme.Text; noResults.Font = Enum.Font.Gotham; noResults.TextSize = 14; noResults.BackgroundTransparency = 1; noResults.Size = UDim2.new(1, 0, 0, 30); noResults.Parent = ResultsFrame
    else
        for i = 1, maxResults do
            local script = scoredScripts[i]
            local resultButton = Instance.new("TextButton"); resultButton.Text = script.Name; resultButton.Size = UDim2.new(1, 0, 0, 45); resultButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35); resultButton.TextColor3 = Theme.Text; resultButton.Font = Enum.Font.Gotham; resultButton.TextSize = 15; resultButton.TextXAlignment = Enum.TextXAlignment.Left; resultButton.Parent = ResultsFrame
            local categoryLabel = Instance.new("TextLabel"); categoryLabel.Text = "Categoria: "..script.Category; categoryLabel.TextColor3 = Theme.Secondary; categoryLabel.Font = Enum.Font.Gotham; categoryLabel.TextSize = 12; categoryLabel.BackgroundTransparency = 1; categoryLabel.Size = UDim2.new(0.5, 0, 0, 15); categoryLabel.Position = UDim2.new(0, 10, 0, 25); categoryLabel.TextXAlignment = Enum.TextXAlignment.Left; categoryLabel.Parent = resultButton
            local padding = Instance.new("UIPadding"); padding.PaddingLeft = UDim.new(0, 10); padding.Parent = resultButton
            local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 8); corner.Parent = resultButton
            resultButton.MouseButton1Click:Connect(function()
                resultButton.TextColor3 = Theme.Primary; task.wait(0.1); resultButton.TextColor3 = Theme.Text
                pcall(script.Callback)
                Notify("Pesquisa", "Script encontrado na aba: "..script.Category, 3)
            end)
        end
    end
end

SearchBar.FocusLost:Connect(function(enterPressed) if enterPressed then SearchScripts(SearchBar.Text) end end)
SearchBar:GetPropertyChangedSignal("Text"):Connect(function() if SearchBar.Text == "" then for _, child in ipairs(ResultsFrame:GetChildren()) do if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end end end end)

-- Temas
CreateDivider("Temas do Hub", InicioContent)
CreateButton("Tema Preto e Ciano", function()
    Theme = { Background = Color3.fromRGB(15, 15, 15), Primary = Color3.fromRGB(0, 255, 255), Secondary = Color3.fromRGB(0, 150, 150), Accent = Color3.fromRGB(200, 200, 200), Text = Color3.fromRGB(255, 255, 255), Error = Color3.fromRGB(255, 50, 50) }
    ApplyTheme()
    Notify("Tema", "Tema preto e ciano aplicado!", 2)
end, InicioContent)

CreateButton("Tema Azul (Original)", function()
    Theme = { Background = Color3.fromRGB(15, 15, 25), Primary = Color3.fromRGB(80, 50, 180), Secondary = Color3.fromRGB(0, 150, 255), Accent = Color3.fromRGB(200, 200, 255), Text = Color3.fromRGB(240, 240, 255), Error = Color3.fromRGB(255, 50, 50) }
    ApplyTheme()
    Notify("Tema", "Tema azul aplicado!", 2)
end, InicioContent)

CreateButton("Tema Branco", function()
    Theme = { Background = Color3.fromRGB(240, 240, 245), Primary = Color3.fromRGB(180, 180, 190), Secondary = Color3.fromRGB(150, 150, 160), Accent = Color3.fromRGB(50, 50, 60), Text = Color3.fromRGB(30, 30, 40), Error = Color3.fromRGB(200, 50, 50) }
    ApplyTheme()
    Notify("Tema", "Tema branco aplicado!", 2)
end, InicioContent)

-- Preenchimento do conteúdo das abas
local function FillContent(contentFrame, scripts)
    for _, script in ipairs(scripts) do
        CreateButton(script.Name, function() SafeLoad(script.URL) end, contentFrame)
    end
end

-- Conteúdo das abas
local scriptsData = {
    Universal = { {Name = "Noclip", URL = "https://pastebin.com/raw/B5xRxTnk"}, {Name = "Voo Universal", URL = "https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"}, {Name = "Infinite Yield", URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"}, {Name = "Anti-AFK", URL = "local VirtualUser = game:GetService('VirtualUser'); game:GetService('Players').LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()); end); Notify('Anti-AFK', 'Ativado com sucesso!')"} },
    BloxFruits = { {Name = "Hoho Hub", URL = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"}, {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}, {Name = "banana hub", URL = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua"}, {Name = "Mukuro Hub", URL = "https://raw.githubusercontent.com/xdepressionx/Blox-Fruits/main/MukuroV2.lua"}, {Name = "Cokka Hub", URL = "https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"} },
    GrowGarden = { {Name = "No-lag Hub", URL = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"}, {Name = "Solix Hub", URL = "https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua"}, {Name = "Mozil Hub", URL = "https://raw.githubusercontent.com/MoziIOnTop/MoziIHub/refs/heads/main/GrowaGarden"}, {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"} },
    Arsenal = { {Name = "Soluna Hub", URL = "https://soluna-script.vercel.app/arsenal.lua"}, {Name = "Aether hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal"}, {Name = "Vynixius", URL = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Arsenal/Arsenal.lua"}, {Name = "Aim Assist", URL = "https://raw.githubusercontent.com/DocYogurt/Arsenal/main/ArsenalAimbot.lua"} },
    Muscles = { {Name = "Speed hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}, {Name = "ML V1 hub", URL = "https://raw.githubusercontent.com/2581235867/21/main/By%20Tokattk"}, {Name = "Nova hub key:NovaHubRework", URL = "https://raw.githubusercontent.com/EncryptedV2/Free/refs/heads/main/Key%20System"}, {Name = "Doca hub Free", URL = "https://raw.githubusercontent.com/CAXAP26BKyCH/MuscleLegensOnTop/refs/heads/main/my"} },
    BlueLock = { {Name = "Alchemy Hub", URL = "https://scripts.alchemyhub.xyz"}, {Name = "Shiro X hub", URL = "https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt"}, {Name = "Express Hub", URL = "https://api.luarmor.net/files/v3/loaders/d8824b23a4d9f2e0d62b4e69397d206b.lua"} },
    DeadRails = { {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}, {Name = "Capri Hub", URL = "https://raw.githubusercontent.com/aceurss/AcxScripter/refs/heads/main/CapriHub-DeadRails"}, {Name = "Ringta Hub", URL = "https://raw.githubusercontent.com/fjruie/RINGTADEADRAILS.github.io/refs/heads/main/UIRAILS.LUA"} },
    PetSim = { {Name = "Reaper Hub", URL = "https://raw.githubusercontent.com/AyoReaper/Reaper-Hub/main/loader.lua"}, {Name = "Project WD", URL = "https://raw.githubusercontent.com/Muhammad6196/Tests/main/wd_Arise/loader.lua"}, {Name = "Turtle Hub", URL = "https://raw.githubusercontent.com/Turtle-0x/TurtleHub/main/psx.lua?token="..math.random(1,9999)} },
    BladeBall = { {Name = "Auto Parry", URL = "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua"} },
    Hubs = { {Name = "Tomato Hub", URL = "https://pastebin.com/raw/jpx7sKJe"}, {Name = "Ghost Hub", URL = "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"}, {Name = "K00p Hub", URL = "https://pastebin.com/raw/aMtQRfDA"} },
    BuildBoat = { {Name = "Cat Hub", URL = "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1"}, {Name = "Weshky Hub", URL = "https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/WeshkyAutoBuild.lua"}, {Name = "Lexus Hub", URL = "https://pastebin.com/raw/2NjKRALJ"}, {Name = "Sem nome", URL = "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1"}, {Name = "Sem nome2", URL = "https://rawscripts.net/raw/Build-A-Boat-For-Treasure-BBFT-Script-24996"} },
    NinjaLegends = { {Name = "Zerpqe Hub", URL = "https://raw.githubusercontent.com/zerpqe/script/main/NinjaLegends.lua"}, {Name = "Apple Hub", URL = "https://raw.githubusercontent.com/AppleScript001/Ninjas_Legends/main/README.md"}, {Name = "Venture Hub", URL = "https://raw.githubusercontent.com/NukeVsCity/TheALLHACKLoader/main/NukeLoader"} },
    Forsaken = { {Name = "Rift Hub", URL = "https://rifton.top/loader.lua"}, {Name = "Funny Hub", URL = "https://pastefy.app/qNeSwq6A/raw"}, {Name = "Apple Hub", URL = "https://raw.githubusercontent.com/SilkScripts/AppleStuff/refs/heads/main/AppleFSKV2"}, {Name = "Esp, stamina ifn e etc", URL = "https://raw.githubusercontent.com/sigmaboy-sigma-boy/sigmaboy-sigma-boy/refs/heads/main/StaminaSettings.ESP.PIDC.raw"}, {Name = "Saryn Hub", URL = "https://raw.githubusercontent.com/Saiky988/Saryn-Hub/refs/heads/main/Saryn%Hub%Beta.lua"} },
    MM2 = { {Name = "Aether Hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Murder%20Mystery%202"}, {Name = "Space Hub", URL = "https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/Multi"}, {Name = "Tbao Hub", URL = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubMurdervssheriff"}, {Name = "MM2 Hub", URL = "https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr"} },
    TheMimic = { {Name = "Mimic OP", URL = "https://raw.githubusercontent.com/Yumiara/FlowRewrite/refs/heads/main/Mimic.lua"} },
    Brainrot = { {Name = "Lurk Hub-key:K82OFK1-2 ", URL = "https://raw.githubusercontent.com/egor2078f/casual-stock/refs/heads/main/Key.lua"}, {Name = "FadHen Hub", URL = "https://pastefy.app/X1AZGnOC/raw"}, {Name = "XxLegendsxX Hub", URL = "https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/nabaruBrainrot"}, {Name = "Sw1ft X Brainrot Hub", URL = "https://oreofdev.github.io/Sw1ftSync/Raw/SSXBr/"} },
    Brookhaven = { {Name = "Mango Hub", URL = "https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub"}, {Name = "Rael Hub", URL = "https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt"}, {Name = "Coquette Hub", URL = "https://raw.githubusercontent.com/Daivd977/Deivd999/refs/heads/main/pessal"}, {Name = "Chaos Hub", URL = "https://raw.githubusercontent.com/Luscaa22/Calabocaa/refs/heads/main/ChaosHub"} }
}

FillContent(tabContents[UniversalTab][1], scriptsData.Universal)
FillContent(tabContents[BloxFruitsTab][1], scriptsData.BloxFruits)
FillContent(tabContents[GrowGardenTab][1], scriptsData.GrowGarden)
FillContent(tabContents[ArsenalTab][1], scriptsData.Arsenal)
FillContent(tabContents[MusclesTab][1], scriptsData.Muscles)
FillContent(tabContents[BlueLockTab][1], scriptsData.BlueLock)
FillContent(tabContents[DeadRailsTab][1], scriptsData.DeadRails)
FillContent(tabContents[PetSimTab][1], scriptsData.PetSim)
FillContent(tabContents[BladeBallTab][1], scriptsData.BladeBall)
FillContent(tabContents[HubsTab][1], scriptsData.Hubs)
FillContent(tabContents[BuildBoatTab][1], scriptsData.BuildBoat)
FillContent(tabContents[NinjaLegendsTab][1], scriptsData.NinjaLegends)
FillContent(tabContents[ForsakenTab][1], scriptsData.Forsaken)
FillContent(tabContents[MM2Tab][1], scriptsData.MM2)
FillContent(tabContents[TheMimicTab][1], scriptsData.TheMimic)
FillContent(tabContents[BrainrotTab][1], scriptsData.Brainrot)
FillContent(tabContents[BrookhavenTab][1], scriptsData.Brookhaven)

-- Sistema de troca de abas
local function SwitchTab(selectedTab)
    local tabs = {
        InicioTab, UniversalTab, BloxFruitsTab, GrowGardenTab, ArsenalTab, 
        MusclesTab, BlueLockTab, DeadRailsTab, PetSimTab, 
        BladeBallTab, HubsTab, BuildBoatTab, NinjaLegendsTab,
        ForsakenTab, MM2Tab, TheMimicTab, BrainrotTab, BrookhavenTab
    }
    
    for _, tab in ipairs(tabs) do
        local contentFrame, listLayout = tabContents[tab][1], tabContents[tab][2]
        if tab == selectedTab then
            tab.BackgroundColor3 = Theme.Primary
            contentFrame.Visible = true
            TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Primary}):Play()
            
            -- Force a UIListLayout update to calculate CanvasSize
            task.wait()
            ContentScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
        else
            tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            contentFrame.Visible = false
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

-- Proteção contra detecção
local function AntiDetection()
    if type(getgenv) ~= "function" then
        getgenv = function()
            local env = {}; local mt = {__index = _G, __newindex = function(t, k, v) rawset(env, k, v) end}; return setmetatable(env, mt)
        end
    end
    local secureEnv = getgenv()
    secureEnv.secureMode = true
    local function RandomizeName(base) return base.."_"..math.random(1000,9999).."_"..string.char(math.random(97,122)) end
    secureEnv[RandomizeName("Instance")] = Instance; secureEnv[RandomizeName("new")] = function(...) return Instance.new(...) end
    secureEnv[RandomizeName("Script")] = script
    secureEnv.debug = nil; secureEnv.getfenv = nil; secureEnv.setfenv = nil
    secureEnv[RandomizeName("HttpGet")] = function(url)
        local attempts = { function() return game:HttpGet(url, true) end, function() return game:HttpGet(url.."?bypass="..tostring(math.random(1,9999)), true) end }
        for _, attempt in ipairs(attempts) do local success, result = pcall(attempt); if success then return result end end
        return ""
    end
end

local success, err = pcall(AntiDetection)
if not success then warn("AntiDetection falhou: "..tostring(err)) end

-- Inicialização
task.wait(1)
ApplyTheme()
SwitchTab(InicioTab)
Notify("Robloki Hub Premium V5.0", "Hub carregado com sucesso!", 5)
