-- Serviços
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

-- Carregar Kavo UI
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Kavo.CreateLib("Robloki Hub Premium", "DarkTheme")

-- Variáveis
local NoclipActive = false
local FlyEnabled = false

-- Função Noclip
local function NoclipLoop()
    while NoclipActive do
        task.wait()
        if Players.LocalPlayer.Character then
            for _, part in ipairs(Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

--[[
=============== ABA UNIVERSAL ===============
--]]
local UniversalTab = Window:NewTab("Universal")
local UniversalSection = UniversalTab:NewSection("Ferramentas Gerais")

UniversalSection:NewToggle("Noclip", "Ativa/Desativa Noclip", function(state)
    NoclipActive = state
    if state then
        coroutine.wrap(NoclipLoop)()
    end
end)

UniversalSection:NewButton("Voo Universal", "Ativa voo em qualquer jogo", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
end)

UniversalSection:NewButton("Infinite Yield", "Ferramentas de administrador", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

--[[
=============== ABA BLOX FRUITS ===============
--]]
local BloxFruitsTab = Window:NewTab("Blox Fruits")
local BFSection = BloxFruitsTab:NewSection("Hubs Completos")

BFSection:NewButton("Hoho Hub", "Melhor hub para Blox Fruits", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"))()
end)

BFSection:NewButton("Speed Hub X", "Hub alternativo", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
end)

--[[
=============== ABA GROW A GARDEN ===============
--]]
local GrowGardenTab = Window:NewTab("Grow a Garden")
local GGSection = GrowGardenTab:NewSection("Auto Farm")

GGSection:NewButton("No-lag Hub", "Farm automático sem lag", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"))()
end)

--[[
=============== ABA ARSENAL ===============
--]]
local ArsenalTab = Window:NewTab("Arsenal")
local ArsenalSection = ArsenalTab:NewSection("Hacks")

ArsenalSection:NewButton("Soluna Hub", "Melhores hacks para Arsenal", function()
    loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua"))()
end)

--[[
=============== ABA MUSCLES LEGENDS ===============
--]]
local MusclesTab = Window:NewTab("Muscles Legends")
local MLSection = MusclesTab:NewSection("Auto Farm")

MLSection:NewButton("Speed Hub X", "Farm automático", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
end)

--[[
=============== CONFIGURAÇÕES ===============
--]]
local SettingsTab = Window:NewTab("Configurações")
local SettingsSection = SettingsTab:NewSection("Sistema")

SettingsSection:NewButton("Fechar Interface", "Fecha o menu", function()
    Window:Destroy()
end)

-- Inicializar
Window:SelectTab(UniversalTab)
