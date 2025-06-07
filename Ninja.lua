-- Ninja Legends Hub - Pura Interface Visual
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Configuração base
local player = Players.LocalPlayer
local interface = Instance.new("ScreenGui")
interface.Name = "NinjaHub"
interface.ResetOnSpawn = false
interface.Parent = player:WaitForChild("PlayerGui")

-------------------------------------------
-- ESTRUTURA PRINCIPAL
-------------------------------------------
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Parent = interface

-- Efeito de borda
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(100, 200, 255)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-------------------------------------------
-- CABEÇALHO COM SUA IMAGEM
-------------------------------------------
local header = Instance.new("ImageLabel")
header.Name = "Header"
header.Size = UDim2.new(1, -20, 0, 100)
header.Position = UDim2.new(0, 10, 0, 10)
header.Image = "rbxassetid://18452874720" -- SUA IMAGEM AQUI
header.ScaleType = Enum.ScaleType.Crop
header.BackgroundTransparency = 1
header.Parent = mainFrame

-- Efeito de brilho
local glow = Instance.new("ImageLabel")
glow.Image = "rbxassetid://10424139824" -- Efeito de brilho
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.BackgroundTransparency = 1
glow.ImageTransparency = 0.7
glow.Parent = header

-------------------------------------------
-- BARRA DE ABA
-------------------------------------------
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 40)
tabBar.Position = UDim2.new(0, 10, 0, 120)
tabBar.BackgroundTransparency = 1
tabBar.Parent = mainFrame

-- Botões de aba
local tabs = {"Farm", "Auto", "Misc", "Credits"}
for i, tabName in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Text = tabName
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 14
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.Size = UDim2.new(1/#tabs, -5, 1, 0)
    tabBtn.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    tabBtn.AutoButtonColor = false
    
    -- Efeito hover
    tabBtn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(tabBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        }):Play()
    end)
    
    tabBtn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(tabBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        }):Play()
    end)
    
    tabBtn.Parent = tabBar
end

-------------------------------------------
-- ÁREA DE CONTEÚDO
-------------------------------------------
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -180)
contentFrame.Position = UDim2.new(0, 10, 0, 170)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Exemplo de conteúdo (Farm)
local farmSection = Instance.new("Frame")
farmSection.Size = UDim2.new(1, 0, 1, 0)
farmSection.BackgroundTransparency = 1
farmSection.Visible = true -- Mostrar apenas esta seção inicialmente
farmSection.Parent = contentFrame

-- Toggle de exemplo
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, 0, 0, 40)
toggleFrame.BackgroundTransparency = 1
toggleFrame.Parent = farmSection

local toggleBtn = Instance.new("TextButton")
toggleBtn.Text = "Auto Farm"
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 0, 0, 5)
toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 30, 30)
toggleBtn.Parent = toggleFrame

local toggleStatus = Instance.new("TextLabel")
toggleStatus.Text = "OFF"
toggleStatus.Size = UDim2.new(0, 50, 0, 30)
toggleStatus.Position = UDim2.new(0, 130, 0, 5)
toggleStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
toggleStatus.BackgroundTransparency = 1
toggleStatus.Parent = toggleFrame

-------------------------------------------
-- BOTÃO DE FECHAR
-------------------------------------------
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    interface:Destroy()
end)

-- Efeito de fechar
closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
end)
