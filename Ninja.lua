-- // FluxLib Loader
local flux = loadstring(game:HttpGet("https://raw.githubusercontent.com/FluxHubz/fluxLib/main/fluxLib.txt"))()

-- // Janela principal
local win = flux:Window("⛩️ Ninja Hubs", " ", Color3.fromRGB(220, 220, 220), Enum.KeyCode.RightControl)

-- // Abas
local autoFarmTab = win:Tab("Auto Farm", "http://www.roblox.com/asset/?id=6023426915")
local miscTab = win:Tab("Misc", "http://www.roblox.com/asset/?id=6023426915")

-- // Referências
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Mouse = player:GetMouse()
local VU = game:GetService("VirtualUser")

-- // Auto Farm
local farmAtivo = false
local farmLoop

-- Auto Sell Handler
local autoSellLoop
local function iniciarAutoSell()
    if autoSellLoop then return end
    autoSellLoop = task.spawn(function()
        while farmAtivo and task.wait(0.5) do
            local statsGui = player:WaitForChild("PlayerGui"):FindFirstChild("GameGui")
            if statsGui then
                local bar = statsGui:FindFirstChild("FullBar")
                if bar and bar.Visible then
                    local sellPad = workspace:FindFirstChild("sellAreaCirclePart") or workspace:FindFirstChild("SellAreaPart") or workspace:FindFirstChildWhichIsA("Part", true)
                    if sellPad then
                        root.CFrame = sellPad.CFrame + Vector3.new(0, 5, 0)
                        task.wait(0.5)
                    end
                end
            end
        end
    end)
end

autoFarmTab:Toggle("Auto Farm", "Ativa o farm com espada equipada", false, function(state)
    farmAtivo = state
    if farmAtivo then
        iniciarAutoSell()
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
        if autoSellLoop then task.cancel(autoSellLoop) autoSellLoop = nil end
    end
end)

-- // Speed & Jump
miscTab:Slider("Velocidade", "Ajusta a velocidade do jogador", 16, 500, humanoid.WalkSpeed, function(val)
    humanoid.WalkSpeed = val
end)

miscTab:Slider("Pulo", "Ajusta a altura do pulo", 50, 500, humanoid.JumpPower, function(val)
    humanoid.JumpPower = val
end)

-- // Fly
local flying = false
local flyConn
local bodyGyro, bodyVel
local direction = Vector3.zero

miscTab:Toggle("Modo Fly", "Ativa/desativa o voo com WASD", false, function(state)
    flying = state
    if flying then
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = root.CFrame

        bodyVel = Instance.new("BodyVelocity", root)
        bodyVel.Velocity = Vector3.zero
        bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        flyConn = RS.RenderStepped:Connect(function()
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            bodyVel.Velocity = workspace.CurrentCamera.CFrame:VectorToWorldSpace(direction) * 100
        end)

        UIS.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.W then direction = Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then direction = Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then direction = Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then direction = Vector3.new(1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.Space then direction = Vector3.new(0, 1, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftControl then direction = Vector3.new(0, -1, 0)
            end
        end)

        UIS.InputEnded:Connect(function(_, gpe)
            if not gpe then direction = Vector3.zero end
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVel then bodyVel:Destroy() end
    end
end)

-- // TP com mouse (T + Clique)
local tpClickActive = false

miscTab:Toggle("TP com Mouse (Segure T)", "Clique onde quer teleportar", false, function(state)
    tpClickActive = state
end)

UIS.InputBegan:Connect(function(input, gpe)
    if not tpClickActive or gpe then return end
    if input.KeyCode == Enum.KeyCode.T then
        local conn
        conn = Mouse.Button1Down:Connect(function()
            local pos = Mouse.Hit.Position
            if root then
                root.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            end
            conn:Disconnect()
        end)
    end
end)

-- // Botão para deletar o script
miscTab:Button("❌ Fechar Script", "Remove a interface e para tudo", function()
    pcall(function()
        if farmLoop then task.cancel(farmLoop) end
        if autoSellLoop then task.cancel(autoSellLoop) end
        if flyConn then flyConn:Disconnect() end
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVel then bodyVel:Destroy() end
        if win and win.Destroy then win:Destroy() end
    end)
end)

-- // Anti-AFK SEM DESATIVAR
player.Idled:Connect(function()
    VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
