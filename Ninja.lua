-- Ninja Hub GUI com Auto Farm, Auto Buy, Fly, TP e mais
local Fluxus = loadstring(game:HttpGet("https://raw.githubusercontent.com/FluxlineCommunity/Fluxlib/main/source.lua"))()
local gui = Fluxus:CreateWindow("Ninja Hubs", Color3.fromRGB(255, 255, 255), Color3.fromRGB(50, 50, 50), true)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- Tabs
local autoFarmTab = gui:CreateTab("Auto Farm")
local miscTab = gui:CreateTab("Misc")

-- Variáveis
local farmAtivo = false
local flyAtivo = false
local tpAtivo = false
local tpConnection
local farmLoop, autoSellLoop, buySwordLoop, buyBeltLoop

-- Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Funções
local function getIslandName()
    local stat1 = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("UnlockedIslands")
    local stat2 = player:FindFirstChild("IslandUnlocked")
    return (stat1 and stat1.Value) or (stat2 and stat2.Value) or "Ground"
end

-- Auto Farm
autoFarmTab:AddToggle("Auto Farm", false, function(state)
    farmAtivo = state
    if farmAtivo then
        autoSellLoop = task.spawn(function()
            while farmAtivo and task.wait(0.5) do
                local gui = player:WaitForChild("PlayerGui"):FindFirstChild("GameGui")
                local bar = gui and gui:FindFirstChild("FullBar")
                if bar and bar.Visible then
                    local sell = workspace:FindFirstChild("sellAreaCirclePart") or workspace:FindFirstChild("SellAreaPart")
                    if sell then
                        root.CFrame = sell.CFrame + Vector3.new(0, 5, 0)
                        task.wait(0.5)
                    end
                end
            end
        end)

        farmLoop = task.spawn(function()
            while farmAtivo and task.wait() do
                local tool = player.Backpack:FindFirstChildOfClass("Tool")
                if tool then tool.Parent = char end
                local remote = tool and (tool:FindFirstChild("RemoteEvent") or tool:FindFirstChildWhichIsA("RemoteEvent"))
                if remote then pcall(function() remote:FireServer() end) end
            end
        end)
    else
        if farmLoop then task.cancel(farmLoop) end
        if autoSellLoop then task.cancel(autoSellLoop) end
    end
end)

autoFarmTab:AddToggle("Auto Comprar Espada", false, function(state)
    if state then
        buySwordLoop = task.spawn(function()
            while task.wait(1) do
                local islandName = getIslandName()
                local event = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):FindFirstChild("buyAllSwordsEvent")
                if event then pcall(function() event:FireServer(islandName) end) end
            end
        end)
    else
        if buySwordLoop then task.cancel(buySwordLoop) end
    end
end)

autoFarmTab:AddToggle("Auto Comprar Faixa", false, function(state)
    if state then
        buyBeltLoop = task.spawn(function()
            while task.wait(1) do
                local islandName = getIslandName()
                local event = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):FindFirstChild("buyAllBeltsEvent")
                if event then pcall(function() event:FireServer(islandName) end) end
            end
        end)
    else
        if buyBeltLoop then task.cancel(buyBeltLoop) end
    end
end)

-- Misc
miscTab:AddSlider("Speed", 16, 500, 16, function(val)
    char:WaitForChild("Humanoid").WalkSpeed = val
end)

miscTab:AddSlider("Jump", 50, 500, 50, function(val)
    char:WaitForChild("Humanoid").JumpPower = val
end)

miscTab:AddToggle("Fly", false, function(state)
    flyAtivo = state
    local bodyGyro, bodyVel

    if flyAtivo then
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = root.CFrame

        bodyVel = Instance.new("BodyVelocity", root)
        bodyVel.velocity = Vector3.zero
        bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)

        local flyConn = game:GetService("RunService").Heartbeat:Connect(function()
            bodyGyro.cframe = workspace.CurrentCamera.CFrame
            bodyVel.velocity = workspace.CurrentCamera.CFrame.LookVector * 100
        end)

        miscTab:AddButton("Desativar Fly", function()
            flyConn:Disconnect()
            bodyGyro:Destroy()
            bodyVel:Destroy()
            flyAtivo = false
        end)
    end
end)

miscTab:AddToggle("Teleportar com T", false, function(state)
    tpAtivo = state
    if tpConnection then tpConnection:Disconnect() end
    if tpAtivo then
        tpConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T) then
                local pos = workspace.CurrentCamera:ScreenPointToRay(game:GetService("UserInputService"):GetMouseLocation().X, game:GetService("UserInputService"):GetMouseLocation().Y)
                local ray = Ray.new(pos.Origin, pos.Direction * 500)
                local part, hit = workspace:FindPartOnRay(ray, char, false, true)
                if hit then
                    root.CFrame = CFrame.new(hit + Vector3.new(0, 5, 0))
                end
            end
        end)
    end
end)

miscTab:AddButton("Fechar GUI", function()
    gui:Destroy()
end)
