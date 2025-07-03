-- RSPY ULTIMATE PREMIUM
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Create premium window with glass theme
local Window = Rayfield:CreateWindow({
    Name = "RSPY ULTIMATE PREMIUM",
    Icon = "award",
    LoadingTitle = "Premium Features Loading",
    LoadingSubtitle = "Mobile Optimized",
    Theme = "Serenity",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RSPY_Config",
        FileName = "PremiumConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "rspy",
        RememberJoins = true
    },
    KeySystem = false
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

local FlyToggle = Tabs.Player:CreateToggle({
    Name = "Flight Mode",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        _G.FlyEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "Flight Activated",
                Content = "Press SPACE to ascend, SHIFT to descend",
                Duration = 3,
                Image = "arrow-up"
            })
        end
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
local ESPSection = Tabs.Visuals:CreateSection("ESP Configuration")
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

local RTXToggle = Tabs.Visuals:CreateToggle({
    Name = "RTX Mode",
    CurrentValue = false,
    Flag = "RTXMode",
    Callback = function(Value)
        _G.RTXMode = Value
        updateRTX()
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

local RayTrackingToggle = Tabs.Combat:CreateToggle({
    Name = "Ray Tracking",
    CurrentValue = false,
    Flag = "RayTracking",
    Callback = function(Value)
        _G.RayTracking = Value
    end
})

local FOVSlider = Tabs.Combat:CreateSlider({
    Name = "Aimbot FOV",
    Range = {50, 300},
    Increment = 10,
    Suffix = "units",
    CurrentValue = 120,
    Flag = "AimbotFOV",
    Callback = function(Value)
        _G.AimbotFOV = Value
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
    Name = "Fling Players",
    CurrentValue = false,
    Flag = "FlingPlayers",
    Callback = function(Value)
        _G.FlingPlayers = Value
    end
})

-- World Tab
local EffectsSection = Tabs.World:CreateSection("Effects")
local TrailToggle = Tabs.World:CreateToggle({
    Name = "Trail Effect",
    CurrentValue = false,
    Flag = "TrailEffect",
    Callback = function(Value)
        _G.TrailEffect = Value
    end
})

local FreeCamToggle = Tabs.World:CreateToggle({
    Name = "Free Cam",
    CurrentValue = false,
    Flag = "FreeCam",
    Callback = function(Value)
        _G.FreeCam = Value
        if Value then
            Rayfield:Notify({
                Title = "Free Cam Activated",
                Content = "Use WASD + QE to move",
                Duration = 3,
                Image = "camera"
            })
        end
    end
})

local AntiLagToggle = Tabs.World:CreateToggle({
    Name = "Anti-Lag",
    CurrentValue = false,
    Flag = "AntiLag",
    Callback = function(Value)
        _G.AntiLag = Value
        antiLag()
    end
})

-- Settings Tab
local ConfigSection = Tabs.Settings:CreateSection("Configuration")
local SaveButton = Tabs.Settings:CreateButton({
    Name = "Save Configuration",
    Callback = function()
        Rayfield:Notify({
            Title = "Configuration Saved",
            Content = "Your settings have been saved",
            Duration = 2,
            Image = "save"
        })
    end
})

local UnlockFPS = Tabs.Settings:CreateButton({
    Name = "Unlock FPS",
    Callback = function()
        setfpscap(999)
        Rayfield:Notify({
            Title = "FPS Unlocked",
            Content = "Maximum FPS increased",
            Duration = 2,
            Image = "zap"
        })
    end
})

--= PREMIUM FEATURE IMPLEMENTATIONS =--
local espCache = {}
local flyConnection
local trailParts = {}

-- Enhanced Flight System
local function fly()
    if not _G.FlyEnabled then 
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        return 
    end

    flyConnection = RunService.Heartbeat:Connect(function()
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
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end)
end

-- Fixed ESP System
function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if _G.ESPMaster and not espCache[player] then
                local espFrame = Instance.new("Folder")
                espFrame.Name = "RSPY_ESP"
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
                        highlight.FillColor = Color3.new(1, 0.3, 0.3) -- Red for enemies
                    else
                        highlight.FillColor = Color3.new(0.3, 1, 0.3) -- Green for teammates
                    end
                end
                
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

-- Ray-Tracking Aimbot
local function rayAimbot()
    if not _G.AimbotEnabled then return end
    
    local closest, maxDist = nil, _G.AimbotFOV
    local mousePos = UIS:GetMouseLocation()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local headPos, onScreen = camera:WorldToViewportPoint(player.Character.Head.Position)
            if onScreen then
                local distance = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(headPos.X, headPos.Y)).Magnitude
                if distance < maxDist then
                    closest = player.Character.Head
                    maxDist = distance
                end
            end
        end
    end
    
    if closest then
        if _G.RayTracking then
            local origin = camera.CFrame.Position
            local direction = (closest.Position - origin).Unit
            camera.CFrame = CFrame.lookAt(origin, origin + direction * 100)
        else
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
        end
    end
end

-- Advanced Fling System
local function flingPlayer()
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
                root.RotVelocity = Vector3.new(
                    math.random(-100, 100),
                    math.random(-100, 100),
                    math.random(-100, 100)
                )
            end
        end
    end
end

-- Trail System
local function updateTrail()
    if _G.TrailEffect and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = localPlayer.Character.HumanoidRootPart
        
        if #trailParts < 5 then
            local trail = Instance.new("Part")
            trail.Size = Vector3.new(0.5, 0.5, 0.5)
            trail.CFrame = root.CFrame
            trail.Anchored = true
            trail.CanCollide = false
            trail.Material = Enum.Material.Neon
            trail.Color = Color3.new(0, 1, 1)
            trail.Parent = workspace
            table.insert(trailParts, trail)
            
            spawn(function()
                for i = 1, 30 do
                    trail.Transparency = i/30
                    wait(0.03)
                end
                trail:Destroy()
            end)
        end
    end
    
    -- Cleanup old trails
    for i = #trailParts, 1, -1 do
        if not trailParts[i].Parent then
            table.remove(trailParts, i)
        end
    end
end

-- RTX Mode
local function updateRTX()
    if _G.RTXMode then
        Lighting.GlobalShadows = true
        Lighting.ShadowSoftness = 0.2
        Lighting.Brightness = 2
        Lighting.ExposureCompensation = 0.5
        Lighting.ClockTime = 14
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Part") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0.1
            end
        end
    else
        Lighting.GlobalShadows = false
        Lighting.ShadowSoftness = 0
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
    end
end

-- Free Cam System
local function freeCam()
    if not _G.FreeCam then 
        camera.CameraType = Enum.CameraType.Custom
        return 
    end
    
    camera.CameraType = Enum.CameraType.Scriptable
    local moveVector = Vector3.new(
        UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,
        UIS:IsKeyDown(Enum.KeyCode.E) and 1 or UIS:IsKeyDown(Enum.KeyCode.Q) and -1 or 0,
        UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0
    )
    camera.CFrame = camera.CFrame * CFrame.new(moveVector * 2)
end

-- Anti-Lag System
local function antiLag()
    if not _G.AntiLag then return end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Transparency > 0.5 then
            obj.Material = Enum.Material.Plastic
        end
        if obj:IsA("ParticleEmitter") then
            obj.Enabled = false
        end
        if obj:IsA("Decal") then
            obj.Transparency = 1
        end
    end
end

--= CORE LOOPS =--
RunService.Heartbeat:Connect(function()
    -- Movement systems
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            -- Walk Speed
            if _G.SpeedEnabled then
                humanoid.WalkSpeed = _G.SpeedValue
            else
                humanoid.WalkSpeed = 16
            end
            
            -- Flight
            if _G.FlyEnabled then fly() end
            
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
    
    -- Trail Effect
    if _G.TrailEffect then updateTrail() end
    
    -- Fling players
    flingPlayer()
    
    -- Free Cam
    freeCam()
end)

RunService.RenderStepped:Connect(function()
    -- Aimbot
    rayAimbot()
end)

--= INITIALIZATION =--
-- Initial feature setup
fly()
updateESP()
updateRTX()
antiLag()

-- Auto-update ESP
Players.PlayerAdded:Connect(updateESP)
Players.PlayerRemoving:Connect(updateESP)

-- Load notification
Rayfield:Notify({
    Title = "RSPY ULTIMATE LOADED",
    Content = "Premium features activated!",
    Duration = 5,
    Image = "check-circle"
})
