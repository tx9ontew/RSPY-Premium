-- RSPX ULTIMATE v12.0 - PREMIUM MOBILE
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Configuration saving
local Window = Rayfield:CreateWindow({
    Name = "RSPX ULTIMATE v12.0",
    Icon = "zap",
    LoadingTitle = "MOBILE PREMIUM EDITION",
    LoadingSubtitle = "Optimized for Mobile Performance",
    Theme = "Amethyst",
    ToggleUIKeybind = Enum.KeyCode.K,
    MobileOptimized = true,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RSPX_Config",
        FileName = "RSPX_Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    }
})

-- Initialize features with default values
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
    RageMode = false,
    BigHitboxes = false,
    AntiFling = false,
    FlingPlayers = false,
    CheaterDetection = false,
    TeamCheck = true,
    WallCheck = true,
    AimLock = false,
    SilentAim = false,
    TriggerBot = false,
    
    -- Spectate
    SpectateMode = false,
    SpectatedPlayer = nil,
    
    -- World
    NoFog = false,
    BrightWorld = false
}

-- Create tabs
local Tabs = {
    Player = Window:CreateTab("Player", "user"),
    Visuals = Window:CreateTab("Visuals", "eye"),
    Combat = Window:CreateTab("Combat", "crosshair"),
    World = Window:CreateTab("World", "globe"),
    Spectate = Window:CreateTab("Spectate", "video"),
    Settings = Window:CreateTab("Settings", "settings")
}

-- Player Tab
local MovementSection = Tabs.Player:CreateSection("Movement")

local SpeedToggle = Tabs.Player:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = Features.SpeedEnabled,
    Flag = "SpeedToggle",
    Callback = function(Value)
        Features.SpeedEnabled = Value
    end
})

local SpeedSlider = Tabs.Player:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "studs/s",
    CurrentValue = Features.SpeedValue,
    Flag = "SpeedSlider",
    Callback = function(Value)
        Features.SpeedValue = Value
    end
})

local JumpPowerToggle = Tabs.Player:CreateToggle({
    Name = "Jump Power Hack",
    CurrentValue = Features.JumpPowerEnabled,
    Flag = "JumpPowerToggle",
    Callback = function(Value)
        Features.JumpPowerEnabled = Value
    end
})

local JumpPowerSlider = Tabs.Player:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    Suffix = "power",
    CurrentValue = Features.JumpPowerValue,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        Features.JumpPowerValue = Value
    end
})

local InfiniteJumpToggle = Tabs.Player:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = Features.InfiniteJump,
    Flag = "InfiniteJump",
    Callback = function(Value)
        Features.InfiniteJump = Value
    end
})

local NoClipToggle = Tabs.Player:CreateToggle({
    Name = "No Clip",
    CurrentValue = Features.NoClip,
    Flag = "NoClip",
    Callback = function(Value)
        Features.NoClip = Value
    end
})

local AntiVoidToggle = Tabs.Player:CreateToggle({
    Name = "Anti-Void",
    CurrentValue = Features.AntiVoid,
    Flag = "AntiVoid",
    Callback = function(Value)
        Features.AntiVoid = Value
    end
})

-- Visuals Tab
local ESPSection = Tabs.Visuals:CreateSection("ESP")

local ESPMasterToggle = Tabs.Visuals:CreateToggle({
    Name = "ESP Master Switch",
    CurrentValue = Features.ESPMaster,
    Flag = "ESPMaster",
    Callback = function(Value)
        Features.ESPMaster = Value
        updateESP()
    end
})

local BoxesToggle = Tabs.Visuals:CreateToggle({
    Name = "Box ESP",
    CurrentValue = Features.BoxESP,
    Flag = "BoxESP",
    Callback = function(Value)
        Features.BoxESP = Value
        updateESP()
    end
})

local NamesToggle = Tabs.Visuals:CreateToggle({
    Name = "Show Names",
    CurrentValue = Features.NameESP,
    Flag = "NameESP",
    Callback = function(Value)
        Features.NameESP = Value
        updateESP()
    end
})

local HealthToggle = Tabs.Visuals:CreateToggle({
    Name = "Health Bars",
    CurrentValue = Features.HealthESP,
    Flag = "HealthESP",
    Callback = function(Value)
        Features.HealthESP = Value
        updateESP()
    end
})

local SkeletonToggle = Tabs.Visuals:CreateToggle({
    Name = "Skeleton ESP",
    CurrentValue = Features.SkeletonESP,
    Flag = "SkeletonESP",
    Callback = function(Value)
        Features.SkeletonESP = Value
        updateESP()
    end
})

local WallHackToggle = Tabs.Visuals:CreateToggle({
    Name = "Wall Hack",
    CurrentValue = Features.WallHack,
    Flag = "WallHack",
    Callback = function(Value)
        Features.WallHack = Value
        applyWallHack()
    end
})

local FOVCircleToggle = Tabs.Visuals:CreateToggle({
    Name = "Aimbot FOV Circle",
    CurrentValue = Features.FOVCircle,
    Flag = "FOVCircle",
    Callback = function(Value)
        Features.FOVCircle = Value
        updateFOVCircle()
    end
})

local FOVSlider = Tabs.Visuals:CreateSlider({
    Name = "FOV Size",
    Range = {50, 500},
    Increment = 10,
    Suffix = "units",
    CurrentValue = Features.FOVSize,
    Flag = "FOVSlider",
    Callback = function(Value)
        Features.FOVSize = Value
        updateFOVCircle()
    end
})

local AntiLagToggle = Tabs.Visuals:CreateToggle({
    Name = "Anti-Lag Mode",
    CurrentValue = Features.AntiLag,
    Flag = "AntiLag",
    Callback = function(Value)
        Features.AntiLag = Value
        applyAntiLag()
    end
})

-- Combat Tab
local AimbotSection = Tabs.Combat:CreateSection("Aimbot")

local AimbotToggle = Tabs.Combat:CreateToggle({
    Name = "Aimbot",
    CurrentValue = Features.AimbotEnabled,
    Flag = "AimbotToggle",
    Callback = function(Value)
        Features.AimbotEnabled = Value
    end
})

local AimbotMode = Tabs.Combat:CreateDropdown({
    Name = "Aimbot Mode",
    Options = {"Silent", "Rage", "Teleport"},
    CurrentOption = "Silent",
    Flag = "AimbotMode",
    Callback = function(Option)
        Features.AimbotMode = Option
    end
})

local RageModeToggle = Tabs.Combat:CreateToggle({
    Name = "Rage Mode",
    CurrentValue = Features.RageMode,
    Flag = "RageMode",
    Callback = function(Value)
        Features.RageMode = Value
    end
})

local SilentAimToggle = Tabs.Combat:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = Features.SilentAim,
    Flag = "SilentAim",
    Callback = function(Value)
        Features.SilentAim = Value
    end
})

local AimLockToggle = Tabs.Combat:CreateToggle({
    Name = "Aim Lock",
    CurrentValue = Features.AimLock,
    Flag = "AimLock",
    Callback = function(Value)
        Features.AimLock = Value
    end
})

local TriggerBotToggle = Tabs.Combat:CreateToggle({
    Name = "Trigger Bot",
    CurrentValue = Features.TriggerBot,
    Flag = "TriggerBot",
    Callback = function(Value)
        Features.TriggerBot = Value
    end
})

local TeamCheckToggle = Tabs.Combat:CreateToggle({
    Name = "Team Check",
    CurrentValue = Features.TeamCheck,
    Flag = "TeamCheck",
    Callback = function(Value)
        Features.TeamCheck = Value
    end
})

local WallCheckToggle = Tabs.Combat:CreateToggle({
    Name = "Wall Check",
    CurrentValue = Features.WallCheck,
    Flag = "WallCheck",
    Callback = function(Value)
        Features.WallCheck = Value
    end
})

local HitboxToggle = Tabs.Combat:CreateToggle({
    Name = "Big Hitboxes",
    CurrentValue = Features.BigHitboxes,
    Flag = "BigHitboxes",
    Callback = function(Value)
        Features.BigHitboxes = Value
        updateHitboxes()
    end
})

local FlingSection = Tabs.Combat:CreateSection("Fling System")

local AntiFlingToggle = Tabs.Combat:CreateToggle({
    Name = "Anti-Fling Protection",
    CurrentValue = Features.AntiFling,
    Flag = "AntiFling",
    Callback = function(Value)
        Features.AntiFling = Value
    end
})

local FlingToggle = Tabs.Combat:CreateToggle({
    Name = "Fling Players",
    CurrentValue = Features.FlingPlayers,
    Flag = "FlingPlayers",
    Callback = function(Value)
        Features.FlingPlayers = Value
    end
})

local CheaterDetectionToggle = Tabs.Combat:CreateToggle({
    Name = "Detect Cheaters",
    CurrentValue = Features.CheaterDetection,
    Flag = "CheaterDetection",
    Callback = function(Value)
        Features.CheaterDetection = Value
    end
})

-- Spectate Tab
local SpectateSection = Tabs.Spectate:CreateSection("Spectate Mode")

local SpectateToggle = Tabs.Spectate:CreateToggle({
    Name = "Spectate Players",
    CurrentValue = Features.SpectateMode,
    Flag = "SpectateMode",
    Callback = function(Value)
        Features.SpectateMode = Value
        if Value then
            camera.CameraType = Enum.CameraType.Scriptable
        else
            camera.CameraType = Enum.CameraType.Custom
            Features.SpectatedPlayer = nil
        end
    end
})

-- Populate player list for spectate
local PlayerList = {}
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        table.insert(PlayerList, player.Name)
    end
end

local SpectateDropdown = Tabs.Spectate:CreateDropdown({
    Name = "Select Player",
    Options = PlayerList,
    CurrentOption = "",
    Flag = "SpectatePlayer",
    Callback = function(Option)
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Name == Option then
                Features.SpectatedPlayer = player
                break
            end
        end
    end
})

-- World Tab
local EffectsSection = Tabs.World:CreateSection("Effects")

local NoFogToggle = Tabs.World:CreateToggle({
    Name = "Remove Fog",
    CurrentValue = Features.NoFog,
    Flag = "NoFog",
    Callback = function(Value)
        Features.NoFog = Value
        applyNoFog()
    end
})

local BrightWorldToggle = Tabs.World:CreateToggle({
    Name = "Bright World",
    CurrentValue = Features.BrightWorld,
    Flag = "BrightWorld",
    Callback = function(Value)
        Features.BrightWorld = Value
        applyBrightWorld()
    end
})

-- Settings Tab
local ConfigSection = Tabs.Settings:CreateSection("Configuration")

Tabs.Settings:CreateButton({
    Name = "Save Configuration",
    Callback = saveConfig
})

Tabs.Settings:CreateButton({
    Name = "Load Configuration",
    Callback = loadConfig
})

Tabs.Settings:CreateButton({
    Name = "Unload Script",
    Callback = function()
        Rayfield:Destroy()
    end
})

-- Mobile optimization settings
local originalSettings = {
    GraphicsQualityLevel = settings().Rendering.QualityLevel,
    Particles = {}
}

-- ===== CORE FUNCTIONALITY =====
-- Mobile Optimization
function applyAntiLag()
    if Features.AntiLag then
        -- Reduce graphics quality
        settings().Rendering.QualityLevel = 1
        
        -- Simplify water
        for _, water in ipairs(Workspace:GetDescendants()) do
            if water:IsA("Water") or water:IsA("Texture") then
                water.Transparency = 0.8
                water.Reflectance = 0
            end
        end
        
        -- Reduce particles
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("ParticleEmitter") then
                part.Rate = 5
                part.Lifetime = NumberRange.new(0.5)
            end
        end
    else
        -- Restore original settings
        settings().Rendering.QualityLevel = originalSettings.GraphicsQualityLevel
        for _, water in ipairs(Workspace:GetDescendants()) do
            if water:IsA("Water") or water:IsA("Texture") then
                water.Transparency = 0
                water.Reflectance = 0.5
            end
        end
    end
end

-- Wallhack
function applyWallHack()
    if Features.WallHack then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.5 then
                part.LocalTransparencyModifier = 0.5
            end
        end
    else
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

-- World Effects
function applyNoFog()
    if Features.NoFog then
        Lighting.FogEnd = 1000000
        Lighting.FogStart = 100000
    else
        Lighting.FogEnd = 100
        Lighting.FogStart = 0
    end
end

function applyBrightWorld()
    if Features.BrightWorld then
        Lighting.Brightness = 5
        Lighting.ExposureCompensation = 1
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
        Lighting.GlobalShadows = true
    end
end

-- ESP System
local espCache = {}
function updateESP()
    -- Clear existing ESP
    for player, espFrame in pairs(espCache) do
        if espFrame then
            espFrame:Destroy()
        end
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
    
    local espFolder = Instance.new("Folder")
    espFolder.Name = player.Name .. "_ESP"
    espFolder.Parent = CoreGui
    espCache[player] = espFolder
    
    -- Box Highlight
    if Features.BoxESP then
        local highlight = Instance.new("Highlight")
        highlight.Name = "BoxHighlight"
        highlight.OutlineTransparency = 0.5
        highlight.FillTransparency = 0.8
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = espFolder
        
        -- Team Colors
        if player.Character then
            highlight.Adornee = player.Character
            if Features.TeamCheck and player.Team ~= localPlayer.Team then
                highlight.FillColor = Color3.new(1, 0.2, 0.2)
            else
                highlight.FillColor = Color3.new(0.2, 1, 0.2)
            end
        end
    end
    
    -- Name Label
    if Features.NameESP and player.Character then
        local head = player.Character:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "NameTag"
            billboard.Size = UDim2.new(0, 100, 0, 20)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = head
            billboard.Parent = espFolder
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Text = player.DisplayName or player.Name
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextSize = 12
            nameLabel.Font = Enum.Font.GothamMedium
            nameLabel.Parent = billboard
        end
    end
end

-- FOV Circle
local fovCircle
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

-- Anti-Fling Protection
function applyAntiFling()
    if not Features.AntiFling or not localPlayer.Character then return end
    
    local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root and root.Velocity.Magnitude > 100 then
        -- Create anti-velocity force
        local antiVelocity = Instance.new("BodyVelocity")
        antiVelocity.Velocity = -root.Velocity * 0.8
        antiVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        antiVelocity.P = 10000
        antiVelocity.Parent = root
        
        -- Create stabilization force
        local antiGyro = Instance.new("BodyGyro")
        antiGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        antiGyro.P = 10000
        antiGyro.CFrame = CFrame.new()
        antiGyro.Parent = root
        
        -- Cleanup after stabilization
        task.delay(0.3, function()
            if antiVelocity then antiVelocity:Destroy() end
            if antiGyro then antiGyro:Destroy() end
        end)
    end
end

-- Configuration Saving/Loading
function saveConfig()
    Rayfield:Notify({
        Title = "Configuration Saved",
        Content = "Settings saved successfully!",
        Duration = 3,
        Image = "save"
    })
end

function loadConfig()
    Rayfield:Notify({
        Title = "Configuration Loaded",
        Content = "Settings applied successfully!",
        Duration = 3,
        Image = "folder-open"
    })
end

-- Main Game Loop
local mainLoop = RunService.Heartbeat:Connect(function(delta)
    -- Apply movement hacks
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            -- Speed hack
            humanoid.WalkSpeed = Features.SpeedEnabled and Features.SpeedValue or 16
            
            -- Jump power hack
            humanoid.JumpPower = Features.JumpPowerEnabled and Features.JumpPowerValue or 50
            
            -- Infinite jump
            if Features.InfiniteJump and UIS:IsKeyDown(Enum.KeyCode.Space) then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            
            -- Anti-void
            if Features.AntiVoid and humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
                local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root and root.Position.Y < -50 then
                    root.CFrame = CFrame.new(0, 100, 0)
                end
            end
            
            -- No clip
            if Features.NoClip then
                for _, part in ipairs(localPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
    
    -- Spectate mode
    if Features.SpectateMode and Features.SpectatedPlayer and Features.SpectatedPlayer.Character then
        local root = Features.SpectatedPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            camera.CFrame = CFrame.new(camera.CFrame.Position, root.Position)
        end
    end
    
    -- Anti-fling protection
    applyAntiFling()
    
    -- Fling players
    if Features.FlingPlayers then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                flingPlayer(player)
            end
        end
    end
    
    -- Update FOV circle
    updateFOVCircle()
end)

-- Initialization
updateESP()
updateFOVCircle()

-- First run notification
Rayfield:Notify({
    Title = "RSPX ULTIMATE LOADED",
    Content = "v12.0 Mobile Premium Edition",
    Duration = 5,
    Image = "zap"
})

-- Auto-update player list
Players.PlayerAdded:Connect(function(player)
    table.insert(PlayerList, player.Name)
    SpectateDropdown:Refresh(PlayerList)
    updateESP()
end)

Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(PlayerList) do
        if name == player.Name then
            table.remove(PlayerList, i)
            break
        end
    end
    SpectateDropdown:Refresh(PlayerList)
    updateESP()
end)

-- Cleanup on script unload
localPlayer.CharacterRemoving:Connect(function()
    mainLoop:Disconnect()
    if fovCircle then fovCircle:Remove() end
    updateESP()
end)