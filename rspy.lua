-- ========== EMBEDDED RAYFIELD UI ==========
local Rayfield = {
    CreateWindow = function(config)
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = game.CoreGui
        ScreenGui.Name = "RSPY_Premium_UI"
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
        MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        MainFrame.BackgroundTransparency = 0.1
        MainFrame.Parent = ScreenGui
        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0.04, 0)
        
        -- Draggable UI
        local UserInputService = game:GetService("UserInputService")
        local dragging, dragInput, dragStart, startPos
        
        local TitleBar = Instance.new("Frame")
        TitleBar.Size = UDim2.new(1, 0, 0.07, 0)
        TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        TitleBar.Parent = MainFrame
        
        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
            end
        end)
        
        TitleBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        -- Create tab system
        local function createTab(name)
            local tab = Instance.new("Frame")
            tab.Size = UDim2.new(1, 0, 0.93, 0)
            tab.Position = UDim2.new(0, 0, 0.07, 0)
            tab.BackgroundTransparency = 1
            tab.Visible = false
            tab.Parent = MainFrame
            
            return {
                Frame = tab,
                Name = name
            }
        end
        
        local tabs = {
            Player = createTab("Player"),
            Visuals = createTab("Visuals"),
            Combat = createTab("Combat")
        }
        
        tabs.Player.Frame.Visible = true
        
        -- Create tab buttons
        local tabButtons = {}
        for i, name in ipairs({"Player", "Visuals", "Combat"}) do
            local btn = Instance.new("TextButton")
            btn.Text = name
            btn.Size = UDim2.new(0.3, 0, 0.07, 0)
            btn.Position = UDim2.new(0.3 * (i-1), 0, 0, 0)
            btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(50, 50, 70)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.GothamMedium
            btn.TextSize = 14
            btn.Parent = MainFrame
            
            btn.MouseButton1Click:Connect(function()
                for _, tab in pairs(tabs) do
                    tab.Frame.Visible = false
                end
                tabs[name].Frame.Visible = true
                for _, button in ipairs(tabButtons) do
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                end
                btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            end)
            
            table.insert(tabButtons, btn)
        end
        
        return {
            CreateTab = function(name)
                return {
                    CreateSection = function(sectionName)
                        local section = Instance.new("Frame")
                        section.Size = UDim2.new(1, 0, 0, 40)
                        section.BackgroundTransparency = 1
                        section.Parent = tabs[name].Frame
                        
                        local label = Instance.new("TextLabel")
                        label.Text = sectionName
                        label.Font = Enum.Font.GothamBold
                        label.TextSize = 16
                        label.TextColor3 = Color3.new(0.8, 0.8, 1)
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.TextXAlignment = Enum.TextXAlignment.Left
                        label.Parent = section
                        
                        return {
                            CreateToggle = function(options)
                                local toggle = Instance.new("TextButton")
                                toggle.Text = options.Name
                                toggle.Size = UDim2.new(0.9, 0, 0.7, 0)
                                toggle.Position = UDim2.new(0.05, 0, 0.15, 0)
                                toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                                toggle.TextColor3 = options.CurrentValue and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
                                toggle.Font = Enum.Font.GothamMedium
                                toggle.Text = options.CurrentValue and "ON" or "OFF"
                                toggle.Parent = section
                                Instance.new("UICorner", toggle).CornerRadius = UDim.new(0.4, 0)
                                
                                toggle.MouseButton1Click:Connect(function()
                                    options.CurrentValue = not options.CurrentValue
                                    toggle.Text = options.CurrentValue and "ON" or "OFF"
                                    toggle.TextColor3 = options.CurrentValue and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
                                    if options.Callback then options.Callback(options.CurrentValue) end
                                end)
                            end
                        }
                    end
                }
            end
        }
    end
}

-- ========== PREMIUM FEATURES ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Create UI
local Window = Rayfield.CreateWindow({
    Name = "RSPY ULTIMATE PREMIUM",
    LoadingTitle = "Mobile Optimized",
    LoadingSubtitle = "All Features Fixed"
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player")
local MovementSection = PlayerTab:CreateSection("Movement")

MovementSection:CreateToggle({
    Name = "Flight Mode",
    CurrentValue = false,
    Callback = function(Value)
        _G.FlyEnabled = Value
    end
})

MovementSection:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

-- Visuals Tab
local VisualsTab = Window:CreateTab("Visuals")
local ESPSection = VisualsTab:CreateSection("ESP")

ESPSection:CreateToggle({
    Name = "ESP Master",
    CurrentValue = false,
    Callback = function(Value)
        _G.ESPMaster = Value
        updateESP()
    end
})

ESPSection:CreateToggle({
    Name = "Show Names",
    CurrentValue = true,
    Callback = function(Value)
        _G.NameESP = Value
        updateESP()
    end
})

-- Combat Tab
local CombatTab = Window:CreateTab("Combat")
local FlingSection = CombatTab:CreateSection("Fling")

FlingSection:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Callback = function(Value)
        _G.AntiFling = Value
    end
})

FlingSection:CreateToggle({
    Name = "Fling Players",
    CurrentValue = false,
    Callback = function(Value)
        _G.FlingPlayers = Value
    end
})

-- ========== FEATURE IMPLEMENTATIONS ==========
-- Fixed Flight System
local flyConnection
function enableFlight()
    if flyConnection then flyConnection:Disconnect() end
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not _G.FlyEnabled then return end
        local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local velocity = Vector3.new(0, 0, 0)
        local camera = workspace.CurrentCamera
        local cf = camera.CFrame
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then velocity = velocity + cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then velocity = velocity - cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then velocity = velocity + cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then velocity = velocity - cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then velocity = velocity + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then velocity = velocity - Vector3.new(0, 1, 0) end
        
        root.Velocity = velocity * 100
    end)
end

enableFlight()

-- Fixed ESP System
local espCache = {}
function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if _G.ESPMaster and not espCache[player] then
                local espFrame = Instance.new("Folder")
                espFrame.Name = "RSPY_ESP"
                espFrame.Parent = player.Character
                
                -- Name Label
                if _G.NameESP then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0, 100, 0, 30)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Adornee = player.Character:WaitForChild("Head")
                    billboard.Parent = espFrame
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Text = player.DisplayName or player.Name
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextSize = 14
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = billboard
                end
                
                espCache[player] = espFrame
            elseif not _G.ESPMaster and espCache[player] then
                espCache[player]:Destroy()
                espCache[player] = nil
            end
        end
    end
end

-- Fling System
function flingPlayers()
    if not _G.FlingPlayers then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(
                    math.random(-50000, 50000),
                    math.random(50000, 100000),
                    math.random(-50000, 50000)
                )
            end
        end
    end
end

-- Core Loop
RunService.Heartbeat:Connect(function()
    -- Movement systems
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then            
            -- Infinite Jump
            if _G.InfiniteJump and UIS:IsKeyDown(Enum.KeyCode.Space) then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            
            -- Anti-Fling
            if _G.AntiFling then
                local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Velocity = Vector3.new(0, 0, 0)
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
    
    -- Fling players
    flingPlayers()
end)

-- Initial ESP update
updateESP()
Players.PlayerAdded:Connect(updateESP)
Players.PlayerRemoving:Connect(updateESP)

-- Notification
local notify = Instance.new("ScreenGui")
notify.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.1, 0)
frame.Position = UDim2.new(0.3, 0, 0.05, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
frame.Parent = notify
Instance.new("UICorner", frame).CornerRadius = UDim.new(0.1, 0)

local label = Instance.new("TextLabel")
label.Text = "RSPY ULTIMATE LOADED!"
label.Size = UDim2.new(1, 0, 1, 0)
label.TextColor3 = Color3.new(0, 1, 1)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 20
label.Parent = frame

wait(3)
notify:Destroy()
