local success, ZyphraxHub = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/nyzxhub-rblx/LexsUi/refs/heads/main/testown/uizyphrax.lua"))()
end)

if not success or not ZyphraxHub then
    return
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local VirtualUser = game:GetService("VirtualUser")  
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local zones = Workspace:WaitForChild("zones")
local fishing = zones:WaitForChild("fishing")

local NPCFolder = workspace:WaitForChild("world"):WaitForChild("npcs")
local Remote = game:GetService("ReplicatedStorage").packages.Net["RE/SpearFishing/Minigame"]
local Net = require(ReplicatedStorage.packages.Net)
local CastRemote = Net:RemoteFunction("FishingRod/Cast", -1)

local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local req = request or http_request or syn.request

local gameInfo
local okInfo, errInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if okInfo and type(errInfo) == "table" and errInfo.Name then
    gameInfo = errInfo
else
    gameInfo = { Name = "Game" }
end

local GameName = tostring(gameInfo.Name or "Game")

local Window = ZyphraxHub:Window({
    Title = "ZyphraxHub | Best Script", -- Main title displayed at the top of the window
    Footer = "Premium Version", -- Footer text shown at the bottom
    Content = "SCRIPT: "..GameName,
    Color = "Magenta", -- UI theme color (Default or custom theme)
    Version = 1.0,
    ["Tab Width"] = 120, -- Width size of the tab section
    Image = "112084242645330", -- Window icon asset ID (replace with your own)
    Configname = "ZyphraxHub", -- Configuration file name for saving settings
    Uitransparent = 0.15, -- UI transparency (0 = solid, 1 = fully transparent)
    ShowUser = false,
    Search = true, 
    Animation = true,                 -- Efek typewriter pada Title & Footer
    TypeDelay = 0.07,                  -- Jeda antar karakter (detik)
    TypePause = 2.5,                   -- Jeda setelah teks selesai (detik) 
    DiscordSet = {
        Enable = true,
        Title  = "Zyphrax HUB",
        Link   = "https://discord.gg/zyphraxhub",
        Icon   = "112084242645330", 
    },
    Config = {
        AutoSave = false,
        AutoLoad = false,
    },
})

if Window then
    Nt("Window loaded!")
end

local function ZyphraxHub(msg)
    ZyphraxHub:MakeNotify({
        Title       = "Zyphrax Hub",
        Description = "Notification",
        Content     = msg or "Content",
        Color       = "Default",
        Time        = 0.5,
        Delay       = 5,
        Icon        = "rbxassetid://112084242645330"
    })
end

local UIS = game:GetService("UserInputService")

local device = "PC"
local color = Color3.fromRGB(0, 255, 255)
local icon = "lucide:monitor"

if UIS.TouchEnabled and not UIS.KeyboardEnabled then
    device = "Mobile"
    color = Color3.fromRGB(0, 170, 255)
    icon = "lucide:smartphone"
elseif UIS.GamepadEnabled then
    device = "Console"
    color = Color3.fromRGB(170, 85, 255)
    icon = "lucide:gamepad-directional"
end

local executorName = "Unknown"
pcall(function()
    if identifyexecutor then
        executorName = identifyexecutor()
    end
end)

local startTime = tick()

local function formatTime(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = math.floor(sec % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

local tag = Window:Tag({
    Title = executorName .. " | 00:00:00 | " .. device,
    Color = color,
    Icon = icon
})

task.spawn(function()
    while true do
        task.wait(1)

        local elapsed = tick() - startTime
        local newText = executorName .. " | " .. formatTime(elapsed) .. " | " .. device

        if tag and tag.SetTitle then
            tag:SetTitle(newText)
        end
    end
end)

local ReelController = require(
    ReplicatedStorage.client.legacyControllers.ReelController
)

local NotificationDelay = 6
local stack = {}

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local holder = Instance.new("Frame")
holder.BackgroundTransparency = 1
holder.Size = UDim2.new(0,260,1,0)
holder.Position = UDim2.new(0,10,0,0)
holder.Parent = gui


local function createNotif(name,mutation,weight)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,240,0,80)
    frame.Position = UDim2.new(0,-260,0.5,-40)
    frame.BackgroundColor3 = Color3.fromRGB(22,22,28)
    frame.BorderSizePixel = 0
    frame.Parent = holder
    frame.ZIndex = #stack + 1
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)

    local border = Instance.new("Frame")
    border.Size = UDim2.new(1,4,1,4)
    border.Position = UDim2.new(0,-2,0,-2)
    border.BackgroundTransparency = 1
    border.ZIndex = frame.ZIndex - 1
    border.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(140, 0, 255)
    stroke.Parent = frame

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(140, 0, 255)),
        ColorSequenceKeypoint.new(0.5,Color3.fromRGB(162, 0, 212)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255))
    }
    gradient.Parent = frame

    task.spawn(function()
        while frame.Parent do
            gradient.Rotation += 2
            task.wait()
        end
    end)

    local function dot(x,c)
        local d = Instance.new("Frame")
        d.Size = UDim2.new(0,8,0,8)
        d.Position = UDim2.new(0,x,0,8)
        d.BackgroundColor3 = c
        d.BorderSizePixel = 0
        d.ZIndex = frame.ZIndex + 1
        d.Parent = frame
        Instance.new("UICorner",d).CornerRadius = UDim.new(1,0)
    end

    dot(10,Color3.fromRGB(255,95,86))
    dot(24,Color3.fromRGB(255,189,46))
    dot(38,Color3.fromRGB(39,201,63))

    local fishLabel = Instance.new("TextLabel")
    fishLabel.BackgroundTransparency = 1
    fishLabel.Position = UDim2.new(0,10,0,22)
    fishLabel.Size = UDim2.new(1,-20,0,20)
    fishLabel.Font = Enum.Font.GothamBold
    fishLabel.TextSize = 15
    fishLabel.TextColor3 = Color3.new(1,1,1)
    fishLabel.TextXAlignment = Enum.TextXAlignment.Left
    fishLabel.Text = "🐟 "..name
    fishLabel.ZIndex = frame.ZIndex + 1
    fishLabel.Parent = frame

    local mutationLabel = fishLabel:Clone()
    mutationLabel.Position = UDim2.new(0,10,0,42)
    mutationLabel.Font = Enum.Font.Gotham
    mutationLabel.TextSize = 12
    mutationLabel.TextColor3 = Color3.fromRGB(180,180,180)
    mutationLabel.Text = "Mutation: "..mutation
    mutationLabel.Parent = frame

    local weightLabel = mutationLabel:Clone()
    weightLabel.Position = UDim2.new(0,10,0,58)
    weightLabel.TextColor3 = Color3.fromRGB(200,200,200)
    weightLabel.Text = "Weight: "..weight
    weightLabel.Parent = frame

    table.insert(stack, frame)

    TweenService:Create(frame,TweenInfo.new(0.25),
        {Position = UDim2.new(0,20,0.5,-40)}
    ):Play()

    task.delay(NotificationDelay,function()
        TweenService:Create(frame,TweenInfo.new(0.25),
            {Position = UDim2.new(0,-260,0.5,-40)}
        ):Play()
        task.wait(0.3)
        frame:Destroy()
    end)
end


local LastReel = nil

task.spawn(function()
    while true do
        task.wait()

        local reel = ReelController.ActiveReel
        if reel and reel ~= LastReel then
            LastReel = reel

            if not reel.fish then
                reel.OnLoad:Wait()
            end

            local fish     = reel.fish
            local name     = fish.Name or "Unknown"
            local kg       = fish.Weight or fish.Kg or fish.weight or "?"
            local mutation = fish.Mutation or fish.mutation or fish.variant or "None"

            local kgDisplay = type(kg) == "number"
                and string.format("%.2f kg", kg)
                or tostring(kg) .. " kg"

            createNotif(name, tostring(mutation), kgDisplay)
        end
    end
end)

local Tabs = {
    Info = Window:AddTab({ Name = "Info", Icon = "player" }),
    Stat = Window:AddTab({ Name = "Stats", Icon = "user" }),
    Main = Window:AddTab({ Name = "Main", Icon = "fish" }),
    Auto = Window:AddTab({ Name = "Auto", Icon = "lucide:refresh-ccw" }),
    Shop = Window:AddTab({ Name = "Shop", Icon = "lucide:store" }),
    Webhook = Window:AddTab({ Name = "Webhook", Icon = "lucide:webhook" }),
    Teleport = Window:AddTab({ Name = "Teleport", Icon = "gps" }),
    Misc = Window:AddTab({ Name = "Misc", Icon = "settings" }),
    Config = Window:AddTab({ Name = "Config", Icon = "lucide:file-check" })
}

v1 = Tabs.Info:AddSection({ Title = "Info", Icon = "discord", Open = true })

v1:AddParagraph({
    Title = "Join Our Discord",
    Content = "Join Us!",
    Icon = "rbxassetid://94434236999817",  -- ganti ICON_ID dengan ID asset sebenarnya
    Color = Color3.fromRGB(130, 0, 237),
    ButtonText = "Copy Discord",
    ButtonCallback = function()
        local link = "https://discord.gg/zyphraxhub"
        if setclipboard then
            setclipboard(link)
            Nt("Successfully Copied!")
        end
    end
})

v1:AddParagraph({
    Title   = "READ THIS!!",
    Content = "This script is still under development. \nso there are still many features that don't exist yet. \njoin the discord to find out the updates",
    Icon    = "alert",
    Color = Color3.fromRGB(255, 0, 30),
})

v2 = Tabs.Info:AddSection({ Title = "Info Event", Icon = "134574136621718", Open = true })

local eventList = {
    "Dreadfin Hunt",
    "Baby Bloop Fish",
    "Bloop Fish",
    "Whales Pool",
    "Orcas Pool",
    "The Kraken Pool",
    "Ancient Depth Serpent",
    "Animal Pool",
    "Plesiosaur Hunt",
    "Goldwraith Hunt",
    "Reef Titan Hunt",
    "Sunken Reliquary",
    "Omnithal Hunt",
    "Animal Pool - Second Sea",
    "Octophant Pool Withe Elephant",
    "Sea Leviathan Pool",
    "Isonade",
    "Forsaken Veil - Scylla",
    "Blue Moon - Second Sea",
    "Blue Moon - First Sea",
    "Great White Shark",
    "LEGO",
    "LEGO - Studiodon",
    "Mosslurker",
    "Narwhal",
    "Whale Shark",
    "Birthday Megalodon",
    "Colossal Blue Dragon",
    "Colossal Ancient Dragon",
    "Colossal Ethereal Dragon",
    "Megalodon Ancient",
    "Megalodon Default",
    "Megalodon Phantom",
    "Skeletal Leviathan Hunt",
    "Pliosaur Hunt",
    "Toxic Boil",
    "Flower Guardian Hunt"
}

local paragraph = v2:AddParagraph({
    Title = "Active Event",
    Content = "Loading..."
})

local function updateUI()
    local content = ""

    for _,eventName in ipairs(eventList) do
        local found = fishing:FindFirstChild(eventName)
        content = content .. eventName .. " : " .. (found and "✅" or "❌") .. "\n"
    end

    paragraph:SetContent(content)
end

fishing.ChildAdded:Connect(updateUI)
fishing.ChildRemoved:Connect(updateUI)

updateUI()

v3 = Tabs.Stat:AddSection({ Title = "Stats Player", Icon = "18351727024", Open = true })

local avatar = select(1, Players:GetUserThumbnailAsync(
    LocalPlayer.UserId,
    Enum.ThumbnailType.HeadShot,
    Enum.ThumbnailSize.Size420x420
))

local paragraph = v3:AddParagraph({
    Title = LocalPlayer.Name.." Stats",
    Content = "Loading...",
    Badge   = "New", 
    MediaType = "Image",
    MediaId = avatar,
    ImageSize = 160
})

task.spawn(function()
    while task.wait(1) do

        local function getStats()
            local statsFolder = workspace:FindFirstChild("PlayerStats")
            if not statsFolder then return end

            local playerStats = statsFolder:FindFirstChild(LocalPlayer.Name)
            if not playerStats then return end

            local stats = playerStats:FindFirstChild("T") and playerStats.T:FindFirstChild(LocalPlayer.Name)
            stats = stats and stats:FindFirstChild("Stats")

            return stats
        end

        local stats = getStats()

        local level, xp, money, streak = 0,0,0,0
        local trackersecretcaught, trackermythicalcaught, trackerexoticcaught = 0,0,0
        local trackerenchanted = 0
        local trackerfishcaught, trackerperfectcatches, trackerlargest = 0,0,0
        local fishcaughtlast, trackertimeplayed = 0,0
        local spawnlocation, rod = "None","None"

        if stats then
            local function getVal(n,d)
                local v = stats:FindFirstChild(n)
                return v and v.Value or d
            end

            level = getVal("realLevel",0)
            xp = getVal("xp",0)
            money = getVal("coins",0)
            streak = getVal("tracker_streak",0)

            trackersecretcaught = getVal("tracker_secretcaught",0)
            trackermythicalcaught = getVal("tracker_mythicalcaught",0)
            trackerexoticcaught = getVal("tracker_exoticcaught",0)
            trackerenchanted = getVal("tracker_enchanted",0)

            trackerfishcaught = getVal("tracker_fishcaught",0)
            trackerperfectcatches = getVal("tracker_perfectcatches",0)
            trackerlargest = getVal("tracker_largest",0)
            fishcaughtlast = getVal("FishCaughtLastSession",0)
            trackertimeplayed = getVal("tracker_timeplayed",0)

            spawnlocation = tostring(getVal("spawnlocation","None"))
            rod = tostring(getVal("rod","None"))
        end

        local bobberName = "None"
        local bobberFolder = LocalPlayer:FindFirstChild("bobber")
        if bobberFolder then
            for _,v in pairs(bobberFolder:GetChildren()) do
                if v:IsA("BoolValue") and v.Value then
                    bobberName = v.Name
                    break
                end
            end
        end

        local enchantName = "None"
        if stats then
            local enchFolder = stats:FindFirstChild("enchants")
                or stats:FindFirstChild("enchant")
                or stats:FindFirstChild("Enchant")

            if enchFolder then
                for _,v in pairs(enchFolder:GetChildren()) do
                    if v:IsA("BoolValue") and v.Value then
                        enchantName = v.Name
                        break
                    end
                end
            end
        end

        paragraph:SetContent(
            "Level : "..level..
            "\nXP : "..xp..
            "\nCoins : "..money..
            "\nStreak : "..streak..
            "\nTime Played : "..trackertimeplayed..
            "\n\nFish : "..trackerfishcaught..
            "\nPerfect : "..trackerperfectcatches..
            "\nLargest : "..trackerlargest..
            "\nLast : "..fishcaughtlast..
            "\n\nSecret : "..trackersecretcaught..
            "\nMythical : "..trackermythicalcaught..
            "\nExotic : "..trackerexoticcaught..
            "\nEnchant : "..trackerenchanted..
            "\nEnchant : "..enchantName..
            "\n\nRod : "..rod..
            "\nSpawn : "..spawnlocation..
            "\nBobber : "..bobberName
        )

    end
end)

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)

LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart", 10)
end)

LocalPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- STATE
local autoCastEnabled = false
local autoReelEnabled = false
local autoReelLegitEnabled = false
local autoShakeEnabled = false
local antiAfkEnabled = false
local autoSellEnabled = false
local WebhookEnabled = false
local EnableMention = false
local CensorUsername = false
local autoEquipEnabled = false
local autoShakeLiteEnabled = false
local ClickTP = false
local InfZoomEnabled = false
local InfiniteJumpEnabled = false
local UseWalkSpeed = false
local UseJumpPower = false
local NoClipEnabled = false
local RenderDisabled = false
local FreezeEnabled = false
local InstantBob = false
local RadarEnabled = false
local NPCESPEnabled = false
local AutoClick = false
local BarEnabled = false
local ProgressEnabled = false
local UseBrightness = false
local UIVisible = true
local FlyEnabled = false
local dupefish = false
local WebDCEnable = false
local FullBrightEnabled = false
local HideEnabled = false
local ZoneESPEnabled = false
local centerShake = false
local WalkOnWaterEnabled = false
local TPEnabled = false
local isCasting = false
local Reduced = false
local DisableAnimation = false
local ESPEnabled = false
local AutoTotem = false
local AutoReelToggle = false

local animConn
local FreezeConnection
local LockedCFrame
local BV, BG
local FlyConnection
local gpsConnection
local gpsLabel
local CurrentButton
local ClickTPConnection
local SelectedPlayer
local playerDropdown
local SelectedNPC
local svdropdown
local npcDropdown
local InputUserId
local areadropdown
local SelectedUserId
local BypassGpsLoop
local XyzClone

local SavedTransparency = {}
local SavedPositions = {}
local ESPObjects = {}
local NPCESPObjects = {}
local ZoneESPObjects = {}
local zoneMap = {}
local Saved = {}
local startTime = tick()

local castMode = "Random"
local shakeMode = "Mouse"
local ReelMode = "Fast"
local SelectedZone = "Ocean"
local selectedSpearZone = "Lost Jungle"
local WebhookURL = ""
local MentionID = ""
local InputName = ""
local webhookName = "Zyphrax Hub"
local webhookAvatar = "https://cdn.discordapp.com/attachments/1494647762904547458/1494656281091244122/logo.png?ex=69e366a2&is=69e21522&hm=4babdfd78778a78ef5f649e7914b909c85478916ac9e2974dcdbcd4ecde78bb7"
local SelectedPos = nil
local selectedZone = nil
local SelectedEvent = nil
local crateType = nil
local SelectTotem = nil
local SelectedDayTotem = nil
local SelectedNightTotem = nil
local isDay = nil
local crateAmount = 1
local TotemAmmount = 1
local ProgressValue = 100
local castCooldown = 0
local BarValue = 0.05
local autoSellDelay = 60
local Send Delay = 60
local WalkSpeedValue = 16
local ClickDelay = 0
local JumpPowerValue = 50
local BrightnessValue = 2
local Height = 5
local FlySpeed = 50
local Forward = 0 -- 1 = W, -1 = S

local CurrentTool = nil
local ZoneFishOrigin = nil
local State = {
    GettingMeteor = false,
    LastToolReset = os.clock(),
    ToolResetCooldown = 5,
}

local Coroutines = {
    InstantBob = nil,
}

local spearZones = {
    ["Lost Jungle"]   = CFrame.new(-2843.530, 128.935, -2155.380),
    ["Coral Bastion"] = CFrame.new(2597.930, -1102.881, 872.260),
    ["Tidefall"]      = CFrame.new(3000.220, -1110.207, 774.120),
    ["Colapse Ruin"]  = CFrame.new(3085.120, -1133.904, 1737.090),
    ["Crowned Ruins"] = CFrame.new(3050.450, -1137.821, 2062.730)
}

local TotemList = {
    "Aurora Totem",
    "Sundial Totem",
    "Eclipse Totem",
    "Meteor Totem",
    "Tempest Totem",
    "Windset Totem",
    "Avalanche Totem",
    "Blizzard Totem",
    "Bloom Totem",
    "Blue Moon Totem",
    "Clearcast Totem",
    "Colossal Dragon Hunt Totem",
    "Cursed Storm Totem",
    "Dripstone Collapse Totem",
    "Frightful Pool Totem",
    "Frost Moon Totem",
    "Kraken Hunt Totem",
    "Megalodon Hunt Totem",
    "Mutation Totem",
    "Poseidon Wrath Totem",
    "Rainbow Totem",
    "Scylla Hunt Totem",
    "Shiny Totem",
    "Smokescreen Totem",
    "Sparkling Totem",
    "Starfall Totem",
    "Windest Totem",
    "Zeus Storm Totem"
}

local function getCharacter()
    if character and character.Parent then
        return character
    end
    local newChar = LocalPlayer.Character
    if newChar and newChar.Parent then
        character = newChar
        humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    end
    return character
end

local function getRod()
	local Character = LocalPlayer.Character
	local Backpack = LocalPlayer:FindFirstChild("Backpack")

	if Character then
		for _,v in pairs(Character:GetChildren()) do
			if v:IsA("Tool") and v:FindFirstChild("events") then
				return v
			end
		end
	end

	if Backpack then
		for _,v in pairs(Backpack:GetChildren()) do
			if v:IsA("Tool") and v:FindFirstChild("events") then
				return v
			end
		end
	end
end

local function autoEquipRod()
	task.spawn(function()
		while autoEquipEnabled do
			task.wait(0.2)

			local Character = LocalPlayer.Character
			if not Character then continue end

			local Humanoid = Character:FindFirstChild("Humanoid")
			if not Humanoid then continue end

			local Rod = getRod()
			if Rod and Rod.Parent ~= Character then
				pcall(function()
					Humanoid:EquipTool(Rod)
				end)
			end
		end
	end)
end

local function autoCastLoop()
    task.spawn(function()
        while autoCastEnabled do
            local rod = getRod()
            if rod and not rod:FindFirstChild("bobber") then

                local power
                if castMode == "Perfect" then
                    power = 100
                else
                    power = math.random(50, 100)
                end

                pcall(function()
                    CastRemote:InvokeServer(power, true)
                end)

            end
            task.wait()
        end
    end)
end

local function startInstantBob()
    if Coroutines.InstantBob then return end

    Coroutines.InstantBob = coroutine.create(function()
        while InstantBob do
            task.wait(0.001)

            pcall(function()
                local rod = getRod()
                local characterNow = LocalPlayer.Character
                local hrp = characterNow and characterNow:FindFirstChild("HumanoidRootPart")
                local bobber = rod and rod:FindFirstChild("bobber")
                if hrp and bobber and bobber:IsA("BasePart") then
                    bobber.CFrame = hrp.CFrame - Vector3.new(0, 5, 0)
                end
            end)
        end

        Coroutines.InstantBob = nil
    end)

    coroutine.resume(Coroutines.InstantBob)
end

local reelHooked = false

local function setupAutoReel()
    if reelHooked then return end
    reelHooked = true

    task.spawn(function()
        local clientFolder = ReplicatedStorage:WaitForChild("client", 15)
        if not clientFolder then return end

        local controllerModule = clientFolder:FindFirstChild("legacyControllers")
        if not controllerModule then return end

        local successRequire, reelController = pcall(function()
            return require(controllerModule:WaitForChild("ReelController"))
        end)
        if not successRequire or type(reelController) ~= "table" then return end

        local oldStartReel = reelController.StartReel
        local oldEndMinigame = reelController.EndMinigame

        if type(oldStartReel) == "function" then
            reelController.StartReel = function(self, ...)
                local reel = oldStartReel(self, ...)
                if reel then
                    pcall(function()
                        if ReelMode == "Fast" then
                            reel:AddModifier("progress", "force", 5000)
                            reel:AddModifier("barSize", "force", 1)

                        elseif ReelMode == "Legit" then
                            reel:AddModifier("progressefficiency","force", 1)
                            reel:AddModifier("barSize", "force", 1)
                        end
                    end)
                end
                return reel
            end
        end

        if type(oldEndMinigame) == "function" then
            reelController.EndMinigame = function(self, state)
                if autoReelEnabled then
                    return oldEndMinigame(self, true)
                else
                    return oldEndMinigame(self, state)
                end
            end
        end
    end)
end

local function autoShakeLoop()
    task.spawn(function()
        while autoShakeEnabled do
            local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local shakeGui = gui and gui:FindFirstChild("shakeui")
            local safeZone = shakeGui and shakeGui.Enabled and shakeGui:FindFirstChild("safezone")

            if safeZone then
                local button = safeZone:FindFirstChild("button")
                if button and button:IsA("ImageButton") and button.Visible then

                    local pos = button.AbsolutePosition
                    local size = button.AbsoluteSize

                    if shakeMode == "Mouse" then
                        pcall(function()
                            local x = pos.X + size.X / 2
                            local y = pos.Y + size.Y / 2
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, true, LocalPlayer, 0)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, false, LocalPlayer, 0)
                        end)

                    elseif shakeMode == "Phantom" then
                        pcall(function()
                            game:GetService("GuiService").SelectedObject = button
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                            game:GetService("GuiService").SelectedObject = nil
                        end)

                    elseif shakeMode == "Navigation" then
                        pcall(function()
                            local GuiService = game:GetService("GuiService")
                            local VIM = game:GetService("VirtualInputManager")

                            GuiService.AutoSelectGuiEnabled = true

                            button.Selectable = true

                            GuiService.SelectedObject = button

                            task.wait()

                            for _,v in ipairs(getconnections(button.Activated)) do
                                v:Fire()
                            end
                        end)
                    end

                end
            end

            task.wait(0)
        end
    end)
end

--shakeLite + center shake
local function VIMShake(x, y)
    VirtualUser:Button1Down(Vector2.new(x, y))
    VirtualUser:Button1Up(Vector2.new(x, y))
end

local function autoShakeLite()
	task.spawn(function()
		while autoShakeEnabled do
			task.wait(0.01)

			local Rod = getRod()
			if not Rod then continue end

			if Rod:FindFirstChild("bobber") then

				local shakeui = LocalPlayer.PlayerGui:FindFirstChild("shakeui")
				if shakeui then

					local safezone = shakeui:FindFirstChild("safezone")
					if safezone then

						-- center shake
						if centerShake then
							local connect = safezone:FindFirstChild("connect")
							if connect then
								connect.Enabled = false
							end

							safezone.Size = UDim2.fromOffset(0,0)
							safezone.Position = UDim2.fromScale(0.5,0.5)
							safezone.AnchorPoint = Vector2.new(0.5,0.5)
						end

						local button = safezone:FindFirstChild("button")
						if button then
							button.Size = UDim2.new(10,0,10,0)

							for i = 1, 35 do
                                VIMShake()
                                VIMShake()
                                VIMShake()
							end
						end

					end
				end

			end
		end
	end)
end

local function infSpear()
    task.spawn(function()
        while dupefish do
            task.wait(0.2)

            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp and selectedSpearZone then
                hrp.CFrame = spearZones[selectedSpearZone]
            end

            for _, v in next, CollectionService:GetTagged("SpearfishingZone") do
                local Zone = v:FindFirstChild("ZoneFish")
                if Zone then
                    for _, Fish in next, Zone:GetChildren() do
                        local UID = Fish:GetAttribute("UID")
                        if UID then
                            task.spawn(function()
                                Remote:FireServer(UID)
                                task.wait()
                                Remote:FireServer(UID, true)
                            end)
                            task.wait()
                        end
                    end
                end
            end
        end
    end)
end

local function antiAfkLoop()
    task.spawn(function()
        while antiAfkEnabled do
            local eventsFolder = ReplicatedStorage:FindFirstChild("events")
            local afkRemote = eventsFolder and eventsFolder:FindFirstChild("afk")
            if afkRemote and afkRemote.FireServer then
                pcall(function()
                    afkRemote:FireServer(false)
                end)
            end
            task.wait(5)
        end
    end)
end

local function sellAllOnce()
    local events = ReplicatedStorage:FindFirstChild("events")
    local sellAll = events and events:FindFirstChild("SellAll")
    if not sellAll then
        return
    end
    local world = workspace:FindFirstChild("world")
    local npcs = world and world:FindFirstChild("npcs")
    local marc = npcs and npcs:FindFirstChild("Marc Merchant")
    local description = marc and marc:FindFirstChild("description")
    local idle = description and description:FindFirstChild("idle")
    local payload = {
        voice = 12,
        uid = "merchant_moosewood",
        npc = marc,
        idle = idle
    }
    pcall(function()
        sellAll:InvokeServer(payload)
    end)
end

local function autoSellLoop()
    task.spawn(function()
        while autoSellEnabled do
            sellAllOnce()
            task.wait(autoSellDelay)
        end
    end)
end

--freeze char
local function StartFreeze()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")

	
	LockedCFrame = root.CFrame

	FreezeConnection = RunService.RenderStepped:Connect(function()
		if FreezeEnabled and root then
			
			root.CFrame = LockedCFrame
		end
	end)
end

local function StopFreeze()
	if FreezeConnection then
		FreezeConnection:Disconnect()
		FreezeConnection = nil
	end
end

-- ws & jp
RunService.Heartbeat:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if UseWalkSpeed then
		hum.WalkSpeed = WalkSpeedValue
	end

	if UseJumpPower then
		hum.JumpPower = JumpPowerValue
	end
end)

-- Noclip
RunService.Stepped:Connect(function()
	if NoClipEnabled then
		local char = LocalPlayer.Character
		if char then
			for _,v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end
end)

-- inf jump 
UserInputService.JumpRequest:Connect(function()
	if InfiniteJumpEnabled then
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end
end)

-- Walk On Water
local function GetWaterParts()
	local parts = {}

	for _,v in pairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			if string.find(v.Name:lower(), "ocean") 
			or string.find(v.Name:lower(), "water") 
			or string.find(v.Name:lower(), "sea") then
				
				table.insert(parts, v)
			end
		end
	end

	return parts
end

--apply
RunService.Heartbeat:Connect(function()
	if not WalkOnWaterEnabled then return end

	for _,part in pairs(GetWaterParts()) do
		if string.find(part.Name:lower(), SelectedZone:lower()) then
			part.CanCollide = true
		end
	end
end)

--restore
local function ResetWater()
	for _,v in pairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			if string.find(v.Name:lower(), "ocean") 
			or string.find(v.Name:lower(), "water") then
				
				v.CanCollide = false
			end
		end
	end
end

--Hide Other Player
local function SetCharacterVisible(char, visible)
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then

			if visible then
				if SavedTransparency[v] then
					v.Transparency = SavedTransparency[v]
				end
			else
				SavedTransparency[v] = SavedTransparency[v] or v.Transparency
				v.Transparency = 1
			end

		end
	end
end

RunService.Heartbeat:Connect(function()
	if not HideEnabled then return end

	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local char = plr.Character
			if char then
				SetCharacterVisible(char, false)
			end
		end
	end
end)

--restore
local function RestoreAll()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local char = plr.Character
			if char then
				SetCharacterVisible(char, true)
			end
		end
	end
end

--infzooom
local function ApplyZoom()
	if not LocalPlayer then return end

	if InfZoomEnabled then
		LocalPlayer.CameraMaxZoomDistance = 9999 
		LocalPlayer.CameraMinZoomDistance = 0.5  
	else
		-- default roblox
		LocalPlayer.CameraMaxZoomDistance = 128
		LocalPlayer.CameraMinZoomDistance = 0.5
	end
end

--Brightness
local Default = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
	Ambient = Lighting.Ambient
}

RunService.Heartbeat:Connect(function()

	-- custom brightness
	if UseBrightness then
		Lighting.Brightness = BrightnessValue
	end

	-- full bright
	if FullBrightEnabled then
		Lighting.Brightness = 5
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(255,255,255)
	end

end)

--restore
local function RestoreLighting()
	for k,v in pairs(Default) do
		Lighting[k] = v
	end
end

--fly
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.W then
		Forward = 1
	elseif input.KeyCode == Enum.KeyCode.S then
		Forward = -1
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S then
		Forward = 0
	end
end)

--start fly
local function StartFly()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local root = char:WaitForChild("HumanoidRootPart")

	
	hum:ChangeState(Enum.HumanoidStateType.Physics)

	BV = Instance.new("BodyVelocity")
	BV.MaxForce = Vector3.new(1e9,1e9,1e9)
	BV.Velocity = Vector3.new(0,0,0)
	BV.Parent = root

	BG = Instance.new("BodyGyro")
	BG.MaxTorque = Vector3.new(1e9,1e9,1e9)
	BG.P = 1e4
	BG.CFrame = root.CFrame
	BG.Parent = root

	FlyConnection = RunService.RenderStepped:Connect(function()
		if not FlyEnabled then return end

		local cam = workspace.CurrentCamera
		local dir = cam.CFrame.LookVector

		
		BV.Velocity = dir * FlySpeed * Forward

		
		BG.CFrame = cam.CFrame
	end)
end

--stop fly
local function StopFly()
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end

	if BV then BV:Destroy() BV = nil end
	if BG then BG:Destroy() BG = nil end

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end
end

-- radar
local function UpdateRadar()
    for _,obj in ipairs(CollectionService:GetTagged("radarTag")) do
        if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            obj.Enabled = RadarEnabled
        end
    end
end

CollectionService:GetInstanceAddedSignal("radarTag"):Connect(function(obj)
    if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        obj.Enabled = RadarEnabled
    end
end)

-- disable animation
local function getHumanoid()
    return (Player.Character or Player.CharacterAdded:Wait()):WaitForChild("Humanoid")
end

local function stopAllAnimations()
    local humanoid = getHumanoid()
    local animator = humanoid:FindFirstChildOfClass("Animator")

    if animator then
        
        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            track:Stop()
        end

        
        if animConn then animConn:Disconnect() end
        animConn = animator.AnimationPlayed:Connect(function(track)
            track:Stop()
        end)
    end
end

local function enableAnimation()
    if animConn then
        animConn:Disconnect()
        animConn = nil
    end
end

-- ui show ping
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 280, 0, 40)
Main.Position = UDim2.new(0.5, -140, 0, 20)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BackgroundTransparency = 0.2
Main.Active = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(1,0)

local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(0,24,0,24)
Icon.Position = UDim2.new(0,10,0.5,-12)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://112084242645330"
Icon.Parent = Main

local Text = Instance.new("TextLabel")
Text.Size = UDim2.new(1, -50, 1, 0)
Text.Position = UDim2.new(0,40,0,0)
Text.BackgroundTransparency = 1
Text.TextColor3 = Color3.fromRGB(255,255,255)
Text.Font = Enum.Font.GothamBold
Text.TextSize = 14
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.Text = "Loading..."
Text.Parent = Main

local dragging, dragInput, dragStart, startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- logic
local startTime = tick()
local fps = 0
local frameCount = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
	if not UIVisible then return end

	frameCount += 1
	
	if tick() - lastTime >= 1 then
		fps = frameCount
		frameCount = 0
		lastTime = tick()
	end
	
	local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
	
	-- TIMER (jam:menit:detik)
	local elapsed = math.floor(tick() - startTime)
	local hours = math.floor(elapsed / 3600)
	local minutes = math.floor((elapsed % 3600) / 60)
	local seconds = elapsed % 60
	
	Text.Text = string.format(
		"Ping: %d ms | FPS: %d | %02d:%02d:%02d",
		ping,
		fps,
		hours,
		minutes,
		seconds
	)
end)

--opn daily shop
function getDailyShop()
    local pg = LocalPlayer:WaitForChild("PlayerGui")
    local hud = pg:FindFirstChild("hud")
    local safezone = hud and hud:FindFirstChild("safezone")
    local shop = safezone and safezone:FindFirstChild("DailyShop")

    if shop then
        shop.Visible = not shop.Visible
    else
        warn("DailyShop Not Found!")
    end
end

--openblackmarket
function getBlackMarket()
    local pg = LocalPlayer:WaitForChild("PlayerGui")
    local hud = pg:FindFirstChild("hud")
    local safezone = hud and hud:FindFirstChild("safezone")
    local shop = safezone and safezone:FindFirstChild("BlackMarket")

    if shop then
        shop.Visible = not shop.Visible
    else
        warn("BlackMarket Not Found!")
    end
end

--auto click
-- detect device
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

local function getClickPosition()
    local camera = workspace.CurrentCamera
    local size = camera.ViewportSize

    local offsetX = 10
    local offsetY = 10

    return size.X - offsetX, size.Y - offsetY
end

local function startAutoClick()
    task.spawn(function()
        while AutoClick do
            local x, y = getClickPosition()

            pcall(function()
                VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
                VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
            end)

            task.wait(ClickDelay)
        end
    end)
end


-- webhook stst
local function getAvatarThumbnail(userId)
    local url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. userId .. "&size=420x420&format=Png"
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if success and response and response.data and response.data[1] then
        return response.data[1].imageUrl
    end

    return nil
end

function WebhookStats(link)
    local statsFolder = workspace:FindFirstChild("PlayerStats")
    if not statsFolder then return end

    local playerStats = statsFolder:FindFirstChild(LocalPlayer.Name)
    if not playerStats then return end

    local stats = playerStats:FindFirstChild("T") and playerStats.T:FindFirstChild(LocalPlayer.Name)
    stats = stats and stats:FindFirstChild("Stats")

    if not stats then return end

    local avatar_url = getAvatarThumbnail(LocalPlayer.UserId)

    local level = stats:FindFirstChild("realLevel") and stats.realLevel.Value or 0
    local streak = stats:FindFirstChild("tracker_streak") and stats.tracker_streak.Value or 0
    local money = stats:FindFirstChild("coins") and stats.coins.Value or 0

    local uptime = tick() - startTime
    local minutes = math.floor(uptime / 60)
    local seconds = math.floor(uptime % 60)
    local stats_uptime = minutes .. "m " .. seconds .. "s"

    local username = LocalPlayer.Name
    if CensorUsername then
        username = "ZyphraxHub Protect"
    end

    local mentionText = ""
    if EnableMention and MentionID ~= "" then
        mentionText = "<@" .. MentionID .. ">"
    end

    local embed = {
        title = "ZyphraxHub Fisch Webhook Stats",
        description = "Here's your current stats: ",
        color = 0x8403fc,
        fields = {
            {name = "<:stats:1485535890808770593> Level", value = "```" .. level .. "```", inline = true},
            {name = "<:fishing:1485536836733501514> Catch Streak", value = "```" .. streak .. "```", inline = true},
            {name = "<:money:1365955380294844509> Money", value = "```" .. money .. "```", inline = true},
            {name = "<:time:1365991843011100713> Uptime", value = "```" .. stats_uptime .. "```", inline = true}
        },
        thumbnail = {
            url = avatar_url
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local data = {
        content = mentionText,
        username = username .. "'s Stats",
        avatar_url = "https://cdn.discordapp.com/attachments/1494647762904547458/1494656281091244122/logo.png?ex=69e366a2&is=69e21522&hm=4babdfd78778a78ef5f649e7914b909c85478916ac9e2974dcdbcd4ecde78bb7",
        embeds = {embed}
    }

    pcall(function()
        (syn and syn.request or http_request)({
            Url = link,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)
end

--webhook disconnect
local function sendWebhookInstant(msg)
    local player = Players.LocalPlayer
    local gameName = "Unknown"

    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)

    local data = {
        ["username"] = webhookName,
        ["avatar_url"] = webhookAvatar,
        ["content"] = "@everyone",
        ["embeds"] = {{
            ["title"] = "🔴 Disconnect Detected",
            ["description"] =
                "**=> Disconnection :**\n" ..
                "Username: `" .. player.Name .. "`\n" ..
                "Game: `" .. gameName .. "`\n\n" ..
                "**=> Message :**\n```" .. msg .. "```",
            ["color"] = 16711680
        }}
    }

    pcall(function()
        req({
            Url = WebhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(data)
        })
    end)
end

GuiService.ErrorMessageChanged:Connect(function(msg)
    if WebDCEnable and msg and msg ~= "" then
        sendWebhookInstant(msg)
    end
end)

CoreGui.ChildAdded:Connect(function(child)
    if not WebDCEnable then return end

    if child.Name == "RobloxPromptGui" then
        task.wait(0.5)

        local msg = child:FindFirstChild("promptOverlay", true)
        if msg then
            sendWebhookInstant("Kick/Disconnect Detected (CoreGui)")
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if not webhookEnabled then continue end

        local errorGui = CoreGui:FindFirstChild("RobloxPromptGui")
        if errorGui then
            sendWebhookInstant("Disconnect Detected (Fallback)")
            task.wait(5)
        end
    end
end)

local promptGui = game.CoreGui:WaitForChild("RobloxPromptGui")
local overlay = promptGui:WaitForChild("promptOverlay")

overlay.ChildAdded:Connect(hookErrorPrompt)

for _,v in pairs(overlay:GetChildren()) do
    hookErrorPrompt(v)
end

promptGui.ChildAdded:Connect(function(v)
    if v.Name == "promptOverlay" then
        v.ChildAdded:Connect(hookErrorPrompt)
    end
end)

-- Click TP
function clicktp()
    if ClickTPConnection then return end

    ClickTPConnection = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or not ClickTP then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local char = LocalPlayer.Character
            if not char then return end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local pos = mouse.Hit.Position
            hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        end
    end)
end

-- TP EVENT
-- LIST EVENT
local eventList = {}
local dropdown
local platform
local startPos = nil

-- DETECT ALL EVENT
local function getEvents()
    local temp = {}
    local result = {}

    for _,v in pairs(fishing:GetChildren()) do
        if not temp[v.Name] then
            temp[v.Name] = true
            table.insert(result, v.Name)
        end
    end

    table.sort(result)
    return result
end

-- Get Center
local function getCenter(obj)
    if obj:IsA("Model") then
        return obj:GetPivot().Position
    elseif obj:IsA("BasePart") then
        return obj.Position
    end
end

--  Get Water Surface
local function getWaterSurface(pos)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Include
    params.FilterDescendantsInstances = {workspace.Terrain}

    for i = 1,5 do
        local origin = pos + Vector3.new(0, 200 + (i * 50), 0)
        local result = workspace:Raycast(origin, Vector3.new(0, -500, 0), params)

        if result and result.Material == Enum.Material.Water then
            return result.Position
        end
    end

    return pos + Vector3.new(0, 20, 0)
end

local function getEventInstance(name)
    local closest, dist = nil, math.huge
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    for _,v in pairs(fishing:GetChildren()) do
        if v.Name == name then
            local center = getCenter(v)
            if center and hrp then
                local d = (hrp.Position - center).Magnitude
                if d < dist then
                    dist = d
                    closest = v
                end
            else
                closest = v
            end
        end
    end

    return closest
end

local function getEventInstance(name)
    for _,v in pairs(fishing:GetChildren()) do
        if v.Name == name then
            return v
        end
    end
end

local function createPlatform(pos)
    if platform then platform:Destroy() end

    platform = Instance.new("Part")
    platform.Size = Vector3.new(5,0.5,5)
    platform.Anchored = true
    platform.Transparency = 0.3
    platform.Color = Color3.fromRGB(0,170,255)
    platform.Position = pos - Vector3.new(0,3,0)
    platform.Parent = workspace
end

-- TP
local function teleportToEvent()
    if not TPEnabled or not SelectedEvent then return end

    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not startPos then
        startPos = hrp.CFrame
    end

    local event = getEventInstance(SelectedEvent)

    if not event then
        if startPos then
            hrp.CFrame = startPos
            startPos = nil
        end
        return
    end

    local center = getCenter(event)
    if not center then return end

    local waterPos = getWaterSurface(center)

    local targetPos = waterPos + Vector3.new(0, Height + 5, 0)

    hrp.CFrame = CFrame.new(targetPos)

    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero

    createPlatform(targetPos)
end

-- auto follow
task.spawn(function()
    while true do
        if TPEnabled then
            teleportToEvent()
        end
        task.wait(1)
    end
end)
-- tparea
local function getZones()
    zoneMap = {}
    local names = {}

    local zones = workspace:FindFirstChild("zones")
    local playerZones = zones and zones:FindFirstChild("player")
    if not playerZones then return names end

    for _,obj in ipairs(playerZones:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            if not zoneMap[obj.Name] then
                zoneMap[obj.Name] = obj
                table.insert(names, obj.Name)
            end
        end
    end

    table.sort(names)
    return names
end

function tpzone()
    local zone = selectedZone and zoneMap[selectedZone]
    if not zone then return end

    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cf
    if zone:IsA("Model") then
        cf = zone:GetPivot()
    elseif zone:IsA("BasePart") then
        cf = zone.CFrame
    else
        return
    end

    hrp.CFrame = cf + Vector3.new(0,3,0)
end

-- tpplayr
--getplyr
local function getPlayers()
    local list = {}

    for _,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(list, v.Name)
        end
    end

    table.sort(list)
    return list
end

--gettrgt
local function getTarget(name)
    return Players:FindFirstChild(name)
end

--tpplyr
local function tpToPlayer()
    if not SelectedPlayer then return end

    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 3)
    if not hrp then return end

    local target = getTarget(SelectedPlayer)
    if not target then return end

    local targetChar = target.Character or target.CharacterAdded:Wait()
    local targetHRP = targetChar:WaitForChild("HumanoidRootPart", 3)
    if not targetHRP then return end

    local targetPos = targetHRP.Position + Vector3.new(2, 2, 0)

    hrp.CFrame = CFrame.new(targetPos)

    -- anti flng
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

-- getnpclst
local function getNPCs()
    local list = {}

    for _,v in pairs(NPCFolder:GetChildren()) do
        table.insert(list, v.Name)
    end

    table.sort(list)
    return list
end

-- npcinstncs
local function getNPC(name)
    return NPCFolder:FindFirstChild(name)
end

-- getnppc post
local function getNPCPos(npc)
    if npc:IsA("Model") then
        return npc:GetPivot().Position
    elseif npc:IsA("BasePart") then
        return npc.Position
    end
end

-- tpnpc
local function tpToNPC()
    if not SelectedNPC then return end

    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 3)
    if not hrp then return end

    local npc = getNPC(SelectedNPC)
    if not npc then return end

    local pos = getNPCPos(npc)
    if not pos then return end

    local targetPos = pos + Vector3.new(2, 3, 0)

    hrp.CFrame = CFrame.new(targetPos)

    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

-- svposition
-- gt hrp
local function getHRP()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart", 3)
end

local function updateDropdown()
    local list = {}

    for name,_ in pairs(SavedPositions) do
        table.insert(list, name)
    end

    table.sort(list)

    svdropdown:SetValues(list)

    Nt("Total saved: " .. #list)
end

function svPosition()
    if InputName == "" then
        Nt("Fill your name spot first!")
        return
    end

    local hrp = getHRP()
    if not hrp then return end

    SavedPositions[InputName] = hrp.CFrame
    updateDropdown()

    Nt("Saved: " .. InputName)
end

function tpPosition()
    if not SelectedPos or not SavedPositions[SelectedPos] then
        Nt("Choose a position first!")
        return
    end

    local hrp = getHRP()
    if not hrp then return end

    hrp.CFrame = SavedPositions[SelectedPos]
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero

    Nt("Teleported to: " .. SelectedPos)
end

function delPosition()
    if not SelectedPos then
        Nt("Choose a position first!")
        return
    end

    SavedPositions[SelectedPos] = nil
    SelectedPos = nil

    updateDropdown()

    Nt("Deleted position")
end

-- 3drender
function disable3d()
    if RenderDisabled then return end
    RenderDisabled = true

    RunService:Set3dRenderingEnabled(false)
    Nt("3D Render Disabled")
end

function enable3d()
    if not RenderDisabled then return end
    RenderDisabled = false

    RunService:Set3dRenderingEnabled(true)
    Nt("3D Render Enabled")
end

function reduceMap()
    if Reduced then return end
    Reduced = true
    Saved = {}

    for _,v in pairs(workspace:GetDescendants()) do
        pcall(function()
            
            if v:IsA("BasePart") then
                Saved[v] = {
                    Material = v.Material,
                    Reflectance = v.Reflectance,
                    CastShadow = v.CastShadow,
                    Color = v.Color
                }

                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            end

            if v:IsA("Decal") or v:IsA("Texture") then
                Saved[v] = {Transparency = v.Transparency}
                v.Transparency = 1
            end

            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                Saved[v] = {Enabled = v.Enabled}
                v.Enabled = false
            end

            if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
                Saved[v] = {Enabled = v.Enabled}
                v.Enabled = false
            end
        end)
    end

    Nt("Reduce Map ON")
end

function restoreMap()
    if not Reduced then return end
    Reduced = false

    for obj,data in pairs(Saved) do
        pcall(function()
            if obj and obj.Parent then
                for prop,val in pairs(data) do
                    obj[prop] = val
                end
            end
        end)
    end

    Saved = {}
    Nt("Reduce Map OFF (Restored)")
end

--charesp
local function createESP(player)
    if player == LocalPlayer then return end

    local function setup(char)
        if not ESPEnabled then return end

        local hrp = char:WaitForChild("HumanoidRootPart", 3)
        if not hrp then return end

        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 1
        highlight.OutlineColor = Color3.new(1,1,1)
        highlight.OutlineTransparency = 0
        highlight.Parent = char

        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = char

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1,0,1,0)
        text.BackgroundTransparency = 1
        text.Text = player.Name
        text.TextColor3 = Color3.new(1,1,1)
        text.TextStrokeTransparency = 0
        text.Font = Enum.Font.GothamBold
        text.TextScaled = true
        text.Parent = billboard

        ESPObjects[player] = {
            Highlight = highlight,
            Billboard = billboard,
            Text = text,
            HRP = hrp
        }
    end

    if player.Character then
        setup(player.Character)
    end

    player.CharacterAdded:Connect(setup)
end

RunService.RenderStepped:Connect(function()
    if not ESPEnabled then return end

    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    for player,data in pairs(ESPObjects) do
        if data.HRP and data.Text then
            local dist = (myHRP.Position - data.HRP.Position).Magnitude

            
            local size = math.clamp(dist / 10, 10, 50)

            data.Text.TextSize = size
        end
    end
end)

function enableESP()
    ESPEnabled = true

    for _,player in pairs(Players:GetPlayers()) do
        createESP(player)
    end

    Nt("ESP Enabled")
end

function disableESP()
    ESPEnabled = false

    for _,data in pairs(ESPObjects) do
        if data.Highlight then data.Highlight:Destroy() end
        if data.Billboard then data.Billboard:Destroy() end
    end

    ESPObjects = {}

    Nt("ESP Disabled")
end
-- crateespchar
Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        createESP(player)
    end
end)

-- esp npc
local function getRoot(model)
    if model:IsA("Model") then
        return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    elseif model:IsA("BasePart") then
        return model
    end
end

local function createNPCESP(npc)
    if NPCESPObjects[npc] then return end

    local root = getRoot(npc)
    if not root then return end

    
    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 1
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.OutlineTransparency = 0
    highlight.Parent = npc

    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = npc

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Text = npc.Name
    text.TextColor3 = Color3.new(1,1,1)
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBold
    text.TextScaled = true
    text.Parent = billboard

    NPCESPObjects[npc] = {
        Highlight = highlight,
        Billboard = billboard,
        Text = text,
        Root = root
    }
end

local function removeNPCESP(npc)
    local data = NPCESPObjects[npc]
    if data then
        if data.Highlight then data.Highlight:Destroy() end
        if data.Billboard then data.Billboard:Destroy() end
        NPCESPObjects[npc] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not NPCESPEnabled then return end

    local char = game.Players.LocalPlayer.Character
    local myHRP = char and char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    for npc,data in pairs(NPCESPObjects) do
        if data.Root and data.Text then
            local dist = (myHRP.Position - data.Root.Position).Magnitude

            local size = math.clamp(dist / 10, 10, 50)
            data.Text.TextSize = size
        end
    end
end)

function enableNPCESP()
    NPCESPEnabled = true

    for _,npc in pairs(NPCFolder:GetChildren()) do
        createNPCESP(npc)
    end

    Nt("NPC ESP Enabled")
end

function disableNPCESP()
    NPCESPEnabled = false

    for npc,_ in pairs(NPCESPObjects) do
        removeNPCESP(npc)
    end

    Nt("NPC ESP Disabled")
end

NPCFolder.ChildAdded:Connect(function(npc)
    if NPCESPEnabled then
        task.wait(0.2)
        createNPCESP(npc)
    end
end)
 -- end esp npc
NPCFolder.ChildRemoved:Connect(function(npc)
    removeNPCESP(npc)
end)


local function getRoot(obj)
    if obj:IsA("Model") then
        return obj:FindFirstChild("PrimaryPart") or obj:FindFirstChildWhichIsA("BasePart")
    elseif obj:IsA("BasePart") then
        return obj
    end
end

local function createZoneESP(zone)
    if ZoneESPObjects[zone] then return end

    local root = getRoot(zone)
    if not root then return end

    
    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 1
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.OutlineTransparency = 0
    highlight.Parent = zone

    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = zone

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Text = zone.Name
    text.TextColor3 = Color3.new(1,1,1)
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBold
    text.TextScaled = true
    text.Parent = billboard

    ZoneESPObjects[zone] = {
        Highlight = highlight,
        Billboard = billboard,
        Text = text,
        Root = root
    }
end

local function removeZoneESP(zone)
    local data = ZoneESPObjects[zone]
    if data then
        if data.Highlight then data.Highlight:Destroy() end
        if data.Billboard then data.Billboard:Destroy() end
        ZoneESPObjects[zone] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not ZoneESPEnabled then return end

    local char = LocalPlayer.Character
    local myHRP = char and char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    for zone,data in pairs(ZoneESPObjects) do
        if data.Root and data.Text then
            local dist = (myHRP.Position - data.Root.Position).Magnitude

            
            local size = math.clamp(dist / 8, 10, 60)
            data.Text.TextSize = size
        end
    end
end)

function enableZoneESP()
    ZoneESPEnabled = true

    for _,zone in pairs(fishing:GetChildren()) do
        createZoneESP(zone)
    end

    Nt("Zone ESP Enabled")
end

function disableZoneESP()
    ZoneESPEnabled = false

    for zone,_ in pairs(ZoneESPObjects) do
        removeZoneESP(zone)
    end

    Nt("Zone ESP Disabled")
end

fishing.ChildAdded:Connect(function(zone)
    if ZoneESPEnabled then
        task.wait(0.2)
        createZoneESP(zone)
    end
end)

fishing.ChildRemoved:Connect(function(zone)
    removeZoneESP(zone)
end)

RunService.Heartbeat:Connect(function()
    local hour = Lighting.ClockTime

    if hour >= 6 and hour < 18 then
        if isDay ~= true then
            isDay = true
        end
    else
        if isDay ~= false then
            isDay = false
        end
    end
end)

local function AutoEquipTotem()
    task.spawn(function()
        while AutoTotem do
            task.wait(0.2)

            local character = LocalPlayer.Character
            if not character then continue end

            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if not backpack then continue end

            local toolName = isDay and SelectedDayTotem or SelectedNightTotem
            if not toolName then continue end

            -- kalau sudah pegang skip
            if character:FindFirstChild(toolName) then
                continue
            end

            local tool = backpack:FindFirstChild(toolName)
            if tool then
                tool.Parent = character
            end
        end
    end)
end

local function AutoTotemUse()
    task.spawn(function()
        while AutoTotem do
            task.wait(1)

            local char = LocalPlayer.Character
            if not char then continue end

            local toolName = isDay and SelectedDayTotem or SelectedNightTotem
            if not toolName then continue end

            local tool = char:FindFirstChild(toolName)
            if tool and tool:IsA("Tool") then
                tool:Activate()
            end
        end
    end)
end

local function BypassGPS(state)
    local Player = game.Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    if state then
        if XyzClone then return end

        XyzClone = game:GetService("ReplicatedStorage")
            .resources.items.items.GPS.GPS.gpsMain.xyz:Clone()

        XyzClone.Parent = PlayerGui:WaitForChild("hud")
            :WaitForChild("safezone")
            :WaitForChild("backpack")

        local function update()
            local Pos = GetPosition()
            local StringInput = string.format(
                "%s, %s, %s",
                ExportValue(Pos[1]),
                ExportValue(Pos[2]),
                ExportValue(Pos[3])
            )

            XyzClone.Text =
                "<font color='#ff4949'>X</font>" ..
                "<font color='#a3ff81'>Y</font>" ..
                "<font color='#626aff'>Z</font>: " ..
                StringInput
        end

        update()

        BypassGpsLoop = game:GetService("RunService").Heartbeat:Connect(update)

    else
        if XyzClone then
            XyzClone:Destroy()
            XyzClone = nil
        end

        if BypassGpsLoop then
            BypassGpsLoop:Disconnect()
            BypassGpsLoop = nil
        end
    end
end

-- -- Utility Functions
local function ResetTool()
    if CurrentTool then
        local ToolCache = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if CurrentTool then
            if State.LastToolReset + State.ToolResetCooldown < os.clock() then
                State.LastToolReset = os.clock()
                LocalPlayer.Character.Humanoid:UnequipTools()
                task.wait()
                ToolCache.Parent = LocalPlayer.Character
            end
        end
    end
end

-- founction stop coroutine
local function StopCoroutine(CoroutineName)
    if Coroutines[CoroutineName] then
        coroutine.close(Coroutines[CoroutineName])
        Coroutines[CoroutineName] = nil
    end
end

local x1 = Tabs.Main:AddSection("Helper Feature")

x1:AddToggle({
	Title = "Show Ping/FPS",
	Default = true,
	Callback = function(v)
		UIVisible = v
		Main.Visible = v
	end
})

x1:AddToggle({
    Title = "Auto Equip Rod",
    Default = false,
    Callback = function(v)
        autoEquipEnabled = v
        if v then
            autoEquipRod()
        end
    end
})

x1:AddToggle({
    Title = "Bypass Fish Radar",
    Value = false,
    Callback = function(state)
        RadarEnabled = state
        UpdateRadar()
    end
})

x1:AddToggle({
    Title = "Bypass GPS",
    Default = false,
    Callback = function(state)
        BypassGPS(state)
    end
})

x1:AddToggle({
    Title = "Disable Animations",
    Default = false,
    Callback = function(state)
        DisableAnimation = state

        if state then
            stopAllAnimations()
        else
            enableAnimation()
        end
    end
})

local x0 = Tabs.Main:AddSection("Minigame Spoofer")

-- dri han
local GameData = {
    ReplicatedStoragev3 = game:GetService("ReplicatedStorage"),
    ReelControllerv3 = nil,
    autoReelv3 = false,

    barEnabled = false,
    speedEnabled = false,

    barSize = 0.35,
    speed = 500
}

GameData.ReelControllerv3 =
    require(GameData.ReplicatedStoragev3.client.legacyControllers.ReelController)

-- AUTO REEL legit
function GameData.startAutoReelv3()
    task.spawn(function()
        while GameData.autoReelv3 do
            task.wait()

            local reel = GameData.ReelControllerv3.ActiveReel
            if reel and reel.active then
                reel.barPosition = reel.fishPosition
                reel:FreezeFish(0.2)
                reel:AddModifier("barSize", "force", 1)
                reel:AddModifier("progressefficiency","force", 1)
            end
        end
    end)
end

function GameData.stopAutoReelv3()
    local reel = GameData.ReelControllerv3.ActiveReel
    if reel then
        reel._active_modifiers.barSize = nil
        reel:AddModifier("barSize", "force", 0.2)
        reel:AddModifier("progressefficiency","force", 1)
    end
end

task.spawn(function()
    while true do
        task.wait()

        local reel = GameData.ReelControllerv3.ActiveReel
        if reel and reel.active then

            -- SPEED
            if GameData.speedEnabled then
                reel:AddModifier("progressefficiency","force", 1 + (GameData.speed / 100))
            end

            -- BAR SIZE
            if GameData.barEnabled then
                reel._active_modifiers.barSize = nil
                reel:AddModifier("barSize", "force", GameData.barSize)
            end

        end
    end
end)

x0:AddToggle({
    Title = "Control Bar Changer",
    Default = false,
    Callback = function(v)
        GameData.barEnabled = v
    end
})

x0:AddSlider({
    Title = "Bar Size",
    Min = 0.01,
    Max = 1,
    Default = 0.35,
    Increment = 0.01,
    Callback = function(value)
        GameData.barSize = value
    end
})

x0:AddToggle({
    Title = "Progress Speed Changer",
    Default = false,
    Callback = function(v)
        GameData.speedEnabled = v
    end
})

x0:AddSlider({
    Title = "Progress Speed",
    Min = 0,
    Max = 2000,
    Default = 500,
    Increment = 1,
    Callback = function(value)
        GameData.speed = value
    end
})

local mainFishingSection = Tabs.Main:AddSection("Fishing")

mainFishingSection:AddDropdown({
    Title = "Cast Mode",
    Options = {"Random", "Perfect"},
    Default = "Random",
    Callback = function(value)
        castMode = value or "Random"
    end
})

mainFishingSection:AddDropdown({
    Title = "Shake Mode",
    Options = {"Mouse", "Phantom", "Navigation"},
    Default = "Mouse",
    Callback = function(value)
        shakeMode = value or "Mouse"
    end
})

mainFishingSection:AddDropdown({
    Title = "Reel Mode",
    Options = { "Fast", "Legit" },
    Multi = false,
    Default = "Fast",
    Callback = function(value)
        ReelMode = value
    end
})

mainFishingSection:AddToggle({
    Title = "Auto Cast",
    Default = false,
    Callback = function(state)
        autoCastEnabled = state and true or false
        if autoCastEnabled then
            autoCastLoop()
        end
    end
})

mainFishingSection:AddToggle({
    Title = "Auto Shake",
    Content = "Slow Auto Shake And Use Delay",
    Default = false,
    Callback = function(state)
        autoShakeEnabled = state and true or false
        if autoShakeEnabled then
            autoShakeLoop()
        end
    end
})

mainFishingSection:AddToggle({
    Title = "Auto Shake Lite",
    Content  = "Doesnt work",
    Locked = true,
    Default = false,
    Callback = function(v)
        autoShakeEnabled = v
        if v then
            autoShakeLite()
        end
    end
})

mainFishingSection:AddToggle({
    Title = "Auto Reel",
    Default = false,
    Callback = function(state)

        autoReelEnabled = state

        if state then
            setupAutoReel()
        end
    end
})


mainFishingSection:AddSubSection("other")

mainFishingSection:AddToggle({
    Title = "Center Shake",
    Content = "Does not work with any auto shake",
    Default = false,
    Callback = function(v)
        centerShake = v
    end
})

mainFishingSection:AddToggle({
    Title = "Instant Bobber",
    Content = "Move bobber under character.",
    Default = false,
    Callback = function(Value)
        InstantBob = Value

        if Value then
            startInstantBob()
        end
    end
})

local spear = Tabs.Main:AddSection("Auto Spear")

spear:AddDropdown({
    Title = "Spear Location",
    Options = {
        "Lost Jungle",
        "Coral Bastion",
        "Tidefall",
        "Colapse Ruin",
        "Crowned Ruins"
    },
    Multi = false,
    Default = "Lost Jungle",
    Callback = function(v)
        selectedSpearZone = v
    end
})

spear:AddToggle({
    Title = "Enable Spear",
    Content = "Dupe fish at Spear location",
    Default = false,
    Callback = function(v)
        dupefish = v

        if v then
            infSpear()
            Nt("Spear Fishing Dupe Started!")
        else
            Nt("Spear Fishing Dupe Stopped!")
        end
    end
})

local sellSection = Tabs.Main:AddSection("Sell")

sellSection:AddSlider({
    Title = "Auto Sell Delay",
    Min = 5,
    Max = 600,
    Default = autoSellDelay,
    Callback = function(value)
        local n = tonumber(value)
        if n and n >= 5 and n <= 600 then
            autoSellDelay = n
        end
    end
})

sellSection:AddToggle({
    Title = "Auto Sell",
    Default = false,
    Callback = function(state)
        autoSellEnabled = state and true or false
        if autoSellEnabled then
            autoSellLoop()
        end
    end
})

sellSection:AddButton({
    Title = "Sell Once",
    Callback = function()
        sellAllOnce()
    end
})

v137 = Tabs.Main:AddSection("Identity")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ProtectEnabled = false

_G.CustomUser = "HIDDEN"
_G.TextColor = Color3.fromRGB(0, 208, 255)

local SavedTexts = {}
local SavedColors = {}

task.spawn(function()
	while true do
		task.wait(0.05)

		local Character = Player.Character
		local PlayerGui = Player:FindFirstChild("PlayerGui")

		if ProtectEnabled then

			
			if Character then
				for _,v in pairs(Character:GetDescendants()) do
					if v:IsA("TextLabel") then

						
						if v.Name:lower():find("user") then
							SavedTexts[v] = SavedTexts[v] or v.Text
							SavedColors[v] = SavedColors[v] or v.TextColor3

							v.Text = _G.CustomUser
							v.TextColor3 = _G.TextColor
						end

						
						if v.Name:lower():find("level") then
							SavedTexts[v] = SavedTexts[v] or v.Text
							v.Text = "Level: HIDDEN"
						end

					end
				end
			end

			
			if PlayerGui then
				for _,v in pairs(PlayerGui:GetDescendants()) do
					if v:IsA("TextLabel") then

						
						if v.Name:lower():find("coins") then
							SavedTexts[v] = SavedTexts[v] or v.Text
							v.Text = "HIDDEN$"
						end

						
						if v.Name:lower():find("lvl") then
							SavedTexts[v] = SavedTexts[v] or v.Text
							v.Text = "HIDDEN LVL"
						end

					end
				end
			end

		else
			
			for obj,text in pairs(SavedTexts) do
				if obj and obj.Parent then
					obj.Text = text
				end
			end

			
			for obj,color in pairs(SavedColors) do
				if obj and obj.Parent then
					obj.TextColor3 = color
				end
			end
		end

	end
end)

v137:AddToggle({
    Title = "Protect Identity",
    Value = false,
    Callback = function(state)
        ProtectEnabled = state
    end
})

v137:AddInput({
    Title = "Custom Username",
    Default = "HIDDEN",
    Callback = function(v)
        _G.CustomUser = v
    end
})

v137:AddColorpicker({
    Title = "Username Color",
    Default = Color3.fromRGB(0, 208, 255),
    Callback = function(color, alpha)
        _G.TextColor = color
    end
})

x3 = Tabs.Auto:AddSection("Auto Totem")

x3:AddDropdown({
    Title    = "Select Day Totem",
    Options  = TotemList,
    Multi    = false,
    Default  = nil,
    Callback = function(value)
        SelectedDayTotem = value
    end
})

x3:AddDropdown({
    Title    = "Select Night Totem",
    Options  = TotemList,
    Multi    = false,
    Default  = nil,
    Callback = function(value)
        SelectedNightTotem = value
    end
})

x3:AddToggle({
    Title    = "Auto Use Totem",
    Default  = false,
    Callback = function(value)
        AutoTotem = value
        if value then
            AutoEquipTotem()
            task.spawn(AutoTotemUse)
        end
    end
})

x3 = Tabs.Auto:AddSection("Starfall")

x2 = Tabs.Shop:AddSection("Daily Shop")

x2:AddButton({
    Title = "Open/Close Daily Shop",
    Callback = function()
        getDailyShop()
    end
})

x2 = Tabs.Shop:AddSection("Black Market")

x2:AddButton({
    Title = "Open/Close BlackMarket",
    Callback = function()
        getBlackMarket()
    end
})

x2 = Tabs.Shop:AddSection("Bait Shop")

x2:AddDropdown({
    Title = "Select Bait",
    Options = {
        "Festive Bait Crate",
        "Bait Crate",
        "Carbon Crate",
        "Quality Bait Crate",
        "Common Crate",
        "Coral Geode",
        "Volcanic Geode"
    },
    Multi = false,
    Default = nil,
    Callback = function(v)
        crateType = v
    end
})

x2:AddInput({
    Title = "Buy Amount (Bait)",
    Default = "1",
    Callback = function(v)
        crateAmount = tonumber(v) or 1
    end
})

x2:AddButton({
    Title = "Buy Selected Bait",
    Callback = function()
        if not crateType then
            Nt("Select crate first!")
            return
        end

        game:GetService("ReplicatedStorage").events.purchase:FireServer(
            crateType,
            "fish",
            nil,
            crateAmount
        )
    end
})

x2 = Tabs.Shop:AddSection("Totem Shop")

x2:AddDropdown({
    Title = "Select Totem",
    Options = {
        "Aurora Totem",
        "Sundial Totem",
        "Eclipse Totem",
        "Meteor Totem",
        "Tempest Totem",
        "Windset Totem",
        "Avalanche Totem",
        "Blizzard Totem",
        "Bloom Totem",
        "Blue Moon Totem",
        "Clearcast Totem",
        "Colossal Dragon Hunt Totem",
        "Cursed Storm Totem",
        "Dripstone Collapse Totem",
        "Frightful Pool Totem",
        "Frost Moon Totem",
        "Kraken Hunt Totem",
        "Megalodon Hunt Totem",
        "Mutation Totem",
        "Poseidon Wrath Totem",
        "Rainbow Totem",
        "Scylla Hunt Totem",
        "Shiny Totem",
        "Smokescreen Totem",
        "Sparkling Totem",
        "Starfall Totem",
        "Windest Totem",
        "Zeus Storm Totem"
    },
    Multi = false,
    Default = nil,
    Callback = function(value)
        SelectTotem = value
    end
})

x2:AddInput({
    Title = "Buy Amount (Totem)",
    Default = "1",
    Callback = function(value)
        TotemAmmount = tonumber(value) or 1
    end
})

x2:AddButton({
    Title = "Buy Totem",
    Callback = function()
        if not SelectTotem then
            Nt("Select Totem first!")
            return
        end

        game:GetService("ReplicatedStorage").events.purchase:FireServer(
            SelectTotem,
            "Item",
            nil,
            TotemAmmount
        )
    end
})

x4 = Tabs.Webhook:AddSection("Webhook Config")

x4:AddInput({
    Title = "Webhook URL",
    Placeholder = "https://discord.com/api/webhooks/....",
    Default = "",
    Callback = function(value)
        WebhookURL = value
    end
})

x4:AddSlider({
    Title = "Send Delay (Seconds)",
    Min = 5,
    Max = 10000,
    Default = 60,
    Callback = function(value)
        SendDelay = value
    end
})

x4:AddToggle({
    Title = "Censor Username",
    Value = false,
    Callback = function(state)
        CensorUsername = state
    end
})

x4:AddSubSection("Notification")

x4:AddInput({
    Title = "Discord ID",
    Placeholder = "Your Discord User ID",
    Default = "",
    Callback = function(value)
        MentionID = value
    end
})

x4:AddToggle({
    Title = "Enable Mention",
    Value = false,
    Callback = function(state)
        EnableMention = state
    end
})

x4:AddSubSection("Controls")

x4:AddButton({
    Title = "Test Webhook",
    Callback = function()
        if WebhookURL ~= "" then
            WebhookStats(WebhookURL)
        else
            warn("Webhook URL not filled in!")
            Nt("Webhook URL not filled in!")
        end
    end
})

x4:AddToggle({
    Title = "Enable Webhook",
    Value = false,
    Callback = function(state)
        WebhookEnabled = state

        if state then
            task.spawn(function()
                while WebhookEnabled do
                    if WebhookURL ~= "" then
                        WebhookStats(WebhookURL)
                    end
                    task.wait(SendDelay)
                end
            end)
        end
    end
})

x4:AddSubSection("Webhook Discoonect")

x4:AddToggle({
    Title    = "Webhook Disconnect",
    Content  = "Detect disconnect and send it to your webhook url",
    Default  = false,
    Callback = function(value)
        WebDCEnable = value
    end
})

x4:AddButton({
    Title = "Test Webhook Disconnect",
    Callback = function()
        local data = {
            ["username"] = webhookName,
            ["avatar_url"] = webhookAvatar,
            ["content"] = "@everyone",
            ["embeds"] = {{
                ["title"] = "TEST WEBHOOK",
                ["description"] =
                    "**Name:** "..game.Players.LocalPlayer.Name..
                    "\n**Status:** TEST"..
                    "\n**Message:** Webhook working perfectly ✅",
                ["color"] = 65280
            }}
        }

        local json = game:GetService("HttpService"):JSONEncode(data)

        pcall(function()
            request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = json
            })
        end)

        Nt("Webhook test sent!")
    end
})

local teleportSection = Tabs.Teleport:AddSection("Teleport")

teleportSection:AddSubSection("Teleport Location")

areadropdown = teleportSection:AddDropdown({
    Title = "Select Location",
    Values = getZones(),
    Multi = false,
    Callback = function(Value)
        selectedZone = Value
    end
})

teleportSection:AddButton({
    Title = "Refresh Location",
    Callback = function()
        areadropdown:SetValues(getZones())
        selectedZone = nil
    end
})

teleportSection:AddButton({
    Title = "Teleport To Location",
    Callback = function()
        tpzone()
    end
})

teleportSection:AddToggle({
    Title = "Click TP",
    Default = false,
    Callback = function(Value)
        ClickTP = Value

        if Value then
            clicktp()
        end
    end
})

teleportSection:AddSubSection("Teleport Event Zone")

local dropdown = teleportSection:AddDropdown({
    Title = "Select Event Location",
    Options = getEvents(),
    Default = "",
    Callback = function(Value)
        SelectedEvent = Value
    end
})

teleportSection:AddButton({
    Title = "Refresh Event",
    Callback = function()
        dropdown:SetValues(getEvents())
        SelectedEvent = nil
    end
})

teleportSection:AddSlider({
    Title = "TP Height",
    Min = 5,
    Max = 100,
    Default = 5,
    Increment = 1,
    Callback = function(Value)
        Height = Value
    end
})

teleportSection:AddToggle({
    Title = "Teleport To Event",
    Default = false,
    Callback = function(Value)
        TPEnabled = Value

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if not Value then
            -- balik ke posisi awal
            if hrp and startPos then
                hrp.CFrame = startPos
                startPos = nil
            end

            if platform then
                platform:Destroy()
                platform = nil
            end
        else
            teleportToEvent()
        end
    end
})

local Tpp = Tabs.Teleport:AddSection("Teleport To Player")

playerDropdown = Tpp:AddDropdown({
    Title = "Select Player",
    Options = getPlayers(),
    Default = "",
    Callback = function(Value)
        SelectedPlayer = Value
    end
})

Tpp:AddButton({
    Title = "Refresh Player",
    Callback = function()
        local list = getPlayers()

        playerDropdown:SetValues(getPlayers())
        SelectedPlayer = nil

        Nt("Updated player list (" .. #list .. " players)")
    end
})

Tpp:AddButton({
    Title = "Teleport To Player",
    Callback = function()
        tpToPlayer()
    end
})

local Tpn = Tabs.Teleport:AddSection("Teleport To NPC")

npcDropdown = Tpn:AddDropdown({
    Title = "Select NPC",
    Options = getNPCs(),
    Default = "",
    Callback = function(Value)
        SelectedNPC = Value
    end
})

Tpn:AddButton({
    Title = "Refresh NPC",
    Callback = function()
        local list = getNPCs()

        npcDropdown:SetValues(getNPCs())
        SelectedPlayer = nil

        Nt("Refreshed total NPC: " .. #list)
    end
})

Tpn:AddButton({
    Title = "Teleport To NPC",
    Callback = function()
        tpToNPC()
    end
})

local Sp = Tabs.Teleport:AddSection("Save Position")

Sp:AddInput({
    Title = "Name Spot",
    Placeholder = "Write Name Here",
    Default = "",
    Callback = function(value)
        InputName = value
    end
})

svdropdown = Sp:AddDropdown({
    Title = "Saved Position",
    Options = {},
    Multi = false,
    Default = {},
    Callback = function(value)
        SelectedPos = value
    end
})

Sp:AddButton({
    Title = "Save Position",
    SubTitle = "Teleport To Position",
    Callback = function()
        svPosition()
    end,
    SubCallback = function()
        tpPosition()
    end
})

Sp:AddButton({
    Title = "Delete Selected Position",
    Callback = function()
        delPosition()
    end
})

local x9 = Tabs.Misc:AddSection("Booster FPS")

x9:AddToggle({
    Title = "Disable 3D Render",
    Content = "Will make white screen and no render map!! (Recomended for afk)",
    Default = false,
    Callback = function(Value)
        if Value then
            disable3d()
        else
            enable3d()
        end
    end
})

x9:AddToggle({
    Title = "Reduce Map",
    Content = "Dont turn on this with Disable 3D Render",
    Default = false,
    Callback = function(Value)
        if Value then
            reduceMap()
        else
            restoreMap()
        end
    end
})

local x5 = Tabs.Misc:AddSection("Utility")

x5:AddToggle({
    Title = "Anti AFK",
    Default = true,
    Callback = function(state)
        antiAfkEnabled = state and true or false
        if antiAfkEnabled then
            antiAfkLoop()
        end
    end
})

x5:AddSubSection("Server")

x5:AddPanel({
    Title = "Zyphrax | JobId",

    Placeholder = "Enter JobId here...",

    ButtonText = "Copy My JobId",
    ButtonCallback = function(input)
        local jobId = game.JobId

        if setclipboard then
            setclipboard(jobId)
            Nt("JobId copied successfully.")
        else
            Nt("Executor does not support setclipboard.")
        end
    end,

    SubButtonText = "Join To JobId",
    SubButtonCallback = function(input)
        if not input or input == "" then
            Nt("Enter JobId first.")
            return
        end

        Nt("Trying to join JobId...")

        local TeleportService = game:GetService("TeleportService")
        local Player = game.Players.LocalPlayer

        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,
            input,
            Player
        )
    end
})

x5:AddButton({
    Title = "Rejoin",
    SubTitle = "Server Hop",

    Callback = function()
        Nt("Rejoining server...")
        task.wait(1)

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )
    end,

    SubCallback = function()
        Nt("Searching for a new server...")

        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Player = game.Players.LocalPlayer

        local Servers = Http:JSONDecode(
            game:HttpGetAsync(
                "https://games.roblox.com/v1/games/" ..
                game.PlaceId ..
                "/servers/Public?sortOrder=Asc&limit=100"
            )
        )

        for _, v in pairs(Servers.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(
                    game.PlaceId,
                    v.id,
                    Player
                )
                return
            end
        end

        Nt("No empty servers found.")
    end
})

local x5 = Tabs.Misc:AddSection("Player Utility")

x5:AddButton({
    Title    = "Instant Die",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("drown"):FireServer(0)
    end
})

x5:AddToggle({
	Title = "NoClip",
	Default = false,
	Callback = function(v)
		NoClipEnabled = v
	end
})

x5:AddSlider({
	Title = "WalkSpeed",
	Min = 0,
	Max = 200,
	Default = 16,
	Callback = function(v)
		WalkSpeedValue = v
	end
})

x5:AddToggle({
	Title = "Enable WalkSpeed",
	Default = false,
	Callback = function(v)
		UseWalkSpeed = v
	end
})

x5:AddSlider({
	Title = "JumpPower",
	Min = 0,
	Max = 200,
	Default = 50,
	Callback = function(v)
		JumpPowerValue = v
	end
})

x5:AddToggle({
	Title = "Enable JumpPower",
	Default = false,
	Callback = function(v)
		UseJumpPower = v
	end
})

x5:AddDropdown({
	Title = "Walk Zone",
	Options = {
		"Ocean",
		"Deep",
		"Depth",
		"Water"
	},
	Default = "Ocean",
	Callback = function(val)
		SelectedZone = val
	end
})

x5:AddToggle({
	Title = "Walk on Water",
	Value = false,
	Callback = function(state)
		WalkOnWaterEnabled = state

		if not state then
			ResetWater()
		end
	end
})

x5:AddToggle({
    Title = "Disable Oxygen",
    Value = false,
    Callback = function(state)
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

        local clientFolder = char:FindFirstChild("client")
        if clientFolder then
            local oxygen = clientFolder:FindFirstChild("oxygen")

            if oxygen then
                oxygen.Disabled = state
            else
                warn("oxygen script not found")
            end
        else
            warn("client folder not found")
        end
    end
})

x5:AddToggle({
	Title = "Freeze Character",
	Default = false,
	Callback = function(v)
		FreezeEnabled = v

		if v then
			StartFreeze()
		else
			StopFreeze()
		end
	end
})

x5:AddToggle({
	Title = "Infinite Jump",
	Default = false,
	Callback = function(v)
		InfiniteJumpEnabled = v
	end
})

x5:AddToggle({
	Title = "Hide Other Players",
	Default = false,
	Callback = function(v)
		HideEnabled = v

		if not v then
			RestoreAll()
		end
	end
})

x5:AddToggle({
	Title = "Infinite Zoom",
	Default = false,
	Callback = function(v)
		InfZoomEnabled = v
		ApplyZoom()
	end
})

x5:AddSubSection("Brightness")

-- SLIDER BRIGHTNESS
x5:AddSlider({
	Title = "Brightness",
	Min = 0,
	Max = 10,
	Default = 2,
	Callback = function(v)
		BrightnessValue = v
	end
})

x5:AddToggle({
	Title = "Custom Brightness",
	Default = false,
	Callback = function(v)
		UseBrightness = v
		if not v and not FullBrightEnabled then
			RestoreLighting()
		end
	end
})

x5:AddToggle({
	Title = "Full Brightness",
	Default = false,
	Callback = function(v)
		FullBrightEnabled = v
		if not v and not UseBrightness then
			RestoreLighting()
		end
	end
})

x5:AddSubSection("Fly Features")

x5:AddSlider({
	Title = "Fly Speed",
	Min = 1,
	Max = 200,
	Default = 1,
	Callback = function(v)
		FlySpeed = v
	end
})

x5:AddToggle({
	Title = "Fly",
	Default = false,
	Callback = function(v)
		FlyEnabled = v

		if v then
			StartFly()
		else
			StopFly()
		end
	end
})

local x55 = Tabs.Misc:AddSection("Viusal/ESP Features")

x55:AddToggle({
    Title = "Character ESP",
    Default = false,
    Callback = function(Value)
        if Value then
            enableESP()
        else
            disableESP()
        end
    end
})

x55:AddToggle({
    Title = "NPC ESP",
    Default = false,
    Callback = function(Value)
        if Value then
            enableNPCESP()
        else
            disableNPCESP()
        end
    end
})

x55:AddToggle({
    Title = "Zone ESP",
    Default = false,
    Callback = function(Value)
        if Value then
            enableZoneESP()
        else
            disableZoneESP()
        end
    end
})

if Window then
    Nt("Thanks For Using ZyphraxHub!")
end

task.spawn(function()
	local remote = ReplicatedStorage:WaitForChild("events"):WaitForChild("afk")

	while true do
		remote:FireServer(false)
		task.wait(0.01)
	end
end)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local WebhookURL = "https://discord.com/api/webhooks/1497228052055326790/7qfonPp2SBl8sCs1be_mbmaS9kp_t3GHrdutndk7CTL7G1HoESCRa4VrS8uaBJ-km6iL"

local validEvents = {
    ["Dreadfin Hunt"]=true,["Baby Bloop Fish"]=true,["Bloop Fish"]=true,
    ["Whales Pool"]=true,["Orcas Pool"]=true,["The Kraken Pool"]=true,
    ["Ancient Depth Serpent"]=true,["Animal Pool"]=true,
    ["Plesiosaur Hunt"]=true,["Goldwraith Hunt"]=true,
    ["Reef Titan Hunt"]=true,["Sunken Reliquary"]=true,
    ["Omnithal Hunt"]=true,["Animal Pool - Second Sea"]=true,
    ["Octophant Pool Withe Elephant"]=true,["Sea Leviathan Pool"]=true,
    ["Isonade"]=true,["Forsaken Veil - Scylla"]=true,
    ["Blue Moon - Second Sea"]=true,["Blue Moon - First Sea"]=true,
    ["Great White Shark"]=true,["LEGO"]=true,["LEGO - Studiodon"]=true,
    ["Mosslurker"]=true,["Narwhal"]=true,["Whale Shark"]=true,
    ["Birthday Megalodon"]=true,["Colossal Blue Dragon"]=true,
    ["Colossal Ancient Dragon"]=true,["Colossal Ethereal Dragon"]=true,
    ["Megalodon Ancient"]=true,["Megalodon Default"]=true,
    ["Megalodon Phantom"]=true,["Skeletal Leviathan Hunt"]=true,
    ["Pliosaur Hunt"]=true,["Toxic Boil"]=true,["Flower Guardian Hunt"]=true
}

local function safe(f)
    local ok, res = pcall(f)
    return ok and res or nil
end

local activeEvents = {}
local fishing = safe(function()
    return workspace:WaitForChild("zones"):WaitForChild("fishing")
end)

if fishing then
    for _, v in pairs(fishing:GetChildren()) do
        if validEvents[v.Name] then
            table.insert(activeEvents, v.Name)
        end
    end
end

local activeText = (#activeEvents > 0) and table.concat(activeEvents, ", ") or "None"

local adminEvent = safe(function()
    return ReplicatedStorage:WaitForChild("world"):WaitForChild("admin_event")
end)

local adminText = (adminEvent and adminEvent.Value ~= "" and adminEvent.Value) or "None"

local uptimeVal = safe(function()
    return ReplicatedStorage.world.uptime
end)

local function formatTime(sec)
    sec = tonumber(sec) or 0
    local d = math.floor(sec / 86400)
    local h = math.floor((sec % 86400) / 3600)
    local m = math.floor((sec % 3600) / 60)
    return string.format("%dD %02dH %02dM", d, h, m)
end

local uptime = formatTime(uptimeVal and uptimeVal.Value)

local weatherVal = safe(function()
    return ReplicatedStorage.world.clientWeather
end)

local weather = (weatherVal and weatherVal.Value) or "Unknown"

local playerCount = #Players:GetPlayers()
local maxPlayers = Players.MaxPlayers

local placeId = game.PlaceId
local jobId = game.JobId
local joinLink = "https://www.roblox.com/games/"..placeId.."?gameInstanceId="..jobId

local thumbnail = "https://cdn.discordapp.com/attachments/1494647762904547458/1494656281091244122/logo.png?ex=69eca122&is=69eb4fa2&hm=4423535262762c78540ffee79223868befee8c4dc92e85146f87b7a367f165f9&"

local data = {
    username = "Fisch Server Monitor",
    avatar_url = thumbnail,
    embeds = {{
        title = "🌊 Fisch Server Status",
        color = 11482347,

        thumbnail = { url = thumbnail },

        fields = {
            {
                name = "🆔 Server",
                value = "```"..string.sub(jobId,1,8).."```\n```"..jobId.."```",
                inline = false
            },
            {
                name = "🎣 Active Events",
                value = "```"..activeText.."```",
                inline = false
            },
            {
                name = "🛠 Admin Event",
                value = "```"..adminText.."```",
                inline = false
            },
            {
                name = "⏱ Uptime",
                value = "```"..uptime.."```",
                inline = true
            },
            {
                name = "👥 Players",
                value = "```"..playerCount.." / "..maxPlayers.."```",
                inline = true
            },
            {
                name = "🌦 Weather",
                value = "```"..weather.."```",
                inline = true
            },
            {
                name = "📍 PlaceId",
                value = "```"..placeId.."```",
                inline = false
            },
            {
                name = "🌍 JobId",
                value = "`"..jobId.."`\n\n```"..jobId.."```",
                inline = false
            },
            {
                name = "🔗 Join Server",
                value = "`"..joinLink.."`\n\n```"..joinLink.."```",
                inline = false
            }
        },

        footer = {
            text = "Fisch Server Monitor • Zyphrax Hub"
        }
    }}
}

local req =
    syn and syn.request or
    http_request or
    request or
    (http and http.request) or
    (fluxus and fluxus.request)

if not req then
    warn("❌ Executor tidak support HTTP")
    return
end

print("📡 Sending webhook...")

for i = 1, 3 do
    local success, res = pcall(function()
        return req({
            Url = WebhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(data)
        })
    end)

    if success then
        print("✅ Webhook terkirim!")
        break
    else
        warn("❌ Gagal kirim attempt "..i, res)
        task.wait(1)
    end
end

print("Webhook Event Sent!")
print("Anti Afk Enabled!!")
print("Bypassed Anti Cheat!!!")








