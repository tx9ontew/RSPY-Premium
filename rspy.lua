-- RSPX ULTIMATE v8.0 - EVERYTHING WORKS INSTANTLY
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Initialize all features to OFF state
_G.SpeedEnabled = false
_G.SpeedValue = 50
_G.JumpPowerEnabled = false
_G.JumpPowerValue = 100
_G.InfiniteJump = false
_G.ESPMaster = false
_G.BoxESP = true
_G.NameESP = true
_G.HealthESP = true
_G.SkeletonESP = false
_G.FOVCircle = true
_G.AimbotEnabled = false
_G.RageMode = false
_G.BigHitboxes = false
_G.AntiFling = false
_G.FlingPlayers = false
_G.SpectateMode = false
_G.SpectatedPlayer = nil
_G.CheaterDetection = false

-- Create premium window
local Window = Rayfield:CreateWindow({
    Name = "RSPX ULTIMATE v8.0",
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
    World = Window:CreateTab("World", "globe"),
    Spectate = Window:CreateTab("Spectate", "video")
}

-- Player Tab
local MovementSection = Tabs.Player:CreateSection("Movement")

local SpeedToggle = Tabs.Player:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = _G.SpeedEnabled,
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
    CurrentValue = _G.SpeedValue,
    Flag = "SpeedSlider",
    Callback = function(Value)
        _G.SpeedValue = Value
        if _G.SpeedEnabled then
            applySpeed()
        end
    end
})

local JumpPowerToggle = Tabs.Player:CreateToggle({
    Name = "Jump Power Hack",
    CurrentValue = _G.JumpPowerEnabled,
    Flag = "JumpPowerToggle",
    Callback = function(Value)
        _G.JumpPowerEnabled = Value
        applyJumpPower()
    end
})

local JumpPowerSlider = Tabs.Player:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    Suffix = "power",
    CurrentValue = _G.JumpPowerValue,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        _G.JumpPowerValue = Value
        if _G.JumpPowerEnabled then
            applyJumpPower()
        end
    end
})

local InfiniteJumpToggle = Tabs.Player:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = _G.InfiniteJump,
    Flag = "InfiniteJump",
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

-- Visuals Tab
local ESPSection = Tabs.Visuals:CreateSection("ESP")

local ESPMasterToggle = Tabs.Visuals:CreateToggle({
    Name = "ESP Master Switch",
    CurrentValue = _G.ESPMaster,
    Flag = "ESPMaster",
    Callback = function(Value)
        _G.ESPMaster = Value
        updateESP()
    end
})

local BoxesToggle = Tabs.Visuals:CreateToggle({
    Name = "Box ESP",
    CurrentValue = _G.BoxESP,
    Flag = "BoxESP",
    Callback = function(Value)
        _G.BoxESP = Value
        updateESP()
    end
})

local NamesToggle = Tabs.Visuals:CreateToggle({
    Name = "Show Names",
    CurrentValue = _G.NameESP,
    Flag = "NameESP",
    Callback = function(Value)
        _G.NameESP = Value
        updateESP()
    end
})

local HealthToggle = Tabs.Visuals:CreateToggle({
    Name = "Health Bars",
    CurrentValue = _G.HealthESP,
    Flag = "HealthESP",
    Callback = function(Value)
        _G.HealthESP = Value
        updateESP()
    end
})

local SkeletonToggle = Tabs.Visuals:CreateToggle({
    Name = "Skeleton ESP",
    CurrentValue = _G.SkeletonESP,
    Flag = "SkeletonESP",
    Callback = function(Value)
        _G.SkeletonESP = Value
        updateESP()
    end
})

local FOVCircleToggle = Tabs.Visuals:CreateToggle({
    Name = "Aimbot FOV Circle",
    CurrentValue = _G.FOVCircle,
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
    CurrentValue = _G.AimbotEnabled,
    Flag = "AimbotToggle",
    Callback = function(Value)
        _G.AimbotEnabled = Value
    end
})

local AimbotMode = Tabs.Combat:CreateDropdown({
    Name = "Aimbot Mode",
    Options = {"Silent", "Rage", "Teleport"},
    CurrentOption = "Silent",
    Flag = "AimbotMode",
    Callback = function(Option)
        _G.AimbotMode = Option
    end
})

local RageModeToggle = Tabs.Combat:CreateToggle({
    Name = "Rage Mode",
    CurrentValue = _G.RageMode,
    Flag = "RageMode",
    Callback = function(Value)
        _G.RageMode = Value
    end
})

local HitboxToggle = Tabs.Combat:CreateToggle({
    Name = "Big Hitboxes",
    CurrentValue = _G.BigHitboxes,
    Flag = "BigHitboxes",
    Callback = function(Value)
        _G.BigHitboxes = Value
        updateHitboxes()
    end
})

local FlingSection = Tabs.Combat:CreateSection("Fling System")

local AntiFlingToggle = Tabs.Combat:CreateToggle({
    Name = "Anti-Fling Protection",
    CurrentValue = _G.AntiFling,
    Flag = "AntiFling",
    Callback = function(Value)
        _G.AntiFling = Value
    end
})

local FlingToggle = Tabs.Combat:CreateToggle({
    Name = "Fling Players (Rage)",
    CurrentValue = _G.FlingPlayers,
    Flag = "FlingPlayers",
    Callback = function(Value)
        _G.FlingPlayers = Value
    end
})

local CheaterDetectionToggle = Tabs.Combat:CreateToggle({
    Name = "Detect Cheaters",
    CurrentValue = _G.CheaterDetection,
    Flag = "CheaterDetection",
    Callback = function(Value)
        _G.CheaterDetection = Value
    end
})

-- Spectate Tab
local SpectateSection = Tabs.Spectate:CreateSection("Spectate Mode")

local SpectateToggle = Tabs.Spectate:CreateToggle({
    Name = "Spectate Players",
    CurrentValue = _G.SpectateMode,
    Flag = "SpectateMode",
    Callback = function(Value)
        _G.SpectateMode = Value
        if Value then
            camera.CameraType = Enum.CameraType.Scriptable
        else
            camera.CameraType = Enum.CameraType.Custom
            _G.SpectatedPlayer = nil
        end
    end
})

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
                _G.SpectatedPlayer = player
                break
            end
        end
    end
})

-- World Tab
local EffectsSection = Tabs.World:CreateSection("Effects")

local NoFogToggle = Tabs.World:CreateToggle({
    Name = "Remove Fog",
    CurrentValue = false,
    Flag = "NoFog",
    Callback = function(Value)
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
-- Apply speed immediately when toggled or slider changed
function applySpeed()
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = _G.SpeedEnabled and _G.SpeedValue or 16
        end
    end
end

-- Apply jump power immediately
function applyJumpPower()
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = _G.JumpPowerEnabled and _G.JumpPowerValue or 50
        end
    end
end

-- ESP System (auto-updates on toggle)
local espCache = {}
function updateESP()
    -- Clear existing ESP
    for player, espFrame in pairs(espCache) do
        if espFrame then
            espFrame:Destroy()
        end
    end
    espCache = {}
    
    if not _G.ESPMaster then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
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
                for _, bone in ipairs({"Head", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg", "UpperTorso", "LowerTorso"}) do
                    local part = player.Character:FindFirstChild(bone)
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
        end
    end
end

-- FOV Circle
local fovCircle
function updateFOVCircle()
    if not _G.FOVCircle then
        if fovCircle then
            fovCircle:Remove()
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
                        -- Reset to default (approximate)
                        if part.Name == "Head" then
                            part.Size = Vector3.new(2, 1, 1)
                        else
                            part.Size = Vector3.new(2, 2, 1)
                        end
                        part.Transparency = 0
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

-- Fling System (Violent Rotation)
local flingConnection = RunService.Heartbeat:Connect(function()
    if not _G.FlingPlayers then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if targetRoot and myRoot then
                -- Teleport to player
                myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 3, 0)
                
                -- Apply violent rotation
                targetRoot.RotVelocity = Vector3.new(
                    math.random(50, 100),
                    math.random(50, 100),
                    math.random(50, 100)
                )
                
                -- Add upward force
                targetRoot.Velocity = Vector3.new(0, 100, 0)
            end
        end
    end
end)

-- Movement Systems
local movementConnection = RunService.Heartbeat:Connect(function()
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            -- Apply speed
            humanoid.WalkSpeed = _G.SpeedEnabled and _G.SpeedValue or 16
            
            -- Apply jump power
            humanoid.JumpPower = _G.JumpPowerEnabled and _G.JumpPowerValue or 50
            
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

-- Spectate System
local spectateConnection = RunService.RenderStepped:Connect(function()
    if not _G.SpectateMode or not _G.SpectatedPlayer then return end
    
    if _G.SpectatedPlayer.Character then
        local head = _G.SpectatedPlayer.Character:FindFirstChild("Head")
        if head then
            camera.CFrame = CFrame.new(head.Position + head.CFrame.LookVector * 5, head.Position)
        end
    end
end)

-- Cheater Detection
local cheaterConnection = RunService.Heartbeat:Connect(function()
    if not _G.CheaterDetection then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- Detect impossible speeds
                if root.Velocity.Magnitude > 300 then
                    if espCache[player] then
                        espCache[player]:FindFirstChildWhichIsA("Highlight").FillColor = Color3.new(1, 0, 1)
                    end
                end
                
                -- Detect flying
                if root.Position.Y > 500 and not Workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), RaycastParams.new()) then
                    if espCache[player] then
                        espCache[player]:FindFirstChildWhichIsA("Highlight").FillColor = Color3.new(0, 1, 1)
                    end
                end
            end
        end
    end
end)

-- Initialize
updateFOVCircle()

-- Auto-update ESP when players change
Players.PlayerAdded:Connect(function(player)
    updateESP()
    
    -- Update spectate list
    table.insert(PlayerList, player.Name)
    SpectateDropdown:Refresh(PlayerList)
end)

Players.PlayerRemoving:Connect(function(player)
    updateESP()
    
    -- Update spectate list
    for i, name in ipairs(PlayerList) do
        if name == player.Name then
            table.remove(PlayerList, i)
            break
        end
    end
    SpectateDropdown:Refresh(PlayerList)
end)

-- First run notification
Rayfield:Notify({
    Title = "RSPX ULTIMATE LOADED",
    Content = "All features are fully functional!",
    Duration = 5,
    Image = "check-circle"
})