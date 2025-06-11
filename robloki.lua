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
local UniversalTab = Window:CreateTab("Universal", 7733960981)
local UniversalSection = UniversalTab:CreateSection("Scripts para Todos os Jogos")

-- Script de voo universal
UniversalSection:CreateButton({
   Name = "Ativar Voo (Universal)",
   Callback = function()
      loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
   end,
})

-- Noclip toggle
local NoclipActive = false
UniversalSection:CreateToggle({
   Name = "Ativar Noclip",
   CurrentValue = false,
   Callback = function(Value)
      NoclipActive = Value
      coroutine.wrap(function()
         while NoclipActive do
               task.wait(0.1)
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

-- Lista de hubs para Blox Fruits
local BFHubs = {
   {Name = "Hoho Hub", URL = "https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"},
   {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
   {Name = "banana hub", URL = "https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/refs/heads/main/BananaCatHub.lua"},
   {Name = "Tsou hub", URL = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"},
   {Name = "Solix hub", URL = "https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"},
   {Name = "Alchemy Hub", URL = "https://scripts.alchemyhub.xyz"}
}

for _, hub in ipairs(BFHubs) do
   BFSection1:CreateButton({
      Name = hub.Name,
      Callback = function()
         loadstring(game:HttpGet(hub.URL))()
      end,
   })
end

--[[
======================================
          ABA GROW A GARDEN
======================================
--]]
local GrowGardenTab = Window:CreateTab("Grow a Garden", 10983741056)
local GGSection = GrowGardenTab:CreateSection("Farms")

-- Lista de hubs para Grow a Garden
local GGHubs = {
   {Name = "No-lag hub", URL = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"},
   {
      Name = "Solix Hub", 
      URL = "https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua",
      Config = {
         AutoFarm = true,
         PerformanceMode = "Fast",
         TeleportCooldown = 0.1,
         AutoRebuy = true,
         SeedPrice = 4000,
         AutoSellThreshold = 50,
         AutoWatering = true,
         AutoSprinklers = true,
         GearShopAutoBuy = true,
         GearShopItems = {"Basic Watering Can", "Basic Sprinkler", "Basic Shovel"},
         RenderDistance = 50,
         UIUpdateInterval = 2,
         OptimizeRendering = true
      }
   },
   {Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
   {Name = "Lunor hub", URL = "https://lunor.dev/loader"}
}

for _, hub in ipairs(GGHubs) do
   GGSection:CreateButton({
      Name = hub.Name,
      Callback = function()
         if hub.Config then
            for k,v in pairs(hub.Config) do
               _G[k] = v
            end
         end
         loadstring(game:HttpGet(hub.URL))()
      end,
   })
end

--[[
======================================
          ABA BLUE LOCK RIVALS
======================================
--]]
local BlueLockTab = Window:CreateTab("Blue Lock Rivals", 12345678901)
local BLRSection1 = BlueLockTab:CreateSection("Auto Farm & hacks")

-- Lista de hubs para Blue Lock
local BLHubs = {
   {Name = "Alchemy Hub", URL = "https://scripts.alchemyhub.xyz"},
   {Name = "Souls Hub", URL = "https://pastebin.com/raw/SPQT6v5J"},
   {Name = "Shiro X hub", URL = "https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/refs/heads/main/Protected_3467848847610666.txt"},
   {Name = "Controls Guis", URL = "https://pastebin.com/raw/WWa5yYf8"}
}

for _, hub in ipairs(BLHubs) do
   BLRSection1:CreateButton({
      Name = hub.Name,
      Callback = function()
         loadstring(game:HttpGet(hub.URL))()
      end,
   })
end

-- Speed Hack
BLRSection1:CreateSlider({
   Name = "Velocidade do Jogador",
   Range = {16, 100},
   Increment = 1,
   Suffix = "estudos/s",
   CurrentValue = 16,
   Callback = function(Value)
      if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

--[[
======================================
          ABA ARSENAL
======================================
--]]
local ArsenalTab = Window:CreateTab("Arsenal", 6949946023)
local ArsenalSection = ArsenalTab:CreateSection("Hacks")

-- Lista de hubs para Arsenal
local ArsenalHubs = {
   {Name = "Soluna Hub", URL = "https://soluna-script.vercel.app/arsenal.lua"},
   {Name = "Aether hub", URL = "https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/refs/heads/main/Arsenal"},
   {Name = "Nodoll hub", URL = "https://raw.githubusercontent.com/NoDollManB/roblox_scripts/refs/heads/main/arsenal.lua"},
   {Name = "Ronix Hub", URL = "https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"},
   {Name = "Tbao hub", URL = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"}
}

for _, hub in ipairs(ArsenalHubs) do
   ArsenalSection:CreateButton({
      Name = hub.Name,
      Callback = function()
         loadstring(game:HttpGet(hub.URL))()
      end,
   })
end

--[[
======================================
       ABA MUSCLES LEGENDS
======================================
--]]
local MusclesTab = Window:CreateTab("Muscles Legends", 12779704821)
local MLSection = MusclesTab:CreateSection("Automação")

-- Lista de hubs para Muscles Legends
local MLHubs = {
   {Name = "Speed hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
   {Name = "ML V1 hub", URL = "https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"},
   {Name = "Nox hub", URL = "https://pastebin.com/raw/2Cuza2mr"},
   {Name = "KTM hub", URL = "https://raw.githubusercontent.com/zapstreams123/KTMHUB/refs/heads/main/PublicVersion"},
   {Name = "CriShoux Hub", URL = "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"}
}

for _, hub in ipairs(MLHubs) do
   MLSection:CreateButton({
      Name = hub.Name,
      Callback = function()
         loadstring(game:HttpGet(hub.URL))()
      end,
   })
end

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

-- Notificação de inicialização
Rayfield:Notify({
   Title = "Robloki Hub Premium",
   Content = "Hub carregado com sucesso!",
   Duration = 5,
   Image = 7733960981,
   Actions = {
      Ignore = {
         Name = "Ok",
         Callback = function()
            print("Notificação fechada")
         end
      },
   },
})

-- Inicializar a UI
Rayfield:LoadConfiguration()
