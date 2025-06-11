-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source'))()

-- Criar janela principal
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
      Invite = "PvssedzXpT", -- Apenas o código
      RememberJoins = true
   },
   KeySystem = false
})

-- ABA UNIVERSAL
local UniversalTab = Window:CreateTab("Universal")
local UniversalSection = UniversalTab:CreateSection("Scripts para Todos os Jogos")

UniversalSection:CreateButton({
   Name = "Ativar Voo (Universal)",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
      end)
   end,
})

UniversalSection:CreateToggle({
   Name = "Ativar Noclip",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      coroutine.wrap(function()
         while _G.Noclip do
            task.wait()
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

UniversalSection:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
      end)
   end,
})

-- BLOX FRUITS
local BloxFruitsTab = Window:CreateTab("Blox Fruits")
local BFSection1 = BloxFruitsTab:CreateSection("Hubs Completos")

local scriptsBF = {
   {Name = "Hoho Hub", Url = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"},
   {Name = "Speed Hub X", Url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
   {Name = "banana hub", Url = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/refs/heads/main/BananaCatHub.lua"},
   {Name = "Tsou hub", Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"},
   {Name = "Solix hub", Url = "https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"},
   {Name = "Alchemy Hub", Url = "https://scripts.alchemyhub.xyz"},
}

for _, v in pairs(scriptsBF) do
   BFSection1:CreateButton({
      Name = v.Name,
      Callback = function()
         pcall(function()
            loadstring(game:HttpGet(v.Url))()
         end)
      end,
   })
end

-- GROW A GARDEN
local GrowGardenTab = Window:CreateTab("Grow a Garden")
local GGSection = GrowGardenTab:CreateSection("Farms")

GGSection:CreateButton({
   Name = "No-lag hub",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
      end)
   end,
})

GGSection:CreateButton({
   Name = "Solix Hub",
   Callback = function()
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
      pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()
      end)
   end,
})

GGSection:CreateButton({
   Name = "Speed Hub X",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
      end)
   end,
})

GGSection:CreateButton({
   Name = "Lunor hub",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet("https://lunor.dev/loader"))()
      end)
   end,
})

-- BLUE LOCK RIVALS
local BlueLockTab = Window:CreateTab("Blue Lock Rivals")
local BLRSection1 = BlueLockTab:CreateSection("Auto Farm & Hacks")

local scriptsBLR = {
   {Name = "Alchemy Hub", Url = "https://scripts.alchemyhub.xyz"},
   {Name = "Souls Hub", Url = "https://pastebin.com/raw/SPQT6v5J"},
   {Name = "Shiro X hub", Url = "https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/refs/heads/main/Protected_3467848847610666.txt"},
   {Name = "Controls Guis", Url = "https://pastebin.com/raw/WWa5yYf8"},
}

for _, v in pairs(scriptsBLR) do
   BLRSection1:CreateButton({
      Name = v.Name,
      Callback = function()
         pcall(function()
            loadstring(game:HttpGet(v.Url))()
         end)
      end,
   })
end

BLRSection1:CreateSlider({
   Name = "Velocidade do Jogador",
   Range = {16, 100},
   Increment = 1,
   Suffix = "studs/s",
   CurrentValue = 16,
   Callback = function(Value)
      pcall(function()
         Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end)
   end,
})

-- ARSENAL
local ArsenalTab = Window:CreateTab("Arsenal")
local ArsenalSection = ArsenalTab:CreateSection("Hacks")

local scriptsArsenal = {
   {Name = "Soluna Hub", Url = "https://soluna-script.vercel.app/arsenal.lua"},
   {Name = "Aether hub", Url = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Arsenal"},
   {Name = "Nodoll hub", Url = "https://raw.githubusercontent.com/NoDollManB/roblox_scripts/refs/heads/main/arsenal.lua"},
   {Name = "Ronix Hub", Url = "https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"},
   {Name = "Tbao hub", Url = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"},
}

for _, v in pairs(scriptsArsenal) do
   ArsenalSection:CreateButton({
      Name = v.Name,
      Callback = function()
         pcall(function()
            loadstring(game:HttpGet(v.Url))()
         end)
      end,
   })
end

-- MUSCLES LEGENDS
local MusclesTab = Window:CreateTab("Muscles Legends")
local MLSection = MusclesTab:CreateSection("Automação")

local scriptsML = {
   {Name = "Speed hub X", Url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
   {Name = "ML V1 hub", Url = "https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"},
   {Name = "Nox hub", Url = "https://pastebin.com/raw/2Cuza2mr"},
   {Name = "KTM hub", Url = "https://raw.githubusercontent.com/zapstreams123/KTMHUB/refs/heads/main/PublicVersion"},
   {Name = "CriShoux Hub", Url = "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"},
}

for _, v in pairs(scriptsML) do
   MLSection:CreateButton({
      Name = v.Name,
      Callback = function()
         pcall(function()
            loadstring(game:HttpGet(v.Url))()
         end)
      end,
   })
end

-- CONFIGURAÇÕES
local SettingsTab = Window:CreateTab("Configurações")
local SettingsSection = SettingsTab:CreateSection("Personalização")

SettingsSection:CreateToggle({
   Name = "Modo Escuro",
   CurrentValue = true,
   Callback = function(Value)
      Window:SetTheme(Value and "Dark" or "Light")
   end,
})

SettingsSection:CreateButton({
   Name = "Fechar Hub",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- Carregar configuração
Rayfield:LoadConfiguration()
