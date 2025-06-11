-- Serviços necessários
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source'))()

-- Criar a janela principal do hub
local Window = Rayfield:CreateWindow({
   Name = "Robloki Hub Premium",
   LoadingTitle = "Carregando Script Hub...",
   LoadingSubtitle = "Dr4gonzin",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PremiumScriptHub",
      FileName = "Configuracao"
   },
   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/PvssedzXpT",
      RememberJoins = true
   },
   KeySystem = false
})

--[[
======================================
          ABA UNIVERSAL
======================================
--]]
local UniversalTab = Window:CreateTab("Universal", 7733960981) -- Ícone de engrenagem
local UniversalSection = UniversalTab:CreateSection("Scripts para Todos os Jogos")

-- Script de voo universal
UniversalSection:CreateButton({
   Name = "Ativar Voo (Universal)",
   Callback = function()
      loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
   end,
})

-- Noclip toggle
UniversalSection:CreateToggle({
   Name = "Ativar Noclip",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      coroutine.wrap(function()
         while _G.Noclip do
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
   end,
})

-- Infinite Yield
UniversalSection:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

--[[
======================================
          ABA BLOX FRUITS
======================================
--]]
local BloxFruitsTab = Window:CreateTab("Blox Fruits", 12584504442)
local BFSection1 = BloxFruitsTab:CreateSection("Hubs Completos")

-- Hoho Hub
BFSection1:CreateButton({
   Name = "Hoho Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"))()
   end,
})

-- Fluxus Hub
BFSection1:CreateButton({
   Name = "Speed Hub X",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
   end,
})

-- Auto Farm Level
BFSection1:CreateButton({
   Name = "banana hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/refs/heads/main/BananaCatHub.lua"))()
   end,
})

BFSection1:CreateButton({
   Name = "Tsou hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
   end,
})

BFSection1:CreateButton({
   Name = "Solix hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))() 
   end,
})

BFSection1:CreateButton({
   Name = "Alchemy Hub",
   Callback = function()
      loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
   end,
})

--[[
======================================
          ABA GROW A GARDEN
======================================
--]]
local GrowGardenTab = Window:CreateTab("Grow a Garden", 10983741056)
local GGSection = GrowGardenTab:CreateSection("Farms")

-- Garden Bot Pro
GGSection:CreateButton({
   Name = "No-lag hub",
   Callback = function()
     loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
   end,
})

GGSection:CreateButton({
   Name = "Solix Hub",
   Callback = function()
      _G.AutoFarm = true
_G.PerformanceMode = "Fast" -- "LowEnd", "Normal", "Fast", "Ultra"
_G.TeleportCooldown = 0.1
-- Seed settings
_G.AutoRebuy = true
_G.SeedPrice = 4000
_G.AutoSellThreshold = 50
_G.AutoWatering = true
_G.AutoSprinklers = true
-- Gear shop
_G.GearShopAutoBuy = true
_G.GearShopItems = {"Basic Watering Can", "Basic Sprinkler", "Basic Shovel"}
_G.RenderDistance = 50
_G.UIUpdateInterval = 2
_G.OptimizeRendering = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()
   end,
})

GGSection:CreateButton({
   Name = "Speed Hub X",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
   end,
})

GGSection:CreateButton({
   Name = "Lunor hub",
   Callback = function()
        loadstring(game:HttpGet("https://lunor.dev/loader"))()
   end,
})

--[[
======================================
          ABA BLUE LOCK RIVALS
======================================
--]]
local BlueLockTab = Window:CreateTab("Blue Lock Rivals", 12345678901) -- Substitua pelo ícone desejado
local BLRSection1 = BlueLockTab:CreateSection("Auto Farm & hacks")


-- Auto Train
BLRSection1:CreateButton({
   Name = "Alchemy Hub",
   Callback = function()
      loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
   end,
})

BLRSection1:CreateButton({
   Name = "Souls Hub",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/SPQT6v5J"))()
   end,
})

BLRSection1:CreateButton({
   Name = "Shiro X hub",
   Callback = function()
      loadstring(game:HttpGet(('https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/refs/heads/main/Protected_3467848847610666.txt')))()
   end,
})

BLRSection1:CreateButton({
   Name = "Controls Guis",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/WWa5yYf8"))()
   end,
})



-- Speed Hack
BLRSection1:CreateSlider({
   Name = "Velocidade do Jogador",
   Range = {16, 100},
   Increment = 1,
   Suffix = "estudos/s",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

--[[
======================================
          ABA ARSENAL
======================================
--]]
local ArsenalTab = Window:CreateTab("Arsenal", 6949946023)
local ArsenalSection = ArsenalTab:CreateSection("Hacks")

-- Owl Hub
ArsenalSection:CreateButton({
   Name = "Soluna Hub",
   Callback = function()
      loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua",true))()
   end,
})

ArsenalSection:CreateButton({
   Name = "Aether hub",
   Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Arsenal"))()
   end,
})

ArsenalSection:CreateButton({
   Name = "Nodoll hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/NoDollManB/roblox_scripts/refs/heads/main/arsenal.lua"))()
   end,
})

ArsenalSection:CreateButton({
   Name = "Ronix Hub",
   Callback = function()
      loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"))() 
   end,
})

ArsenalSection:CreateButton({
   Name = "Tbao hub",
   Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))
   end,
})

--[[
======================================
       ABA MUSCLES LEGENDS
======================================
--]]
local MusclesTab = Window:CreateTab("Muscles Legends", 12779704821)
local MLSection = MusclesTab:CreateSection("Automação")

-- Titan Hub
MLSection:CreateButton({
   Name = "Speed hub X",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
   end,
})

MLSection:CreateButton({
   Name = "ML V1 hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"))()
   end,
})

MLSection:CreateButton({
   Name = "Nox hub",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/2Cuza2mr"))()
   end,
})

MLSection:CreateButton({
   Name = "KTM hub",
   Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/zapstreams123/KTMHUB/refs/heads/main/PublicVersion"))()
   end,
})

MLSection:CreateButton({
   Name = "CriShoux Hub",
   Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
   end,
})

--[[
======================================
          ABA CONFIGURAÇÕES
======================================
--]]
local SettingsTab = Window:CreateTab("Configurações", 6023426915)
local SettingsSection = SettingsTab:CreateSection("Personalização")

-- Tema Escuro/Claro
SettingsSection:CreateToggle({
   Name = "Modo Escuro",
   CurrentValue = true,
   Callback = function(Value)
      Window:SetTheme(Value and "Dark" or "Light")
   end,
})

-- Fechar Hub
SettingsSection:CreateButton({
   Name = "Fechar Hub",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- Inicializar a UI
Rayfield:LoadConfiguration()
