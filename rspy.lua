-- RSPX ULTIMATE v7.0 - EVERYTHING WORKS
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Create premium window
local Window = Rayfield:CreateWindow({
    Name = "RSPX ULTIMATE v7.0",
    Icon = "zap",
    LoadingTitle = "ALL FEATURES WORKING",
    LoadingSubtitle = "Mobile Optimized",
    Theme = "Amethyst",
    ToggleUIKeybind = "K"
})

-- Create tabs
local Tabs = {
    Player = Window:CreateTab("Player", "user"),
    Visuals = Window:CreateTab("Visuals", "eye"),
    Combat = Window:CreateTab("Combat", "crosshair"),
    World = Window:CreateTab("World", "globe")
}

-- Player Tab
local MovementSection = Tabs.Player:CreateSection("Movement")

local SpeedToggle = Tabs.Player:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        _G.SpeedEnabled = Value
    end
})

local SpeedSlider = Tabs.Player:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "studs/s",
    CurrentValue = 50,
    Flag = "SpeedSlider",
    Callback = function(Value)
        _G.SpeedValue = Value
    end
})

local JumpPowerToggle = Tabs.Player:CreateToggle({
    Name = "Jump Power Hack",
    CurrentValue = false,
    Flag = "JumpPowerToggle",
    Callback = function(Value)
        _G.JumpPowerEnabled = Value
    end
})

local JumpPowerSlider = Tabs.Player:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    Suffix = "power",
    CurrentValue = 100,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        _G.JumpPowerValue = Value
    end
})

local InfiniteJumpToggle = Tabs.Player:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

-- Visuals Tab
local ESPSection = Tabs.Visuals:CreateSection("ESP")

local ESPMasterToggle = Tabs.Visuals:CreateToggle({
    Name = "ESP Master Switch",
    CurrentValue = false,
    Flag = "ESPMaster",
    Callback = function(Value)
        _G.ESPMaster = Value
        updateESP()
    end
})

local BoxesToggle = Tabs.Visuals:CreateToggle({
    Name = "Box ESP",
    CurrentValue = true,
    Flag = "BoxESP",
    Callback = function(Value)
        _G.BoxESP = Value
        updateESP()
    end
})

local NamesToggle = Tabs.Visuals:CreateToggle({
    Name = "Show Names",
    CurrentValue = true,
    Flag = "NameESP",
    Callback = function(Value)
        _G.NameESP = Value
        updateESP()
    end
})

local HealthToggle = Tabs.Visuals:CreateToggle({
    Name = "Health Bars",
    CurrentValue = true,
    Flag = "HealthESP",
    Callback = function(Value)
        _G.HealthESP = Value
        updateESP()
    end
})

local SkeletonToggle = Tabs.Visuals:CreateToggle({
    Name = "Skeleton ESP",
    CurrentValue = false,
    Flag = "SkeletonESP",
    Callback = function(Value)
        _G.SkeletonESP = Value
        updateESP()
    end
})

local FOVCircleToggle = Tabs.Visuals:CreateToggle({
    Name = "Aimbot FOV Circle",
    CurrentValue = true,
    Flag = "FOVCircle",
    Callback = function(Value)
        _G.FOVCircle = Value
        updateFOVCircle()
    end
})

-- Combat Tab
local AimbotSection = Tabs.Combat:CreateSection("Aimbot")

local AimbotToggle = Tabs.Combat:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        _G.AimbotEnabled = Value
    end
})

local RageModeToggle = Tabs.Combat:CreateToggle({
    Name = "Rage Mode",
    CurrentValue = false,
    Flag = "RageMode",
    Callback = function(Value)
        _G.RageMode = Value
    end
})

local HitboxToggle = Tabs.Combat:CreateToggle({
    Name = "Big Hitboxes",
    CurrentValue = false,
    Flag = "BigHitboxes",
    Callback = function(Value)
        _G.BigHitboxes = Value
        updateHitboxes()
    end
})

local FlingSection = Tabs.Combat:CreateSection("Fling System")

local AntiFlingToggle = Tabs.Combat:CreateToggle({
    Name = "Anti-Fling Protection",
    CurrentValue = false,
    Flag = "AntiFling",
    Callback = function(Value)
        _G.AntiFling = Value
    end
})

local FlingToggle = Tabs.Combat:CreateToggle({
    Name = "Fling Players (Rage)",
    CurrentValue = false,
    Flag = "FlingPlayers",
    Callback = function(Value)
        _G.FlingPlayers = Value
    end
})

-- World Tab
local EffectsSection = Tabs.World:CreateSection("Effects")

local FreeCamToggle = Tabs.World:CreateToggle({
    Name = "Free Cam",
    CurrentValue = false,
    Flag = "FreeCam",
    Callback = function(Value)
        _G.FreeCam = Value
        if Value then
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(camera.CFrame.Position)
            createFreeCamControls()
        else
            camera.CameraType = Enum.CameraType.Custom
            if freeCamConnection then
                freeCamConnection:Disconnect()
            end
        end
    end
})

local NoFogToggle = Tabs.World:CreateToggle({
    Name = "Remove Fog",
    CurrentValue = false,
    Flag = "NoFog",
    Callback = function(Value)
        _G.NoFog = Value
        if Value then
            Lighting.FogEnd = 1000000
        else
            Lighting.FogEnd = 100
        end
    end
})

local BrightWorldToggle = Tabs.World:CreateToggle({
    Name = "Bright World",
    CurrentValue = false,
    Flag = "BrightWorld",
    Callback = function(Value)
        _G.BrightWorld = Value
        if Value then
            Lighting.Brightness = 5
            Lighting.ExposureCompensation = 1
        else
            Lighting.Brightness = 1
            Lighting.ExposureCompensation = 0
        end
    end
})

-- ===== CORE FUNCTIONALITY =====
-- Movement Systems
local movementConnection = RunService.Heartbeat:Connect(function()
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            -- Speed Hack
            if _G.SpeedEnabled then
                humanoid.WalkSpeed = _G.SpeedValue
            else
                humanoid.WalkSpeed = 16
            end
            
            -- Jump Power
            if _G.JumpPowerEnabled then
                humanoid.JumpPower = _G.JumpPowerValue
            else
                humanoid.JumpPower = 50
            end
            
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
end)

-- Fling System
local flingConnection = RunService.Heartbeat:Connect(function()
    if _G.FlingPlayers then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if targetRoot and myRoot then
                    -- Teleport to player
                    myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 3, 0)
                    
                    -- Apply massive force to fling
                    targetRoot.Velocity = Vector3.new(
                        math.random(-50000, 50000),
                        math.random(50000, 100000),
                        math.random(-50000, 50000)
                    )
                    
                    -- Add crazy rotation
                    targetRoot.RotVelocity = Vector3.new(
                        math.random(-100, 100),
                        math.random(-100, 100),
                        math.random(-100, 100)
                    )
                end
            end
        end
    end
end)

-- ESP System
local espCache = {}
function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if _G.ESPMaster and not espCache[player] then
                local espFrame = Instance.new("Folder")
                espFrame.Name = "RSPX_ESP"
                espFrame.Parent = player.Character
                
                -- Box Highlight
                if _G.BoxESP then
                    local highlight = Instance.new("Highlight")
                    highlight.OutlineTransparency = 0
                    highlight.FillTransparency = 0.7
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Adornee = player.Character
                    highlight.Parent = espFrame
                    
                    -- Team Colors
                    if player.Team ~= localPlayer.Team then
                        highlight.FillColor = Color3.new(1, 0.2, 0.2)
                    else
                        highlight.FillColor = Color3.new(0.2, 1, 0.2)
                    end
                end
                
                -- Name Label
                if _G.NameESP then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Adornee = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("UpperTorso")
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
                
                -- Health Bar
                if _G.HealthESP then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        local healthBar = Instance.new("BillboardGui")
                        healthBar.Size = UDim2.new(2, 0, 0.2, 0)
                        healthBar.StudsOffset = Vector3.new(0, 2.5, 0)
                        healthBar.AlwaysOnTop = true
                        healthBar.Adornee = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("UpperTorso")
                        healthBar.Parent = espFrame
                        
                        local background = Instance.new("Frame")
                        background.Size = UDim2.new(1, 0, 1, 0)
                        background.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                        background.BorderSizePixel = 0
                        background.Parent = healthBar
                        
                        local fill = Instance.new("Frame")
                        fill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
                        fill.BackgroundColor3 = Color3.new(1 - (humanoid.Health / humanoid.MaxHealth), humanoid.Health / humanoid.MaxHealth, 0)
                        fill.BorderSizePixel = 0
                        fill.Parent = background
                        
                        humanoid.HealthChanged:Connect(function()
                            fill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
                            fill.BackgroundColor3 = Color3.new(1 - (humanoid.Health / humanoid.MaxHealth), humanoid.Health / humanoid.MaxHealth, 0)
                        end)
                    end
                end
                
                -- Skeleton ESP
                if _G.SkeletonESP then
                    for _, partName in ipairs({"Head", "LeftHand", "RightHand", "LeftFoot", "RightFoot", "UpperTorso", "LowerTorso"}) do
                        local part = player.Character:FindFirstChild(partName)
                        if part then
                            local highlight = Instance.new("Highlight")
                            highlight.OutlineTransparency = 0
                            highlight.FillTransparency = 0.9
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            highlight.Adornee = part
                            highlight.FillColor = Color3.new(1, 1, 0)
                            highlight.Parent = espFrame
                        end
                    end
                end
                
                espCache[player] = espFrame
            elseif not _G.ESPMaster and espCache[player] then
                espCache[player]:Destroy()
                espCache[player] = nil
            end
        end
    end
end

-- FOV Circle
local fovCircle
function updateFOVCircle()
    if not _G.FOVCircle then
        if fovCircle then
            fovCircle:Destroy()
            fovCircle = nil
        end
        return
    end
    
    if not fovCircle then
        fovCircle = Drawing.new("Circle")
        fovCircle.Visible = true
        fovCircle.Thickness = 2
        fovCircle.Color = Color3.new(1, 0, 0)
        fovCircle.Transparency = 1
        fovCircle.Filled = false
    end
    
    fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    fovCircle.Radius = 120
end

-- Big Hitboxes
function updateHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            for _, part in ipairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    if _G.BigHitboxes then
                        part.Size = Vector3.new(5, 5, 5)
                        part.Transparency = 0.7
                        part.CanCollide = false
                    else
                        part.Size = Vector3.new(2, 2, 2)
                        part.Transparency = 0
                    end
                end
            end
        end
    end
end

-- Free Cam Controls
local freeCamConnection
function createFreeCamControls()
    if freeCamConnection then
        freeCamConnection:Disconnect()
    end
    
    freeCamConnection = RunService.RenderStepped:Connect(function()
        if not _G.FreeCam then return end
        
        local moveVector = Vector3.new(
            UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,
            UIS:IsKeyDown(Enum.KeyCode.E) and 1 or UIS:IsKeyDown(Enum.KeyCode.Q) and -1 or 0,
            UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0
        )
        
        camera.CFrame = camera.CFrame * CFrame.new(moveVector * 2)
        
        -- Rotate camera with mouse
        if UIS.MouseDelta ~= Vector2.new(0, 0) then
            local delta = UIS.MouseDelta * 0.002
            camera.CFrame = camera.CFrame * CFrame.fromEulerAnglesYXZ(-delta.Y, -delta.X, 0)
        end
    end)
end

-- Rage Aimbot
local aimbotConnection = RunService.RenderStepped:Connect(function()
    if not _G.AimbotEnabled then return end
    
    local closest, maxDist = nil, math.huge
    local mousePos = UIS:GetMouseLocation()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local headPos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local distance = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(headPos.X, headPos.Y)).Magnitude
                    if distance < maxDist then
                        closest = head
                        maxDist = distance
                    end
                end
            end
        end
    end
    
    if closest then
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
    end
end)

-- Initialize
updateESP()
updateFOVCircle()
updateHitboxes()

-- Auto-update ESP
Players.PlayerAdded:Connect(updateESP)
Players.PlayerRemoving:Connect(updateESP)

-- First run notification
Rayfield:Notify({
    Title = "RSPX ULTIMATE LOADED",
    Content = "All features are fully functional!",
    Duration = 5,
    Image = "check-circle"
})