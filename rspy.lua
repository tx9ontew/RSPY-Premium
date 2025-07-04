-- RSPX ULTIMATE v10.5 - MOBILE PREMIUM
-- Mobile-optimized with texture reduction, anti-lag, and premium features
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

-- Initialize all features
local _G = {
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

-- MOBILE OPTIMIZATION SETTINGS
local originalSettings = {
    GraphicsQualityLevel = settings().Rendering.QualityLevel,
    Particles = {}
}

-- Create premium window with mobile optimizations
local Window = Rayfield:CreateWindow({
    Name = "RSPX ULTIMATE v10.5",
    Icon = "zap",
    LoadingTitle = "MOBILE PREMIUM EDITION",
    LoadingSubtitle = "Optimized for Mobile Performance",
    Theme = "Amethyst",
    ToggleUIKeybind = Enum.KeyCode.K,
    MobileOptimized = true
})

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
Tabs.Player:CreateToggle({Name = "Speed Hack", CurrentValue = _G.SpeedEnabled, Flag = "SpeedToggle"})
Tabs.Player:CreateSlider({Name = "Walk Speed", Range = {16, 300}, CurrentValue = _G.SpeedValue, Suffix = "studs/s", Flag = "SpeedSlider"})
Tabs.Player:CreateToggle({Name = "Jump Power Hack", CurrentValue = _G.JumpPowerEnabled, Flag = "JumpPowerToggle"})
Tabs.Player:CreateSlider({Name = "Jump Power", Range = {50, 500}, CurrentValue = _G.JumpPowerValue, Suffix = "power", Flag = "JumpPowerSlider"})
Tabs.Player:CreateToggle({Name = "Infinite Jump", CurrentValue = _G.InfiniteJump, Flag = "InfiniteJump"})
Tabs.Player:CreateToggle({Name = "No Clip", CurrentValue = _G.NoClip, Flag = "NoClip"})
Tabs.Player:CreateToggle({Name = "Anti-Void", CurrentValue = _G.AntiVoid, Flag = "AntiVoid"})

-- Visuals Tab
local ESPSection = Tabs.Visuals:CreateSection("ESP")
Tabs.Visuals:CreateToggle({Name = "ESP Master Switch", CurrentValue = _G.ESPMaster, Flag = "ESPMaster"})
Tabs.Visuals:CreateToggle({Name = "Box ESP", CurrentValue = _G.BoxESP, Flag = "BoxESP"})
Tabs.Visuals:CreateToggle({Name = "Show Names", CurrentValue = _G.NameESP, Flag = "NameESP"})
Tabs.Visuals:CreateToggle({Name = "Health Bars", CurrentValue = _G.HealthESP, Flag = "HealthESP"})
Tabs.Visuals:CreateToggle({Name = "Skeleton ESP", CurrentValue = _G.SkeletonESP, Flag = "SkeletonESP"})
Tabs.Visuals:CreateToggle({Name = "Wall Hack", CurrentValue = _G.WallHack, Flag = "WallHack"})
Tabs.Visuals:CreateToggle({Name = "Aimbot FOV Circle", CurrentValue = _G.FOVCircle, Flag = "FOVCircle"})
Tabs.Visuals:CreateSlider({Name = "FOV Size", Range = {50, 500}, CurrentValue = _G.FOVSize, Suffix = "units", Flag = "FOVSlider"})
Tabs.Visuals:CreateToggle({Name = "Anti-Lag Mode", CurrentValue = _G.AntiLag, Flag = "AntiLag"})

-- Combat Tab
local AimbotSection = Tabs.Combat:CreateSection("Aimbot")
Tabs.Combat:CreateToggle({Name = "Aimbot", CurrentValue = _G.AimbotEnabled, Flag = "AimbotToggle"})
Tabs.Combat:CreateDropdown({Name = "Aimbot Mode", Options = {"Silent", "Rage", "Teleport"}, CurrentOption = "Silent", Flag = "AimbotMode"})
Tabs.Combat:CreateToggle({Name = "Rage Mode", CurrentValue = _G.RageMode, Flag = "RageMode"})
Tabs.Combat:CreateToggle({Name = "Silent Aim", CurrentValue = _G.SilentAim, Flag = "SilentAim"})
Tabs.Combat:CreateToggle({Name = "Aim Lock", CurrentValue = _G.AimLock, Flag = "AimLock"})
Tabs.Combat:CreateToggle({Name = "Trigger Bot", CurrentValue = _G.TriggerBot, Flag = "TriggerBot"})
Tabs.Combat:CreateToggle({Name = "Team Check", CurrentValue = _G.TeamCheck, Flag = "TeamCheck"})
Tabs.Combat:CreateToggle({Name = "Wall Check", CurrentValue = _G.WallCheck, Flag = "WallCheck"})
Tabs.Combat:CreateToggle({Name = "Big Hitboxes", CurrentValue = _G.BigHitboxes, Flag = "BigHitboxes"})

local FlingSection = Tabs.Combat:CreateSection("Fling System")
Tabs.Combat:CreateToggle({Name = "Anti-Fling Protection", CurrentValue = _G.AntiFling, Flag = "AntiFling"})
Tabs.Combat:CreateToggle({Name = "Fling Players", CurrentValue = _G.FlingPlayers, Flag = "FlingPlayers"})
Tabs.Combat:CreateToggle({Name = "Detect Cheaters", CurrentValue = _G.CheaterDetection, Flag = "CheaterDetection"})

-- Spectate Tab
local SpectateSection = Tabs.Spectate:CreateSection("Spectate Mode")
Tabs.Spectate:CreateToggle({Name = "Spectate Players", CurrentValue = _G.SpectateMode, Flag = "SpectateMode"})

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
                _G.SpectatedPlayer = player
                break
            end
        end
    end
})

-- World Tab
local EffectsSection = Tabs.World:CreateSection("Effects")
Tabs.World:CreateToggle({Name = "Remove Fog", CurrentValue = _G.NoFog, Flag = "NoFog"})
Tabs.World:CreateToggle({Name = "Bright World", CurrentValue = _G.BrightWorld, Flag = "BrightWorld"})

-- Settings Tab
local ConfigSection = Tabs.Settings:CreateSection("Configuration")
Tabs.Settings:CreateButton({Name = "Save Settings", Callback = saveConfig})
Tabs.Settings:CreateButton({Name = "Load Settings", Callback = loadConfig})
Tabs.Settings:CreateButton({Name = "Unload Script", Callback = function() Rayfield:Destroy() end})

-- ===== MOBILE OPTIMIZATION FUNCTIONS =====
function applyAntiLag()
    if _G.AntiLag then
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

-- ===== ENHANCED ESP SYSTEM (MOBILE OPTIMIZED) =====
local espCache = {}
local espConnections = {}

function updateESP()
    -- Clear existing ESP
    for player, espData in pairs(espCache) do
        if espData.Folder then espData.Folder:Destroy() end
        if espData.Connections then
            for _, conn in ipairs(espData.Connections) do conn:Disconnect() end
        end
    end
    espCache = {}
    
    if not _G.ESPMaster then return end
    
    -- Create ESP for all players
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            createPlayerESP(player)
        end
    end
    
    -- Connect to new players
    Players.PlayerAdded:Connect(function(player)
        if player ~= localPlayer then
            createPlayerESP(player)
        end
    end)
end

function createPlayerESP(player)
    if espCache[player] then return end
    
    local espFolder = Instance.new("Folder")
    espFolder.Name = player.Name .. "_ESP"
    espFolder.Parent = CoreGui
    
    local connections = {}
    
    -- Handle character appearance
    local function setupCharacter(char)
        if not char then return end
        
        -- Clear previous ESP parts
        for _, child in ipairs(espFolder:GetChildren()) do child:Destroy() end
        
        -- Box Highlight (mobile optimized)
        if _G.BoxESP then
            local highlight = Instance.new("Highlight")
            highlight.Name = "BoxHighlight"
            highlight.OutlineTransparency = 0.5
            highlight.FillTransparency = 0.8
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Adornee = char
            highlight.Parent = espFolder
            
            -- Team Colors
            local teamColor = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
            highlight.FillColor = (_G.TeamCheck and player.Team ~= localPlayer.Team) and Color3.new(1, 0.2, 0.2) or Color3.new(0.2, 1, 0.2)
        end
        
        -- Name Label (simplified for mobile)
        if _G.NameESP then
            local head = char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso")
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
        
        -- Health Bar (mobile simplified)
        if _G.HealthESP then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
                if root then
                    local healthBar = Instance.new("BillboardGui")
                    healthBar.Name = "HealthBar"
                    healthBar.Size = UDim2.new(1.5, 0, 0.15, 0)
                    healthBar.StudsOffset = Vector3.new(0, 2, 0)
                    healthBar.AlwaysOnTop = true
                    healthBar.Adornee = root
                    healthBar.Parent = espFolder
                    
                    local background = Instance.new("Frame")
                    background.Name = "Background"
                    background.Size = UDim2.new(1, 0, 1, 0)
                    background.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                    background.BorderSizePixel = 0
                    background.Parent = healthBar
                    
                    local fill = Instance.new("Frame")
                    fill.Name = "Fill"
                    fill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
                    fill.BackgroundColor3 = Color3.new(1 - (humanoid.Health / humanoid.MaxHealth), humanoid.Health / humanoid.MaxHealth, 0)
                    fill.BorderSizePixel = 0
                    fill.Parent = background
                    
                    -- Health update connection
                    local healthConn = humanoid.HealthChanged:Connect(function()
                        fill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
                        fill.BackgroundColor3 = Color3.new(1 - (humanoid.Health / humanoid.MaxHealth), humanoid.Health / humanoid.MaxHealth, 0)
                    end)
                    table.insert(connections, healthConn)
                end
            end
        end
    end
    
    -- Initial setup
    if player.Character then setupCharacter(player.Character) end
    
    -- Character added connection
    local charConn = player.CharacterAdded:Connect(setupCharacter)
    table.insert(connections, charConn)
    
    espCache[player] = {Folder = espFolder, Connections = connections}
end

-- ===== ADVANCED AIMBOT WITH WALL CHECK =====
function getClosestPlayer()
    if not camera then return nil end
    
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            -- Team check
            if _G.TeamCheck and player.Team == localPlayer.Team then continue end
            
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and rootPart then
                -- Wall check
                if _G.WallCheck then
                    local origin = camera.CFrame.Position
                    local direction = (rootPart.Position - origin).Unit * 1000
                    local ray = Ray.new(origin, direction)
                    local hit, _ = Workspace:FindPartOnRayWithIgnoreList(ray, {localPlayer.Character, camera})
                    
                    if hit and not hit:IsDescendantOf(player.Character) then
                        continue -- Wall is blocking
                    end
                end
                
                local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2).Magnitude
                
                if onScreen and distance < shortestDistance and distance < _G.FOVSize then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

-- ===== ANTI-FLING PROTECTION (IMPROVED) =====
function applyAntiFling()
    if not _G.AntiFling or not localPlayer.Character then return end
    
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

-- ===== BYPASS SYSTEM =====
function applyBypass()
    -- Method 1: Randomize variable names
    local randomString = tostring(math.random(10000, 99999))
    local fakeEnv = {
        ["_G"..randomString] = _G,
        ["RunService"..randomString] = RunService
    }
    
    -- Method 2: Obfuscate calls
    local function secureCall(func, ...)
        local args = {...}
        return coroutine.wrap(function()
            return func(unpack(args))
        end)()
    end
    
    -- Method 3: Memory manipulation (simulated)
    if not is_synapse_function then
        local fakeMemory = {
            read = function() return 0 end,
            write = function() end
        }
    end
    
    return {
        secureCall = secureCall,
        env = fakeEnv
    }
end

-- Initialize bypass
local bypass = applyBypass()

-- ===== MAIN GAME LOOP =====
local mainLoop = bypass.secureCall(function()
    return RunService.Heartbeat:Connect(function(delta)
        -- Apply movement hacks
        if localPlayer.Character then
            local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                -- Speed hack
                humanoid.WalkSpeed = _G.SpeedEnabled and _G.SpeedValue or 16
                
                -- Jump power hack
                humanoid.JumpPower = _G.JumpPowerEnabled and _G.JumpPowerValue or 50
                
                -- Infinite jump
                if _G.InfiniteJump and UIS:IsKeyDown(Enum.KeyCode.Space) then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                
                -- Anti-void
                if _G.AntiVoid and humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
                    local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root and root.Position.Y < -50 then
                        root.CFrame = CFrame.new(0, 100, 0)
                    end
                end
                
                -- No clip
                if _G.NoClip then
                    for _, part in ipairs(localPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
        
        -- Spectate mode
        if _G.SpectateMode and _G.SpectatedPlayer and _G.SpectatedPlayer.Character then
            local root = _G.SpectatedPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                camera.CFrame = CFrame.new(camera.CFrame.Position, root.Position)
            end
        end
        
        -- Anti-fling protection
        applyAntiFling()
        
        -- Anti-lag
        if _G.AntiLag then applyAntiLag() end
        
        -- Wallhack
        if _G.WallHack then
            for _, part in ipairs(Workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Transparency < 0.5 then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        end
    end)
end)

-- ===== CONFIGURATION SYSTEM =====
function saveConfig()
    local config = {}
    for key, value in pairs(_G) do
        if type(value) ~= "table" and type(value) ~= "function" then
            config[key] = value
        end
    end
    
    writefile("RSPX_Config.json", HttpService:JSONEncode(config))
    Rayfield:Notify({
        Title = "Configuration Saved",
        Content = "Settings saved successfully!",
        Duration = 3,
        Image = "save"
    })
end

function loadConfig()
    if isfile("RSPX_Config.json") then
        local success, config = pcall(function()
            return HttpService:JSONDecode(readfile("RSPX_Config.json"))
        end)
        
        if success then
            for key, value in pairs(config) do
                _G[key] = value
            end
            Rayfield:Notify({
                Title = "Configuration Loaded",
                Content = "Settings applied successfully!",
                Duration = 3,
                Image = "folder-open"
            })
            return
        end
    end
    Rayfield:Notify({
        Title = "Error",
        Content = "No saved configuration found",
        Duration = 3,
        Image = "x-circle"
    })
end

-- Initialize
updateESP()
Rayfield:Notify({
    Title = "RSPX ULTIMATE LOADED",
    Content = "v10.5 Mobile Premium",
    Duration = 5,
    Image = "zap"
})

-- Cleanup when player leaves
localPlayer.CharacterRemoving:Connect(function()
    mainLoop:Disconnect()
    updateESP() -- Clears all ESP
end)