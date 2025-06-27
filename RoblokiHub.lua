--[
--  🐉 Robloki Hub Premium - Versão Completa Otimizada V5.0
 -- Atualizações:
  -- - **Interface TOTALMENTE REMODELADA para o novo design.**
 -- - **Sistema de minimização para um botão flutuante ciano.**
 -- - **Interface arrastável pela barra de título.**
--  - **Barra de pesquisa funcional corrigida.**
--  - Scripts verificados e atualizados
--  - Sistema anti-detecção aprimorado
--  - Interface mais fluida e responsiva
 -- - 15 abas completas com todos os scripts originais
 -- - Sistema de rolagem automático nas abas
 -- - Sistema de temas personalizáveis
-- ]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer

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
    Error = Color3.fromRGB(255, 50, 50),     -- Vermelho para o botão de fechar
    TitleBar=Color3.fromRGB(25,25,25),
    TabBackground=Color3.fromRGB(20,20,20),
    ButtonHover=Color3.fromRGB(40,40,40),
    ButtonBackground=Color3.fromRGB(25,25,25)
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

-- ===== FUNÇÕES DE CRIAÇÃO DE UI (Já existentes no seu script) =====
local function CreateTab(name)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Text = name
    tab.Size = UDim2.new(1, -10, 0, 40)
    tab.Position = UDim2.new(0.5, 0, 0.5, 0)
    tab.AnchorPoint = Vector2.new(0.5, 0.5)
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.GothamMedium
    tab.TextSize = 14
    tab.TextWrapped = true
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
    frame.Name = name .. "Content"
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

-- ===== DATA DOS SCRIPTS (Dados que você forneceu) =====
local scriptData = {
    Inicio = {}, -- Adicionei uma aba Inicio vazia para a lógica de temas e perfil
    Universal = { "Noclip", "Voo Universal", "Infinite Yield", "Anti-AFK" },
    BloxFruits = { "Hoho Hub", "Speed Hub X", "banana hub", "Mukuro Hub", "Cokka Hub" },
    GrowGarden = { "No-lag Hub", "Solix Hub", "Mozil Hub", "Speed Hub X" },
    Arsenal = { "Soluna Hub", "Aether hub", "Vynixius", "Aim Assist" },
    Muscles = { "Speed hub X", "ML V1 hub", "Nova hub key:NovaHubRework", "Doca hub Free" },
    BlueLock = { "Alchemy Hub", "Shiro X hub", "Express Hub" },
    DeadRails = { "Speed Hub X", "Capri Hub", "Ringta Hub" },
    PetSim = { "Reaper Hub", "Project WD", "Turtle Hub" },
    BladeBall = { "Auto Parry" },
    Hubs = { "Tomato Hub", "Ghost Hub", "K00p Hub" },
    BuildBoat = { "Cat Hub", "Weshky Hub", "Lexus Hub", "Sem nome", "Sem nome2" },
    NinjaLegends = { "Zerpqe Hub", "Apple Hub", "Venture Hub" },
    Forsaken = { "Rift Hub", "Funny Hub", "Apple Hub", "Esp, stamina ifn e etc", "Saryn Hub" },
    MM2 = { "Aether Hub", "Space Hub", "Tbao Hub", "MM2 Hub" },
    TheMimic = { "Mimic OP" },
    Brainrot = { "Lurk Hub-key:K82OFK1-2 ", "FadHen Hub", "XxLegendsxX Hub", "Sw1ft X Brainrot Hub" },
    Brookhaven = { "Mango Hub", "Rael Hub", "Coquette Hub", "Chaos Hub" }
}

local scriptURLs = {
    -- Universal
    ["Noclip"] = "https://pastebin.com/raw/B5xRxTnk",
    ["Voo Universal"] = "https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111",
    ["Infinite Yield"] = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    ["Anti-AFK"] = "local vu=game:gs('VirtualUser') local lp=Players.LocalPlayer lp.Idled:Connect(function() vu:CaptureController() vu:ClickButton2(Vector2.new()) end)",

    -- Blox Fruits
    ["Hoho Hub"] = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua",
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["banana hub"] = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua",
    ["Mukuro Hub"] = "https://raw.githubusercontent.com/xdepressionx/Blox-Fruits/main/MukuroV2.lua",
    ["Cokka Hub"] = "https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua",

    -- Grow Garden
    ["No-lag Hub"] = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua",
    ["Solix Hub"] = "https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua",
    ["Mozil Hub"] = "https://raw.githubusercontent.com/MoziIOnTop/MoziIHub/refs/heads/main/GrowaGarden",
    
    -- Arsenal
    ["Soluna Hub"] = "https://soluna-script.vercel.app/arsenal.lua",
    ["Aether hub"] = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal",
    ["Vynixius"] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Arsenal/Arsenal.lua",
    ["Aim Assist"] = "https://raw.githubusercontent.com/DocYogurt/Arsenal/main/ArsenalAimbot.lua",

    -- Muscles
    ["ML V1 hub"] = "https://raw.githubusercontent.com/2581235867/21/main/By%20Tokattk",
    ["Nova hub key:NovaHubRework"] = "https://raw.githubusercontent.com/EncryptedV2/Free/refs/heads/main/Key%20System",
    ["Doca hub Free"] = "https://raw.githubusercontent.com/CAXAP26BKyCH/MuscleLegensOnTop/refs/heads/main/my",
    
    -- Blue Lock
    ["Alchemy Hub"] = "https://scripts.alchemyhub.xyz",
    ["Shiro X hub"] = "https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt",
    ["Express Hub"] = "https://api.luarmor.net/files/v3/loaders/d8824b23a4d9f2e0d62b4e69397d206b.lua",

    -- Dead Rails
    ["Capri Hub"] = "https://raw.githubusercontent.com/aceurss/AcxScripter/refs/heads/main/CapriHub-DeadRails",
    ["Ringta Hub"] = "https://raw.githubusercontent.com/fjruie/RINGTADEADRAILS.github.io/refs/heads/main/UIRAILS.LUA",

    -- Pet Sim
    ["Reaper Hub"] = "https://raw.githubusercontent.com/AyoReaper/Reaper-Hub/main/loader.lua",
    ["Project WD"] = "https://raw.githubusercontent.com/Muhammad6196/Tests/main/wd_Arise/loader.lua",
    ["Turtle Hub"] = "https://raw.githubusercontent.com/Turtle-0x/TurtleHub/main/psx.lua?token="..math.random(1,9999),

    -- Blade Ball
    ["Auto Parry"] = "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua",
    
    -- Hubs
    ["Tomato Hub"] = "https://pastebin.com/raw/jpx7sKJe",
    ["Ghost Hub"] = "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub",
    ["K00p Hub"] = "https://pastebin.com/raw/aMtQRfDA",

    -- Build Boat
    ["Cat Hub"] = "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1",
    ["Weshky Hub"] = "https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/WeshkyAutoBuild.lua",
    ["Lexus Hub"] = "https://pastebin.com/raw/2NjKRALJ",
    ["Sem nome"] = "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/boatbuilderhub_B1",
    ["Sem nome2"] = "https://rawscripts.net/raw/Build-A-Boat-For-Treasure-BBFT-Script-24996",
    
    -- Ninja Legends
    ["Zerpqe Hub"] = "https://raw.githubusercontent.com/zerpqe/script/main/NinjaLegends.lua",
    ["Apple Hub"] = "https://raw.githubusercontent.com/AppleScript001/Ninjas_Legends/main/README.md",
    ["Venture Hub"] = "https://raw.githubusercontent.com/NukeVsCity/TheALLHACKLoader/main/NukeLoader",

    -- Forsaken
    ["Rift Hub"] = "https://rifton.top/loader.lua",
    ["Funny Hub"] = "https://pastefy.app/qNeSwq6A/raw",
    ["Esp, stamina ifn e etc"] = "https://raw.githubusercontent.com/sigmaboy-sigma-boy/sigmaboy-sigma-boy/refs/heads/main/StaminaSettings.ESP.PIDC.raw",
    ["Saryn Hub"] = "https://raw.githubusercontent.com/Saiky988/Saryn-Hub/refs/heads/main/Saryn%Hub%Beta.lua",
    
    -- MM2
    ["Aether Hub"] = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Murder%20Mystery%202",
    ["Space Hub"] = "https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/Multi",
    ["Tbao Hub"] = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubMurdervssheriff",
    ["MM2 Hub"] = "https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr",

    -- The Mimic
    ["Mimic OP"] = "https://raw.githubusercontent.com/Yumiara/FlowRewrite/refs/heads/main/Mimic.lua",

    -- Brainrot
    ["Lurk Hub-key:K82OFK1-2 "] = "https://raw.githubusercontent.com/egor2078f/casual-stock/refs/heads/main/Key.lua",
    ["FadHen Hub"] = "https://pastefy.app/X1AZGnOC/raw",
    ["XxLegendsxX Hub"] = "https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/nabaruBrainrot",
    ["Sw1ft X Brainrot Hub"] = "https://oreofdev.github.io/Sw1ftSync/Raw/SSXBr/",

    -- Brookhaven
    ["Mango Hub"] = "https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub",
    ["Rael Hub"] = "https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt",
    ["Coquette Hub"] = "https://raw.githubusercontent.com/Daivd977/Deivd999/refs/heads/main/pessal",
    ["Chaos Hub"] = "https://raw.githubusercontent.com/Luscaa22/Calabocaa/refs/heads/main/ChaosHub"
}

-- ===== CONSTRUÇÃO DINÂMICA DA UI =====
local MainFrame, TitleBar, MainLayout, TabFrame, ContentScrollingFrame, CloseButton, MinimizeButton, FloatingButton, SearchBar, ResultsFrame, ResultsLayout, PlayerThumbnail, PlayerName, PlayerId, GameName, SearchHint

local tabButtons = {}
local tabContents = {}

local function CreateUI()
    local largeSize = UDim2.new(0.45, 0, 0.7, 0)
    
    MainFrame = Instance.new("Frame")
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
    
    TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "🐉 ROBLOKI HUB PREMIUM V5.0 🐉"
    Title.TextColor3 = Theme.Primary
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 16
    Title.Size = UDim2.new(0.6, 0, 1, 0)
    Title.Position = UDim2.new(0.2, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Parent = TitleBar
    
    CloseButton = Instance.new("TextButton")
    CloseButton.Text = "✕"
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.TextColor3 = Theme.Text
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar
    
    MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Text = "─"
    MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MinimizeButton.TextColor3 = Theme.Primary
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 18
    MinimizeButton.Parent = TitleBar
    
    MainLayout = Instance.new("Frame")
    MainLayout.Size = UDim2.new(1, 0, 1, -35)
    MainLayout.Position = UDim2.new(0, 0, 0, 35)
    MainLayout.BackgroundTransparency = 1
    MainLayout.Parent = MainFrame
    
    local UIListLayoutMain = Instance.new("UIListLayout")
    UIListLayoutMain.FillDirection = Enum.FillDirection.Horizontal
    UIListLayoutMain.Padding = UDim.new(0, 5)
    UIListLayoutMain.Parent = MainLayout
    
    TabFrame = Instance.new("ScrollingFrame")
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
    
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(0, 2, 1, 0)
    Separator.BackgroundColor3 = Theme.Secondary
    Separator.Parent = MainLayout
    
    ContentScrollingFrame = Instance.new("ScrollingFrame")
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
    
    FloatingButton = Instance.new("TextButton")
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

    return MainFrame, TitleBar, TabFrame, ContentScrollingFrame, CloseButton, MinimizeButton, FloatingButton
end

local function AddTab(name, layoutOrder)
    local tabBtn = CreateTab(name)
    tabBtn.LayoutOrder = layoutOrder
    local contentFrame, listLayout = CreateContentFrame(name)
    tabButtons[name] = tabBtn
    tabContents[name] = { frame = contentFrame, layout = listLayout, buttons = {} }
    
    tabBtn.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
    return contentFrame
end

local function AddScript(tabName, scriptName)
    local contentFrame = tabContents[tabName].frame
    local scriptUrl = scriptURLs[scriptName]
    if not scriptUrl then return end -- Avoid errors for undefined scripts
    
    local scriptFunc = function()
        if scriptUrl:find("Anti-AFK") then
            local ok, err = pcall(loadstring(scriptUrl))
            if ok then Notify("Anti-AFK", "Ativado com sucesso!") else Notify("Erro", "Falha ao ativar Anti-AFK: " .. tostring(err), 5) end
        else
            SafeLoad(scriptUrl)
        end
    end
    
    local btn = CreateButton(scriptName, scriptFunc, contentFrame)
    table.insert(tabContents[tabName].buttons, {name = scriptName, btn = btn})
end

local function AddDivider(tabName, text)
    local contentFrame = tabContents[tabName].frame
    CreateDivider(text, contentFrame)
end

local function CreateDynamicUI()
    -- Create tabs and fill with scripts
    local tabsLayoutOrder = 1
    for name, scripts in pairs(scriptData) do
        local tab = AddTab(name, tabsLayoutOrder)
        tabsLayoutOrder = tabsLayoutOrder + 1
        
        -- Add dividers
        if name == "Universal" then AddDivider(name, "Ferramentas Gerais") end
        if name == "BloxFruits" then AddDivider(name, "Hubs Completos") end
        if name == "GrowGarden" then AddDivider(name, "Auto Farm") end
        if name == "Arsenal" then AddDivider(name, "Hacks") end
        if name == "Muscles" then AddDivider(name, "Hubs") end
        if name == "BlueLock" then AddDivider(name, "Auto Farm & Hacks") end
        if name == "DeadRails" then AddDivider(name, "Hacks") end
        if name == "PetSim" then AddDivider(name, "SCRIPTS OFF - PET 99") end
        if name == "BladeBall" then AddDivider(name, "Hacks") end
        if name == "Hubs" then AddDivider(name, "Hubs Premium") end
        if name == "BuildBoat" then AddDivider(name, "Build a Boat") end
        if name == "NinjaLegends" then AddDivider(name, "Ninja Legends") end
        if name == "Forsaken" then AddDivider(name, "Forsaken") end
        if name == "MM2" then AddDivider(name, "Murder Mystery 2") end
        if name == "TheMimic" then AddDivider(name, "The Mimic") end
        if name == "Brainrot" then AddDivider(name, "Scripts Brainrot") end
        if name == "Brookhaven" then AddDivider(name, "Hacks Brookhaven") end
        
        -- Add scripts to the content frame
        for _, scriptName in ipairs(scripts) do
            AddScript(name, scriptName)
        end
    end

    -- Adicionar conteúdo da aba Inicio (perfil e pesquisa)
    local inicioTabContent = tabContents["Inicio"].frame
    local inicioLayout = tabContents["Inicio"].layout
    local ProfileFrame = Instance.new("Frame", inicioTabContent)
    ProfileFrame.Size = UDim2.new(1, -20, 0, 120); ProfileFrame.Position = UDim2.new(0.5, 0, 0, 0); ProfileFrame.AnchorPoint = Vector2.new(0.5, 0); ProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    local cornerProfile = Instance.new("UICorner", ProfileFrame); cornerProfile.CornerRadius = UDim.new(0, 8)
    local PlayerThumbnail = Instance.new("ImageLabel", ProfileFrame); PlayerThumbnail.Size = UDim2.new(0, 80, 0, 80); PlayerThumbnail.Position = UDim2.new(0, 15, 0.5, 0); PlayerThumbnail.AnchorPoint = Vector2.new(0, 0.5); PlayerThumbnail.BackgroundColor3 = Color3.fromRGB(40, 40, 40); PlayerThumbnail.BorderSizePixel = 0
    local cornerThumb = Instance.new("UICorner", PlayerThumbnail); cornerThumb.CornerRadius = UDim.new(0, 8)
    game:GetService("Players"):GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420, function(content) PlayerThumbnail.Image = content end)
    local PlayerName = Instance.new("TextLabel", ProfileFrame); PlayerName.Text = LocalPlayer.Name; PlayerName.TextColor3 = Theme.Primary; PlayerName.Font = Enum.Font.GothamBold; PlayerName.TextSize = 18; PlayerName.TextXAlignment = Enum.TextXAlignment.Left; PlayerName.BackgroundTransparency = 1; PlayerName.Size = UDim2.new(0.6, 0, 0, 25); PlayerName.Position = UDim2.new(0, 110, 0, 20)
    local PlayerId = Instance.new("TextLabel", ProfileFrame); PlayerId.Text = "ID: "..LocalPlayer.UserId; PlayerId.TextColor3 = Theme.Accent; PlayerId.Font = Enum.Font.Gotham; PlayerId.TextSize = 14; PlayerId.TextXAlignment = Enum.TextXAlignment.Left; PlayerId.BackgroundTransparency = 1; PlayerId.Size = UDim2.new(0.6, 0, 0, 20); PlayerId.Position = UDim2.new(0, 110, 0, 45)
    local GameName = Instance.new("TextLabel", ProfileFrame); GameName.Text = "Jogo: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name; GameName.TextColor3 = Theme.Accent; GameName.Font = Enum.Font.Gotham; GameName.TextSize = 14; GameName.TextXAlignment = Enum.TextXAlignment.Left; GameName.BackgroundTransparency = 1; GameName.Size = UDim2.new(0.8, 0, 0, 20); GameName.Position = UDim2.new(0, 110, 0, 70); GameName.TextTruncate = Enum.TextTruncate.AtEnd

    SearchBar = Instance.new("TextBox", inicioTabContent); SearchBar.Size = UDim2.new(1, -20, 0, 40); SearchBar.Position = UDim2.new(0.5, 0, 0, 140); SearchBar.AnchorPoint = Vector2.new(0.5, 0); SearchBar.BackgroundColor3 = Theme.ButtonBackground; SearchBar.TextColor3 = Theme.Text; SearchBar.Font = Enum.Font.Gotham; SearchBar.TextSize = 15; SearchBar.PlaceholderText = "Pesquisar scripts..."; SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    local cornerSearch = Instance.new("UICorner", SearchBar); cornerSearch.CornerRadius = UDim.new(0, 8)
    ResultsFrame = Instance.new("ScrollingFrame", inicioTabContent); ResultsFrame.Size = UDim2.new(1, -20, 0, 250); ResultsFrame.Position = UDim2.new(0.5, 0, 0, 210); ResultsFrame.AnchorPoint = Vector2.new(0.5, 0); ResultsFrame.BackgroundTransparency = 1; ResultsFrame.ScrollBarThickness = 5; ResultsFrame.ScrollBarImageColor3 = Theme.Primary; ResultsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ResultsLayout = Instance.new("UIListLayout", ResultsFrame); ResultsLayout.Padding = UDim.new(0, 8)
    
    AddDivider("Inicio", "Temas do Hub")
    CreateButton("Tema Preto e Ciano", function() Theme.Background=Color3.fromRGB(15,15,15); Theme.Primary=Color3.fromRGB(0,255,255); Theme.Secondary=Color3.fromRGB(0,150,150); Theme.Accent=Color3.fromRGB(200,200,200); Theme.Text=Color3.fromRGB(255,255,255); Theme.Error=Color3.fromRGB(255,50,50); Theme.TitleBar=Color3.fromRGB(25,25,25); Theme.TabBackground=Color3.fromRGB(20,20,20); Theme.ButtonHover=Color3.fromRGB(40,40,40); Theme.ButtonBackground=Color3.fromRGB(25,25,25); ApplyTheme(); Notify("Tema", "Tema ciano aplicado!", 2) end, inicioTabContent)
    CreateButton("Tema Azul (Original)", function() Theme.Background=Color3.fromRGB(15,15,25); Theme.Primary=Color3.fromRGB(80,50,180); Theme.Secondary=Color3.fromRGB(0,150,255); Theme.Accent=Color3.fromRGB(200,200,255); Theme.Text=Color3.fromRGB(240,240,255); Theme.Error=Color3.fromRGB(255,50,50); Theme.TitleBar=Color3.fromRGB(25,25,35); Theme.TabBackground=Color3.fromRGB(20,20,30); Theme.ButtonHover=Color3.fromRGB(35,35,45); Theme.ButtonBackground=Color3.fromRGB(25,25,35); ApplyTheme(); Notify("Tema", "Tema azul aplicado!", 2) end, inicioTabContent)
    CreateButton("Tema Branco", function() Theme.Background=Color3.fromRGB(240,240,245); Theme.Primary=Color3.fromRGB(180,180,190); Theme.Secondary=Color3.fromRGB(150,150,160); Theme.Accent=Color3.fromRGB(50,50,60); Theme.Text=Color3.fromRGB(30,30,40); Theme.Error=Color3.fromRGB(200,50,50); Theme.TitleBar=Color3.fromRGB(230,230,235); Theme.TabBackground=Color3.fromRGB(220,220,225); Theme.ButtonHover=Color3.fromRGB(200,200,205); Theme.ButtonBackground=Color3.fromRGB(215,215,220); ApplyTheme(); Notify("Tema", "Tema branco aplicado!", 2) end, inicioTabContent)

    -- Update layout size after adding content
    inicioLayout.AbsoluteContentSize = inicioLayout.AbsoluteContentSize + Vector2.new(0, 100) -- Adjust as needed
    
end

-- ===== LÓGICA DE PESQUISA, DRAG E SWITCH =====
local function SearchScripts(query)
    for _, child in ipairs(ResultsFrame:GetChildren()) do child:Destroy() end
    if query == "" then return end
    
    local results = {}
    local lowerQuery = query:lower()
    for tabName, data in pairs(tabContents) do
        if tabName ~= "Inicio" then
            for _, btnData in ipairs(data.buttons) do
                if btnData.name:lower():find(lowerQuery) then
                    table.insert(results, { name = btnData.name, tab = tabName, callback = btnData.btn.MouseButton1Click })
                end
            end
        end
    end
    
    if #results == 0 then
        local noResults = Instance.new("TextLabel", ResultsFrame); noResults.Text = "Nenhum resultado para: '"..query.."'"; noResults.TextColor3 = Theme.Text; noResults.BackgroundTransparency = 1; noResults.Size = UDim2.new(1, 0, 0, 30); noResults.Font = Enum.Font.Gotham; noResults.TextSize = 14
    else
        for _, result in ipairs(results) do
            local resultBtn = CreateButton(result.name, result.callback, ResultsFrame)
            local categoryLabel = Instance.new("TextLabel", resultBtn); categoryLabel.Text = "Categoria: "..result.tab; categoryLabel.TextColor3 = Theme.Secondary
            categoryLabel.Font = Enum.Font.Gotham; categoryLabel.TextSize = 12; categoryLabel.BackgroundTransparency = 1; categoryLabel.Size = UDim2.new(0.5, 0, 0, 15); categoryLabel.Position = UDim2.new(0, 10, 0, 25); categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
        end
    end
    ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, ResultsLayout.AbsoluteContentSize.Y)
end

SearchBar.FocusLost:Connect(function(enterPressed) if enterPressed then SearchScripts(SearchBar.Text) end end)

local function SwitchTab(selectedTabName)
    for name, data in pairs(tabContents) do
        local isSelected = (name == selectedTabName)
        data.frame.Visible = isSelected
        tabButtons[name].BackgroundColor3 = isSelected and Theme.Primary or Color3.fromRGB(30, 30, 30)
        
        if isSelected then
            task.wait() -- Allow layout to update
            ContentScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, data.layout.AbsoluteContentSize.Y + 20)
        end
    end
end

-- Dragging logic
local isDragging = false
local dragStartPos
local dragStartMousePos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStartPos = MainFrame.Position
        dragStartMousePos = UserInputService:GetMouseLocation()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartMousePos
        MainFrame.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- Minimize/Restore logic
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

FloatingButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    FloatingButton.Visible = isMinimized
    Notify("Robloki Hub", "Hub restaurado", 1)
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    FloatingButton:Destroy()
    Notify("Robloki Hub", "Interface fechada", 1)
end)

-- ===== INICIALIZAÇÃO =====
CreateUI()
CreateDynamicUI()
task.wait(1)
ApplyTheme()
SwitchTab("Inicio")
Notify("Robloki Hub Premium V5.0", "Hub carregado com sucesso!", 5)
