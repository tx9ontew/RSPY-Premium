-- RSPY ULTIMATE PREMIUM v5.0
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Create premium window
local Window = Rayfield:CreateWindow({
    Name = "RSPY ULTIMATE v5.0",
    Icon = "zap",
    LoadingTitle = "Premium Features Loading",
    LoadingSubtitle = "Mobile Optimized",
    Theme = "Amethyst",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RSPY_Config",
        FileName = "PremiumConfig"
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

local FlyToggle = Tabs.Player:CreateToggle({
    Name = "Flight Mode (Mobile)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        _G.FlyEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "Flight Activated",
                Content = "Virtual joystick enabled",
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

local SkeletonToggle = Tabs.Visuals:CreateToggle({
    Name = "Skeleton ESP",
    CurrentValue = false,
    Flag = "SkeletonESP",
    Callback = function(Value)
        _G.SkeletonESP = Value
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

local AimbotMode = Tabs.Combat:CreateDropdown({
    Name = "Aimbot Mode",
    Options = {"Standard", "Rage Mode", "Silent Aim"},
    CurrentOption = "Standard",
    Flag = "AimbotMode",
    Callback = function(Option)
        _G.AimbotMode = Option
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
    Name = "Fling Players (Rage)",
    CurrentValue = false,
    Flag = "FlingPlayers",
    Callback = function(Value)
        _G.FlingPlayers = Value
        if Value then
            Rayfield:Notify({
                Title = "Fling Activated",
                Content = "Teleporting and flinging targets",
                Duration = 3,
                Image = "wind"
            })
        end
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
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(camera.CFrame.Position)
        else
            camera.CameraType = Enum.CameraType.Custom
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
        Rayfield:SaveConfiguration()
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

-- Exploit detection
local ExploitSection = Tabs.Settings:CreateSection("Security")
local AntiCheatToggle = Tabs.Settings:CreateToggle({
    Name = "Anti-Cheat Bypass",
    CurrentValue = true,
    Flag = "AntiCheat",
    Callback = function(Value)
        _G.AntiCheat = Value
        applyBypass()
    end
})

--= PREMIUM FEATURE IMPLEMENTATIONS =--
local espCache = {}
local flyConnection
local trailParts = {}
local freeCamConnection
local virtualJoystick

-- Advanced bypass system
function applyBypass()
    if not _G.AntiCheat then return end
    
    -- Hook spoofing
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "Destroy" then
            return nil
        end
        return oldNamecall(self, ...)
    end)
    
    -- Environment spoofing
    if not getgenv then getgenv = function() return _G end end
    getgenv().secure_call = function(f) return f() end
end

-- Mobile flight system with virtual joystick
function setupFlight()
    if not _G.FlyEnabled then
        if virtualJoystick then
            virtualJoystick:Destroy()
            virtualJoystick = nil
        end
        return
    end
    
    -- Create virtual joystick
    virtualJoystick = Instance.new("ScreenGui", CoreGui)
    virtualJoystick.Name = "FlightJoystick"
    
    local outer = Instance.new("Frame")
    outer.Size = UDim2.new(0, 100, 0, 100)
    outer.Position = UDim2.new(0.5, -50, 0.8, -50)
    outer.BackgroundTransparency = 0.7
    outer.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
    outer.BorderSizePixel = 0
    Instance.new("UICorner", outer).CornerRadius = UDim.new(1, 0)
    outer.Parent = virtualJoystick
    
    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(0, 40, 0, 40)
    inner.Position = UDim2.new(0.5, -20, 0.5, -20)
    inner.BackgroundColor3 = Color3.new(0, 0.8, 1)
    inner.BorderSizePixel = 0
    Instance.new("UICorner", inner).CornerRadius = UDim.new(1, 0)
    inner.Parent = outer
    
    -- Flight physics
    flyConnection = RunService.Heartbeat:Connect(function()
        local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local velocity = Vector3.new(0, 0, 0)
        local direction = (inner.AbsolutePosition - outer.AbsolutePosition)
        local distance = direction.Magnitude
        local maxDistance = outer.AbsoluteSize.X / 2
        
        if distance > 5 then
            local normalized = direction / distance
            velocity = Vector3.new(normalized.X, 0, normalized.Y) * 50
            
            -- Ascend/descend
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, 1, 0)
            elseif UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                velocity = velocity - Vector3.new(0, 1, 0)
            end
        end
        
        root.Velocity = velocity * 100
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end)
end

-- Fixed ESP System with skeleton
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
                    highlight.FillTransparency = 0.8
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Adornee = player.Character
                    highlight.Parent = espFrame
                    
                    -- Team Colors
                    if player.Team ~= localPlayer.Team then
                        highlight.FillColor = Color3.new(1, 0.2, 0.2) -- Red for enemies
                    else
                        highlight.FillColor = Color3.new(0.2, 1, 0.2) -- Green for teammates
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
                
                -- Health Bar
                if _G.HealthESP then
                    local healthBar = Instance.new("BillboardGui")
                    healthBar.Size = UDim2.new(2, 0, 0.2, 0)
                    healthBar.StudsOffset = Vector3.new(0, 2.5, 0)
                    healthBar.AlwaysOnTop = true
                    healthBar.Adornee = player.Character:WaitForChild("HumanoidRootPart")
                    healthBar.Parent = espFrame
                    
                    local background = Instance.new("Frame")
                    background.Size = UDim2.new(1, 0, 1, 0)
                    background.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                    background.BorderSizePixel = 0
                    background.Parent = healthBar
                    
                    local fill = Instance.new("Frame")
                    fill.Size = UDim2.new(0.8, 0, 1, 0)
                    fill.BackgroundColor3 = Color3.new(0, 1, 0)
                    fill.BorderSizePixel = 0
                    fill.Parent = background
                    
                    player.Character.Humanoid.HealthChanged:Connect(function()
                        fill.Size = UDim2.new(player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth, 0, 1, 0)
                        fill.BackgroundColor3 = Color3.new(
                            1 - (player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth),
                            player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth,
                            0
                        )
                    end)
                end
                
                -- Skeleton ESP
                if _G.SkeletonESP then
                    for _, bone in ipairs({"Head", "LeftHand", "RightHand", "LeftFoot", "RightFoot"}) do
                        if player.Character:FindFirstChild(bone) then
                            local highlight = Instance.new("Highlight")
                            highlight.OutlineTransparency = 0
                            highlight.FillTransparency = 0.9
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            highlight.Adornee = player.Character[bone]
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

-- Rage Aimbot System
local function rageAimbot()
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
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
    end
end

-- Advanced Fling System with teleport
local function flingPlayer()
    if not _G.FlingPlayers then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if root and myRoot then
                -- Teleport to player
                myRoot.CFrame = root.CFrame * CFrame.new(0, 3, 0)
                
                -- Apply fling force
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

-- RTX Mode
local function updateRTX()
    if _G.RTXMode then
        Lighting.GlobalShadows = true
        Lighting.ShadowSoftness = 0.3
        Lighting.Brightness = 1.8
        Lighting.ExposureCompensation = 0.6
        Lighting.ClockTime = 14
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.7, 1)
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0.15
            end
        end
    else
        Lighting.GlobalShadows = false
        Lighting.ShadowSoftness = 0
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
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
            
            -- Jump Power
            if _G.JumpPowerEnabled then
                humanoid.JumpPower = _G.JumpPowerValue
            else
                humanoid.JumpPower = 50
            end
            
            -- Flight
            setupFlight()
            
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
    if _G.FlingPlayers then
        flingPlayer()
    end
end)

RunService.RenderStepped:Connect(function()
    -- Aimbot
    if _G.AimbotEnabled and _G.AimbotMode == "Rage Mode" then
        rageAimbot()
    end
    
    -- Free Cam movement
    if _G.FreeCam then
        local moveVector = Vector3.new(
            UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,
            UIS:IsKeyDown(Enum.KeyCode.E) and 1 or UIS:IsKeyDown(Enum.KeyCode.Q) and -1 or 0,
            UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0
        )
        camera.CFrame = camera.CFrame * CFrame.new(moveVector * 2)
    end
end)

--= INITIALIZATION =--
-- Apply bypass first
applyBypass()

-- Initial feature setup
updateESP()
updateRTX()

-- Auto-update ESP
Players.PlayerAdded:Connect(updateESP)
Players.PlayerRemoving:Connect(updateESP)

-- Load notification
Rayfield:Notify({
    Title = "RSPY ULTIMATE LOADED",
    Content = "All premium features activated!",
    Duration = 5,
    Image = "check-circle"
})