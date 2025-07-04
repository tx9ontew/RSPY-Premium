-- RSPX ULTIMATE v14.0 - PERSISTENT PREMIUM
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Initialize features with persistent values
local Features = {
    -- Movement
    SpeedEnabled = false,
    SpeedValue = 50,
    JumpPowerEnabled = false,
    JumpPowerValue = 100,
    InfiniteJump = false,
    NoClip = false,
    AntiVoid = false,
    
    -- Visuals
    ESPMaster = false,
    BoxESP = true,
    NameESP = true,
    HealthESP = true,
    SkeletonESP = false,
    FOVCircle = true,
    FOVSize = 120,
    AntiLag = false,
    WallHack = false,
    
    -- Combat
    AimbotEnabled = false,
    AimbotMode = "Silent",
    TeamCheck = true,
    WallCheck = true,
    Smoothness = 0.5,
    TriggerBot = false,
    AutoShoot = false,
    HitChance = 100,
    
    -- World
    NoFog = false,
    BrightWorld = false
}

-- Create premium window
local Window = Rayfield:CreateWindow({
    Name = "RSPX ULTIMATE v14.0",
    Icon = "crosshair",
    LoadingTitle = "PERSISTENT PREMIUM FEATURES",
    LoadingSubtitle = "Features Survive Death",
    Theme = "Amethyst",
    ToggleUIKeybind = Enum.KeyCode.K,
    MobileOptimized = true,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RSPX_Config",
        FileName = "RSPX_Settings"
    }
})

-- Create tabs
local Tabs = {
    Player = Window:CreateTab("Player", "user"),
    Visuals = Window:CreateTab("Visuals", "eye"),
    Combat = Window:CreateTab("Combat", "crosshair"),
    World = Window:CreateTab("World", "globe"),
    Settings = Window:CreateTab("Settings", "settings")
}

-- Player Tab
local MovementSection = Tabs.Player:CreateSection("Movement")
Tabs.Player:CreateToggle({Name = "Speed Hack", CurrentValue = Features.SpeedEnabled, Flag = "SpeedToggle"})
Tabs.Player:CreateSlider({Name = "Walk Speed", Range = {16, 300}, CurrentValue = Features.SpeedValue, Suffix = "studs/s", Flag = "SpeedSlider"})
Tabs.Player:CreateToggle({Name = "Jump Power Hack", CurrentValue = Features.JumpPowerEnabled, Flag = "JumpPowerToggle"})
Tabs.Player:CreateSlider({Name = "Jump Power", Range = {50, 500}, CurrentValue = Features.JumpPowerValue, Suffix = "power", Flag = "JumpPowerSlider"})
Tabs.Player:CreateToggle({Name = "Infinite Jump", CurrentValue = Features.InfiniteJump, Flag = "InfiniteJump"})
Tabs.Player:CreateToggle({Name = "No Clip", CurrentValue = Features.NoClip, Flag = "NoClip"})
Tabs.Player:CreateToggle({Name = "Anti-Void", CurrentValue = Features.AntiVoid, Flag = "AntiVoid"})

-- Visuals Tab
local ESPSection = Tabs.Visuals:CreateSection("ESP")
Tabs.Visuals:CreateToggle({Name = "ESP Master Switch", CurrentValue = Features.ESPMaster, Flag = "ESPMaster"})
Tabs.Visuals:CreateToggle({Name = "Box ESP", CurrentValue = Features.BoxESP, Flag = "BoxESP"})
Tabs.Visuals:CreateToggle({Name = "Show Names", CurrentValue = Features.NameESP, Flag = "NameESP"})
Tabs.Visuals:CreateToggle({Name = "Health Bars", CurrentValue = Features.HealthESP, Flag = "HealthESP"})
Tabs.Visuals:CreateToggle({Name = "Skeleton ESP", CurrentValue = Features.SkeletonESP, Flag = "SkeletonESP"})
Tabs.Visuals:CreateToggle({Name = "Wall Hack", CurrentValue = Features.WallHack, Flag = "WallHack"})
Tabs.Visuals:CreateToggle({Name = "Aimbot FOV Circle", CurrentValue = Features.FOVCircle, Flag = "FOVCircle"})
Tabs.Visuals:CreateSlider({Name = "FOV Size", Range = {50, 500}, CurrentValue = Features.FOVSize, Suffix = "units", Flag = "FOVSlider"})
Tabs.Visuals:CreateToggle({Name = "Anti-Lag Mode", CurrentValue = Features.AntiLag, Flag = "AntiLag"})

-- Combat Tab
local AimbotSection = Tabs.Combat:CreateSection("Aimbot")
Tabs.Combat:CreateToggle({Name = "Aimbot", CurrentValue = Features.AimbotEnabled, Flag = "AimbotToggle"})
Tabs.Combat:CreateDropdown({Name = "Aimbot Mode", Options = {"Silent", "Normal", "Rage"}, CurrentOption = "Silent", Flag = "AimbotMode"})
Tabs.Combat:CreateToggle({Name = "Team Check", CurrentValue = Features.TeamCheck, Flag = "TeamCheck"})
Tabs.Combat:CreateToggle({Name = "Wall Check", CurrentValue = Features.WallCheck, Flag = "WallCheck"})
Tabs.Combat:CreateSlider({Name = "Smoothness", Range = {0.1, 1}, Increment = 0.05, CurrentValue = Features.Smoothness, Suffix = "", Flag = "SmoothnessSlider"})
Tabs.Combat:CreateSlider({Name = "Hit Chance", Range = {0, 100}, Increment = 5, CurrentValue = Features.HitChance, Suffix = "%", Flag = "HitChanceSlider"})
Tabs.Combat:CreateToggle({Name = "Trigger Bot", CurrentValue = Features.TriggerBot, Flag = "TriggerBot"})
Tabs.Combat:CreateToggle({Name = "Auto Shoot", CurrentValue = Features.AutoShoot, Flag = "AutoShoot"})

-- World Tab
local EffectsSection = Tabs.World:CreateSection("Effects")
Tabs.World:CreateToggle({Name = "Remove Fog", CurrentValue = Features.NoFog, Flag = "NoFog"})
Tabs.World:CreateToggle({Name = "Bright World", CurrentValue = Features.BrightWorld, Flag = "BrightWorld"})

-- Settings Tab
local ConfigSection = Tabs.Settings:CreateSection("Configuration")
Tabs.Settings:CreateButton({Name = "Save Settings", Callback = saveConfig})
Tabs.Settings:CreateButton({Name = "Load Settings", Callback = loadConfig})
Tabs.Settings:CreateButton({Name = "Unload Script", Callback = function() Rayfield:Destroy() end})

-- ===== PERSISTENT SYSTEMS =====
local espCache = {}
local fovCircle
local humanoidConnections = {}
local bypassMethods = {
    Mouse = true,
    Camera = true,
    Remote = false
}

-- Character management
local function onCharacterAdded(character)
    -- Reapply movement hacks
    local humanoid = character:WaitForChild("Humanoid")
    
    if Features.SpeedEnabled then
        humanoid.WalkSpeed = Features.SpeedValue
    end
    
    if Features.JumpPowerEnabled then
        humanoid.JumpPower = Features.JumpPowerValue
    end
    
    -- Create new connection for infinite jump
    if humanoidConnections[humanoid] then
        humanoidConnections[humanoid]:Disconnect()
    end
    
    humanoidConnections[humanoid] = humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
        if Features.InfiniteJump and UIS:IsKeyDown(Enum.KeyCode.Space) then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

localPlayer.CharacterAdded:Connect(onCharacterAdded)
if localPlayer.Character then
    task.spawn(onCharacterAdded, localPlayer.Character)
end

-- Premium ESP System
function updateESP()
    -- Clear existing ESP
    for player, espData in pairs(espCache) do
        if espData.Highlight then espData.Highlight:Destroy() end
        if espData.Billboard then espData.Billboard:Destroy() end
    end
    espCache = {}
    
    if not Features.ESPMaster then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            createPlayerESP(player)
        end
    end
end

function createPlayerESP(player)
    if espCache[player] then return end
    
    espCache[player] = {}
    local data = espCache[player]
    
    -- Highlight
    if Features.BoxESP then
        data.Highlight = Instance.new("Highlight")
        data.Highlight.Name = player.Name .. "_Highlight"
        data.Highlight.FillTransparency = 0.7
        data.Highlight.OutlineTransparency = 0
        data.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        data.Highlight.Parent = CoreGui
        
        -- Team color
        if Features.TeamCheck and player.Team ~= localPlayer.Team then
            data.Highlight.FillColor = Color3.new(1, 0.2, 0.2)
        else
            data.Highlight.FillColor = Color3.new(0.2, 1, 0.2)
        end
    end
    
    -- Billboard
    if Features.NameESP or Features.HealthESP then
        data.Billboard = Instance.new("BillboardGui")
        data.Billboard.Name = player.Name .. "_Billboard"
        data.Billboard.Size = UDim2.new(0, 200, 0, 50)
        data.Billboard.AlwaysOnTop = true
        data.Billboard.Parent = CoreGui
        
        if Features.NameESP then
            data.NameLabel = Instance.new("TextLabel")
            data.NameLabel.Text = player.Name
            data.NameLabel.TextColor3 = Color3.new(1, 1, 1)
            data.NameLabel.TextSize = 14
            data.NameLabel.Font = Enum.Font.GothamBold
            data.NameLabel.BackgroundTransparency = 1
            data.NameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            data.NameLabel.Parent = data.Billboard
        end
        
        if Features.HealthESP then
            data.HealthBar = Instance.new("Frame")
            data.HealthBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            data.HealthBar.BorderSizePixel = 0
            data.HealthBar.Size = UDim2.new(1, 0, 0.1, 0)
            data.HealthBar.Position = UDim2.new(0, 0, 0.9, 0)
            data.HealthBar.Parent = data.Billboard
            
            data.HealthFill = Instance.new("Frame")
            data.HealthFill.BackgroundColor3 = Color3.new(0, 1, 0)
            data.HealthFill.BorderSizePixel = 0
            data.HealthFill.Size = UDim2.new(1, 0, 1, 0)
            data.HealthFill.Parent = data.HealthBar
        end
    end
    
    -- Update character reference
    if player.Character then
        updateESPCharacter(player, player.Character)
    end
    
    player.CharacterAdded:Connect(function(char)
        updateESPCharacter(player, char)
    end)
end

function updateESPCharacter(player, character)
    local data = espCache[player]
    if not data then return end
    
    if data.Highlight then
        data.Highlight.Adornee = character
    end
    
    if data.Billboard then
        data.Billboard.Adornee = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    end
    
    -- Health update
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid and data.HealthFill then
        if not data.HealthConnection then
            data.HealthConnection = humanoid.HealthChanged:Connect(function()
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                data.HealthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
                data.HealthFill.BackgroundColor3 = Color3.new(1 - healthPercent, healthPercent, 0)
            end)
        end
    end
end

-- Advanced Aimbot System
function getBestTarget()
    if not Features.AimbotEnabled then return nil end
    
    local bestTarget = nil
    local closestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            -- Team check
            if Features.TeamCheck and player.Team == localPlayer.Team then continue end
            
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and rootPart then
                -- Wall check
                if Features.WallCheck then
                    local origin = camera.CFrame.Position
                    local direction = (rootPart.Position - origin).Unit * 1000
                    local ray = Ray.new(origin, direction)
                    local hit, _ = Workspace:FindPartOnRayWithIgnoreList(ray, {localPlayer.Character})
                    
                    if hit and not hit:IsDescendantOf(player.Character) then
                        continue -- Wall is blocking
                    end
                end
                
                -- Hit chance check
                if math.random(1, 100) > Features.HitChance then continue end
                
                -- FOV check
                local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local mousePos = UIS:GetMouseLocation()
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    if distance < Features.FOVSize and distance < closestDistance then
                        closestDistance = distance
                        bestTarget = {Player = player, Part = rootPart}
                    end
                end
            end
        end
    end
    
    return bestTarget
end

-- Aimbot methods
local aimbotMethods = {
    Silent = function(target)
        -- Bypass 1: Mouse position modification
        if bypassMethods.Mouse then
            local screenPos = camera:WorldToScreenPoint(target.Part.Position)
            mousemoverel(screenPos.X - mouse.X, screenPos.Y - mouse.Y)
        end
        
        -- Bypass 2: Camera manipulation
        if bypassMethods.Camera then
            local currentCFrame = camera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, target.Part.Position)
            camera.CFrame = currentCFrame:Lerp(targetCFrame, Features.Smoothness)
        end
    end,
    
    Normal = function(target)
        -- Smooth aim assist
        local currentCFrame = camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, target.Part.Position)
        camera.CFrame = currentCFrame:Lerp(targetCFrame, Features.Smoothness)
        
        -- Auto shoot if enabled
        if Features.AutoShoot and localPlayer.Character then
            local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end,
    
    Rage = function(target)
        -- Instant perfect aim
        camera.CFrame = CFrame.new(camera.CFrame.Position, target.Part.Position)
        
        -- Auto shoot
        if Features.AutoShoot and localPlayer.Character then
            local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                for i = 1, 3 do
                    tool:Activate()
                    task.wait()
                end
            end
        end
    end
}

-- FOV Circle
function updateFOVCircle()
    if not fovCircle and Features.FOVCircle then
        fovCircle = Drawing.new("Circle")
        fovCircle.Visible = true
        fovCircle.Thickness = 2
        fovCircle.Color = Color3.new(1, 0, 0)
        fovCircle.Transparency = 1
        fovCircle.Filled = false
    end
    
    if fovCircle then
        fovCircle.Visible = Features.FOVCircle
        fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
        fovCircle.Radius = Features.FOVSize
    end
end

-- Conflict resolution
function checkFeatureConflicts()
    -- Disable Silent Aim if Normal/Rage is active
    if Features.AimbotMode ~= "Silent" and bypassMethods.Remote then
        bypassMethods.Remote = false
        Rayfield:Notify({
            Title = "Conflict Detected",
            Content = "Remote bypass disabled for current aim mode",
            Duration = 3,
            Image = "alert-triangle"
        })
    end
    
    -- Disable ESP if Anti-Lag is on
    if Features.AntiLag and Features.ESPMaster then
        Features.ESPMaster = false
        Rayfield:Notify({
            Title = "Conflict Detected",
            Content = "ESP disabled while Anti-Lag is active",
            Duration = 3,
            Image = "alert-triangle"
        })
    end
end

-- Main persistent loop
local mainLoop = RunService.Heartbeat:Connect(function()
    -- Check for conflicts
    checkFeatureConflicts()
    
    -- Update FOV circle
    updateFOVCircle()
    
    -- Apply aimbot
    if Features.AimbotEnabled then
        local target = getBestTarget()
        if target and aimbotMethods[Features.AimbotMode] then
            aimbotMethods[Features.AimbotMode](target)
        end
    end
    
    -- Apply anti-void
    if Features.AntiVoid and localPlayer.Character then
        local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root and root.Position.Y < -50 then
            root.CFrame = CFrame.new(0, 100, 0)
        end
    end
    
    -- Apply no clip
    if Features.NoClip and localPlayer.Character then
        for _, part in ipairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    -- Apply wallhack
    if Features.WallHack then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.5 then
                part.LocalTransparencyModifier = 0.5
            end
        end
    end
end)

-- Initialization
updateESP()
updateFOVCircle()

-- First run notification
Rayfield:Notify({
    Title = "RSPX ULTIMATE LOADED",
    Content = "v14.0 - Features Persist Through Death",
    Duration = 5,
    Image = "zap"
})

-- Cleanup on unload
game:GetService("UserInputService").WindowFocused:Connect(function()
    if not mainLoop.Connected then
        mainLoop = RunService.Heartbeat:Connect(function() end)
        updateESP()
        updateFOVCircle()
    end
end)

game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    if mainLoop.Connected then
        mainLoop:Disconnect()
        for player, data in pairs(espCache) do
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
        end
        if fovCircle then fovCircle:Remove() end
    end
end)