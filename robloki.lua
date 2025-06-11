-- Serviços
local Players = game:GetService("Players")

-- Carregar FluxLib
local FluxLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxian-BR/FluxLib/main/FluxLib.lua"))()

-- Criar janela principal
local Window = FluxLib:CreateWindow({
    Title = "Robloki Hub Premium",
    SubTitle = "by Dr4gonzin",
    Size = UDim2.fromOffset(500, 600),
    Theme = "Dark"
})

-- Variáveis globais
local NoclipActive = false

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
local UniversalTab = Window:AddTab("Universal", "rbxassetid://7733960981")

UniversalTab:AddSection("Ferramentas Gerais")

UniversalTab:AddToggle("Noclip", false, function(State)
    NoclipActive = State
    if State then
        coroutine.wrap(NoclipLoop)()
    end
end)

UniversalTab:AddButton("Voo Universal", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
end)

UniversalTab:AddButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

--[[
=============== ABA BLOX FRUITS ===============
--]]
local BloxFruitsTab = Window:AddTab("Blox Fruits", "rbxassetid://12584504442")

BloxFruitsTab:AddSection("Hubs Completos")

BloxFruitsTab:AddButton("Hoho Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"))()
end)

BloxFruitsTab:AddButton("Speed Hub X", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

BloxFruitsTab:AddButton("Banana Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/refs/heads/main/BananaCatHub.lua"))()
end)

BloxFruitsTab:AddButton("Tsou Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
end)

BloxFruitsTab:AddButton("Solix Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
end)

--[[
=============== ABA GROW A GARDEN ===============
--]]
local GrowGardenTab = Window:AddTab("Grow a Garden", "rbxassetid://10983741056")

GrowGardenTab:AddSection("Auto Farm")

GrowGardenTab:AddButton("No-lag Hub", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)

GrowGardenTab:AddButton("Solix Hub", function()
    _G.AutoFarm = true
    _G.PerformanceMode = "Fast"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()
end)

GrowGardenTab:AddButton("Lunor Hub", function()
    loadstring(game:HttpGet("https://lunor.dev/loader"))()
end)

--[[
=============== ABA ARSENAL ===============
--]]
local ArsenalTab = Window:AddTab("Arsenal", "rbxassetid://6949946023")

ArsenalTab:AddSection("Hacks")

ArsenalTab:AddButton("Soluna Hub", function()
    loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua",true))()
end)

ArsenalTab:AddButton("Aether Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Arsenal"))()
end)

ArsenalTab:AddButton("Ronix Hub", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"))()
end)

--[[
=============== ABA MUSCLES LEGENDS ===============
--]]
local MusclesTab = Window:AddTab("Muscles Legends", "rbxassetid://12779704821")

MusclesTab:AddSection("Auto Farm")

MusclesTab:AddButton("Speed Hub X", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

MusclesTab:AddButton("ML V1 Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"))()
end)

MusclesTab:AddButton("CriShoux Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
end)

--[[
=============== ABA CONFIGURAÇÕES ===============
--]]
local SettingsTab = Window:AddTab("Configurações", "rbxassetid://6023426915")

SettingsTab:AddSection("Sistema")

SettingsTab:AddButton("Fechar Hub", function()
    FluxLib:Destroy()
end)

SettingsTab:AddButton("Salvar Configurações", function()
    FluxLib:SaveConfig()
end)

-- Inicializar
FluxLib:Init()
