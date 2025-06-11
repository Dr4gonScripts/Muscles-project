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
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
   end,
})

-- Noclip toggle
local noclipEnabled = false
UniversalSection:CreateToggle({
   Name = "Ativar Noclip",
   CurrentValue = false,
   Callback = function(Value)
      noclipEnabled = Value
      if noclipEnabled then
         coroutine.wrap(function()
            while noclipEnabled and Players.LocalPlayer.Character do
               for _, part in ipairs(Players.LocalPlayer.Character:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
               game:GetService("RunService").Heartbeat:Wait()
            end
         end)()
      end
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

-- Speed Hub X
BFSection1:CreateButton({
   Name = "Speed Hub X",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
   end,
})

-- Banana Hub
BFSection1:CreateButton({
   Name = "Banana Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua"))()
   end,
})

-- Tsou Hub
BFSection1:CreateButton({
   Name = "Tsou Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
   end,
})

-- Solix Hub
BFSection1:CreateButton({
   Name = "Solix Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/main/solix%20new%20keyui.lua"))() 
   end,
})

-- Alchemy Hub
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

-- No-lag Hub
GGSection:CreateButton({
   Name = "No-lag Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"))()
   end,
})

-- Solix Hub
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
      loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua"))()
   end,
})

-- Speed Hub X
GGSection:CreateButton({
   Name = "Speed Hub X",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
   end,
})

-- Lunor Hub
GGSection:CreateButton({
   Name = "Lunor Hub",
   Callback = function()
      loadstring(game:HttpGet("https://lunor.dev/loader"))()
   end,
})

--[[
======================================
          ABA BLUE LOCK RIVALS
======================================
--]]
local BlueLockTab = Window:CreateTab("Blue Lock Rivals", 12345678901)
local BLRSection1 = BlueLockTab:CreateSection("Auto Farm & Hacks")

-- Alchemy Hub
BLRSection1:CreateButton({
   Name = "Alchemy Hub",
   Callback = function()
      loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
   end,
})

-- Souls Hub
BLRSection1:CreateButton({
   Name = "Souls Hub",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/SPQT6v5J"))()
   end,
})

-- Shiro X Hub
BLRSection1:CreateButton({
   Name = "Shiro X Hub",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt'))()
   end,
})

-- Controls Gui
BLRSection1:CreateButton({
   Name = "Controls Gui",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/WWa5yYf8"))()
   end,
})

-- Speed Hack
local walkSpeed = 16
BLRSection1:CreateSlider({
   Name = "Velocidade do Jogador",
   Range = {16, 100},
   Increment = 1,
   Suffix = "estudos/s",
   CurrentValue = 16,
   Callback = function(Value)
      walkSpeed = Value
      if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- Conectar para atualizar velocidade quando o personagem mudar
Players.LocalPlayer.CharacterAdded:Connect(function(character)
   character:WaitForChild("Humanoid")
   character.Humanoid.WalkSpeed = walkSpeed
end)

--[[
======================================
          ABA ARSENAL
======================================
--]]
local ArsenalTab = Window:CreateTab("Arsenal", 6949946023)
local ArsenalSection = ArsenalTab:CreateSection("Hacks")

-- Soluna Hub
ArsenalSection:CreateButton({
   Name = "Soluna Hub",
   Callback = function()
      loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua",true))()
   end,
})

-- Aether Hub
ArsenalSection:CreateButton({
   Name = "Aether Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal"))()
   end,
})

-- Nodoll Hub
ArsenalSection:CreateButton({
   Name = "Nodoll Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/NoDollManB/roblox_scripts/main/arsenal.lua"))()
   end,
})

-- Ronix Hub
ArsenalSection:CreateButton({
   Name = "Ronix Hub",
   Callback = function()
      loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/93f86be991de0ff7d79e6328e4ceea40.lua"))() 
   end,
})

-- Tbao Hub
ArsenalSection:CreateButton({
   Name = "Tbao Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))()
   end,
})

--[[
======================================
       ABA MUSCLES LEGENDS
======================================
--]]
local MusclesTab = Window:CreateTab("Muscles Legends", 12779704821)
local MLSection = MusclesTab:CreateSection("Automação")

-- Speed Hub X
MLSection:CreateButton({
   Name = "Speed Hub X",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
   end,
})

-- ML V1 Hub
MLSection:CreateButton({
   Name = "ML V1 Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/2581235867/21/main/By%20Tokattk"))()
   end,
})

-- Nox Hub
MLSection:CreateButton({
   Name = "Nox Hub",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/2Cuza2mr"))()
   end,
})

-- KTM Hub
MLSection:CreateButton({
   Name = "KTM Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/zapstreams123/KTMHUB/main/PublicVersion"))()
   end,
})

-- CriShoux Hub
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

-- Notificação de inicialização
Rayfield:Notify({
   Title = "Robloki Hub Premium",
   Content = "Hub carregado com sucesso!",
   Duration = 5,
   Image = 7733960981,
})

-- Inicializar a UI
Rayfield:LoadConfiguration()
