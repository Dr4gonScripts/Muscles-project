--[[
  🐉 Robloki Hub Premium - Versão Completa Otimizada V4.3
  Atualizações:
  - Todos os botões e abas restaurados
  - Emojis decorativos adicionados
  - Interface mais atraente
  - Correção de bugs de visibilidade
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

-- Função de notificação melhorada
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
        local content = game:HttpGet(url, true)
        if content:find("404") or content:find("Not Found") then
            error("Script não encontrado (404)")
        end
        return content
    end)
    
    if success then
        loadstring(response)()
        return true
    else
        Notify("Erro", "Falha ao carregar: "..tostring(response), 5)
        return false
    end
end

-- ===== CONSTRUÇÃO DA INTERFACE =====
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.5, 0)
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
Title.Text = "🐉 ROBLOKI HUB PREMIUM V4.3 🐉"
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

-- Barra de abas com rolagem suave
local TabScrollingFrame = Instance.new("ScrollingFrame")
TabScrollingFrame.Size = UDim2.new(1, 0, 0, 35)
TabScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
TabScrollingFrame.BackgroundTransparency = 1
TabScrollingFrame.ScrollBarThickness = 3
TabScrollingFrame.ScrollBarImageColor3 = Theme.Primary
TabScrollingFrame.CanvasSize = UDim2.new(3.5, 0, 0, 35)
TabScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
TabScrollingFrame.Parent = MainFrame

-- Layout para organizar as abas
local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim2.new(0, 5)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Parent = TabScrollingFrame

-- ===== SISTEMA DE ABAS ATUALIZADO =====
local function CreateTab(name, emoji)
    local tab = Instance.new("TextButton")
    tab.Text = emoji.." "..name.." "..emoji
    tab.Size = UDim2.new(0.12, 0, 0.8, 0)
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.GothamMedium
    tab.TextSize = 12
    tab.TextWrapped = true
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
padding.PaddingLeft = UDim.new(0, 10)  -- Alterado para UDim com valor fixo
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

-- ===== CRIAÇÃO DAS ABAS COM EMOJIS =====
local UniversalTab = CreateTab("Universal", "🌐")
local BloxFruitsTab = CreateTab("Blox Fruits", "🍊")
local GrowGardenTab = CreateTab("Grow Garden", "🌱")
local ArsenalTab = CreateTab("Arsenal", "🔫")
local MusclesTab = CreateTab("Muscles", "💪")
local BlueLockTab = CreateTab("Blue Lock", "⚽")
local DeadRailsTab = CreateTab("Dead Rails", "🚂")
local PetSimTab = CreateTab("Pet Sim", "🐾")
local BladeBallTab = CreateTab("Blade Ball", "🔪")
local HubsTab = CreateTab("Hubs", "🧩")
local BuildBoatTab = CreateTab("Build Boat", "⛵")
local NinjaLegendsTab = CreateTab("Ninja Legends", "🥷")
local ForsakenTab = CreateTab("Forsaken", "👻")
local MM2Tab = CreateTab("MM2", "🔪")
local TheMimicTab = CreateTab("The Mimic", "👹")

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
local BuildBoatContent = CreateContentFrame("BuildBoatContent")
local NinjaLegendsContent = CreateContentFrame("NinjaLegendsContent")
local ForsakenContent = CreateContentFrame("ForsakenContent")
local MM2Content = CreateContentFrame("MM2Content")
local TheMimicContent = CreateContentFrame("TheMimicContent")

-- ===== CONTEÚDO DAS ABAS COMPLETO =====

-- ABA UNIVERSAL
CreateDivider("Ferramentas Gerais", UniversalContent)

CreateButton("Ativar Noclip", function()
    local noclip = false
    local character = Player.Character or Player.CharacterAdded:Wait()
    local function noclipLoop()
        if character and character:FindFirstChild("Humanoid") then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = noclip
                end
            end
        end
    end
    
    noclip = not noclip
    Notify("Noclip", noclip and "Ativado" or "Desativado")
    
    game:GetService("RunService").Stepped:Connect(noclipLoop)
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
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Name = "banana hub", URL = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua"},
    {Name = "Mukuro Hub", URL = "https://raw.githubusercontent.com/xdepressionx/Blox-Fruits/main/Mukuro.lua"},
    {Name = "Turtle Hub", URL = "https://raw.githubusercontent.com/Turtle-0x/TurtleHub/main/bf.lua"}
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
    {Name = "Solix Hub", URL = "https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua"}
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
    {Name = "Vynixius", URL = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Arsenal.lua"},
    {Name = "Aim Assist", URL = "https://raw.githubusercontent.com/DocYogurt/Arsenal/main/ArsenalAimbot.lua"}
}

for _, script in ipairs(ArsenalScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Arsenal", script.Name.." carregado")
        end
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
        if SafeLoad(script.URL) then
            Notify("Muscles Legends", script.Name.." carregado")
        end
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
        if SafeLoad(script.URL) then
            Notify("Blue Lock", script.Name.." carregado")
        end
    end, BlueLockContent)
end

-- ABA DEAD RAILS
CreateDivider("Hacks", DeadRailsContent)

local DRScripts = {
    {Name = "Dead Rails OP", URL = "https://raw.githubusercontent.com/m00ndiety/Stillwater/main/obf_Prisonteleport.lua.txt"},
    {Name = "Zephyr Hub", URL = "https://raw.githubusercontent.com/Unknownlodfc/Zephyr/main/DeadRails/Main"},
    {Name = "Micro Hub", URL = "https://raw.githubusercontent.com/TrustsenseDev/MicroHub/main/loader.lua"},
    {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}
}

for _, script in ipairs(DRScripts) do
    CreateButton(script.Name, function()
        if SafeLoad(script.URL) then
            Notify("Dead Rails", script.Name.." carregado")
        end
    end, DeadRailsContent)
end

-- ABA PET SIMULATOR
CreateDivider("Auto Farm", PetSimContent)

local PSScripts = {
    {Name = "Reaper Hub", URL = "https://raw.githubusercontent.com/AyoReaper/Reaper-Hub/main/loader.lua"},
    {Name = "Project WD", URL = "https://raw.githubusercontent.com/Muhammad6196/Tests/main/wd_Arise/loader.lua"},
    {Name = "Turtle Hub", URL = "https://raw.githubusercontent.com/Turtle-0x/TurtleHub/main/psx.lua"}
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
    {Name = "Auto Parry", URL = "https://nicuse.xyz/MainHub.lua"},
    {Name = "Soluna Hub", URL = "https://raw.githubusercontent.com/Patheticcs/Soluna-API/main/bladeball.lua"},
    {Name = "XNEOFF Script", URL = "https://raw.githubusercontent.com/XNEOFF/BladeBallScript/main/BladeBall.lua"},
    {Name = "Aimbot", URL = "https://raw.githubusercontent.com/DocYogurt/BladeBall/main/Aimbot.lua"}
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
    {Name = "Lexus Hub", URL = "https://pastebin.com/raw/2NjKRALJ"}
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
    {Name = "Apple Hub", URL = "https://raw.githubusercontent.com/SilkScripts/AppleStuff/refs/heads/main/AppleFSKV2"},
    {Name = "Esp, stamina ifn e etc", URL = "https://raw.githubusercontent.com/sigmaboy-sigma-boy/sigmaboy-sigma-boy/refs/heads/main/StaminaSettings.ESP.PIDC.raw"},
    {Name = "Rift Hub (Alt)", URL = "https://raw.githubusercontent.com/Rift-Hub/Rift-Hub/main/loader.lua"}
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
    {Name = "Tbao Hub", URL = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubMurdervssheriff"}
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

-- ===== SISTEMA DE ABAS =====
local function SwitchTab(selectedTab)
    local tabs = {
        UniversalTab, BloxFruitsTab, GrowGardenTab, ArsenalTab, 
        MusclesTab, BlueLockTab, DeadRailsTab, PetSimTab, 
        BladeBallTab, HubsTab, BuildBoatTab, NinjaLegendsTab,
        ForsakenTab, MM2Tab, TheMimicTab
    }
    
    local contents = {
        UniversalContent, BloxFruitsContent, GrowGardenContent, ArsenalContent,
        MusclesContent, BlueLockContent, DeadRailsContent, PetSimContent,
        BladeBallContent, HubsContent, BuildBoatContent, NinjaLegendsContent,
        ForsakenContent, MM2Content, TheMimicContent
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
    if not getgenv then getgenv = function() return _G end end
    getgenv().secureMode = true
    
    -- Ofuscar nomes
    local obfuscated = {
        ["Instance"] = "Inst",
        ["new"] = "create",
        ["Script"] = "Scr"
    }
    
    for original, obfuscated in pairs(obfuscated) do
        if not getgenv()[obfuscated] then
            getgenv()[obfuscated] = getgenv()[original]
        end
    end
end

AntiDetection()

-- ===== INICIALIZAÇÃO =====
SwitchTab(UniversalTab)
Notify("Robloki Hub Premium V4.3", "Hub carregado com sucesso!\n15 abas disponíveis", 5)

-- Verificação de atualização
spawn(function()
    local success, latestVersion = pcall(function()
        return game:HttpGet("https://pastebin.com/raw/ExampleVersionCheck", true)
    end)
    
    if success and latestVersion ~= "V4.3" then
        Notify("Atualização Disponível", "Nova versão do hub disponível!", 10)
    end
end)
