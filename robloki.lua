-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Load Unnamed ESP library (alternative to Rayfield)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Create main window
local Window = Library:CreateWindow({
    Title = "Robloki Hub Premium",
    AutoHide = false,
    SaveConfig = true,
    ConfigFolder = "PremiumScriptHub"
})

--[[
======================================
          UNIVERSAL TAB
======================================
--]]
local UniversalTab = Window:AddTab("Universal")
local UniversalSection = UniversalTab:AddSection("Scripts para Todos os Jogos")

-- Flight script
UniversalSection:AddButton({
    Text = "Ativar Voo (Universal)",
    Func = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
    end
})

-- Noclip toggle
local noclipEnabled = false
UniversalSection:AddToggle({
    Text = "Ativar Noclip",
    State = false,
    Func = function(state)
        noclipEnabled = state
        if state then
            coroutine.wrap(function()
                while noclipEnabled do
                    wait()
                    if Players.LocalPlayer.Character then
                        for _, part in ipairs(Players.LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)()
        end
    end
})

-- Infinite Yield
UniversalSection:AddButton({
    Text = "Infinite Yield",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

--[[
======================================
          BLOX FRUITS TAB
======================================
--]]
local BloxFruitsTab = Window:AddTab("Blox Fruits")
local BFSection1 = BloxFruitsTab:AddSection("Hubs Completos")

-- Hoho Hub
BFSection1:AddButton({
    Text = "Hoho Hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"))()
    end
})

-- Fluxus Hub
BFSection1:AddButton({
    Text = "Speed Hub X",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

-- Banana Hub
BFSection1:AddButton({
    Text = "banana hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/refs/heads/main/BananaCatHub.lua"))()
    end
})

-- Tsou hub
BFSection1:AddButton({
    Text = "Tsou hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
    end
})

-- Solix hub
BFSection1:AddButton({
    Text = "Solix hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})

-- Alchemy Hub
BFSection1:AddButton({
    Text = "Alchemy Hub",
    Func = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})

--[[
======================================
          GROW A GARDEN TAB
======================================
--]]
local GrowGardenTab = Window:AddTab("Grow a Garden")
local GGSection = GrowGardenTab:AddSection("Farms")

-- No-lag hub
GGSection:AddButton({
    Text = "No-lag hub",
    Func = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
    end
})

-- Solix Hub
GGSection:AddButton({
    Text = "Solix Hub",
    Func = function()
        _G.AutoFarm = true
        _G.PerformanceMode = "Fast"
        _G.TeleportCooldown = 0.1
        _G.AutoRebuy = true
        _G.SeedPrice = 4000
        _G.AutoSellThreshold = 50
        _G.AutoWatering = true
        _G.AutoSprinklers = true
        _G.GearShopAutoBuy = true
        _G.GearShopItems = {"Basic Watering Can", "Basic Sprinkler", "Basic Shovel"}
        _G.RenderDistance = 50
        _G.UIUpdateInterval = 2
        _G.OptimizeRendering = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()
    end
})

-- Speed Hub X
GGSection:AddButton({
    Text = "Speed Hub X",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

-- Lunor hub
GGSection:AddButton({
    Text = "Lunor hub",
    Func = function()
        loadstring(game:HttpGet("https://lunor.dev/loader"))()
    end
})

--[[
======================================
          BLUE LOCK RIVALS TAB
======================================
--]]
local BlueLockTab = Window:AddTab("Blue Lock Rivals")
local BLRSection1 = BlueLockTab:AddSection("Auto Farm & hacks")

-- Alchemy Hub
BLRSection1:AddButton({
    Text = "Alchemy Hub",
    Func = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})

-- Souls Hub
BLRSection1:AddButton({
    Text = "Souls Hub",
    Func = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/SPQT6v5J"))()
    end
})

-- Shiro X hub
BLRSection1:AddButton({
    Text = "Shiro X hub",
    Func = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/refs/heads/main/Protected_3467848847610666.txt')))()
    end
})

-- Controls Guis
BLRSection1:AddButton({
    Text = "Controls Guis",
    Func = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/WWa5yYf8"))()
    end
})

-- Speed Hack
local walkSpeed = 16
BLRSection1:AddSlider({
    Text = "Velocidade do Jogador",
    Min = 16,
    Max = 100,
    Default = 16,
    Func = function(value)
        walkSpeed = value
        if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

--[[
======================================
          ARSENAL TAB
======================================
--]]
local ArsenalTab = Window:AddTab("Arsenal")
local ArsenalSection = ArsenalTab:AddSection("Hacks")

-- Soluna Hub
ArsenalSection:AddButton({
    Text = "Soluna Hub",
    Func = function()
        loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua",true))()
    end
})

-- Aether hub
ArsenalSection:AddButton({
    Text = "Aether hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Arsenal"))()
    end
})

-- Nodoll hub
ArsenalSection:AddButton({
    Text = "Nodoll hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NoDollManB/roblox_scripts/refs/heads/main/arsenal.lua"))()
    end
})

-- Ronix Hub
ArsenalSection:AddButton({
    Text = "Ronix Hub",
    Func = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"))()
    end
})

-- Tbao hub
ArsenalSection:AddButton({
    Text = "Tbao hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))()
    end
})

--[[
======================================
       MUSCLES LEGENDS TAB
======================================
--]]
local MusclesTab = Window:AddTab("Muscles Legends")
local MLSection = MusclesTab:AddSection("Automação")

-- Speed hub X
MLSection:AddButton({
    Text = "Speed hub X",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

-- ML V1 hub
MLSection:AddButton({
    Text = "ML V1 hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"))()
    end
})

-- Nox hub
MLSection:AddButton({
    Text = "Nox hub",
    Func = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/2Cuza2mr"))()
    end
})

-- KTM hub
MLSection:AddButton({
    Text = "KTM hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zapstreams123/KTMHUB/refs/heads/main/PublicVersion"))()
    end
})

-- CriShoux Hub
MLSection:AddButton({
    Text = "CriShoux Hub",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
    end
})

--[[
======================================
          SETTINGS TAB
======================================
--]]
local SettingsTab = Window:AddTab("Configurações")
local SettingsSection = SettingsTab:AddSection("Personalização")

-- Dark/Light theme
local darkMode = true
SettingsSection:AddToggle({
    Text = "Modo Escuro",
    State = true,
    Func = function(state)
        darkMode = state
        -- You would need to implement theme changing logic here
        -- This library doesn't have built-in theme support like Rayfield
    end
})

-- Close Hub
SettingsSection:AddButton({
    Text = "Fechar Hub",
    Func = function()
        Library:Destroy()
    end
})

-- Initialize
Library:Init()
