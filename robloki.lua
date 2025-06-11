--[[
  🐉 Robloki Hub Premium - Versão Completa
  Abas incluídas:
    - Universal
    - Blox Fruits
    - Grow Garden
    - Arsenal
    - Muscles Legends
    - Blue Lock Rivals
    - Dead Rails
    - Pet Simulator
    - Blade Ball
    - Hubs Gerais
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO INICIAL =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Configuração do tema
local Theme = {
    Background = Color3.fromRGB(15, 15, 25),
    Primary = Color3.fromRGB(80, 50, 180),
    Secondary = Color3.fromRGB(0, 150, 255),
    Accent = Color3.fromRGB(200, 200, 255),
    Text = Color3.fromRGB(240, 240, 255)
}

-- Função para notificações
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "Robloki Hub",
        Text = text or "Ação concluída!",
        Duration = duration or 3,
    })
end

-- ===== CONSTRUÇÃO DA INTERFACE =====
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Efeitos visuais
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

-- Botões de controle
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

-- Barra de abas com scroll
local TabScrollingFrame = Instance.new("ScrollingFrame")
TabScrollingFrame.Size = UDim2.new(1, 0, 0, 30)
TabScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
TabScrollingFrame.BackgroundTransparency = 1
TabScrollingFrame.ScrollBarThickness = 0
TabScrollingFrame.CanvasSize = UDim2.new(2, 0, 0, 30)
TabScrollingFrame.Parent = MainFrame

-- ===== FUNÇÕES AUXILIARES =====
local function CreateTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Text = name
    tab.Size = UDim2.new(0.15, 0, 1, 0)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.Gotham
    tab.TextSize = 12
    tab.TextWrapped = true
    tab.Parent = TabScrollingFrame
    
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

-- ===== CRIAR TODAS AS ABAS =====
local UniversalTab = CreateTab("Universal", UDim2.new(0, 0, 0, 0))
local BloxFruitsTab = CreateTab("Blox Fruits", UDim2.new(0.15, 0, 0, 0))
local GrowGardenTab = CreateTab("Grow Garden", UDim2.new(0.3, 0, 0, 0))
local ArsenalTab = CreateTab("Arsenal", UDim2.new(0.45, 0, 0, 0))
local MusclesTab = CreateTab("Muscles", UDim2.new(0.6, 0, 0, 0))
local BlueLockTab = CreateTab("Blue Lock", UDim2.new(0.75, 0, 0, 0))
local DeadRailsTab = CreateTab("Dead Rails", UDim2.new(0.9, 0, 0, 0))
local PetSimTab = CreateTab("Pet Sim", UDim2.new(1.05, 0, 0, 0))
local BladeBallTab = CreateTab("Blade Ball", UDim2.new(1.2, 0, 0, 0))
local HubsTab = CreateTab("Hubs", UDim2.new(1.35, 0, 0, 0))

-- Criar conteúdos para cada aba
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

-- ===== CONTEÚDO DAS ABAS =====

-- ABA UNIVERSAL
CreateDivider("Ferramentas Gerais", UniversalContent)

CreateButton("Ativar Noclip", function()
    -- Código do noclip aqui
    Notify("Noclip", "Noclip ativado/desativado")
end, UniversalContent)

CreateButton("Voo Universal", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
    Notify("Voo", "Script de voo carregado!")
end, UniversalContent)

CreateButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    Notify("Infinite Yield", "Admin tools carregadas")
end, UniversalContent)

-- ABA BLOX FRUITS
CreateDivider("Hubs Completos", BloxFruitsContent)

local BFScripts = {
    {Name = "Hoho Hub", URL = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"},
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "banana hub", URL = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua"}
}

for _, script in ipairs(BFScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Blox Fruits", script.Name.." carregado")
    end, BloxFruitsContent)
end

-- ABA GROW GARDEN
CreateDivider("Auto Farm", GrowGardenContent)

local GGScripts = {
    {Name = "No-lag Hub", URL = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"},
    {Name = "Solix Hub", URL = "https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua"}
}

for _, script in ipairs(GGScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Grow Garden", script.Name.." carregado")
    end, GrowGardenContent)
end

-- ABA ARSENAL
CreateDivider("Hacks", ArsenalContent)

local ArsenalScripts = {
    {Name = "Soluna Hub", URL = "https://soluna-script.vercel.app/arsenal.lua"},
    {Name = "Aether hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal"}
}

for _, script in ipairs(ArsenalScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Arsenal", script.Name.." carregado")
    end, ArsenalContent)
end

-- ABA MUSCLES LEGENDS
CreateDivider("Auto Farm", MusclesContent)

local MLScripts = {
    {Name = "Speed hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "ML V1 hub", URL = "https://raw.githubusercontent.com/2581235867/21/main/By%20Tokattk"}
}

for _, script in ipairs(MLScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Muscles Legends", script.Name.." carregado")
    end, MusclesContent)
end

-- ABA BLUE LOCK RIVALS
CreateDivider("Auto Farm & Hacks", BlueLockContent)

local BLScripts = {
    {Name = "Alchemy Hub", URL = "https://scripts.alchemyhub.xyz"},
    {Name = "Shiro X hub", URL = "https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt"}
}

for _, script in ipairs(BLScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Blue Lock", script.Name.." carregado")
    end, BlueLockContent)
end

-- ABA DEAD RAILS
CreateDivider("Hacks", DeadRailsContent)

local DRScripts = {
    {Name = "Dead Rails OP", URL = "https://raw.githubusercontent.com/m00ndiety/Stillwater/refs/heads/main/obf_Prisonteleport.lua.txt"},
    {Name = "Zephyr Hub", URL = "https://raw.githubusercontent.com/Unknownlodfc/Zephyr/refs/heads/main/DeadRails/Main"}
    {Name = "Micro Hub", URL = "https://raw.githubusercontent.com/TrustsenseDev/MicroHub/refs/heads/main/loader.lua"}
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}
}

for _, script in ipairs(DRScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Dead Rails", script.Name.." carregado")
    end, DeadRailsContent)
end

-- ABA PET SIMULATOR
CreateDivider("Auto Farm", PetSimContent)

local PSScripts = {
    {Name = "Reaper Hub", URL = "https://raw.githubusercontent.com/AyoReaper/Reaper-Hub/refs/heads/main/loader.lua"},
    {Name = "Project WD", URL = "https://raw.githubusercontent.com/Muhammad6196/Tests/main/wd_Arise/loader.lua"}
}

for _, script in ipairs(PSScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Pet Simulator 99", script.Name.." carregado")
    end, PetSimContent)
end

-- ABA BLADE BALL
CreateDivider("Hacks", BladeBallContent)

local BBScripts = {
    {Name = "Auto Parry", URL = "https://nicuse.xyz/MainHub.lua"},
    {Name = "Soluna Hub", URL = "https://raw.githubusercontent.com/Patheticcs/Soluna-API/refs/heads/main/bladeball.lua"}
}

for _, script in ipairs(BBScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Blade Ball", script.Name.." carregado")
    end, BladeBallContent)
end

-- ABA HUBS
CreateDivider("Hubs Premium", HubsContent)

local HubScripts = {
    {Name = "Tomato Hub", URL = "https://pastebin.com/raw/jpx7sKJe"},
    {Name = "Ghost Hub", URL = "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"}
    {Name = "K00p Hub", URL = "https://pastebin.com/raw/aMtQRfDA"}
}

for _, script in ipairs(HubScripts) do
    CreateButton(script.Name, function()
        loadstring(game:HttpGet(script.URL))()
        Notify("Hubs", script.Name.." carregado")
    end, HubsContent)
end

-- ===== CONTROLES DA INTERFACE =====
local minimized = false
local dragging = false
local dragInput, dragStart, startPos

-- Função para alternar entre abas
local function SwitchTab(selectedTab)
    local tabs = {
        UniversalTab, BloxFruitsTab, GrowGardenTab, ArsenalTab, 
        MusclesTab, BlueLockTab, DeadRailsTab, PetSimTab, 
        BladeBallTab, HubsTab
    }
    
    local contents = {
        UniversalContent, BloxFruitsContent, GrowGardenContent, ArsenalContent,
        MusclesContent, BlueLockContent, DeadRailsContent, PetSimContent,
        BladeBallContent, HubsContent
    }
    
    for i, tab in ipairs(tabs) do
        tab.BackgroundColor3 = (tab == selectedTab) and Theme.Primary or Color3.fromRGB(40, 40, 60)
        contents[i].Visible = (tab == selectedTab)
    end
end

-- Conectar eventos das abas
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

-- Configurar fechamento e minimização
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    MainFrame.Visible = not minimized
end)

-- Iniciar com a aba Universal
SwitchTab(UniversalTab)
Notify("Robloki Hub Premium V3.0", "Hub carregado com sucesso!", 5)
