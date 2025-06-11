-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carregar Orion Lib
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Criar a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Robloki Hub Premium",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "RoblokiConfigs",
    IntroEnabled = true,
    IntroText = "Robloki Hub Premium"
})

-- Função de Noclip
local NoclipToggle = false
local function NoclipLoop()
    while NoclipToggle do
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
======================================
          ABA UNIVERSAL
======================================
--]]
local UniversalTab = Window:MakeTab({
    Name = "Universal",
    Icon = "rbxassetid://7733960981",
    PremiumOnly = false
})

UniversalTab:AddSection("Scripts para Todos os Jogos")

UniversalTab:AddButton({
    Name = "Ativar Voo (Universal)",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
    end
})

UniversalTab:AddToggle({
    Name = "Ativar Noclip",
    Default = false,
    Callback = function(Value)
        NoclipToggle = Value
        if Value then
            coroutine.wrap(NoclipLoop)()
        end
    end
})

UniversalTab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

UniversalTab:AddSlider({
    Name = "Velocidade de Caminhada",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    Callback = function(Value)
        pcall(function()
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

UniversalTab:AddSlider({
    Name = "Força de Pulo",
    Min = 50,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    Callback = function(Value)
        pcall(function()
            Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end)
    end
})

--[[
======================================
          ABA BLOX FRUITS
======================================
--]]
local BloxFruitsTab = Window:MakeTab({
    Name = "Blox Fruits",
    Icon = "rbxassetid://12584504442",
    PremiumOnly = false
})

BloxFruitsTab:AddSection("Hubs Completos")

BloxFruitsTab:AddButton({
    Name = "Hoho Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/main/Hoho.lua"))()
    end
})

BloxFruitsTab:AddButton({
    Name = "Speed Hub X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

BloxFruitsTab:AddButton({
    Name = "Banana Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/BananaCatHub/main/BananaCatHub.lua"))()
    end
})

BloxFruitsTab:AddButton({
    Name = "Tsou Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
    end
})

BloxFruitsTab:AddButton({
    Name = "Solix Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/main/solix%20new%20keyui.lua"))()
    end
})

--[[
======================================
          ABA GROW A GARDEN
======================================
--]]
local GrowGardenTab = Window:MakeTab({
    Name = "Grow a Garden",
    Icon = "rbxassetid://10983741056",
    PremiumOnly = false
})

GrowGardenTab:AddSection("Farms")

GrowGardenTab:AddButton({
    Name = "No-lag Hub",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua"))()
    end
})

GrowGardenTab:AddButton({
    Name = "Solix Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/main/solix%20v2%20new%20loader.lua"))()
    end
})

GrowGardenTab:AddButton({
    Name = "Lunor Hub",
    Callback = function()
        loadstring(game:HttpGet("https://lunor.dev/loader"))()
    end
})

--[[
======================================
          ABA BLUE LOCK RIVALS
======================================
--]]
local BlueLockTab = Window:MakeTab({
    Name = "Blue Lock Rivals",
    Icon = "rbxassetid://12345678901",
    PremiumOnly = false
})

BlueLockTab:AddSection("Auto Farm & Hacks")

BlueLockTab:AddButton({
    Name = "Alchemy Hub",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})

BlueLockTab:AddButton({
    Name = "Shiro X Hub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkFusionSSS/SHIRO-X-BLUE-LOCK-SIGMA/main/Protected_3467848847610666.txt'))()
    end
})

--[[
======================================
          ABA ARSENAL
======================================
--]]
local ArsenalTab = Window:MakeTab({
    Name = "Arsenal",
    Icon = "rbxassetid://6949946023",
    PremiumOnly = false
})

ArsenalTab:AddSection("Hacks")

ArsenalTab:AddButton({
    Name = "Soluna Hub",
    Callback = function()
        loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua", true))()
    end
})

ArsenalTab:AddButton({
    Name = "Aether Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vzyxer/Aether-Hub-Global-Roblox-Script-Hub/main/Arsenal"))()
    end
})

--[[
======================================
          ABA MUSCLES LEGENDS
======================================
--]]
local MusclesTab = Window:MakeTab({
    Name = "Muscles Legends",
    Icon = "rbxassetid://12779704821",
    PremiumOnly = false
})

MusclesTab:AddSection("Automação")

MusclesTab:AddButton({
    Name = "Speed Hub X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

MusclesTab:AddButton({
    Name = "CriShoux Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
    end
})

--[[
======================================
          ABA CONFIGURAÇÕES
======================================
--]]
local SettingsTab = Window:MakeTab({
    Name = "Configurações",
    Icon = "rbxassetid://6023426915",
    PremiumOnly = false
})

SettingsTab:AddSection("Personalização")

SettingsTab:AddButton({
    Name = "Fechar Hub",
    Callback = function()
        OrionLib:Destroy()
    end
})

SettingsTab:AddButton({
    Name = "Salvar Configurações",
    Callback = function()
        OrionLib:SaveConfig()
    end
})

SettingsTab:AddButton({
    Name = "Restaurar Padrões",
    Callback = function()
        OrionLib:ResetConfig()
    end
})

-- Inicializar a UI
OrionLib:Init()
