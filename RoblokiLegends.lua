-- Carrega a biblioteca FluxLib
local Flux = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robloxian-Studio/FluxLib/main/source.lua'))()

-- Configurações básicas
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Cria a janela principal simplificada
local Window = Flux:Window({
    Title = "Robloki Legends",
    Size = UDim2.new(0, 450, 0, 400),
    Theme = "Dark"
})

-- Função segura para evitar erros
local function SafeRemote(remoteName, ...)
    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
    if not remotes then return end
    
    local remote = remotes:FindFirstChild(remoteName)
    if not remote then return end
    
    if remote:IsA("RemoteEvent") then
        remote:FireServer(...)
    elseif remote:IsA("RemoteFunction") then
        remote:InvokeServer(...)
    end
end

-------------------------
-- ABA: PLAYER
-------------------------
local PlayerTab = Window:Tab("Jogador", "rbxassetid://7734065396")

PlayerTab:Slider("Velocidade", 16, 200, 16, function(value)
    pcall(function()
        Humanoid.WalkSpeed = value
    end)
end)

PlayerTab:Slider("Tamanho", 0.5, 5, 1, function(value)
    pcall(function()
        Humanoid.BodyHeightScale.Value = value
        Humanoid.BodyWidthScale.Value = value
    end)
end)

-- Anti-AFK simplificado
local antiAFK = false
PlayerTab:Toggle("Anti-AFK", false, function(state)
    antiAFK = state
    if state then
        coroutine.wrap(function()
            while antiAFK do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                wait(1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                wait(1)
            end
        end)()
    end
end)

-------------------------
-- ABA: AUTO FARM (SIMPLIFICADO)
-------------------------
local AutoFarmTab = Window:Tab("Auto Farm", "rbxassetid://7734053491")

local farming = false
AutoFarmTab:Toggle("Farm Básico", false, function(state)
    farming = state
    if state then
        coroutine.wrap(function()
            while farming do
                pcall(function()
                    SafeRemote("Training")
                end)
                wait()
            end
        end)()
    end
end)

-------------------------
-- ABA: OVOS (ÚNICA FUNCIONALIDADE)
-------------------------
local EggsTab = Window:Tab("Ovos", "rbxassetid://9432217880")

local openingEggs = false
EggsTab:Toggle("Auto Abrir Ovos", false, function(state)
    openingEggs = state
    if state then
        coroutine.wrap(function()
            while openingEggs do
                pcall(function()
                    SafeRemote("EggOpening", "Basic Egg", 1)
                end)
                wait(0.5)
            end
        end)()
    end
end)

-- Notificação inicial simplificada
Flux:Notification({
    Title = "Robloki Legends",
    Text = "Script carregado!",
    Duration = 3
})

-- Atualiza o personagem quando morrer (proteção contra erros)
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
end)
