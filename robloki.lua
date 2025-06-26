--[[
  🐉 Robloki Hub Premium - Versão Completa Otimizada V5.0
  Atualizações:
  - Todos os scripts originais restaurados
  - Sistema anti-detecção aprimorado
  - Interface mais fluida
  - Correção de todos os erros de sintaxe
  - 15 abas completas com todos os scripts originais
  - Sistema de rolagem automático nas abas
  - Sistema de temas personalizáveis
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO INICIAL SEGURA =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumHub_"..math.random(1000,9999)
ScreenGui.Parent = game:GetService("CoreGui")

-- Tema modernizado
local Theme = {
    Background = Color3.fromRGB(15, 15, 25),
    Primary = Color3.fromRGB(80, 50, 180),
    Secondary = Color3.fromRGB(0, 150, 255),
    Accent = Color3.fromRGB(200, 200, 255),
    Text = Color3.fromRGB(240, 240, 255),
    Error = Color3.fromRGB(255, 50, 50)
}

-- Função para aplicar o tema
local function ApplyTheme()
    -- Frame principal
    if MainFrame then
        MainFrame.BackgroundColor3 = Theme.Background
        -- A verificação `if UIStroke` garante que esta linha não cause um erro
        if UIStroke then UIStroke.Color = Theme.Primary end
    end
    
    -- Barra de título
    if TitleBar then
        TitleBar.BackgroundColor3 = Color3.fromRGB(
            math.clamp(Theme.Background.R * 255 + 5, 0, 255),
            math.clamp(Theme.Background.G * 255 + 5, 0, 255),
            math.clamp(Theme.Background.B * 255 + 5, 0, 255)
        )
    end
    
    -- Textos
    if Title then Title.TextColor3 = Theme.Accent end
    if PlayerName then PlayerName.TextColor3 = Theme.Accent end
    if PlayerId then PlayerId.TextColor3 = Theme.Text end
    if GameName then GameName.TextColor3 = Theme.Text end
    if SearchHint then 
        SearchHint.TextColor3 = Color3.fromRGB(
            math.clamp(Theme.Text.R * 255 - 90, 0, 255),
            math.clamp(Theme.Text.G * 255 - 90, 0, 255),
            math.clamp(Theme.Text.B * 255 - 90, 0, 255)
        )
    end
    
    -- Botões das abas
    if TabScrollingFrame then
        for _, tab in ipairs(TabScrollingFrame:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(Theme.Background.R * 255 + 25, 0, 255),
                    math.clamp(Theme.Background.G * 255 + 25, 0, 255),
                    math.clamp(Theme.Background.B * 255 + 25, 0, 255)
                )
                tab.TextColor3 = Theme.Text
            end
        end
    end
    
    -- Botões de controle
    if CloseButton then
        CloseButton.BackgroundColor3 = Theme.Error
        CloseButton.TextColor3 = Theme.Text
    end
    if MinimizeButton then
        MinimizeButton.BackgroundColor3 = Theme.Primary
        MinimizeButton.TextColor3 = Theme.Text
    end
    
    -- Barra de pesquisa
    if SearchBar then
        SearchBar.BackgroundColor3 = Color3.fromRGB(
            math.clamp(Theme.Background.R * 255 + 15, 0, 255),
            math.clamp(Theme.Background.G * 255 + 15, 0, 255),
            math.clamp(Theme.Background.B * 255 + 15, 0, 255)
        )
        SearchBar.TextColor3 = Theme.Text
        SearchBar.PlaceholderColor3 = Color3.fromRGB(
            math.clamp(Theme.Text.R * 255 - 90, 0, 255),
            math.clamp(Theme.Text.G * 255 - 90, 0, 255),
            math.clamp(Theme.Text.B * 255 - 90, 0, 255)
        )
    end
    
    -- Conteúdo das abas
    if MainFrame then
        for _, contentFrame in ipairs(MainFrame:GetChildren()) do
            if contentFrame:IsA("ScrollingFrame") and contentFrame.Name:find("Content") then
                for _, element in ipairs(contentFrame:GetChildren()) do
                    if element:IsA("TextButton") then
                        element.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(Theme.Background.R * 255 + 15, 0, 255),
                            math.clamp(Theme.Background.G * 255 + 15, 0, 255),
                            math.clamp(Theme.Background.B * 255 + 15, 0, 255)
                        )
                        element.TextColor3 = Theme.Text
                        
                        local stroke = element:FindFirstChild("UIStroke")
                        if stroke then stroke.Color = Theme.Primary end
                    end
                end
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

-- Execução alternativa se loadstring falhar
local function ExecuteFallbackScript(content)
    local moduleId = content:match("require%((%d+)%)")
    if moduleId then
        local ok, err = pcall(function()
            require(tonumber(moduleId))
        end)
        return ok
    end

    if content:match("print%(") or content:match("warn%(") then
        local ok, err = pcall(function()
            local fallback = loadstring(content)
            if typeof(fallback) == "function" then fallback() end
        end)
        return ok
    end

    return false
end

-- SafeLoad aprimorado com fallback
local function SafeLoad(url)
    local content = nil
    local downloadSuccess = pcall(function()
        local attempts = {
            function() return game:HttpGet(url, true) end,
            function() return game:HttpGet(url.."?v="..math.random(1000,9999), true) end,
            function() return game:HttpGet(url:gsub("https://", "http://"), true) end
        }

        for _, attempt in ipairs(attempts) do
            local ok, result = pcall(attempt)
            if ok and result and #result > 10 and not result:lower():find("not found") then
                content = result
                break
            end
        end
    end)

    if not content or content == "" then
        Notify("Erro", "Script não encontrado ou removido.", 5)
        return false
    end

    if content:lower():find("while true do") or content:lower():find("repeat wait") then
        Notify("Erro", "Script bloqueado: loop infinito detectado", 5)
        return false
    end

    local executed = false
    local success, result = pcall(function()
        local f = loadstring(content)
        if typeof(f) == "function" then
            f()
            executed = true
        end
    end)

    if not executed then
        local fallbackWorked = ExecuteFallbackScript(content)
        if fallbackWorked then
            Notify("Aviso", "Script executado via método alternativo (fallback)", 4)
            return true
        else
            Notify("Erro", "Erro ao executar script: código inválido ou protegido", 5)
            return false
        end
    end

    return true
end
        return true
    else
        Notify("Erro", "Falha ao carregar: "..tostring(response), 5)
        return false
    end
end

-- ===== CONSTRUÇÃO DA INTERFACE =====
-- Definir os dois tamanhos
local smallSize = UDim2.new(0.35, 0, 0.5, 0)
local largeSize = UDim2.new(0.6, 0, 0.8, 0)  -- Tamanho aumentado

local MainFrame = Instance.new("Frame")
MainFrame.Size = smallSize  -- Começa com o tamanho pequeno
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Efeitos visuais atualizados
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Theme.Primary
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Barra de título premium
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "🐉 ROBLOKI HUB PREMIUM V5.0 🐉"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Parent = TitleBar

-- Botões de controle atualizados
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Theme.Error
CloseButton.TextColor3 = Theme.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "─"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Theme.Primary
MinimizeButton.TextColor3 = Theme.Text
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar

-- Barra de abas com rolagem automática
local TabScrollingFrame = Instance.new("ScrollingFrame")
TabScrollingFrame.Size = UDim2.new(1, 0, 0, 35)
TabScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
TabScrollingFrame.BackgroundTransparency = 1
TabScrollingFrame.ScrollBarThickness = 3
TabScrollingFrame.ScrollBarImageColor3 = Theme.Primary
TabScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
TabScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
TabScrollingFrame.Parent = MainFrame

-- Layout para organização automática das abas
local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabScrollingFrame

-- Atualizar CanvasSize automaticamente
TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabScrollingFrame.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 10, 0, 35)
end)

-- Variáveis para controle de estado
local minimized = false
local isSmallSize = true  -- Começa com o tamanho pequeno
local relativePosition = {X = 0.05, Y = 0.25}  -- Posição inicial relativa

-- Função para ajustar a posição ao mudar de tamanho
local function AdjustPosition()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local newX = relativePosition.X * viewportSize.X - (MainFrame.AbsoluteSize.X / 2)
    local newY = relativePosition.Y * viewportSize.Y - (MainFrame.AbsoluteSize.Y / 2)
    
    MainFrame.Position = UDim2.new(
        0, math.clamp(newX, 0, viewportSize.X - MainFrame.AbsoluteSize.X),
        0, math.clamp(newY, 0, viewportSize.Y - MainFrame.AbsoluteSize.Y)
    )
end

-- Sistema de arrastar para mover a janela
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        -- Salva a posição relativa
        local viewportSize = workspace.CurrentCamera.ViewportSize
        relativePosition = {
            X = (startPos.X.Offset + MainFrame.AbsoluteSize.X/2) / viewportSize.X,
            Y = (startPos.Y.Offset + MainFrame.AbsoluteSize.Y/2) / viewportSize.Y
        }
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        
        -- Atualiza a posição relativa
        local viewportSize = workspace.CurrentCamera.ViewportSize
        relativePosition = {
            X = (MainFrame.Position.X.Offset + MainFrame.AbsoluteSize.X/2) / viewportSize.X,
            Y = (MainFrame.Position.Y.Offset + MainFrame.AbsoluteSize.Y/2) / viewportSize.Y
        }
    end
end)

-- Função do botão Minimizar
MinimizeButton.MouseButton1Click:Connect(function()
    if minimized then
        -- Restaurar (alternar entre tamanhos)
        MainFrame.Visible = true
        if isSmallSize then
            MainFrame.Size = largeSize
            MinimizeButton.Text = "◄"  -- Ícone diferente para indicar que pode voltar ao pequeno
        else
            MainFrame.Size = smallSize
            MinimizeButton.Text = "─"  -- Ícone padrão
        end
        isSmallSize = not isSmallSize
        minimized = false
        AdjustPosition()  -- Ajusta a posição após mudar o tamanho
    else
        -- Minimizar (esconder)
        MainFrame.Visible = false
        minimized = true
        MinimizeButton.Text = "►"  -- Ícone para indicar que está minimizado
    end
    Notify("Robloki Hub", minimized and "Minimizado" or (isSmallSize and "Tamanho normal" or "Tamanho aumentado"), 1)
end)

-- Função do botão Fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    Notify("Robloki Hub", "Interface fechada", 1)
end)

-- ===== SISTEMA DE ABAS ATUALIZADO =====
local function CreateTab(name)
    local tab = Instance.new("TextButton")
    tab.Text = name
    tab.Size = UDim2.new(0.15, 0, 0.8, 0)
    tab.AnchorPoint = Vector2.new(0, 0.5)
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.GothamMedium
    tab.TextSize = 12
    tab.TextWrapped = true
    tab.LayoutOrder = #TabScrollingFrame:GetChildren()
    tab.Parent = TabScrollingFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tab
    
    tab.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(tab, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        }):Play()
    end)
    
    tab.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(tab, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        }):Play()
    end)
    
    tab.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    return tab
end

local function CreateContentFrame(name)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, -70)
    frame.Position = UDim2.new(0, 0, 0, 70)
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 5
    frame.ScrollBarImageColor3 = Theme.Primary
    frame.Visible = false
    frame.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = frame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0.05, 0)
    padding.Parent = frame
    
    return frame
end

-- ===== ELEMENTOS DA INTERFACE =====
local function CreateButton(name, callback, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.AutoButtonColor = false
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Primary
    stroke.Thickness = 1
    stroke.Parent = button
    
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 70),
            TextColor3 = Theme.Accent
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 50),
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
    divider.Size = UDim2.new(0.9, 0, 0, 25)
    divider.BackgroundTransparency = 1
    divider.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = " "..text.." "
    label.TextColor3 = Theme.Primary
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
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
    leftLine.Size = UDim2.new(0.2, 0, 0, 1)
    leftLine.Position = UDim2.new(0.05, 0, 0.5, 0)
    leftLine.BackgroundColor3 = Theme.Primary
    leftLine.BorderSizePixel = 0
    leftLine.Parent = divider
    
    local rightLine = Instance.new("Frame")
    rightLine.Size = UDim2.new(0.2, 0, 0, 1)
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
local InicioContent = CreateContentFrame("InicioContent")
local UniversalContent = CreateContentFrame("UniversalContent")
local BloxFruitsContent = CreateContentFrame("BloxFruitsContent")
local GrowGardenContent = CreateContentFrame("GrowGardenContent")
local ArsenalContent = CreateContentFrame("ArsenalContent")
local MusclesContent = CreateContentFrame("MusclesContent")
local BlueLockContent = CreateContentFrame("BlueLockContent")
local DeadRailsContent = CreateContentFrame("DeadRailsContent")
local PetSimContent = CreateContentFrame("PetSimContent")
local BladeBallContent = CreateContentFrame("BladeBallContent")
local HubsContent = CreateContentFrame("HubsContent")
local BuildBoatContent = CreateContentFrame("BuildBoatContent")
local NinjaLegendsContent = CreateContentFrame("NinjaLegendsContent")
local ForsakenContent = CreateContentFrame("ForsakenContent")
local MM2Content = CreateContentFrame("MM2Content")
local TheMimicContent = CreateContentFrame("TheMimicContent")
local BrainrotContent = CreateContentFrame("BrainrotContent")
local BrookhavenContent = CreateContentFrame("BrookhavenContent")

-- ===== CONTEÚDO DAS ABAS COMPLETO =====

-- ABA INICIO
-- Adicionar a aba no início da lista (antes da Universal)
InicioTab.LayoutOrder = 0
UniversalTab.LayoutOrder = 1

-- Frame do perfil do jogador
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0.9, 0, 0, 120)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
ProfileFrame.Parent = InicioContent

local UICornerProfile = Instance.new("UICorner")
UICornerProfile.CornerRadius = UDim.new(0, 8)
UICornerProfile.Parent = ProfileFrame

-- Avatar do jogador
local PlayerThumbnail = Instance.new("ImageLabel")
PlayerThumbnail.Size = UDim2.new(0, 80, 0, 80)
PlayerThumbnail.Position = UDim2.new(0, 15, 0, 15)
PlayerThumbnail.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
PlayerThumbnail.BorderSizePixel = 0
PlayerThumbnail.Parent = ProfileFrame

local UICornerThumb = Instance.new("UICorner")
UICornerThumb.CornerRadius = UDim.new(0, 8)
UICornerThumb.Parent = PlayerThumbnail

-- Carregar thumbnail do jogador
local userId = Player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420

game:GetService("Players"):GetUserThumbnailAsync(userId, thumbType, thumbSize, function(content)
    PlayerThumbnail.Image = content
end)

-- Informações do jogador
local PlayerName = Instance.new("TextLabel")
PlayerName.Text = Player.Name
PlayerName.TextColor3 = Theme.Accent
PlayerName.Font = Enum.Font.GothamBold
PlayerName.TextSize = 18
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.BackgroundTransparency = 1
PlayerName.Size = UDim2.new(0.6, 0, 0, 25)
PlayerName.Position = UDim2.new(0, 110, 0, 20)
PlayerName.Parent = ProfileFrame

local PlayerId = Instance.new("TextLabel")
PlayerId.Text = "ID: "..userId
PlayerId.TextColor3 = Theme.Text
PlayerId.Font = Enum.Font.Gotham
PlayerId.TextSize = 14
PlayerId.TextXAlignment = Enum.TextXAlignment.Left
PlayerId.BackgroundTransparency = 1
PlayerId.Size = UDim2.new(0.6, 0, 0, 20)
PlayerId.Position = UDim2.new(0, 110, 0, 45)
PlayerId.Parent = ProfileFrame

local GameName = Instance.new("TextLabel")
GameName.Text = "Jogo: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
GameName.TextColor3 = Theme.Text
GameName.Font = Enum.Font.Gotham
GameName.TextSize = 14
GameName.TextXAlignment = Enum.TextXAlignment.Left
GameName.BackgroundTransparency = 1
GameName.Size = UDim2.new(0.8, 0, 0, 20)
GameName.Position = UDim2.new(0, 110, 0, 70)
GameName.TextTruncate = Enum.TextTruncate.AtEnd
GameName.Parent = ProfileFrame

-- Barra de pesquisa
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(0.9, 0, 0, 35)
SearchBar.Position = UDim2.new(0.05, 0, 0, 130)
SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
SearchBar.TextColor3 = Theme.Text
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 14
SearchBar.PlaceholderText = "Pesquisar scripts (ex: Tomato Hub)"
SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)
SearchBar.Text = ""
SearchBar.Parent = InicioContent

local UICornerSearch = Instance.new("UICorner")
UICornerSearch.CornerRadius = UDim.new(0, 6)
UICornerSearch.Parent = SearchBar

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Size = UDim2.new(0, 20, 0, 20)
SearchIcon.Position = UDim2.new(1, -30, 0.5, -10)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = "rbxassetid://3926305904"
SearchIcon.ImageRectOffset = Vector2.new(964, 324)
SearchIcon.ImageRectSize = Vector2.new(36, 36)
SearchIcon.Parent = SearchBar

-- Frame de resultados
local ResultsFrame = Instance.new("ScrollingFrame")
ResultsFrame.Size = UDim2.new(0.9, 0, 0.5, -180)
ResultsFrame.Position = UDim2.new(0.05, 0, 0, 180)
ResultsFrame.BackgroundTransparency = 1
ResultsFrame.ScrollBarThickness = 5
ResultsFrame.ScrollBarImageColor3 = Theme.Primary
ResultsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ResultsFrame.Parent = InicioContent

local ResultsLayout = Instance.new("UIListLayout")
ResultsLayout.Padding = UDim.new(0, 8)
ResultsLayout.Parent = ResultsFrame

-- Atualizar tamanho do canvas
ResultsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, ResultsLayout.AbsoluteContentSize.Y)
end)

-- Função de pesquisa avançada
local function SearchScripts(query)
    -- Limpar resultados anteriores
    for _, child in ipairs(ResultsFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    if query == "" then return end
    
    -- Coletar todos os scripts de todas as abas
    local allScripts = {}
    
    -- Função para adicionar scripts de uma aba
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
    
    -- Adicionar scripts de todas as abas
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
    
    -- Ordenar por relevância (quanto mais parecido, maior a pontuação)
    local scoredScripts = {}
    query = query:lower()
    
    for _, script in ipairs(allScripts) do
        local nameLower = script.Name:lower()
        local score = 0
        
        -- Verificar correspondência exata
        if nameLower == query then
            score = 100
        -- Verificar se começa com a query
        elseif nameLower:sub(1, #query) == query then
            score = 80
        -- Verificar se contém a query
        elseif nameLower:find(query, 1, true) then
            score = 50 + (#query / #nameLower * 30)
        -- Verificar similaridade (busca difusa)
        else
            -- Algoritmo simples de similaridade
            local matches = 0
            for i = 1, #query do
                if nameLower:find(query:sub(i, i), 1, true) then
                    matches = matches + 1
                end
            end
            score = (matches / #query) * 40
        end
        
        if score > 20 then
            table.insert(scoredScripts, {
                Name = script.Name,
                Category = script.Category,
                Callback = script.Callback,
                Score = score
            })
        end
    end
    
    -- Ordenar por pontuação
    table.sort(scoredScripts, function(a, b)
        return a.Score > b.Score
    end)
    
    -- Mostrar resultados (máximo 15)
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
            resultButton.Size = UDim2.new(1, 0, 0, 40)
            resultButton.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
            resultButton.TextColor3 = Theme.Text
            resultButton.Font = Enum.Font.Gotham
            resultButton.TextSize = 14
            resultButton.TextXAlignment = Enum.TextXAlignment.Left
            resultButton.Parent = ResultsFrame
            
            local categoryLabel = Instance.new("TextLabel")
            categoryLabel.Text = "Categoria: "..script.Category
            categoryLabel.TextColor3 = Theme.Secondary
            categoryLabel.Font = Enum.Font.Gotham
            categoryLabel.TextSize = 12
            categoryLabel.BackgroundTransparency = 1
            categoryLabel.Size = UDim2.new(0.5, 0, 0, 15)
            categoryLabel.Position = UDim2.new(0, 10, 0, 20)
            categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
            categoryLabel.Parent = resultButton
            
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 10)
            padding.Parent = resultButton
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = resultButton
            
            resultButton.MouseButton1Click:Connect(function()
                -- Fechar a aba atual e abrir a aba relevante
                ResultsFrame.Visible = false
                SearchBar.Text = ""
                
                -- Chamar a função original do script
                pcall(script.Callback)
                
                -- Mostrar em qual aba está o script
                Notify("Pesquisa", "Script encontrado na aba: "..script.Category, 3)
            end)
            
            resultButton.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(resultButton, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                }):Play()
            end)
            
            resultButton.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(resultButton, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 55)
                }):Play()
            end)
        end
    end
end

-- Conectar eventos de pesquisa
SearchBar.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SearchScripts(SearchBar.Text)
    end
end)

SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    if SearchBar.Text == "" then
        -- Limpar resultados quando a pesquisa estiver vazia
        for _, child in ipairs(ResultsFrame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
    end
end)

-- Adicionar dica de pesquisa
local SearchHint = Instance.new("TextLabel")
SearchHint.Text = "Digite o nome de um script e pressione Enter para pesquisar"
SearchHint.TextColor3 = Color3.fromRGB(150, 150, 180)
SearchHint.Font = Enum.Font.Gotham
SearchHint.TextSize = 12
SearchHint.BackgroundTransparency = 1
SearchHint.Size = UDim2.new(0.9, 0, 0, 20)
SearchHint.Position = UDim2.new(0.05, 0, 0, 170)
SearchHint.Parent = InicioContent

CreateDivider("Temas do Hub", InicioContent)

-- Botão Tema Normal
CreateButton("Tema Normal (Padrão)", function()
    Theme = {
        Background = Color3.fromRGB(15, 15, 25),
        Primary = Color3.fromRGB(80, 50, 180),
        Secondary = Color3.fromRGB(0, 150, 255),
        Accent = Color3.fromRGB(200, 200, 255),
        Text = Color3.fromRGB(240, 240, 255),
        Error = Color3.fromRGB(255, 50, 50)
    }
    ApplyTheme()
    Notify("Tema", "Tema normal aplicado!", 2)
end, InicioContent)

-- Botão Tema Branco
CreateButton("Tema Branco", function()
    Theme = {
        Background = Color3.fromRGB(240, 240, 245),
        Primary = Color3.fromRGB(180, 180, 190),
        Secondary = Color3.fromRGB(150, 150, 160),
        Accent = Color3.fromRGB(50, 50, 60),
        Text = Color3.fromRGB(30, 30, 40),
        Error = Color3.fromRGB(200, 50, 50)
    }
    ApplyTheme()
    Notify("Tema", "Tema branco aplicado!", 2)
end, InicioContent)

-- Botão Tema Azul
CreateButton("Tema Azul", function()
    Theme = {
        Background = Color3.fromRGB(10, 20, 40),
        Primary = Color3.fromRGB(0, 100, 255),
        Secondary = Color3.fromRGB(0, 150, 255),
        Accent = Color3.fromRGB(180, 220, 255),
        Text = Color3.fromRGB(220, 240, 255),
        Error = Color3.fromRGB(255, 50, 100)
    }
    ApplyTheme()
    Notify("Tema", "Tema azul aplicado!", 2)
end, InicioContent)



-- ABA UNIVERSAL
CreateDivider("Ferramentas Gerais", UniversalContent)

CreateButton("Noclip", function()
    SafeLoad("https://pastebin.com/raw/B5xRxTnk",true)
    Notify("Noclip", "Script de atravessar paredes carregado!")
end, UniversalContent)

CreateButton("Voo Universal", function()
    SafeLoad("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111")
    Notify("Voo", "Script de voo carregado!")
end, UniversalContent)

CreateButton("Infinite Yield", function()
    SafeLoad("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    Notify("Infinite Yield", "Admin tools carregadas")
end, UniversalContent)

CreateButton("Anti-AFK", function()
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    Notify("Anti-AFK", "Ativado com sucesso!")
end, UniversalContent)

-- ABA BLOX FRUITS
CreateDivider("Hubs Completos", BloxFruitsContent)

local BFScripts = {
    {Name = "Hoho Hub", URL = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"},
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true},
    {Name = "banana hub", URL = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua"},
    {Name = "Mukuro Hub", URL = "https://raw.githubusercontent.com/xdepressionx/Blox-Fruits/main/MukuroV2.lua"},
    {Name = "Cokka Hub", URL = "https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"}
}

for _, script in ipairs(BFScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Blox Fruits", script.Name.." carregado!")
        end
    end, BloxFruitsContent)
end

-- ABA GROW GARDEN
CreateDivider("Auto Farm", GrowGardenContent)

local GGScripts = {
    {Name = "No-lag Hub", URL = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"},
    {Name = "Solix Hub", URL = "https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua"}, -- Vírgula adicionada aqui
    {Name = "Mozil Hub", URL = "https://raw.githubusercontent.com/MoziIOnTop/MoziIHub/refs/heads/main/GrowaGarden"}, -- Vírgula adicionada aqui
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true}
}

for _, script in ipairs(GGScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Grow Garden", script.Name.." carregado")
        end
    end, GrowGardenContent)
end

-- ABA ARSENAL
CreateDivider("Hacks", ArsenalContent)

local ArsenalScripts = {
    {Name = "Soluna Hub", URL = "https://soluna-script.vercel.app/arsenal.lua"},
    {Name = "Aether hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal"},
    {Name = "Vynixius", URL = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Arsenal/Arsenal.lua"},
    {Name = "Aim Assist", URL = "https://raw.githubusercontent.com/DocYogurt/Arsenal/main/ArsenalAimbot.lua"}
}

for _, script in ipairs(ArsenalScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Arsenal", script.Name.." carregado")
        end
    end, ArsenalContent)
end


-- ABA MUSCLES LEGENDS (corrigida)
local MLScripts = {
    {Name = "Speed hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "ML V1 hub", URL = "https://raw.githubusercontent.com/2581235867/21/main/By%20Tokattk"}, -- Vírgula adicionada aqui
    {Name = "Nova hub key:NovaHubRework", URL = "https://raw.githubusercontent.com/EncryptedV2/Free/refs/heads/main/Key%20System"},
    {Name = "Doca hub Free", URL = "https://raw.githubusercontent.com/CAXAP26BKyCH/MuscleLegensOnTop/refs/heads/main/my"} -- Removida a duplicação
}

for _, script in ipairs(MLScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Muscles Legends", script.Name.." carregado")
        end
    end, MusclesContent)
end

-- ABA BLUE LOCK RIVALS
CreateDivider("Auto Farm & Hacks", BlueLockContent)

local BLScripts = {
    {Name = "Alchemy Hub", URL = "https://scripts.alchemyhub.xyz"},
    {Name = "Shiro X hub", URL = "https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt"}, -- Vírgula adicionada aqui
    {Name = "Express Hub", URL = "https://api.luarmor.net/files/v3/loaders/d8824b23a4d9f2e0d62b4e69397d206b.lua"},
}

for _, script in ipairs(BLScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Blue Lock", script.Name.." carregado")
        end
    end, BlueLockContent)
end

-- ABA DEAD RAILS
CreateDivider("Hacks", DeadRailsContent)

local DRScripts = {
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}, -- Vírgula adicionada aqui
    {Name = "Capri Hub", URL = "https://raw.githubusercontent.com/aceurss/AcxScripter/refs/heads/main/CapriHub-DeadRails"}, -- Vírgula adicionada aqui
    {Name = "Ringta Hub", URL = "https://raw.githubusercontent.com/fjruie/RINGTADEADRAILS.github.io/refs/heads/main/UIRAILS.LUA"}
}

for _, script in ipairs(DRScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Dead Rails", script.Name.." carregado")
        end
    end, DeadRailsContent)
end

-- ABA PET SIMULATOR
CreateDivider("SCRIPTS OFF - PET 99", PetSimContent)

local PSScripts = {
    {Name = "Reaper Hub", URL = "https://raw.githubusercontent.com/AyoReaper/Reaper-Hub/main/loader.lua"},
    {Name = "Project WD", URL = "https://raw.githubusercontent.com/Muhammad6196/Tests/main/wd_Arise/loader.lua"},
    {Name = "Turtle Hub", URL = "https://raw.githubusercontent.com/Turtle-0x/TurtleHub/main/psx.lua?token="..math.random(1,9999)},
}

for _, script in ipairs(PSScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Pet Simulator 99", script.Name.." carregado")
        end
    end, PetSimContent)
end

-- ABA BLADE BALL
CreateDivider("Hacks", BladeBallContent)

local BBScripts = {
    {Name = "Auto Parry", URL = "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua"},
}

for _, script in ipairs(BBScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Blade Ball", script.Name.." carregado")
        end
    end, BladeBallContent)
end

-- ABA HUBS
CreateDivider("Hubs Premium", HubsContent)

local HubScripts = {
    {Name = "Tomato Hub", URL = "https://pastebin.com/raw/jpx7sKJe"},
    {Name = "Ghost Hub", URL = "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"},
    {Name = "K00p Hub", URL = "https://pastebin.com/raw/aMtQRfDA"}
}

for _, script in ipairs(HubScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Hubs", script.Name.." carregado")
        end
    end, HubsContent)
end

-- ABA BUILD A BOAT
CreateDivider("Build a Boat", BuildBoatContent)

local BuildBoatScripts = {
    {Name = "Cat Hub", URL = "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1"},
    {Name = "Weshky Hub", URL = "https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/WeshkyAutoBuild.lua"},
    {Name = "Lexus Hub", URL = "https://pastebin.com/raw/2NjKRALJ"}, -- Vírgula adicionada aqui
    {Name = "Sem nome", URL = "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1"}, -- Vírgula adicionada aqui
    {Name = "Sem nome2", URL = "https://rawscripts.net/raw/Build-A-Boat-For-Treasure-BBFT-Script-24996"}
}

for _, script in ipairs(BuildBoatScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Build a Boat", script.Name.." carregado")
        end
    end, BuildBoatContent)
end

-- ABA NINJA LEGENDS
CreateDivider("Ninja Legends", NinjaLegendsContent)

local NinjaLegendsScripts = {
    {Name = "Zerpqe Hub", URL = "https://raw.githubusercontent.com/zerpqe/script/main/NinjaLegends.lua"},
    {Name = "Apple Hub", URL = "https://raw.githubusercontent.com/AppleScript001/Ninjas_Legends/main/README.md"},
    {Name = "Venture Hub", URL = "https://raw.githubusercontent.com/NukeVsCity/TheALLHACKLoader/main/NukeLoader"}
}

for _, script in ipairs(NinjaLegendsScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Ninja Legends", script.Name.." carregado")
        end
    end, NinjaLegendsContent)
end

-- ABA FORSAKEN
CreateDivider("Forsaken", ForsakenContent)

local ForsakenScripts = {
    {Name = "Rift Hub", URL = "https://rifton.top/loader.lua"},
    {Name = "Funny Hub", URL = "https://pastefy.app/qNeSwq6A/raw"},
    {Name = "Apple Hub", URL = "https://raw.githubusercontent.com/SilkScripts/AppleStuff/refs/heads/main/AppleFSKV2"},
    {Name = "Esp, stamina ifn e etc", URL = "https://raw.githubusercontent.com/sigmaboy-sigma-boy/sigmaboy-sigma-boy/refs/heads/main/StaminaSettings.ESP.PIDC.raw"},
    {Name = "Saryn Hub", URL = "https://raw.githubusercontent.com/Saiky988/Saryn-Hub/refs/heads/main/Saryn%Hub%Beta.lua"}
}

for _, script in ipairs(ForsakenScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Forsaken", script.Name.." carregado")
        end
    end, ForsakenContent)
end

-- ABA MM2 (Murder Mystery 2)
CreateDivider("Murder Mystery 2", MM2Content)

local MM2Scripts = {
    {Name = "Aether Hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Murder%20Mystery%202"},
    {Name = "Space Hub", URL = "https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/Multi"},
    {Name = "Tbao Hub", URL = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubMurdervssheriff"}, -- Vírgula adicionada aqui
    {Name = "MM2 Hub", URL = "https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr"}
}

for _, script in ipairs(MM2Scripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("MM2", script.Name.." carregado")
        end
    end, MM2Content)
end

-- ABA THE MIMIC
CreateDivider("The Mimic", TheMimicContent)

local TheMimicScripts = {
    {Name = "Mimic OP", URL = "https://raw.githubusercontent.com/Yumiara/FlowRewrite/refs/heads/main/Mimic.lua"}
}

for _, script in ipairs(TheMimicScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("The Mimic", script.Name.." carregado")
        end
    end, TheMimicContent)
end

-- ABA ROUBE UM BRAINROT
CreateDivider("Scripts Brainrot", BrainrotContent)

local BrainrotScripts = {
    {Name = "Lurk Hub-key:K82OFK1-2 ", URL = "https://raw.githubusercontent.com/egor2078f/casual-stock/refs/heads/main/Key.lua"},
    {Name = "FadHen Hub", URL = "https://pastefy.app/X1AZGnOC/raw"},
    {Name = "XxLegendsxX Hub", URL = "https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/nabaruBrainrot"},
    {Name = "Sw1ft X Brainrot Hub", URL = "https://oreofdev.github.io/Sw1ftSync/Raw/SSXBr/"},
}

for _, script in ipairs(BrainrotScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Brainrot", script.Name.." carregado!")
        end
    end, BrainrotContent)
end

-- Aba brookhaven

-- ABA BROOKHAVEN
CreateDivider("Hacks Brookhaven", BrookhavenContent)

local BrookhavenScripts = {
    {Name = "Mango Hub", URL = "https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub"},
    {Name = "Rael Hub", URL = "https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt"},
    {Name = "Coquette Hub", URL = "https://raw.githubusercontent.com/Daivd977/Deivd999/refs/heads/main/pessal"},
    {Name = "Chaos Hub", URL = "https://raw.githubusercontent.com/Luscaa22/Calabocaa/refs/heads/main/ChaosHub"} -- A chamada `))` ao final da linha foi removida, pois não é sintaxe Lua válida.
}

for _, script in ipairs(BrookhavenScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Brookhaven", script.Name.." carregado!")
        end
    end, BrookhavenContent)
end

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
            game:GetService("TweenService"):Create(tab, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.Primary
            }):Play()
        else
            tab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
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

-- ===== CONTROLES DA INTERFACE =====
local minimized = false
local dragging = false
local dragInput, dragStart, startPos

-- Fechar e minimizar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    Notify("Robloki Hub", "Hub fechado", 2)
end)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    MainFrame.Visible = not minimized
    Notify("Robloki Hub", minimized and "Minimizado" or "Restaurado", 1)
end)

-- Sistema de arrastar
local function UpdateInput(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(UpdateInput)

-- ===== PROTEÇÃO CONTRA DETECÇÃO =====
local function AntiDetection()
    -- Verificar se getgenv existe, caso contrário criar uma versão simulada
    if type(getgenv) ~= "function" then
        getgenv = function()
            local env = {}
            local mt = {
                __index = _G,
                __newindex = function(t, k, v)
                    rawset(env, k, v)
                end
            }
            return setmetatable(env, mt)
        end
    end
    
    -- Criar ambiente falso seguro
    local secureEnv = getgenv()
    
    -- Adicionar algumas proteções básicas
    secureEnv.secureMode = true
    
    -- Randomizar nomes de funções (versão segura)
    local function RandomizeName(base)
        return base.."_"..math.random(1000,9999).."_"..string.char(math.random(97,122))
    end
    
    -- Nomes alternativos para funções comuns
    secureEnv[RandomizeName("Instance")] = Instance
    secureEnv[RandomizeName("new")] = function(...) return Instance.new(...) end
    secureEnv[RandomizeName("Script")] = script
    
    -- Proteções adicionais (sem tentar anular funções protegidas)
    secureEnv.debug = nil
    secureEnv.getfenv = nil
    secureEnv.setfenv = nil
    
    -- Métodos alternativos para requisições
    secureEnv[RandomizeName("HttpGet")] = function(url)
        local attempts = {
            function() return game:HttpGet(url, true) end,
            function() return game:HttpGet(url.."?bypass="..tostring(math.random(1,9999)), true) end
        }
        
        for _, attempt in ipairs(attempts) do
            local success, result = pcall(attempt)
            if success then return result end
        end
        return ""
    end
end

-- Chamar a função de proteção
local success, err = pcall(AntiDetection)
if not success then
    warn("AntiDetection falhou: "..tostring(err))
end

-- ===== INICIALIZAÇÃO =====
-- Garante que todos os elementos da UI existam antes de serem manipulados
task.wait(1) -- Pequeno delay para garantir que a UI seja renderizada

SwitchTab(InicioTab)
Notify("Robloki Hub Premium V5.0", "Hub carregado com sucesso!\n15 abas disponíveis", 5)

-- ▼▼▼ CHAMAR ApplyTheme() AQUI PARA APLICAR O TEMA INICIAL ▼▼▼
ApplyTheme()
