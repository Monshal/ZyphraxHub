if _G.ZyphraxBloxFruitHub and _G.ZyphraxBloxFruitHub.Stop then
    _G.ZyphraxBloxFruitHub.Stop()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

local Sea1 = game.PlaceId == 2753915549
local Sea2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
local Sea3 = game.PlaceId == 100117331123089 or game.PlaceId == 7449423635
local World1 = Sea1
local World2 = Sea2
local World3 = Sea3

_G.AutoFarm = false
_G.AutoNear = false
_G.AutoBossFarm = false
_G.SelectBoss = ""
_G.AutoFarmFruits = false
_G.selectFruitFarm = "Farm Level Mastery"
_G.AutoFarmMaterial = false
_G.SelectMaterial = ""
_G.AutoHaki = true
_G.BringMonster = true
_G.BringMob = true
_G.AutoSecondWorld = false
_G.AutoThirdWorld = false
_G.AutoActiveRaceV3 = false
_G.AutoActiveRaceV4 = false
_G.WalkWater = false
_G.CheckPoint = false
_G.InfiniteSoru = false
_G.DodgeNoCD = false
_G.SpinPosition = false
_G.InfiniteGeppo = false
_G.InfiniteJump = false

local SkillZ = true
local SkillX = false
local SkillC = false
local SkillV = false
local SkillF = false
local KillPercent = 25
local ZYPHRAX_CONFIG_FILE = "zyphraxbloxfruit.autosave.json"
local zyphraxConfigLoaded = false
local zyphraxConfigLastJson = nil
local ZYPHRAX_UI_FILE = "C:\\Users\\jiane\\OneDrive\\Documents\\WHOLE SCRIPT GALAXY\\Zyphrax\\ui.lua"
local ZYPHRAX_UI_FALLBACK_URL = "https://raw.githubusercontent.com/Moonshall/ZyphraxHub/refs/heads/main/mainui.lua"
local readWorkspaceFile

local state = {
    running = true,
    autoEquipTool = true,
    weaponType = "Melee",
    selectedWeapon = nil,
    levelFarmMelee = "Auto Detect",
    boneFarmMelee = "Auto Detect",
    seaTreatsFarmMelee = "Auto Detect",
    fastAttack = true,
    fastAttackDelay = 0.5,
    autoEnablePvP = false,
    autoObservationHaki = false,
    autoBerry = false,
    autoBerryHop = false,
    autoYama = false,
    autoHolyTorch = false,
    autoTushita = false,
    autoTyrant = false,
    autoCDK = false,
    autoMastery = false,
    masteryWeaponType = "Devil Fruit",
    masteryAimbot = true,
    masteryQuestCheck = "Quest",
    positionMethod = "Top",
    positionOffsetX = 0,
    positionOffsetY = 0,
    positionOffsetZ = 0,
    autoSelectedMobNoQuest = false,
    autoSelectedMobQuest = false,
    selectedQuestMob = nil,
    mobFarmTargetKey = nil,
    mobFarmTargetIndex = 1,
    mobFarmTargetSwitchAt = 0,
    selectedBoat = "Pirate Sloop",
    window = nil,
    espPlayers = false,
    espChests = false,
    espFruits = false,
    espFlowers = false,
    espBerries = false,
    espSpecialIslands = false,
    autoChest = false,
    autoChestHop = false,
    autoEliteHunter = false,
    autoEliteHop = false,
    stopEliteOnChalice = false,
    autoPirateRaid = false,
    autoPirateRaidBusy = false,
    autoMirageTeleport = false,
    autoBuyRandomFruit = false,
    autoBoneFarm = false,
    autoBoneSurprise = false,
    fruitNotifications = true,
    autoTweenFruit = false,
    autoTweenFruitHop = false,
    mirageNotifications = false,
    kitsuneNotifications = false,
    prehistoricNotifications = false,
    autoFactoryRaid = false,
    autoKitsuneIsland = false,
    autoCollectAzureEmber = false,
    autoKitsunePray = false,
    autoMirageGear = false,
    autoAdvancedFruitDealer = false,
    autoSanguineArt = false,
    autoDojoTrainer = false,
    autoBlazeEmbers = false,
    dragon = {
        autoDojoTrainer = false,
        autoDragonHunter = false,
        autoDracoV2V3 = false,
        currentBelt = "Null",
        currentBeltQuest = nil,
        currentDracoQuest = nil,
        currentDragonHunterQuest = nil,
        beltProgress = {},
        localProgress = {},
        greenTimer = 0,
        purpleProgress = nil,
        startPurpleProgress = 0,
        blackProgress = nil,
        killedTerrorshark = false,
        lastDojoRefresh = 0,
        lastDracoRefresh = 0,
        lastHunterRefresh = 0,
        status = "Idle",
        hunterStatus = "Idle",
        dracoStatus = "Idle",
        notificationSeen = setmetatable({}, {__mode = "k"})
    },
    raceQuest = {
        autoV2 = false,
        autoV3 = false,
        completedV3 = {},
        statusV2 = "Idle",
        statusV3 = "Idle"
    },
    v4Trial = {
        autoLever = false,
        autoRaceDoor = false,
        autoHumanGhoulTrial = false,
        autoCompleteTrial = false,
        autoKillTrialPlayer = false,
        lastEntranceRequest = 0
    },
    craft = {
        autoCraftVolcanicMagnet = false,
        autoCollectDragonEgg = false,
        autoTradeAzureEmber = false,
        azureTradeAmount = 20,
        selectedAura = nil,
        auraOptions = {},
        auraSkins = nil,
        unlockedAuras = nil,
        unlockedAurasAt = 0,
        autoAuraColor = false,
        autoCraftHop = false,
        autoBaristaCousin = false,
        status = "Idle",
        lastBaristaAttempt = 0
    },
    ui = {
        dragon = {},
        raceQuest = {},
        craft = {}
    },
    inventoryCache = {
        updatedAt = 0,
        counts = {},
        unlocked = {},
        materials = {}
    },
    quests = {
        autoObservation = false,
        autoObservationHop = false,
        autoCakePrince = false,
        autoDoughKing = false,
        autoSoulReaper = false,
        autoSoulReaperHop = false,
        autoSuperhuman = false,
        superhumanMethod = "Auto Farm Level",
        autoDeathStep = false,
        autoSharkmanKarate = false,
        autoElectricClaw = false,
        electricClawStage = 0,
        autoDragonTalon = false,
        autoGodhuman = false,
        autoDungeon = false,
        autoAwaken = false,
        selectedChip = "Flame",
        autoSelectDungeon = false,
        autoBuyChip = false,
        autoStartRaid = false,
        autoLawRaid = false,
        autoBuyLawChip = false
    },
    sea = {
        team = "Pirates",
        boat = "PirateBrigade",
        seaLevel = "Level 1",
        weaponType = "Melee",
        autoEvents = false,
        autoSail = false,
        attackMobs = false,
        attackSharks = true,
        attackFishCrew = true,
        attackPirateShips = true,
        attackSeaBeasts = false,
        autoPrehistoricTeleport = false,
        autoDefendVolcano = false,
        autoMirageSail = false,
        mirageRouteIndex = 4,
        volcanoUseMelee = false,
        volcanoUseSword = false,
        volcanoUseGun = false,
        destroyRocks = false,
        autoPressW = false,
        attackDistance = 30,
        boatTweenSpeed = 350,
        boatSpeed = 150,
        skillZ = true,
        skillX = true,
        skillC = false,
        skillV = false,
        skillF = false,
        skillAimEnabled = false,
        skillAimPosition = nil,
        lastBoatBuyAttempt = 0
    },
    bounty = {
        autoFarm = false,
        autoHop = false,
        tweenToPlayer = false,
        aimbotSkills = false,
        aimbotGun = false,
        skillZ = true,
        skillX = true,
        skillC = false,
        skillV = false,
        skillF = false,
        holdDelayZ = 1,
        holdDelayX = 1,
        holdDelayC = 1,
        holdDelayV = 1,
        holdDelayF = 1,
        positionMethod = "Top",
        ignoreSafeZonePlayers = false,
        lockEnabled = false,
        lockValue = 750000,
        selectedPlayer = "Nearest Enemy",
        playerDistance = 20,
        maxDistance = 17000,
        targetTimeout = 6.5,
        status = "Idle",
        currentTarget = nil,
        lastTargetHealth = nil,
        lastDamageTick = 0,
        lastHopTick = 0,
        startValue = nil,
        skipTargets = {}
    },
    autoStats = {
        Melee = false,
        Defense = false,
        Sword = false,
        ["Demon Fruit"] = false,
        Gun = false
    },
    combat = {
        overrideSource = nil,
        overrideType = nil,
        overrideWeapon = nil,
        equipRequestedUntil = 0
    },
    aimbot = {
        enabled = false,
        holdKey = "Q",
        holdActive = false,
        smoothness = 3,
        showFov = true,
        fovRadius = 150,
        teamCheck = true,
        ignoreFriends = true,
        highlightTarget = true,
        lockedPlayer = nil,
        highlightedPlayer = nil,
        status = "Idle"
    }
}

local ZYPHRAX_CONFIG_SKIP_KEYS = {
    running = true,
    window = true,
    mobFarmTargetKey = true,
    mobFarmTargetIndex = true,
    mobFarmTargetSwitchAt = true,
    autoPirateRaidBusy = true,
    ui = true,
    inventoryCache = true,
}

local function sanitizeZyphraxConfigValue(value, skipKeys, visited)
    local valueType = typeof(value)
    if valueType == "boolean" or valueType == "number" or valueType == "string" then
        return value
    end

    if value == nil then
        return nil
    end

    if valueType ~= "table" then
        return nil
    end

    visited = visited or {}
    if visited[value] then
        return nil
    end
    visited[value] = true

    local result = {}
    for key, nestedValue in pairs(value) do
        local keyType = typeof(key)
        if (keyType == "string" or keyType == "number") and not (skipKeys and skipKeys[key]) then
            local sanitized = sanitizeZyphraxConfigValue(nestedValue, nil, visited)
            if sanitized ~= nil then
                result[key] = sanitized
            end
        end
    end

    visited[value] = nil
    return result
end

local function applyZyphraxConfigTable(target, saved, skipKeys)
    if typeof(target) ~= "table" or typeof(saved) ~= "table" then
        return
    end

    for key, value in pairs(saved) do
        if not (skipKeys and skipKeys[key]) and target[key] ~= nil then
            if typeof(target[key]) == "table" and typeof(value) == "table" then
                applyZyphraxConfigTable(target[key], value)
            elseif typeof(value) == "boolean" or typeof(value) == "number" or typeof(value) == "string" then
                target[key] = value
            end
        end
    end
end

local function buildZyphraxConfigSnapshot()
    return {
        globals = {
            AutoFarm = _G.AutoFarm,
            AutoNear = _G.AutoNear,
            AutoBossFarm = _G.AutoBossFarm,
            SelectBoss = _G.SelectBoss,
            AutoFarmFruits = _G.AutoFarmFruits,
            selectFruitFarm = _G.selectFruitFarm,
            AutoFarmMaterial = _G.AutoFarmMaterial,
            SelectMaterial = _G.SelectMaterial,
            AutoHaki = _G.AutoHaki,
            BringMonster = _G.BringMonster,
            BringMob = _G.BringMob,
            AutoSecondWorld = _G.AutoSecondWorld,
            AutoThirdWorld = _G.AutoThirdWorld,
            AutoActiveRaceV3 = _G.AutoActiveRaceV3,
            AutoActiveRaceV4 = _G.AutoActiveRaceV4,
            WalkWater = _G.WalkWater,
            CheckPoint = _G.CheckPoint,
            InfiniteSoru = _G.InfiniteSoru,
            DodgeNoCD = _G.DodgeNoCD,
            SpinPosition = _G.SpinPosition,
            InfiniteGeppo = _G.InfiniteGeppo,
            InfiniteJump = _G.InfiniteJump,
        },
        combat = {
            SkillZ = SkillZ,
            SkillX = SkillX,
            SkillC = SkillC,
            SkillV = SkillV,
            SkillF = SkillF,
            KillPercent = KillPercent,
        },
        state = sanitizeZyphraxConfigValue(state, ZYPHRAX_CONFIG_SKIP_KEYS),
    }
end

local function saveZyphraxConfig(force)
    if not writefile then
        return false
    end

    local ok, json = pcall(function()
        return HttpService:JSONEncode(buildZyphraxConfigSnapshot())
    end)
    if not ok or not json then
        return false
    end

    if not force and json == zyphraxConfigLastJson then
        return true
    end

    local wrote = pcall(function()
        writefile(ZYPHRAX_CONFIG_FILE, json)
    end)

    if wrote then
        zyphraxConfigLastJson = json
    end

    return wrote
end

local function loadZyphraxConfig()
    if not (readfile and isfile and isfile(ZYPHRAX_CONFIG_FILE)) then
        return false
    end

    local ok, payload = pcall(function()
        return HttpService:JSONDecode(readfile(ZYPHRAX_CONFIG_FILE))
    end)
    if not ok or typeof(payload) ~= "table" then
        return false
    end

    if typeof(payload.globals) == "table" then
        for key, value in pairs(payload.globals) do
            if _G[key] ~= nil and (typeof(value) == "boolean" or typeof(value) == "number" or typeof(value) == "string") then
                _G[key] = value
            end
        end
    end

    if typeof(payload.combat) == "table" then
        if typeof(payload.combat.SkillZ) == "boolean" then SkillZ = payload.combat.SkillZ end
        if typeof(payload.combat.SkillX) == "boolean" then SkillX = payload.combat.SkillX end
        if typeof(payload.combat.SkillC) == "boolean" then SkillC = payload.combat.SkillC end
        if typeof(payload.combat.SkillV) == "boolean" then SkillV = payload.combat.SkillV end
        if typeof(payload.combat.SkillF) == "boolean" then SkillF = payload.combat.SkillF end
        if typeof(payload.combat.KillPercent) == "number" then KillPercent = payload.combat.KillPercent end
    end

    if typeof(payload.state) == "table" then
        applyZyphraxConfigTable(state, payload.state, ZYPHRAX_CONFIG_SKIP_KEYS)
    end

    zyphraxConfigLoaded = true
    return true
end

loadZyphraxConfig()

state.bounty.autoFarm = false
state.bounty.autoHop = false
state.bounty.tweenToPlayer = false
state.bounty.lockEnabled = false
state.bounty.status = "Disabled"
state.bounty.currentTarget = nil
state.aimbot.enabled = false
state.aimbot.holdActive = false
state.aimbot.lockedPlayer = nil
state.aimbot.highlightedPlayer = nil
state.aimbot.status = "Disabled"

if LocalPlayer.Team and LocalPlayer.Team.Name then
    state.sea.team = LocalPlayer.Team.Name
end

_G.__ZyphraxSeaSkillState = state

local connections = {}
local moveTween
local isTeleporting = false
local teleportTargetCFrame
local teleportCompletedConnection
local teleportPartConnection
local chestScanCache = {
    parts = {},
    lookup = setmetatable({}, {__mode = "k"}),
    recent = setmetatable({}, {__mode = "k"}),
    nextRefreshAt = 0,
    dirty = true
}
local chestEspRendered = setmetatable({}, {__mode = "k"})
local fruitScanCache = {
    handles = {},
    lookup = setmetatable({}, {__mode = "k"}),
    nextRefreshAt = 0,
    dirty = true
}
local flowerEspCache = {
    items = {},
    lookup = setmetatable({}, {__mode = "k"}),
    nextRefreshAt = 0,
    dirty = true
}
local specialIslandEspCache = {
    items = {},
    lookup = setmetatable({}, {__mode = "k"}),
    nextRefreshAt = 0,
    dirty = true
}
local fruitEspRendered = setmetatable({}, {__mode = "k"})
local flowerEspRendered = setmetatable({}, {__mode = "k"})
local berryEspRendered = setmetatable({}, {__mode = "k"})
local specialIslandEspRendered = setmetatable({}, {__mode = "k"})
local espInstanceRegistry = {}
local lastEntranceRequestAt = 0
local lastEntranceRequestPos
local seaBoatTween
local seaBoatTweenTarget
local seaBoatTweenSeat
local seaBoatSpeedSeat
local lastBoatCollisionUpdate = 0
local lastBoatCollisionBoat = nil
local bountySkillState = {
    Z = {lastUse = 0, holding = false},
    X = {lastUse = 0, holding = false},
    C = {lastUse = 0, holding = false},
    V = {lastUse = 0, holding = false},
    F = {lastUse = 0, holding = false}
}

local SelectMonster = nil
local Mon = ""
local MonFarm = ""
local LevelQuest = 1
local NameQuest = ""
local NameMon = ""
local CFrameQuest = CFrame.new()
local CFrameMon = CFrame.new()
local CFrameMon2 = nil
local PosMon = nil
local BringPos = nil
local MPos = nil
local MMonList = nil
local MyLevel = 0
local StartBring = false
local recentServerHops = {}

cakePrinceRemainingLabel = nil
doughKingRemainingLabel = nil
berryStatusLabel = nil
eliteHunterProgressLabel = nil
observationStatusLabel = nil
raceInfoLabels = {}
mirageStatusLabel = nil
kitsuneStatusLabel = nil
prehistoricStatusLabel = nil
fruitNotifyStatusLabel = nil
dojoQuestStatusLabel = nil
blazeQuestStatusLabel = nil
dracoRaceStatusLabel = nil
raceV2StatusLabel = nil
raceV3StatusLabel = nil
craftStatusLabel = nil
aimbotStatusLabel = nil
aimbotBindLabel = nil


local CHEST_SCAN_REFRESH = 5
local CHEST_RETRY_COOLDOWN = 1.5
local MAX_CHEST_ESP_RENDER = 20
local MAX_CHEST_ESP_DISTANCE = 2500
local CHEST_INTERACT_DISTANCE = 14
local FRUIT_SCAN_REFRESH = 0.75
local FLOWER_SCAN_REFRESH = 5
local SPECIAL_ISLAND_SCAN_REFRESH = 5
local WORLD_ESP_MAX_RENDER = 40
local WORLD_ESP_MAX_DISTANCE = 3000
local PLAYER_ESP_MAX_DISTANCE = 3000
local TELEPORT_DIRECT_DISTANCE = 150
local TELEPORT_SPEED = 420
local TELEPORT_ENTRANCE_MIN_DISTANCE = 1500
local TELEPORT_ENTRANCE_MIN_SAVINGS = 600
local MOVEMENT_NOCLIP_INTERVAL = 0.2
local FAST_ATTACK_INTERVAL = 0.08
local CLICK_ATTACK_INTERVAL = 0.12
local ATTACK_LOOP_INTERVAL = 0.05
local TELEPORT_REISSUE_INTERVAL = 0.15
local BONE_FARM_MOVE_INTERVAL = 1
local SEA_COMBAT_MIN_Y = 10
local SEA_COMBAT_BOAT_CLEARANCE = 6

local function isUsableTargetCFrame(value)
    if typeof(value) ~= "CFrame" then
        return false
    end

    local position = value.Position
    if position.X ~= position.X or position.Y ~= position.Y or position.Z ~= position.Z then
        return false
    end

    return position.Magnitude > 0.5
end


combatPlayerCountLabel = nil
combatTargetLabel = nil
bountyCurrentLabel = nil
bountyEarnedLabel = nil
bountyStatusLabel = nil
combatPlayerDropdown = nil
fruitNotificationSeen = setmetatable({}, {__mode = "k"})
lastClickAttackAt = 0
lastTeleportIssueAt = 0
lastTeleportIssueCFrame = nil
lastBoneFarmMoveAt = 0
lastBoneFarmMoveCFrame = nil
aimbotFovCircle = nil
aimbotKeyOptions = {
    "Q",
    "E",
    "R",
    "T",
    "Y",
    "F",
    "G",
    "X",
    "C",
    "V",
    "B",
    "LeftAlt",
    "RightAlt",
    "LeftControl",
    "RightControl",
    "LeftShift",
    "RightShift"
}


specialNotificationState = {
    mirage = false,
    kitsune = false,
    prehistoric = false
}

dojoQuestClaimed = false
dojoQuestText = ""
dragonHunterClaimed = false
dragonHunterText = ""
lastMovementNoClipUpdate = 0

dragonNpcFallbacks = {
    DojoTrainer = CFrame.new(5867, 1208, 872),
    DragonWizard = CFrame.new(5771, 1209, 804),
    DragonHunter = CFrame.new(5864, 1209, 810),
    Alchemist = CFrame.new(-2777, 73, -3570),
    Wenlocktoad = CFrame.new(-1988, 124, -70)
}

raceQuestV3HumanBossNames = {"Fajita", "Diamond", "Jeremy"}
raceQuestV3HumanBossFallbacks = {
    Fajita = CFrame.new(-2297.40332, 115.449463, -3946.53833),
    Diamond = CFrame.new(-1736.26587, 198.627731, -236.412857),
    Jeremy = CFrame.new(2203.76953, 448.966034, 752.731079)
}
v4TrialTreeTopCFrame = CFrame.new(3030.39453125, 2280.6171875, -7320.18359375)
v4TrialTempleCFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
v4TrialTempleEntrance = Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875)
v4TrialLeverCFrame = CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734)
v4TrialGearCFrame = CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375)
v4TrialCyborgTrialCFrame = CFrame.new(28654, 14898.7832, -30)
v4TrialSkyPartNames = {
    ["snowisland_Cylinder.081"] = true
}
v4TrialRaceDoorTargets = {
    Human = CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375),
    Skypiea = CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375),
    Angel = CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375),
    Fishman = CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156),
    Shark = CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156),
    Cyborg = CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156),
    Ghoul = CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156),
    Mink = CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094),
    Rabbit = CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094)
}

dragonDojoTargets = {
    Yellow = {"Shark", "Piranha"},
    Red = {"Terrorshark", "Sea Beast"},
    FireFlower = {"Forest Pirate", "Mythological Pirate"}
}

eliteHunterTargetNames = {
    "Diablo [Lv. 1750]",
    "Deandre [Lv. 1750]",
    "Urban [Lv. 1750]",
    "Diablo",
    "Deandre",
    "Urban"
}

readWorkspaceFile = function(path)
    if not (readfile and isfile) then
        return nil
    end

    local candidates = {path}
    local filename = type(path) == "string" and path:match("[^\\/]+$") or nil
    if filename and filename ~= path then
        table.insert(candidates, filename)
    end

    for _, candidate in ipairs(candidates) do
        if isfile(candidate) then
            local ok, result = pcall(readfile, candidate)
            if ok and type(result) == "string" and result ~= "" then
                return result
            end
        end
    end

    return nil
end

pirateRaidEnemyTokens = {
    "mercenary",
    "swan pirate",
    "factory staff",
    "marine lieutenant",
    "marine captain",
    "vampire",
    "snow trooper",
    "winter warrior",
    "lab subordinate",
    "horned warrior",
    "magma ninja",
    "lava pirate",
    "ship deckhand",
    "ship engineer",
    "ship steward",
    "ship officer",
    "arctic warrior",
    "snow lurker",
    "sea soldier",
    "water fighter"
}

pirateRaidFallbackCFrame = CFrame.new(-5074, 315, -2991)
cakePrinceBossNames = {"Cake Prince [Lv. 2300] [Raid Boss]", "Cake Prince"}
doughKingBossNames = {"Dough King [Lv. 2300] [Raid Boss]", "Dough King"}
cakeMobNames = {
    "Cookie Crafter [Lv. 2200]",
    "Cake Guard [Lv. 2225]",
    "Baking Staff [Lv. 2250]",
    "Head Baker [Lv. 2275]",
    "Cookie Crafter",
    "Cake Guard",
    "Baking Staff",
    "Head Baker"
}
cakeMobTokens = {"cookie crafter", "cake guard", "baking staff", "head baker"}
cocoaMobNames = {
    "Chocolate Bar Battler [Lv. 2325]",
    "Chocolate Bar Battler",
    "Cocoa Warrior",
    "Sweet Thief",
    "Candy Rebel"
}
cocoaMobTokens = {"chocolate bar battler", "cocoa warrior", "sweet thief", "candy rebel"}
boneMobNames = {
    "Reborn Skeleton [Lv. 1975]",
    "Living Zombie [Lv. 2000]",
    "Demonic Soul [Lv. 2025]",
    "Posessed Mummy [Lv. 2050]",
    "Reborn Skeleton",
    "Living Zombie",
    "Demonic Soul",
    "Posessed Mummy"
}
boneMobTokens = {"reborn skeleton", "living zombie", "demonic soul", "posessed mummy"}
soulReaperBossNames = {"Soul Reaper [Lv. 2100] [Raid Boss]", "Soul Reaper"}
longmaBossNames = {"Longma"}
tyrantBossNames = {"Tyrant of the Skies [Lv. 2600] [Raid Boss]", "Tyrant of the Skies"}
tyrantMobNames = {"Isle Outlaw", "Island Boy", "Isle Champion", "Serpent Hunter", "Skull Slayer"}
holyTorchPath = {
    CFrame.new(-10752, 417, -9366),
    CFrame.new(-11672, 334, -9474),
    CFrame.new(-12132, 521, -10655),
    CFrame.new(-13336, 486, -6985),
    CFrame.new(-13489, 332, -7925)
}
tyrantSearchPoints = {
    CFrame.new(-1436.86011, 167.753616, -12296.9512),
    CFrame.new(-2383.78979, 150.450592, -12126.4961),
    CFrame.new(-2231.2793, 168.256653, -12845.7559)
}
cdkMythologicalPirateCFrame = CFrame.new(-13451.46484375, 543.712890625, -6961.0029296875)
cdkGoodTrialPath = {
    CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125),
    CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625),
    CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875)
}

cdkGoodTrialStage2CFrame = CFrame.new(-5545.1240234375, 313.800537109375, -2976.616455078125)
cdkCakeQueenCFrame = CFrame.new(-709.3132934570313, 381.6005859375, -11011.396484375)
cdkFinalPedestalCFrame = CFrame.new(-12361.7060546875, 603.3547973632813, -6550.5341796875)
cdkFinalBossNames = {"Cursed Skeleton Boss [Lv. 2025] [Boss]", "Cursed Skeleton Boss"}
cdkFinalBossFallbackCFrame = CFrame.new(-12253.5419921875, 598.8999633789063, -6546.8388671875)

observationTargets = {
    ["First Sea"] = {Enemy = "Galley Captain [Lv. 650]", Spawn = CFrame.new(5569, 29, 4967)},
    ["Second Sea"] = {Enemy = "Lava Pirate [Lv. 1200]", Spawn = CFrame.new(-5478, 16, -5247)},
    ["Third Sea"] = {Enemy = "Giant Islander [Lv. 1650]", Spawn = CFrame.new(4530, 657, -132)}
}

raidChipOptions = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix"}
fruitM1Whitelist = {
    leopard = true,
    dragon = true,
    dough = true,
    rubber = true,
    venom = true,
    spirit = true,
    mammoth = true,
    ["t-rex"] = true,
    trex = true
}
lastObservationHop = 0
lastCakePrinceAttempt = 0
lastBoneSurpriseAttempt = 0
lastTyrantSearchTick = 0
lastTyrantSearchIndex = 0
lastBerryHop = 0
lastFruitScan = 0
lastAutoFruitHop = 0
lastObservationToggleAt = 0
recentFruitNotificationKeys = {}
berryAttemptCache = {
    key = nil,
    attempts = 0,
    lastTry = 0
}

function addConnection(connection)
    table.insert(connections, connection)
    return connection
end

function Hop()
    local browser = ReplicatedStorage:FindFirstChild("__ServerBrowser")
    if not browser then
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
        return false
    end

    for page = 1, 100 do
        local ok, serverPage = pcall(function()
            return browser:InvokeServer(page)
        end)

        if ok and type(serverPage) == "table" then
            for jobId, serverInfo in pairs(serverPage) do
                local count = type(serverInfo) == "table" and tonumber(serverInfo.Count) or nil
                if jobId ~= game.JobId and count and count < 10 then
                    local lastHop = recentServerHops[jobId]
                    if not lastHop or tick() - lastHop > 600 then
                        recentServerHops[jobId] = tick()
                        pcall(function()
                            browser:InvokeServer("teleport", jobId)
                        end)
                        return true
                    end
                end
            end
        end
    end

    TeleportService:Teleport(game.PlaceId, LocalPlayer)
    return false
end

function disconnectAll()
    for _, connection in ipairs(connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end
    table.clear(connections)
end

function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

function getHumanoid()
    local character = LocalPlayer.Character
    return character and character:FindFirstChildOfClass("Humanoid") or nil
end

function getHumanoidRootPart()
    local character = LocalPlayer.Character
    return character and character:FindFirstChild("HumanoidRootPart") or nil
end

function textContains(text, value)
    return typeof(text) == "string"
        and typeof(value) == "string"
        and string.find(string.lower(text), string.lower(value), 1, true) ~= nil
end

function fruitSupportsM1(tool)
    if not tool or not tool:IsA("Tool") then
        return false
    end

    local toolType = normalizeWeaponType(tool.ToolTip or tool:GetAttribute("WeaponType"))
    if toolType ~= "Blox Fruit" then
        return false
    end

    local fruitName = string.lower(tostring(tool.Name or ""))
    for allowedName in pairs(fruitM1Whitelist) do
        if string.find(fruitName, allowedName, 1, true) then
            return true
        end
    end

    return false
end

function fireFruitM1(tool)
    if not fruitSupportsM1(tool) then
        return false
    end

    local leftClickRemote = tool:FindFirstChild("LeftClickRemote")
    local hrp = getHumanoidRootPart()
    if not leftClickRemote or not leftClickRemote:IsA("RemoteEvent") or not hrp then
        return false
    end

    local lookVector = hrp.CFrame.LookVector
    local horizontalDirection = Vector3.new(lookVector.X, 0, lookVector.Z)
    if horizontalDirection.Magnitude <= 0.001 then
        horizontalDirection = Vector3.new(0, 0, -1)
    else
        horizontalDirection = horizontalDirection.Unit
    end

    leftClickRemote:FireServer(horizontalDirection, 1)
    return true
end

function clickAttack()
    local now = tick()
    if now - lastClickAttackAt < CLICK_ATTACK_INTERVAL then
        return false
    end

    lastClickAttackAt = now
    local character = LocalPlayer.Character
    local equippedTool = character and character:FindFirstChildOfClass("Tool")
    if equippedTool and fireFruitM1(equippedTool) then
        return true
    end

    VirtualUser:CaptureController()
    VirtualUser:Button1Down(Vector2.new(1280, 672))
    return true
end

function AutoHaki()
    local character = LocalPlayer.Character
    if character and not character:FindFirstChild("HasBuso") then
        CommF:InvokeServer("Buso")
    end
end

function getAllTools()
    local tools = {}
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")

    if character then
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Tool") then
                table.insert(tools, child)
            end
        end
    end

    if backpack then
        for _, child in ipairs(backpack:GetChildren()) do
            if child:IsA("Tool") then
                table.insert(tools, child)
            end
        end
    end

    return tools
end

function getWeaponOptions()
    local options = {"Auto Detect"}
    local seen = {
        ["Auto Detect"] = true
    }

    for _, tool in ipairs(getAllTools()) do
        if not seen[tool.Name] then
            seen[tool.Name] = true
            table.insert(options, tool.Name)
        end
    end

    table.sort(options, function(a, b)
        if a == "Auto Detect" then
            return true
        elseif b == "Auto Detect" then
            return false
        end
        return a < b
    end)

    return options
end

function getWeaponOptionsByType(weaponType)
    local options = {"Auto Detect"}
    local seen = {
        ["Auto Detect"] = true
    }
    local selectedType = normalizeWeaponType(weaponType)

    for _, tool in ipairs(getAllTools()) do
        local toolType = normalizeWeaponType(tool.ToolTip)
        if toolType == selectedType and not seen[tool.Name] then
            seen[tool.Name] = true
            table.insert(options, tool.Name)
        end
    end

    table.sort(options, function(a, b)
        if a == "Auto Detect" then
            return true
        elseif b == "Auto Detect" then
            return false
        end
        return a < b
    end)

    return options
end

function getMeleeWeaponOptions()
    return getWeaponOptionsByType("Melee")
end

function normalizeWeaponType(value)
    if value == "Devil Fruit" then
        return "Blox Fruit"
    end

    return value
end

function requestCombatEquip(duration)
    state.combat.equipRequestedUntil = math.max(state.combat.equipRequestedUntil or 0, tick() + (duration or 0.2))
end

function clearCombatEquipRequest()
    state.combat.equipRequestedUntil = 0
end

function isCombatEquipRequested()
    return (state.combat.equipRequestedUntil or 0) > tick()
end

function shouldAutoEquipNow(forceEquip)
    if not state.autoEquipTool then
        return false
    end

    if forceEquip then
        return true
    end

    return isCombatEquipRequested()
end

function isSeaOfTreatsQuestActive()
    return Sea3 and (
        NameQuest == "CakeQuest1"
        or NameQuest == "CakeQuest2"
        or NameQuest == "ChocQuest1"
        or NameQuest == "ChocQuest2"
        or NameQuest == "CandyQuest1"
    )
end

function setCombatWeaponOverride(source, weaponType, weaponName)
    state.combat.overrideSource = source
    state.combat.overrideType = weaponType
    state.combat.overrideWeapon = weaponName
end

function clearCombatWeaponOverride(source)
    if source == nil or state.combat.overrideSource == source then
        state.combat.overrideSource = nil
        state.combat.overrideType = nil
        state.combat.overrideWeapon = nil
    end
end

function withCombatWeaponOverride(source, weaponType, weaponName, callback)
    setCombatWeaponOverride(source, weaponType, weaponName)
    local ok, result = pcall(callback)
    clearCombatWeaponOverride(source)
    if not ok then
        warn(result)
        return nil
    end
    return result
end

function getAutomationWeaponOverride()
    if state.combat.overrideWeapon or state.combat.overrideType then
        return state.combat.overrideType, state.combat.overrideWeapon
    end

    if (state.autoBoneFarm or state.quests.autoSoulReaper) and state.boneFarmMelee ~= "Auto Detect" then
        return "Melee", state.boneFarmMelee
    end

    if _G.AutoFarm then
        if isSeaOfTreatsQuestActive() and state.seaTreatsFarmMelee ~= "Auto Detect" then
            return "Melee", state.seaTreatsFarmMelee
        end

        if state.levelFarmMelee ~= "Auto Detect" then
            return "Melee", state.levelFarmMelee
        end
    end

    return nil, nil
end

function resolveWeaponName(overrideType, overrideWeapon)
    local activeType, activeWeapon = getAutomationWeaponOverride()
    local selectedWeapon = overrideWeapon
    if selectedWeapon == nil then
        selectedWeapon = activeWeapon ~= nil and activeWeapon or state.selectedWeapon
    end

    if selectedWeapon and selectedWeapon ~= "Auto Detect" then
        for _, tool in ipairs(getAllTools()) do
            if tool.Name == selectedWeapon then
                return tool.Name
            end
        end
    end

    local selectedType = normalizeWeaponType(overrideType or activeType or state.weaponType)

    for _, tool in ipairs(getAllTools()) do
        local tip = tool.ToolTip
        if selectedType == "Blox Fruit" then
            if tip == "Blox Fruit" then
                return tool.Name
            end
        elseif tip == selectedType then
            return tool.Name
        end
    end

    return nil
end

function equipSelectedWeapon(overrideType, overrideWeapon, forceEquip)
    local weaponName = resolveWeaponName(overrideType, overrideWeapon)
    local character = getCharacter()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer:FindFirstChild("Backpack")

    if not humanoid then
        return nil
    end

    if not shouldAutoEquipNow(forceEquip) then
        return character:FindFirstChildOfClass("Tool")
    end

    if not weaponName then
        return character:FindFirstChildOfClass("Tool")
    end

    if character:FindFirstChild(weaponName) then
        return character[weaponName]
    end

    if backpack and backpack:FindFirstChild(weaponName) then
        humanoid:EquipTool(backpack[weaponName])
        task.wait(0.05)
    end

    return character:FindFirstChild(weaponName)
end

function WaitHRP(player)
    if not player or not player.Character then
        return nil
    end

    return player.Character:WaitForChild("HumanoidRootPart", 9)
end

function CheckNearestTeleporter(target)
    local targetPos = target.Position
    local minDist = math.huge
    local chosenTeleport = nil
    local teleports = {}

    if game.PlaceId == 2753915549 then
        teleports = {
            Vector3.new(-7894, 5547, -380),
            Vector3.new(-4607, 874, -1667),
            Vector3.new(61163, 11, 1819),
            Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            Vector3.new(4050, -1, -1814)
        }
    elseif game.PlaceId == 4442272183 then
        teleports = {
            Vector3.new(-390, 332, 673),
            Vector3.new(2285, 15, 905),
            Vector3.new(923, 126, 32852),
            Vector3.new(-6509, 83, -133)
        }
    elseif Sea3 then
        teleports = {
            Vector3.new(-12462, 375, -7552),
            Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            Vector3.new(-5036, 315, -3179),
            Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
            Vector3.new(5319, 23, -93),
            Vector3.new(28286, 14897, 103)
        }
    end

    for _, teleportPos in ipairs(teleports) do
        local distance = (teleportPos - targetPos).Magnitude
        if distance < minDist then
            minDist = distance
            chosenTeleport = teleportPos
        end
    end

    local hrp = getHumanoidRootPart()
    if hrp and chosenTeleport and minDist <= (targetPos - hrp.Position).Magnitude then
        return chosenTeleport
    end

    return nil
end

function requestEntrance(teleportPos)
    if typeof(teleportPos) == "CFrame" then
        teleportPos = teleportPos.Position
    elseif typeof(teleportPos) ~= "Vector3" then
        return false
    end

    local now = os.clock()
    if lastEntranceRequestPos and (lastEntranceRequestPos - teleportPos).Magnitude <= 10 and now - lastEntranceRequestAt < 1 then
        return false
    end

    lastEntranceRequestPos = teleportPos
    lastEntranceRequestAt = now

    pcall(function()
        CommF:InvokeServer("requestEntrance", teleportPos)
    end)

    local hrp = getHumanoidRootPart()
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
    end

    task.wait(0.4)
    return true
end

function shouldRequestQuestEntrance(questCFrame, entrancePos, targetDistanceThreshold, entranceRadius)
    local hrp = getHumanoidRootPart()
    if not hrp or typeof(questCFrame) ~= "CFrame" then
        return false
    end

    local targetDistance = (questCFrame.Position - hrp.Position).Magnitude
    local entranceDistance = (entrancePos - hrp.Position).Magnitude
    return targetDistance > (targetDistanceThreshold or 10000)
        and entranceDistance > (entranceRadius or 350)
end

function stopTeleport()
    isTeleporting = false

    if teleportCompletedConnection then
        pcall(function()
            teleportCompletedConnection:Disconnect()
        end)
        teleportCompletedConnection = nil
    end

    if teleportPartConnection then
        pcall(function()
            teleportPartConnection:Disconnect()
        end)
        teleportPartConnection = nil
    end

    if moveTween then
        pcall(function()
            moveTween:Cancel()
        end)
        moveTween = nil
    end

    teleportTargetCFrame = nil

    local character = LocalPlayer.Character
    if character and character:FindFirstChild("PartTele") then
        character.PartTele:Destroy()
    end
end

function StopTween(active)
    if not active then
        stopTeleport()
    end
end

function resolveTeleportTarget(position)
    if not position then
        return nil
    end

    local positionType = typeof(position)
    if positionType == "CFrame" then
        return isUsableTargetCFrame(position) and position or nil
    elseif positionType == "Vector3" then
        local target = CFrame.new(position)
        return isUsableTargetCFrame(target) and target or nil
    elseif positionType == "Instance" then
        if position:IsA("BasePart") then
            return isUsableTargetCFrame(position.CFrame) and position.CFrame or nil
        elseif position:IsA("Model") then
            local part = position.PrimaryPart or position:FindFirstChildWhichIsA("BasePart")
            return part and isUsableTargetCFrame(part.CFrame) and part.CFrame or nil
        elseif position:IsA("Attachment") then
            return isUsableTargetCFrame(position.WorldCFrame) and position.WorldCFrame or nil
        end
    elseif type(position) == "table" then
        local x = tonumber(position.X or position.x)
        local y = tonumber(position.Y or position.y)
        local z = tonumber(position.Z or position.z)
        if x and y and z then
            local target = CFrame.new(x, y, z)
            return isUsableTargetCFrame(target) and target or nil
        end
    end

    local success, resolved = pcall(function()
        return CFrame.new(position)
    end)
    if not success or not isUsableTargetCFrame(resolved) then
        return nil
    end

    return resolved
end

function topos(position)
    local character = LocalPlayer.Character
    local humanoid = getHumanoid()
    local hrp = getHumanoidRootPart()

    if not character or not humanoid or not hrp or humanoid.Health <= 0 or not position then
        return false
    end

    local target = resolveTeleportTarget(position)
    if not target then
        return false
    end

    local distance = (hrp.Position - target.Position).Magnitude

    if distance <= 3 then
        stopTeleport()
        hrp.CFrame = target
        lastTeleportIssueAt = tick()
        lastTeleportIssueCFrame = target
        return true
    end

    if distance <= TELEPORT_DIRECT_DISTANCE then
        stopTeleport()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.CFrame = target
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        lastTeleportIssueAt = tick()
        lastTeleportIssueCFrame = target
        return true
    end

    local partTele = character:FindFirstChild("PartTele")
    if isTeleporting and moveTween and teleportTargetCFrame and partTele and (teleportTargetCFrame.Position - target.Position).Magnitude <= 3 then
        return true
    end

    if lastTeleportIssueCFrame and (lastTeleportIssueCFrame.Position - target.Position).Magnitude <= 3 and (tick() - lastTeleportIssueAt) < TELEPORT_REISSUE_INTERVAL then
        return true
    end

    local nearestTeleport = CheckNearestTeleporter(target)
    if nearestTeleport
        and distance >= TELEPORT_ENTRANCE_MIN_DISTANCE
        and ((target.Position - nearestTeleport).Magnitude + TELEPORT_ENTRANCE_MIN_SAVINGS) < distance
    then
        requestEntrance(nearestTeleport)
    end

    stopTeleport()

    character = LocalPlayer.Character
    humanoid = getHumanoid()
    hrp = getHumanoidRootPart()
    if not character or not humanoid or not hrp or humanoid.Health <= 0 then
        return false
    end

    partTele = Instance.new("Part")
    partTele.Name = "PartTele"
    partTele.Size = Vector3.new(8, 1, 8)
    partTele.Anchored = true
    partTele.Transparency = 1
    partTele.CanCollide = false
    partTele.CFrame = hrp.CFrame
    partTele.Parent = character

    teleportPartConnection = partTele:GetPropertyChangedSignal("CFrame"):Connect(function()
        if isTeleporting and partTele.Parent then
            local liveRoot = getHumanoidRootPart()
            if liveRoot and liveRoot.Parent then
                liveRoot.CFrame = partTele.CFrame
            end
        end
    end)

    isTeleporting = true
    teleportTargetCFrame = target
    lastTeleportIssueAt = tick()
    lastTeleportIssueCFrame = target
    moveTween = TweenService:Create(partTele, TweenInfo.new(math.max(distance / TELEPORT_SPEED, 0.05), Enum.EasingStyle.Linear), {CFrame = target})

    teleportCompletedConnection = moveTween.Completed:Connect(function(playbackState)
        if teleportCompletedConnection then
            teleportCompletedConnection:Disconnect()
            teleportCompletedConnection = nil
        end

        if teleportPartConnection then
            teleportPartConnection:Disconnect()
            teleportPartConnection = nil
        end

        if character and character:FindFirstChild("PartTele") then
            character.PartTele:Destroy()
        end

        if playbackState == Enum.PlaybackState.Completed then
            local liveRoot = getHumanoidRootPart()
            if liveRoot and liveRoot.Parent then
                liveRoot.CFrame = target
            end
        end

        isTeleporting = false
        moveTween = nil
        teleportTargetCFrame = nil
    end)

    moveTween:Play()
    return true
end

function TP1(position)
    return topos(position)
end

function BringMob(targetName)
    if not (_G.BringMonster or _G.BringMob) or not targetName then
        return
    end

    local hrp = getHumanoidRootPart()
    local enemies = Workspace:FindFirstChild("Enemies")

    if not hrp or not enemies then
        return
    end

    BringPos = hrp.CFrame * CFrame.new(0, -30, 0)
    MPos = BringPos
    PosMon = PosMon or BringPos

    for _, enemy in ipairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
        local head = enemy:FindFirstChild("Head")

        if enemy.Name == targetName and humanoid and enemyRoot and humanoid.Health > 0 then
            if (enemyRoot.Position - hrp.Position).Magnitude <= 350 then
                enemyRoot.CFrame = PosMon
                enemyRoot.CanCollide = false
                enemyRoot.Transparency = 1
                enemyRoot.Size = Vector3.new(60, 60, 60)
                humanoid.JumpPower = 0
                humanoid.WalkSpeed = 0

                if head then
                    head.CanCollide = false
                end

                if not enemyRoot:FindFirstChild("ZyphraxMobLock") then
                    local lock = Instance.new("BodyVelocity")
                    lock.Name = "ZyphraxMobLock"
                    lock.MaxForce = Vector3.new(100000, 100000, 100000)
                    lock.Velocity = Vector3.new(0, 0, 0)
                    lock.Parent = enemyRoot
                end
            end
        end
    end

    pcall(function()
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
    end)
end

function getQuestGui()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainGui = playerGui and playerGui:FindFirstChild("Main")
    return mainGui and mainGui:FindFirstChild("Quest") or nil
end

function getQuestTitleText()
    local questGui = getQuestGui()
    local container = questGui and questGui:FindFirstChild("Container")
    local questTitle = container and container:FindFirstChild("QuestTitle")
    local title = questTitle and questTitle:FindFirstChild("Title")
    return title and title.Text or ""
end

local submergedQuestFirstDropCFrame = CFrame.new(9466, 92, 9498)
local submergedQuestDropCFrame = CFrame.new(9299, -1554, 9551)
local submergedQuestStartAttemptAt = 0
local submergedQuestRouteStage = "first_drop"
local submergedQuestFirstDropRange = 120
local submergedQuestDropRange = 80
local submergedQuestNpcRange = 300
local submergedQuestQuestInvokeRange = 15
local submergedQuestReachedFirstDrop = false

function getSubmergedQuestDropCFrame()
    return submergedQuestDropCFrame
end

function isSubmergedQuestTarget()
    return NameQuest == "SubmergedQuest2" or NameQuest == "SubmergedQuest3"
end

function ensureSubmergedQuestEntryPoint()
    if not isSubmergedQuestTarget() then
        submergedQuestReachedFirstDrop = false
        return true
    end

    local hrp = getHumanoidRootPart()
    if not hrp then
        return false
    end

    if (hrp.Position - submergedQuestFirstDropCFrame.Position).Magnitude <= submergedQuestFirstDropRange then
        submergedQuestReachedFirstDrop = true
        return true
    end

    if submergedQuestReachedFirstDrop then
        return true
    end

    StartBring = false
    TP1(submergedQuestFirstDropCFrame)
    return false
end

function handleSubmergedQuestStart()
    local hrp = getHumanoidRootPart()
    if not hrp then
        return false
    end

    local questGiverCFrame = getNpcTargetCFrame("Submerged Quest Giver 2")
    local firstDropDistance = (hrp.Position - submergedQuestFirstDropCFrame.Position).Magnitude
    local dropCFrame = getSubmergedQuestDropCFrame()
    local dropDistance = dropCFrame and (hrp.Position - dropCFrame.Position).Magnitude or math.huge
    local questGiverDistance = questGiverCFrame and (hrp.Position - questGiverCFrame.Position).Magnitude or math.huge

    if firstDropDistance <= submergedQuestFirstDropRange then
        submergedQuestReachedFirstDrop = true
    end

    if questGiverDistance <= submergedQuestQuestInvokeRange then
        local now = tick()
        if now - submergedQuestStartAttemptAt >= 1 then
            submergedQuestStartAttemptAt = now
            CommF:InvokeServer(unpack({
                "StartQuest",
                "SubmergedQuest2",
                1
            }))
        end
        submergedQuestRouteStage = "first_drop"
        submergedQuestReachedFirstDrop = false
        return true
    end

    if not submergedQuestReachedFirstDrop then
        submergedQuestRouteStage = "first_drop"
    elseif questGiverCFrame and questGiverDistance <= submergedQuestNpcRange then
        submergedQuestRouteStage = "npc"
    elseif dropDistance <= submergedQuestNpcRange then
        submergedQuestRouteStage = "npc"
    elseif dropDistance <= submergedQuestDropRange then
        submergedQuestRouteStage = "drop"
    else
        submergedQuestRouteStage = "drop"
    end

    if submergedQuestRouteStage == "first_drop" then
        TP1(submergedQuestFirstDropCFrame)
        return true
    end

    if submergedQuestRouteStage == "drop" then
        TP1(dropCFrame)
        submergedQuestRouteStage = "npc"
        return true
    end

    if questGiverCFrame then
        TP1(questGiverCFrame * CFrame.new(0, 3, 0))
        return true
    end

    return true
end

function ensureQuestStarted()
    CheckQuest()

    if not isUsableTargetCFrame(CFrameQuest) or NameQuest == "" or NameMon == "" then
        return false
    end

    if not ensureSubmergedQuestEntryPoint() then
        return false
    end

    local questGui = getQuestGui()
    local questTitle = getQuestTitleText()

    if questGui and questGui.Visible and not textContains(questTitle, NameMon) then
        StartBring = false
        CommF:InvokeServer("AbandonQuest")
        task.wait(0.25)
        return false
    end

    if not questGui or not questGui.Visible then
        StartBring = false
        TP1(CFrameQuest)

        local hrp = getHumanoidRootPart()
        if hrp and (hrp.Position - CFrameQuest.Position).Magnitude <= 20 then
            CommF:InvokeServer("StartQuest", NameQuest, LevelQuest)
        end

        return false
    end

    return true
end

function findClosestNamedEnemy(targetName)
    local hrp = getHumanoidRootPart()
    local enemies = Workspace:FindFirstChild("Enemies")
    local closestEnemy = nil
    local closestDistance = math.huge

    if not hrp or not enemies then
        return nil
    end

    for _, enemy in ipairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")

        if enemy.Name == targetName and humanoid and enemyRoot and humanoid.Health > 0 then
            local distance = (enemyRoot.Position - hrp.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestEnemy = enemy
            end
        end
    end

    return closestEnemy
end

function findNearestEnemy(maxDistance)
    local hrp = getHumanoidRootPart()
    local enemies = Workspace:FindFirstChild("Enemies")
    local nearestEnemy = nil
    local nearestDistance = maxDistance or math.huge

    if not hrp or not enemies then
        return nil
    end

    for _, enemy in ipairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")

        if humanoid and enemyRoot and humanoid.Health > 0 then
            local distance = (enemyRoot.Position - hrp.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestEnemy = enemy
            end
        end
    end

    return nearestEnemy
end

function enemyNameHasToken(enemyName, tokens)
    local loweredName = string.lower(enemyName or "")
    for _, token in ipairs(tokens) do
        if string.find(loweredName, token, 1, true) then
            return true
        end
    end

    return false
end

function findClosestEnemyByTokens(tokens)
    local hrp = getHumanoidRootPart()
    local enemies = Workspace:FindFirstChild("Enemies")
    local closestEnemy = nil
    local closestDistance = math.huge

    if not hrp or not enemies then
        return nil
    end

    for _, enemy in ipairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
        if humanoid and enemyRoot and humanoid.Health > 0 and enemyNameHasToken(enemy.Name, tokens) then
            local distance = (enemyRoot.Position - hrp.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestEnemy = enemy
            end
        end
    end

    return closestEnemy
end

function isChestName(name)
    return string.find(string.lower(name or ""), "chest", 1, true) ~= nil
end

function isChestPart(item)
    if not item or not item:IsA("BasePart") or not item.Parent then
        return false
    end

    if LocalPlayer.Character and item:IsDescendantOf(LocalPlayer.Character) then
        return false
    end

    local parent = item.Parent
    if not isChestName(item.Name) and not (parent and isChestName(parent.Name)) then
        return false
    end

    return item:FindFirstChildOfClass("TouchTransmitter")
        or item:FindFirstChild("TouchInterest")
        or item:FindFirstChildWhichIsA("TouchTransmitter", true)
        or (parent and parent:FindFirstChildOfClass("ProximityPrompt", true))
end

function getChestOwner(item)
    if not item then
        return nil
    end

    local current = item
    while current and current ~= Workspace do
        if isChestName(current.Name) then
            return current
        end
        current = current.Parent
    end

    return item.Parent or item
end

function getChestDisplayPart(item)
    local owner = getChestOwner(item)
    if not owner then
        return item
    end

    if owner:IsA("BasePart") then
        return owner
    end

    if owner:IsA("Model") then
        return owner.PrimaryPart
            or owner:FindFirstChild("HumanoidRootPart")
            or owner:FindFirstChild("Handle")
            or owner:FindFirstChildWhichIsA("BasePart", true)
            or item
    end

    return owner:FindFirstChildWhichIsA("BasePart", true) or item
end

function insertNearestCandidate(candidates, entry, maxCount)
    local insertIndex = #candidates + 1

    for index = 1, #candidates do
        if entry.distance < candidates[index].distance then
            insertIndex = index
            break
        end
    end

    if insertIndex > maxCount then
        return
    end

    table.insert(candidates, insertIndex, entry)
    if #candidates > maxCount then
        table.remove(candidates)
    end
end

function pruneChestCache(now)
    local writeIndex = 1

    for index = 1, #chestScanCache.parts do
        local part = chestScanCache.parts[index]
        local retryAt = chestScanCache.recent[part]
        if retryAt and retryAt <= now then
            chestScanCache.recent[part] = nil
            retryAt = nil
        end

        if isChestPart(part) then
            chestScanCache.parts[writeIndex] = part
            chestScanCache.lookup[part] = true
            writeIndex = writeIndex + 1
        else
            chestScanCache.lookup[part] = nil
            chestScanCache.recent[part] = nil
        end
    end

    for index = writeIndex, #chestScanCache.parts do
        chestScanCache.parts[index] = nil
    end
end

function refreshChestCache(force)
    local now = tick()
    if not force and not chestScanCache.dirty and now < chestScanCache.nextRefreshAt then
        return
    end

    local parts = {}
    local lookup = setmetatable({}, {__mode = "k"})

    for _, item in ipairs(Workspace:GetDescendants()) do
        if isChestPart(item) then
            parts[#parts + 1] = item
            lookup[item] = true
        end
    end

    chestScanCache.parts = parts
    chestScanCache.lookup = lookup
    chestScanCache.dirty = false
    chestScanCache.nextRefreshAt = now + CHEST_SCAN_REFRESH
    pruneChestCache(now)
end

function getClosestChestFromCache(originPosition, now)
    local closestPart = nil
    local closestDistance = math.huge
    local trackedOwners = {}

    for _, item in ipairs(chestScanCache.parts) do
        local owner = getChestOwner(item)
        local ownerKey = owner or item
        local retryAt = chestScanCache.recent[ownerKey] or chestScanCache.recent[item]
        if item and item.Parent and not trackedOwners[ownerKey] and (not retryAt or retryAt <= now) then
            trackedOwners[ownerKey] = true
            local distance = (item.Position - originPosition).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPart = item
            end
        end
    end

    return closestPart
end

function findClosestChestPart()
    local hrp = getHumanoidRootPart()
    if not hrp then
        return nil
    end

    local now = tick()
    pruneChestCache(now)
    refreshChestCache(false)

    local closestPart = getClosestChestFromCache(hrp.Position, now)
    if closestPart then
        return closestPart
    end

    refreshChestCache(true)
    return getClosestChestFromCache(hrp.Position, tick())
end

function markChestRecentlyHandled(chestPart, duration)
    if chestPart then
        local retryUntil = tick() + (duration or CHEST_RETRY_COOLDOWN)
        local owner = getChestOwner(chestPart)
        chestScanCache.recent[chestPart] = retryUntil
        if owner then
            chestScanCache.recent[owner] = retryUntil
        end
    end
end

function tryCollectChest(chestPart)
    local hrp = getHumanoidRootPart()
    if not hrp or not chestPart or not chestPart:IsA("BasePart") or not chestPart.Parent then
        return false
    end

    local targetCFrame = chestPart.CFrame * CFrame.new(0, 1.2, 0)
    local distance = (hrp.Position - chestPart.Position).Magnitude
    if distance > CHEST_INTERACT_DISTANCE then
        markChestRecentlyHandled(chestPart, 0.2)
        TP1(targetCFrame)
        return true
    end

    local interacted = false
    pcall(function()
        if firetouchinterest then
            firetouchinterest(hrp, chestPart, 0)
            task.wait(0.03)
            firetouchinterest(hrp, chestPart, 1)
            interacted = true
        end
    end)

    local prompt = chestPart.Parent and chestPart.Parent:FindFirstChildOfClass("ProximityPrompt", true)
    if prompt and fireproximityprompt then
        pcall(function()
            fireproximityprompt(prompt)
            interacted = true
        end)
    end

    markChestRecentlyHandled(chestPart, interacted and CHEST_RETRY_COOLDOWN or 0.35)

    return interacted
end

addConnection(Workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") and isChestPart(descendant) and not chestScanCache.lookup[descendant] then
        chestScanCache.lookup[descendant] = true
        chestScanCache.parts[#chestScanCache.parts + 1] = descendant
    elseif descendant:IsA("BasePart") then
        local parent = descendant.Parent
        if isChestName(descendant.Name) or (parent and isChestName(parent.Name)) then
            chestScanCache.dirty = true
        end
    elseif descendant:IsA("ProximityPrompt") then
        local parent = descendant.Parent
        if parent and parent:IsA("BasePart") then
            local grandParent = parent.Parent
            if isChestName(parent.Name) or (grandParent and isChestName(grandParent.Name)) then
                chestScanCache.dirty = true
            end
        end
    end

    if isFlowerEspItem(descendant) then
        flowerEspCache.dirty = true
    end

    if isSpecialIslandEspItem(descendant) then
        specialIslandEspCache.dirty = true
    end
end))

addConnection(Workspace.DescendantRemoving:Connect(function(descendant)
    if chestScanCache.lookup[descendant] then
        chestScanCache.lookup[descendant] = nil
        chestScanCache.recent[descendant] = nil
        local owner = getChestOwner(descendant)
        if owner then
            chestScanCache.recent[owner] = nil
        end
        return
    end

    if descendant:IsA("BasePart") then
        local parent = descendant.Parent
        if isChestName(descendant.Name) or (parent and isChestName(parent.Name)) then
            chestScanCache.dirty = true
        end
    end

    if flowerEspCache.lookup[descendant] or isFlowerEspItem(descendant) then
        flowerEspCache.lookup[descendant] = nil
        flowerEspCache.dirty = true
    end

    if specialIslandEspCache.lookup[descendant] or isSpecialIslandEspItem(descendant) then
        specialIslandEspCache.lookup[descendant] = nil
        specialIslandEspCache.dirty = true
    end
end))

function getMirageIslandTargetCFrame()
    local map = Workspace:FindFirstChild("Map")
    if not map then
        return nil
    end

    local island = map:FindFirstChild("MysticIsland") or map:FindFirstChild("Mirage Island")
    if not island then
        return nil
    end

    local spawnFolder = island:FindFirstChild("npcspawn", true)
    local spawnPart = spawnFolder and (spawnFolder:FindFirstChild("npcSpawn", true) or spawnFolder:FindFirstChildWhichIsA("BasePart", true))
    local targetPart = spawnPart or getAdornmentPart(island)
    return targetPart and (targetPart.CFrame * CFrame.new(0, 4, 0)) or nil
end

function notifyZyphrax(title, description, duration)
    window = state.window
    if window and window.Notify then
        window:Notify({
            Title = title,
            Description = description,
            Duration = duration or 3
        })
    end
end

function getNetRemote(remoteName)
    local modules = ReplicatedStorage:FindFirstChild("Modules")
    local netFolder = modules and modules:FindFirstChild("Net")
    return netFolder and netFolder:FindFirstChild(remoteName) or nil
end

function tryInvokeNetRemote(remoteName, payload)
    local remote = getNetRemote(remoteName)
    if not remote or not remote.InvokeServer then
        return nil
    end

    local ok, result = pcall(function()
        return remote:InvokeServer(payload)
    end)

    return ok and result or nil
end

function getMapModel()
    return Workspace:FindFirstChild("Map")
end

function findNpcModelByName(npcName)
    local workspaceNpcs = Workspace:FindFirstChild("NPCs")
    local replicatedNpcs = ReplicatedStorage:FindFirstChild("NPCs")
    return (workspaceNpcs and workspaceNpcs:FindFirstChild(npcName))
        or (replicatedNpcs and replicatedNpcs:FindFirstChild(npcName))
        or nil
end

function getNpcTargetCFrame(npcName)
    local npc = findNpcModelByName(npcName)
    local part = npc and (npc.PrimaryPart or getAdornmentPart(npc))
    return part and part.CFrame or nil
end

function isFruitSpawnInstance(instance)
    if not instance then
        return false
    end

    if not instance:IsDescendantOf(Workspace) then
        return false
    end

    if LocalPlayer.Character and instance:IsDescendantOf(LocalPlayer.Character) then
        return false
    end

    if not (instance:IsA("Tool") or instance:IsA("Model")) then
        return false
    end

    if string.find(string.lower(instance.Name), "fruit", 1, true) == nil then
        return false
    end

    local handle = instance:FindFirstChild("Handle")
    if not handle or not handle:IsA("BasePart") then
        return false
    end

    return handle:FindFirstChildOfClass("TouchTransmitter") ~= nil
        or handle:FindFirstChild("TouchInterest") ~= nil
end

function refreshFruitSpawnCache(force)
    local now = tick()
    if not force and not fruitScanCache.dirty and now < fruitScanCache.nextRefreshAt then
        return
    end

    local handles = {}
    local lookup = setmetatable({}, {__mode = "k"})

    for _, instance in ipairs(Workspace:GetChildren()) do
        if isFruitSpawnInstance(instance) then
            local handle = instance:FindFirstChild("Handle")
            if handle and handle:IsA("BasePart") then
                handles[#handles + 1] = handle
                lookup[handle] = true
            end
        end
    end

    fruitScanCache.handles = handles
    fruitScanCache.lookup = lookup
    fruitScanCache.dirty = false
    fruitScanCache.nextRefreshAt = now + FRUIT_SCAN_REFRESH
end

function getFruitSpawnHandles(forceRefresh)
    refreshFruitSpawnCache(forceRefresh)

    local handles = fruitScanCache.handles
    local writeIndex = 1
    for index = 1, #handles do
        local handle = handles[index]
        local parent = handle and handle.Parent
        if handle
            and handle:IsDescendantOf(Workspace)
            and parent
            and isFruitSpawnInstance(parent)
        then
            handles[writeIndex] = handle
            fruitScanCache.lookup[handle] = true
            writeIndex = writeIndex + 1
        else
            fruitScanCache.lookup[handle] = nil
        end
    end

    for index = writeIndex, #handles do
        handles[index] = nil
    end

    return handles
end

function refreshFlowerEspCache(force)
    local now = tick()
    if not force and not flowerEspCache.dirty and now < flowerEspCache.nextRefreshAt then
        return
    end

    local items = {}
    local lookup = setmetatable({}, {__mode = "k"})

    for _, item in ipairs(Workspace:GetDescendants()) do
        if isFlowerEspItem(item) then
            items[#items + 1] = item
            lookup[item] = true
        end
    end

    flowerEspCache.items = items
    flowerEspCache.lookup = lookup
    flowerEspCache.dirty = false
    flowerEspCache.nextRefreshAt = now + FLOWER_SCAN_REFRESH
end

function getFlowerEspItems(forceRefresh)
    refreshFlowerEspCache(forceRefresh)

    local items = flowerEspCache.items
    local writeIndex = 1
    for index = 1, #items do
        local item = items[index]
        if item and item:IsDescendantOf(Workspace) and isFlowerEspItem(item) then
            items[writeIndex] = item
            flowerEspCache.lookup[item] = true
            writeIndex = writeIndex + 1
        else
            flowerEspCache.lookup[item] = nil
        end
    end

    for index = writeIndex, #items do
        items[index] = nil
    end

    return items
end

function refreshSpecialIslandEspCache(force)
    local now = tick()
    if not force and not specialIslandEspCache.dirty and now < specialIslandEspCache.nextRefreshAt then
        return
    end

    local items = {}
    local lookup = setmetatable({}, {__mode = "k"})

    for _, item in ipairs(Workspace:GetDescendants()) do
        if isSpecialIslandEspItem(item) then
            items[#items + 1] = item
            lookup[item] = true
        end
    end

    specialIslandEspCache.items = items
    specialIslandEspCache.lookup = lookup
    specialIslandEspCache.dirty = false
    specialIslandEspCache.nextRefreshAt = now + SPECIAL_ISLAND_SCAN_REFRESH
end

function getSpecialIslandEspItems(forceRefresh)
    refreshSpecialIslandEspCache(forceRefresh)

    local items = specialIslandEspCache.items
    local writeIndex = 1
    for index = 1, #items do
        local item = items[index]
        if item and item:IsDescendantOf(Workspace) and isSpecialIslandEspItem(item) then
            items[writeIndex] = item
            specialIslandEspCache.lookup[item] = true
            writeIndex = writeIndex + 1
        else
            specialIslandEspCache.lookup[item] = nil
        end
    end

    for index = writeIndex, #items do
        items[index] = nil
    end

    return items
end

function scanFruitSpawnNotifications(targetInstance)
    if not state.fruitNotifications then
        return
    end

    local hrp = getHumanoidRootPart()
    local now = tick()
    for key, timestamp in pairs(recentFruitNotificationKeys) do
        if now - timestamp > 120 then
            recentFruitNotificationKeys[key] = nil
        end
    end

    local function notifyInstance(instance)
        local handle = instance and instance:FindFirstChild("Handle")
        if handle and isFruitSpawnInstance(instance) and not fruitNotificationSeen[instance] then
            local key = string.lower(instance.Name)
                .. ":"
                .. tostring(math.floor(handle.Position.X / 8))
                .. ":"
                .. tostring(math.floor(handle.Position.Y / 8))
                .. ":"
                .. tostring(math.floor(handle.Position.Z / 8))

            if recentFruitNotificationKeys[key] and now - recentFruitNotificationKeys[key] <= 45 then
                fruitNotificationSeen[instance] = true
                return
            end

            fruitNotificationSeen[instance] = true
            recentFruitNotificationKeys[key] = now
            local message = instance.Name
            if hrp then
                message = string.format("%s - %.0f studs away", instance.Name, (handle.Position - hrp.Position).Magnitude)
            end
            notifyZyphrax("Fruit Spawned", message, 5)
        end
    end

    if targetInstance then
        notifyInstance(targetInstance)
        return
    end

    for _, instance in ipairs(Workspace:GetChildren()) do
        notifyInstance(instance)
    end
end

function findNearestFruitSpawnHandle()
    local hrp = getHumanoidRootPart()
    local bestHandle
    local bestDistance = math.huge

    for _, handle in ipairs(getFruitSpawnHandles(false)) do
        local distance = hrp and (handle.Position - hrp.Position).Magnitude or 0
        if distance < bestDistance then
            bestDistance = distance
            bestHandle = handle
        end
    end

    if bestHandle then
        return bestHandle, bestDistance
    end

    for _, handle in ipairs(getFruitSpawnHandles(true)) do
        local distance = hrp and (handle.Position - hrp.Position).Magnitude or 0
        if distance < bestDistance then
            bestDistance = distance
            bestHandle = handle
        end
    end

    return bestHandle, bestDistance
end

function runAutoTweenFruitStep()
    local handle = findNearestFruitSpawnHandle()
    if handle then
        TP1(handle.CFrame * CFrame.new(0, 3, 0))
        return true
    end

    if state.autoTweenFruitHop and tick() - lastAutoFruitHop >= 20 then
        lastAutoFruitHop = tick()
        Hop()
        return true
    end

    return false
end

addConnection(Workspace.ChildAdded:Connect(function(child)
    pcall(function()
        if isFruitSpawnInstance(child) then
            fruitScanCache.dirty = true
        end
        scanFruitSpawnNotifications(child)
    end)
end))

addConnection(Workspace.ChildRemoved:Connect(function(child)
    if isFruitSpawnInstance(child) then
        fruitScanCache.dirty = true
    else
        local handle = child and child:FindFirstChild("Handle")
        if handle and fruitScanCache.lookup[handle] then
            fruitScanCache.lookup[handle] = nil
            fruitScanCache.dirty = true
        end
    end
end))

function getKitsuneIslandModel()
    local map = getMapModel()
    if not map then
        return nil
    end

    return map:FindFirstChild("KitsuneIsland") or map:FindFirstChild("Kitsune Island")
end

function getKitsuneIslandTargetCFrame()
    local island = getKitsuneIslandModel()
    if not island then
        return nil
    end

    local shrine = island:FindFirstChild("ShrineActive", true)
    if shrine then
        for _, descendant in ipairs(shrine:GetDescendants()) do
            if descendant:IsA("BasePart") and string.find(descendant.Name, "NeonShrinePart", 1, true) then
                return descendant.CFrame * CFrame.new(0, 4, 0)
            end
        end
    end

    local part = getAdornmentPart(island)
    return part and (part.CFrame * CFrame.new(0, 4, 0)) or nil
end

function getMirageGearPart()
    local map = getMapModel()
    local island = map and map:FindFirstChild("MysticIsland")
    if not island then
        return nil
    end

    for _, descendant in ipairs(island:GetDescendants()) do
        if descendant:IsA("MeshPart") and descendant.MeshId == "rbxassetid://10153114969" then
            return descendant
        end
    end

    return nil
end

function getAdvancedFruitDealerCFrame()
    local npc = findNpcModelByName("Advanced Fruit Dealer")
    local part = npc and (npc.PrimaryPart or getAdornmentPart(npc))
    return part and part.CFrame or nil
end

function getFactoryCoreEnemy()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then
        return nil
    end

    local core = enemies:FindFirstChild("Core")
    if core and core:FindFirstChild("Humanoid") and core.Humanoid.Health > 0 then
        return core
    end

    for _, enemy in ipairs(enemies:GetChildren()) do
        if enemy.Name == "Core" and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            return enemy
        end
    end

    return nil
end

function getHydraTreePart()
    local map = getMapModel()
    local islandFolder = map and map:FindFirstChild("Waterfall")
    local hydraFolder = islandFolder and islandFolder:FindFirstChild("IslandModel")
    local islandChunks = hydraFolder and hydraFolder:FindFirstChild("IslandChunks")
    local treeFolder = islandChunks and islandChunks:FindFirstChild("F")
    if not treeFolder then
        return nil
    end

    for _, chunk in ipairs(treeFolder:GetChildren()) do
        local group = chunk:FindFirstChild("Group")
        local part = group and group:FindFirstChild("Part")
        if part and (part.Color == Color3.fromRGB(130, 107, 64) or part.Color == Color3.fromRGB(231, 231, 236)) then
            return part
        end
    end

    return nil
end

function updateSpecialIslandNotifications()
    local map = getMapModel()
    local mirageSpawned = map and (map:FindFirstChild("MysticIsland") or map:FindFirstChild("Mirage Island")) ~= nil or false
    local kitsuneSpawned = getKitsuneIslandModel() ~= nil
    local prehistoricSpawned = getPrehistoricIsland() ~= nil

    if state.mirageNotifications and mirageSpawned and not specialNotificationState.mirage then
        notifyZyphrax("Mirage Island", "Mirage Island has spawned.", 5)
    end

    if state.kitsuneNotifications and kitsuneSpawned and not specialNotificationState.kitsune then
        notifyZyphrax("Kitsune Island", "Kitsune Island has spawned.", 5)
    end

    if state.prehistoricNotifications and prehistoricSpawned and not specialNotificationState.prehistoric then
        notifyZyphrax("Prehistoric Island", "Prehistoric Island has spawned.", 5)
    end

    specialNotificationState.mirage = mirageSpawned
    specialNotificationState.kitsune = kitsuneSpawned
    specialNotificationState.prehistoric = prehistoricSpawned
end

function getDragonNpcCFrame(npcName)
    local lookupKey = string.gsub(npcName or "", "%s+", "")
    return getNpcTargetCFrame(npcName) or dragonNpcFallbacks[lookupKey]
end

function invokeDragonQuest(payload)
    return tryInvokeNetRemote("RF/InteractDragonQuest", payload)
end

function invokeDragonHunter(payload)
    return tryInvokeNetRemote("RF/DragonHunter", payload)
end

function invokeFruitCustomizer(payload)
    return tryInvokeNetRemote("RF/FruitCustomizerRF", payload)
end

function getPlayerRaceName()
    local data = LocalPlayer:FindFirstChild("Data")
    local raceValue = data and data:FindFirstChild("Race")
    return raceValue and raceValue.Value or ""
end

function hasRaceEvolved()
    local data = LocalPlayer:FindFirstChild("Data")
    local raceValue = data and data:FindFirstChild("Race")
    return raceValue and raceValue:FindFirstChild("Evolved") ~= nil or false
end

function getPlayerBeli()
    local data = LocalPlayer:FindFirstChild("Data")
    local beli = data and data:FindFirstChild("Beli")
    return beli and tonumber(beli.Value) or 0
end

function getSeaDangerLevel()
    return tonumber(LocalPlayer:GetAttribute("DangerLevel")) or 0
end

function syncLegacyDragonFlags()
    state.autoDojoTrainer = state.dragon.autoDojoTrainer
    state.autoBlazeEmbers = state.dragon.autoDragonHunter
    dojoQuestClaimed = state.dragon.currentBeltQuest ~= nil
    dojoQuestText = state.dragon.status or ""
    dragonHunterClaimed = state.dragon.currentDragonHunterQuest ~= nil
    dragonHunterText = state.dragon.hunterStatus or ""
    if state.craft.autoTradeAzureEmber then
        state.autoKitsunePray = true
    end
end

function getAuraSkinData()
    local craftState = state.craft
    if craftState.auraSkins then
        return craftState.auraSkins
    end

    local ok, skinUtil = pcall(function()
        local moduleFolder = ReplicatedStorage:FindFirstChild("Modules")
        local skinModule = (moduleFolder and moduleFolder:FindFirstChild("SkinUtil")) or ReplicatedStorage:FindFirstChild("SkinUtil")
        return skinModule and require(skinModule) or {}
    end)

    craftState.auraSkins = ok and (skinUtil.AuraSkins or skinUtil) or {}
    return craftState.auraSkins
end

function getAuraColorOptions()
    local options = {}
    for auraName, auraInfo in pairs(getAuraSkinData()) do
        if type(auraInfo) == "table" and auraInfo.EtcItems then
            table.insert(options, auraName)
        end
    end
    table.sort(options)
    state.craft.auraOptions = options
    return options
end

function getAuraCraftRequirements(auraName)
    return (getAuraSkinData()[auraName] or {}).EtcItems
end

function getUnlockedAuraColors(force)
    local craftState = state.craft
    if not force and craftState.unlockedAuras and tick() - (craftState.unlockedAurasAt or 0) < 30 then
        return craftState.unlockedAuras
    end

    local unlocked = invokeFruitCustomizer({
        Context = "GetSkinsInventory"
    })

    craftState.unlockedAuras = type(unlocked) == "table" and unlocked or {}
    craftState.unlockedAurasAt = tick()
    return craftState.unlockedAuras
end

function hasAuraColorUnlocked(auraName)
    local unlocked = getUnlockedAuraColors()
    return unlocked and unlocked[auraName] ~= nil
end

function getDragonEggInstance()
    local island = getPrehistoricIsland()
    local core = island and island:FindFirstChild("Core")
    local eggs = core and core:FindFirstChild("SpawnedDragonEggs")
    return eggs and eggs:FindFirstChild("DragonEgg") or nil
end

function getFireFlowerTarget()
    local fireFlowers = Workspace:FindFirstChild("FireFlowers")
    if not fireFlowers then
        return nil
    end

    for _, flower in ipairs(fireFlowers:GetChildren()) do
        local part = flower:IsA("Model") and (flower.PrimaryPart or flower:FindFirstChildWhichIsA("BasePart")) or flower
        if part and part:IsA("BasePart") then
            return flower, part
        end
    end

    return nil
end

function hasDroppedPlayerFruit()
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local function isDroppedFruit(tool)
        return tool
            and tool:IsA("Tool")
            and tool:FindFirstChild("Fruit")
            and tool.ToolTip ~= "Blox Fruit"
            and typeof(tool:GetAttribute("DroppedBy")) == "string"
            and #tool:GetAttribute("DroppedBy") > 0
    end

    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if isDroppedFruit(tool) then
                return true
            end
        end
    end

    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if isDroppedFruit(tool) then
                return true
            end
        end
    end

    return false
end

function getRandomSeaRoamCFrame(levelName)
    local base = seaLevelTargets[levelName] or seaLevelTargets["Level 6"] or seaBoatDockCFrame
    return base * CFrame.new(math.random(-1800, 1800), 50, math.random(-1800, 1800))
end

function getCachedSeaRoamCFrame(cacheKey, levelName)
    local localProgress = state.dragon.localProgress
    local targetKey = tostring(cacheKey) .. "_RoamTarget"
    local timeKey = tostring(cacheKey) .. "_RoamAt"
    if not localProgress[targetKey] or tick() - (localProgress[timeKey] or 0) >= 6 then
        localProgress[targetKey] = getRandomSeaRoamCFrame(levelName)
        localProgress[timeKey] = tick()
    end
    return localProgress[targetKey]
end

function ensureSeaBoatForQuest(targetCFrame)
    local humanoid = getHumanoid()
    local hrp = getHumanoidRootPart()
    if not humanoid or not hrp then
        return false
    end

    local boat = getSeaBoatModel()
    local seat = getSeaBoatSeat(boat)
    local ownerValue = boat and boat:FindFirstChild("Owner")
    local owner = ownerValue and ownerValue.Value or nil
    local ownedByLocalPlayer = owner == LocalPlayer or (owner and owner.Name == LocalPlayer.Name) or false

    if boat and seat and ownedByLocalPlayer then
        if not humanoid.Sit then
            TP1(seat.CFrame * CFrame.new(0, 1, 0))
        else
            tweenSeaBoatTo(targetCFrame or getRandomSeaRoamCFrame("Level 6"))
        end
        return true
    end

    humanoid.Sit = false
    stopSeaBoatTween()
    TP1(seaBoatDockCFrame)

    if (seaBoatDockCFrame.Position - hrp.Position).Magnitude <= 10 then
        local now = os.clock()
        if now - state.sea.lastBoatBuyAttempt >= 1 then
            state.sea.lastBoatBuyAttempt = now
            ensureSeaTeam()
            CommF:InvokeServer("BuyBoat", state.sea.boat)
        end
    end

    return false
end

function runMaterialRouteStep(selection, isEnabled)
    local routeTargets, routeCFrame = getMaterialRoute(selection)
    if not routeTargets or not routeCFrame then
        return false
    end

    local enemy = findClosestNamedEnemyByNames(routeTargets)
    if enemy then
        attackEnemy(enemy, 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running and isEnabled() and enemy.Parent and humanoid and humanoid.Health > 0
        end)
    else
        moveToReplicaOrFallback(routeTargets, routeCFrame, 20)
    end

    return true
end

function refreshDojoQuestState(force)
    local dragonState = state.dragon
    if not force and tick() - (dragonState.lastDojoRefresh or 0) < 2 then
        return dragonState.currentBeltQuest
    end

    dragonState.lastDojoRefresh = tick()
    local questState = invokeDragonQuest({
        NPC = "Dojo Trainer",
        Command = "RequestQuest"
    })

    if type(questState) == "table" then
        dragonState.currentBeltQuest = questState
        local quest = questState.Quest
        if type(quest) == "table" and quest.BeltName then
            dragonState.currentBelt = quest.BeltName
            if quest.Progress ~= nil then
                local beltName = quest.BeltName
                local remoteProgress = tonumber(quest.Progress) or 0
                dragonState.beltProgress[beltName] = math.max(dragonState.beltProgress[beltName] or 0, remoteProgress)
            end
        end
    elseif questState ~= nil then
        dragonState.currentBeltQuest = nil
    end

    syncLegacyDragonFlags()
    return dragonState.currentBeltQuest
end

function refreshDracoQuestState(force)
    local dragonState = state.dragon
    if not force and tick() - (dragonState.lastDracoRefresh or 0) < 2 then
        return dragonState.currentDracoQuest
    end

    dragonState.lastDracoRefresh = tick()
    local questState = invokeDragonQuest({
        NPC = "Dragon Wizard",
        Command = "Speak"
    })

    if type(questState) == "table" then
        dragonState.currentDracoQuest = questState
    elseif questState ~= nil then
        dragonState.currentDracoQuest = nil
    end

    syncLegacyDragonFlags()
    return dragonState.currentDracoQuest
end

function updateDragonProgressFromNotification(textValue)
    local dragonState = state.dragon
    if type(textValue) ~= "string" then
        return
    end

    local currentBelt = dragonState.currentBelt
    if textValue == "Obtained <Color=Purple><Mutant Tooth><Color=/> (1x)" then
        dragonState.beltProgress.Red = (dragonState.beltProgress.Red or 0) + 1
    elseif textValue == "<Color=Yellow><QUEST COMPLETED!><Color=/>" and currentBelt == "White" then
        dragonState.beltProgress.White = (dragonState.beltProgress.White or 0) + 8
    elseif textValue == "Head back to the Dojo to complete more tasks." or textValue == "Dojo quest abandoned!" then
        dragonState.currentDragonHunterQuest = nil
    elseif string.find(textValue, "Earned <Color=Green>%$", 1, false) and currentBelt == "Yellow" and getSeaDangerLevel() >= 100 then
        dragonState.beltProgress.Yellow = (dragonState.beltProgress.Yellow or 0) + 1
    end
end

function scanDragonNotifications()
    local notifications = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("Notifications")
    if not notifications then
        return
    end

    for _, notification in ipairs(notifications:GetChildren()) do
        if not state.dragon.notificationSeen[notification] then
            state.dragon.notificationSeen[notification] = true
            local textObject = notification:FindFirstChild("Text")
            local textValue = textObject and textObject:IsA("TextLabel") and textObject.Text or nil
            if not textValue then
                pcall(function()
                    textValue = notification.Text
                end)
            end
            updateDragonProgressFromNotification(textValue)
        end
    end
end

function getFarmPositionCFrame(targetCFrame, offset)
    if not isUsableTargetCFrame(targetCFrame) then
        return nil
    end

    local mode = state.positionMethod or "Top"
    local verticalOffset = offset or 30
    local distanceOffset = math.clamp(math.floor(verticalOffset / 2), 8, 20)

    local baseOffset = Vector3.new(0, verticalOffset, 0)
    if mode == "Bottom" then
        baseOffset = Vector3.new(0, -verticalOffset, 0)
    elseif mode == "Behind" then
        baseOffset = Vector3.new(0, 0, distanceOffset)
    elseif mode == "Front" then
        baseOffset = Vector3.new(0, 0, -distanceOffset)
    end

    local customOffset = Vector3.new(state.positionOffsetX or 0, state.positionOffsetY or 0, state.positionOffsetZ or 0)
    return targetCFrame * CFrame.new(baseOffset + customOffset)
end

function tweenToPositionIfNeeded(targetCFrame, tolerance)
    local target = resolveTeleportTarget(targetCFrame)
    if not target then
        return false
    end

    local character = LocalPlayer.Character
    local partTele = character and character:FindFirstChild("PartTele")

    if isTeleporting and partTele and (partTele.Position - target.Position).Magnitude <= (tolerance or 5) then
        return true
    end

    return topos(target)
end

function moveToFarmPosition(targetCFrame, offset, forceTween)
    local hrp = getHumanoidRootPart()
    if not hrp then
        return
    end

    local desired = getFarmPositionCFrame(targetCFrame, offset)
    if not isUsableTargetCFrame(desired) then
        return
    end

    local distance = (hrp.Position - desired.Position).Magnitude

    if forceTween then
        if distance > 5 then
            tweenToPositionIfNeeded(desired, 5)
        else
            stopTeleport()
            hrp.CFrame = desired
        end
        return
    end

    if distance > 40 then
        tweenToPositionIfNeeded(desired, 5)
    else
        stopTeleport()
        hrp.CFrame = desired
    end
end

function moveAboveTarget(targetCFrame, offset)
    moveToFarmPosition(targetCFrame, offset, false)
end

function moveToMobTarget(targetCFrame, offset, minimumDistance)
    local hrp = getHumanoidRootPart()
    if not hrp or not isUsableTargetCFrame(targetCFrame) then
        return false
    end

    if not ensureSubmergedQuestEntryPoint() then
        return true
    end

    local desired = targetCFrame * CFrame.new(0, offset or 20, 0)
    local distance = (hrp.Position - desired.Position).Magnitude
    if distance <= (minimumDistance or 40) then
        stopTeleport()
        return false
    end

    TP1(desired)
    return true
end

function getMobFarmTarget(primaryCFrame, secondaryCFrame, minimumDistance)
    if not isUsableTargetCFrame(primaryCFrame) then
        return secondaryCFrame
    end

    if not isUsableTargetCFrame(secondaryCFrame) then
        return primaryCFrame
    end

    local hrp = getHumanoidRootPart()
    if not hrp then
        return primaryCFrame
    end

    local range = minimumDistance or 40
    local switchDelay = 2
    local primaryDistance = (hrp.Position - primaryCFrame.Position).Magnitude
    local secondaryDistance = (hrp.Position - secondaryCFrame.Position).Magnitude
    local inPrimaryRange = primaryDistance <= range
    local inSecondaryRange = secondaryDistance <= range
    local targetKey = string.format(
        "%s|%d|%d|%d|%d|%d|%d",
        tostring(NameMon ~= "" and NameMon or Mon or ""),
        math.floor(primaryCFrame.Position.X),
        math.floor(primaryCFrame.Position.Y),
        math.floor(primaryCFrame.Position.Z),
        math.floor(secondaryCFrame.Position.X),
        math.floor(secondaryCFrame.Position.Y),
        math.floor(secondaryCFrame.Position.Z)
    )

    if state.mobFarmTargetKey ~= targetKey then
        state.mobFarmTargetKey = targetKey
        state.mobFarmTargetIndex = 1
        state.mobFarmTargetSwitchAt = tick()
    end

    if inPrimaryRange and not inSecondaryRange and state.mobFarmTargetIndex ~= 1 then
        state.mobFarmTargetIndex = 1
        state.mobFarmTargetSwitchAt = tick()
    elseif inSecondaryRange and not inPrimaryRange and state.mobFarmTargetIndex ~= 2 then
        state.mobFarmTargetIndex = 2
        state.mobFarmTargetSwitchAt = tick()
    end

    local standingOnCurrentTarget = (state.mobFarmTargetIndex == 1 and inPrimaryRange) or (state.mobFarmTargetIndex == 2 and inSecondaryRange)
    if standingOnCurrentTarget and (tick() - state.mobFarmTargetSwitchAt) >= switchDelay then
        state.mobFarmTargetIndex = state.mobFarmTargetIndex == 1 and 2 or 1
        state.mobFarmTargetSwitchAt = tick()
    end

    if state.mobFarmTargetIndex == 1 then
        return primaryCFrame
    end

    return secondaryCFrame
end

function moveToMasteryFarmPosition(targetCFrame)
    moveToFarmPosition(targetCFrame, 20, false)
end



function moveToPlayerTarget(targetCFrame, heightOffset, backOffset, forceTween)
    local hrp = getHumanoidRootPart()
    if not hrp or not isUsableTargetCFrame(targetCFrame) then
        return
    end

    local desired = targetCFrame * CFrame.new(0, heightOffset or 20, backOffset or 0)
    local distance = (hrp.Position - desired.Position).Magnitude

    if forceTween then
        if distance > 5 then
            tweenToPositionIfNeeded(desired, 5)
        else
            stopTeleport()
            hrp.CFrame = desired
        end
        return
    end

    if distance > 40 then
        tweenToPositionIfNeeded(desired, 5)
    else
        stopTeleport()
        hrp.CFrame = desired
    end
end

function attackEnemy(enemy, offset, keepRunning)
    local humanoid = enemy and enemy:FindFirstChild("Humanoid")
    local enemyRoot = enemy and enemy:FindFirstChild("HumanoidRootPart")
    local head = enemy and enemy:FindFirstChild("Head")

    if not humanoid or not enemyRoot then
        return
    end

    repeat
        task.wait(ATTACK_LOOP_INTERVAL)

        if not keepRunning() or not enemy.Parent or humanoid.Health <= 0 then
            break
        end

        AutoHaki()
        requestCombatEquip()
        equipSelectedWeapon()

        MonFarm = enemy.Name
        PosMon = enemyRoot.CFrame
        StartBring = true

        enemyRoot.CanCollide = false
        enemyRoot.Size = Vector3.new(60, 60, 60)
        humanoid.WalkSpeed = 0

        if head then
            head.CanCollide = false
        end

        moveAboveTarget(enemyRoot.CFrame, offset or 30)
        BringMob(enemy.Name)
        local healthPercent = humanoid.MaxHealth > 0 and ((humanoid.Health / humanoid.MaxHealth) * 100) or 100
        if (state.autoMastery or _G.AutoFarmFruits) and healthPercent <= KillPercent then
            performMasteryAttack(enemy)
        else
            clickAttack()
        end
    until not keepRunning()

    StartBring = false
end

function addPoint(stat)
    CommF:InvokeServer("AddPoint", stat, 1)
end

local fastAttackController = {}
local fastAttackNet = nil
local fastAttackRemoteEvent = nil
local fastAttackRemoteEventId = nil
local FAST_ATTACK_RANGE = 100

local function resolveFastAttackNet()
    if fastAttackNet then
        return fastAttackNet
    end

    local modules = ReplicatedStorage:FindFirstChild("Modules")
    local netFolder = modules and modules:FindFirstChild("Net")
    if not netFolder then
        return nil
    end

    local ok, result = pcall(require, netFolder)
    if ok then
        fastAttackNet = result
    end

    return fastAttackNet
end

local function findFastAttackRemoteEvent(container)
    if not container then
        return nil, nil
    end

    for _, obj in ipairs(container:GetChildren()) do
        if obj:IsA("RemoteEvent") and obj:GetAttribute("Id") then
            return obj, obj:GetAttribute("Id")
        end
    end

    return nil, nil
end

local function refreshFastAttackRemoteEvent()
    if fastAttackRemoteEvent and fastAttackRemoteEvent.Parent and fastAttackRemoteEventId then
        return
    end

    local storages = {
        ReplicatedStorage:FindFirstChild("Util"),
        ReplicatedStorage:FindFirstChild("Common"),
        ReplicatedStorage:FindFirstChild("Remotes"),
        ReplicatedStorage:FindFirstChild("Assets"),
        ReplicatedStorage:FindFirstChild("FX")
    }

    for _, storage in ipairs(storages) do
        local event, id = findFastAttackRemoteEvent(storage)
        if event and id then
            fastAttackRemoteEvent = event
            fastAttackRemoteEventId = id
        end
    end
end

local function isFastAttackCharacterAlive(character)
    local humanoid = character and character:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function collectFastAttackTargets(rootPart)
    local targets = {}
    local folders = {
        Workspace:FindFirstChild("Enemies"),
        Workspace:FindFirstChild("Characters")
    }

    for _, folder in ipairs(folders) do
        if folder then
            for _, entity in ipairs(folder:GetChildren()) do
                local entityRoot = entity:FindFirstChild("HumanoidRootPart")
                local humanoid = entity:FindFirstChild("Humanoid")

                if entity ~= LocalPlayer.Character and entityRoot and humanoid and humanoid.Health > 0 then
                    if (entityRoot.Position - rootPart.Position).Magnitude <= FAST_ATTACK_RANGE then
                        local targetHead = entity:FindFirstChild("Head")
                        table.insert(targets, {entity, targetHead or entityRoot})
                        if targetHead and targetHead ~= entityRoot then
                            table.insert(targets, {entity, entityRoot})
                        end
                    end
                end
            end
        end
    end

    return targets
end

local function fireFastAttackToolRemote(tool, character, targets)
    local leftClickRemote = tool and tool:FindFirstChild("LeftClickRemote")
    if not leftClickRemote then
        return false
    end

    local origin = character:GetPivot().Position
    local fired = false
    for _, targetData in ipairs(targets) do
        local enemy = targetData[1]
        local enemyRoot = enemy and enemy:FindFirstChild("HumanoidRootPart")
        if enemyRoot then
            local direction = (enemyRoot.Position - origin).Unit
            pcall(function()
                leftClickRemote:FireServer(direction, 1)
            end)
            fired = true
        end
    end

    return fired
end

local function fireFastAttackNetRemotes(character, targets)
    local tool = character and character:FindFirstChildOfClass("Tool")
    if not tool then
        return
    end

    local weaponType = tool:GetAttribute("WeaponType") or tool.ToolTip
    if weaponType == "Gun" then
        return
    end

    if fireFastAttackToolRemote(tool, character, targets) then
        return
    end

    local net = resolveFastAttackNet()
    if not net or #targets == 0 then
        return
    end

    refreshFastAttackRemoteEvent()

    local registerAttack = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack")
    local registerHit = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterHit")
    local targetHead = targets[1][1] and targets[1][1]:FindFirstChild("Head")

    if not registerAttack or not registerHit or not targetHead then
        return
    end

    pcall(function()
        net:RemoteEvent("RegisterHit", true)
        registerAttack:FireServer()

        local threadToken = tostring(coroutine.running() or ""):sub(11, 15)
        local userIdToken = tostring(LocalPlayer.UserId):sub(2, 4)
        registerHit:FireServer(targetHead, targets, {}, userIdToken .. threadToken)

        if fastAttackRemoteEvent and fastAttackRemoteEventId then
            local remote = cloneref and cloneref(fastAttackRemoteEvent) or fastAttackRemoteEvent
            remote:FireServer(
                string.gsub("RE/RegisterHit", ".", function(char)
                    return string.char(bit32.bxor(string.byte(char), math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1))
                end),
                bit32.bxor(fastAttackRemoteEventId + 909090, ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2),
                targetHead,
                targets
            )
        end
    end)
end

function fastAttackController:Step()
    if not (state.fastAttack and not state.autoChest and isMovementAutomationActive()) then
        return
    end

    local character = LocalPlayer.Character
    local rootPart = getHumanoidRootPart()
    if not character or not rootPart or not isFastAttackCharacterAlive(character) then
        return
    end

    local targets = collectFastAttackTargets(rootPart)
    if #targets == 0 then
        return
    end

    requestCombatEquip()
    if not _G.AutoFarmFruits then
        equipSelectedWeapon()
    elseif not character:FindFirstChildOfClass("Tool") then
        equipSelectedWeapon()
    end

    fireFastAttackNetRemotes(character, targets)
end

function fastAttackController:Start()
    if self._thread then
        return self
    end

    self._thread = task.spawn(function()
        while self._running ~= false and state.running do
            task.wait(math.max(state.fastAttackDelay or FAST_ATTACK_INTERVAL, 0.01))
            self:Step()
        end
    end)

    return self
end

function fastAttackController:Stop()
    self._running = false
end

function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
        SelectMonster = nil
    end
    Mon = ""
    NameMon = ""
    NameQuest = ""
    CFrameQuest = nil
    CFrameMon = nil
    CFrameMon2 = nil
    if Sea1 then
        if (MyLevel >= 1 and MyLevel <= 9) or SelectMonster == "Bandit" then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)              
        elseif (MyLevel >= 10 and MyLevel <= 14) or SelectMonster == "Monkey" then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)                
        elseif (MyLevel >= 15 and MyLevel <= 29) or SelectMonster == "Gorilla" then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
        elseif (MyLevel >= 30 and MyLevel <= 39) or SelectMonster == "Pirate" then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)                
        elseif (MyLevel >= 40 and MyLevel <= 59) or SelectMonster == "Brute" then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif (MyLevel >= 60 and MyLevel <= 74) or SelectMonster == "Desert Bandit" then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)            
        elseif (MyLevel >= 75 and MyLevel <= 89) or SelectMonster == "Desert Officer" then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)               
        elseif (MyLevel >= 90 and MyLevel <= 99) or SelectMonster == "Snow Bandit" then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
            
        elseif (MyLevel >= 100 and MyLevel <= 119) or SelectMonster == "Snowman" then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif (MyLevel >= 120 and MyLevel <= 149) or SelectMonster == "Chief Petty Officer" then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018)
            CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
        elseif (MyLevel >= 150 and MyLevel <= 174) or SelectMonster == "Sky Bandit" then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
            
        elseif (MyLevel >= 175 and MyLevel <= 189) or SelectMonster == "Dark Master" then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif (MyLevel >= 190 and MyLevel <= 209) or SelectMonster == "Prisoner" then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif (MyLevel >= 210 and MyLevel <= 249) or SelectMonster == "Dangerous Prisone" then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif (MyLevel >= 250 and MyLevel <= 274) or SelectMonster == "Toga Warrior" then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif (MyLevel >= 275 and MyLevel <= 299) or SelectMonster == "Gladiator" then
            Mon = "Gladiator"
            LevelQuest = 2
            NameQuest = "ColosseumQuest"
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
        elseif (MyLevel >= 300 and MyLevel <= 324) or SelectMonster == "Military Soldier" then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif (MyLevel >= 325 and MyLevel <= 374) or SelectMonster == "Military Spy" then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif (MyLevel >= 375 and MyLevel <= 399) or SelectMonster == "Fishman Warrior" then
            Mon = "Fishman Warrior"
            LevelQuest = 1
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)) then
                requestEntrance(Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif (MyLevel >= 400 and MyLevel <= 449) or SelectMonster == "Fishman Commando" then
            Mon = "Fishman Commando"
            LevelQuest = 2
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)) then
                requestEntrance(Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif (MyLevel >= 450 and MyLevel <= 474) or SelectMonster == "God's Guard" then
            Mon = "God's Guard"
            LevelQuest = 1
            NameQuest = "SkyExp1Quest"
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(-4607.82275, 872.54248, -1667.55688)) then
                requestEntrance(Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif (MyLevel >= 475 and MyLevel <= 524) or SelectMonster == "Shanda" then
            Mon = "Shanda"
            LevelQuest = 2
            NameQuest = "SkyExp1Quest"
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047)) then
                requestEntrance(Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif (MyLevel >= 525 and MyLevel <= 549) or SelectMonster == "Royal Squad" then
            Mon = "Royal Squad"
            LevelQuest = 1
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif (MyLevel >= 550 and MyLevel <= 624) or SelectMonster == "Royal Soldier" then
            Mon = "Royal Soldier"
            LevelQuest = 2
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif (MyLevel >= 625 and MyLevel <= 649) or SelectMonster == "Galley Pirate" then
            Mon = "Galley Pirate"
            LevelQuest = 1
            NameQuest = "FountainQuest"
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 or SelectMonster == "Galley Captain" then
            Mon = "Galley Captain"
            LevelQuest = 2
            NameQuest = "FountainQuest"
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif Sea2 then
        if (MyLevel >= 700 and MyLevel <= 724) or SelectMonster == "Raider" then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif (MyLevel >= 725 and MyLevel <= 774) or SelectMonster == "Mercenary" then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif (MyLevel >= 775 and MyLevel <= 799) or SelectMonster == "Swan Pirate" then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif (MyLevel >= 800 and MyLevel <= 874) or SelectMonster == "Factory Staff" then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321)
            local factoryStaffSpawns = {
                CFrame.new(-391, 73, -423),
                CFrame.new(-153, 73, -668),
                CFrame.new(-57, 73, -45),
                CFrame.new(613, 70, 173),
                CFrame.new(466, 73, 129),
                CFrame.new(607, 73, 145)
            }
            local factoryStaffSpawn = factoryStaffSpawns[1]
            local humanoidRootPart = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                for _, spawnCFrame in ipairs(factoryStaffSpawns) do
                    if (spawnCFrame.Position - humanoidRootPart.Position).Magnitude < (factoryStaffSpawn.Position - humanoidRootPart.Position).Magnitude then
                        factoryStaffSpawn = spawnCFrame
                    end
                end
            end
            CFrameMon = factoryStaffSpawn
        elseif (MyLevel >= 875 and MyLevel <= 899) or SelectMonster == "Marine Lieutenant" then           
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif (MyLevel >= 900 and MyLevel <= 949) or SelectMonster == "Marine Captain" then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
        elseif (MyLevel >= 950 and MyLevel <= 974) or SelectMonster == "Zombie" then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif (MyLevel >= 975 and MyLevel <= 999) or SelectMonster == "Vampire" then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif (MyLevel >= 1000 and MyLevel <= 1049) or SelectMonster == "Snow Trooper" then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif (MyLevel >= 1050 and MyLevel <= 1099) or SelectMonster == "Winter Warrior" then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif (MyLevel >= 1100 and MyLevel <= 1124) or SelectMonster == "Lab Subordinate" then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6229, 82, -4851)
            CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
        elseif (MyLevel >= 1125 and MyLevel <= 1174) or SelectMonster == "Horned Warrior" then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6229, 82, -4851)
            CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
        elseif (MyLevel >= 1175 and MyLevel <= 1199) or SelectMonster == "Magma Ninja" then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5400, 29, -5368)
            CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
        elseif (MyLevel >= 1200 and MyLevel <= 1249) or SelectMonster == "Lava Pirate" then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5400, 29, -5368)
            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
        elseif (MyLevel >= 1250 and MyLevel <= 1274) or SelectMonster == "Ship Deckhand" then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)    
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(922, 185, 32846)) then
                requestEntrance(Vector3.new(922, 185, 32846))
            end
        elseif (MyLevel >= 1275 and MyLevel <= 1299) or SelectMonster == "Ship Engineer" then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)   
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(922, 185, 32846)) then
                requestEntrance(Vector3.new(922, 185, 32846))
            end
        elseif (MyLevel >= 1300 and MyLevel <= 1324) or SelectMonster == "Ship Steward" then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)      
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(922, 185, 32846)) then
                requestEntrance(Vector3.new(922, 185, 32846))
            end
        elseif (MyLevel >= 1325 and MyLevel <= 1349) or SelectMonster == "Ship Officer" then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(922, 185, 32846)) then
                requestEntrance(Vector3.new(922, 185, 32846))
            end
        elseif (MyLevel >= 1350 and MyLevel <= 1374) or SelectMonster == "Arctic Warrior" then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
            if _G.AutoFarm and shouldRequestQuestEntrance(CFrameQuest, Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422)) then
                requestEntrance(Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
            end 
        elseif (MyLevel >= 1375 and MyLevel <= 1424) or SelectMonster == "Snow Lurker" then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif (MyLevel >= 1425 and MyLevel <= 1449) or SelectMonster == "Sea Soldier" then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 or SelectMonster == "Water Fighter" then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
        end
            elseif Sea3 then
    if (MyLevel >= 1500 and MyLevel <= 1524) or SelectMonster == "Pirate Millionaire" then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607)
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif (MyLevel >= 1525 and MyLevel <= 1574) or SelectMonster == "Pistol Billionaire" then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607)
            CFrameMon = CFrame.new(-54.8110352, 83.7698746, 5947.84082, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
        elseif (MyLevel >= 1575 and MyLevel <= 1599) or SelectMonster == "Dragon Crew Warrior" then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "DragonCrewQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
            CFrameMon = CFrame.new(6709.76367, 52.3442993, -1139.02966, -0.763515472, 0, 0.645789504, 0, 1, 0, -0.645789504, 0, -0.763515472)          
        elseif (MyLevel >= 1600 and MyLevel <= 1624) or SelectMonster == "Dragon Crew Archer" then
            Mon = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
            CFrameMon = CFrame.new(6668.76172, 481.376923, 329.12207, -0.121787429, 0, -0.992556155, 0, 1, 0, 0.992556155, 0, -0.121787429)
        elseif (MyLevel >= 1625 and MyLevel <= 1649) or SelectMonster == "Hydra Enforcer" then
            Mon = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 1
            NameMon = "Hydra Enforcer"
            CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
            CFrameMon = CFrame.new(4547.11523, 1003.10217, 334.194824, 0.388810456, -0, -0.921317935, 0, 1, -0, 0.921317935, 0, 0.388810456)
        elseif (MyLevel >= 1650 and MyLevel <= 1699) or SelectMonster == "Venomous Assailant" then
            Mon = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 2
            NameMon = "Venomous Assailant"
            CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
            CFrameMon = CFrame.new(4674.92676, 1134.82654, 996.308838, 0.731321394, -0, -0.682033002, 0, 1, -0, 0.682033002, 0, 0.731321394)
        elseif (MyLevel >= 1700 and MyLevel <= 1724) or SelectMonster == "Marine Commodore" then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
            CFrameMon = CFrame.new(2577.25391, 75.6100006, -7739.87207, 0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, 0.499959469)
        elseif (MyLevel >= 1725 and MyLevel <= 1774) or SelectMonster == "Marine Rear Admiral" then
            Mon = "Marine Rear Admiral"
            LevelQuest = 2
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Rear Admiral"
            CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
            CFrameMon = CFrame.new(3761.81006, 123.912003, -6823.52197, 0.961273968, 0, 0.275594592, 0, 1, 0, -0.275594592, 0, 0.961273968)
        elseif (MyLevel >= 1775 and MyLevel <= 1799) or SelectMonster == "Fishman Raider" then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif (MyLevel >= 1800 and MyLevel <= 1824) or SelectMonster == "Fishman Captain" then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625) 
        elseif (MyLevel >= 1825 and MyLevel <= 1849) or SelectMonster == "Forest Pirate" then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif (MyLevel >= 1850 and MyLevel <= 1899) or SelectMonster == "Mythological Pirate" then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif (MyLevel >= 1900 and MyLevel <= 1924) or SelectMonster == "Jungle Pirate" then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif (MyLevel >= 1925 and MyLevel <= 1974) or SelectMonster == "Musketeer Pirate" then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif (MyLevel >= 1975 and MyLevel <= 1999) or SelectMonster == "Reborn Skeleton" then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif (MyLevel >= 2000 and MyLevel <= 2024) or SelectMonster == "Living Zombie" then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
        elseif (MyLevel >= 2025 and MyLevel <= 2049) or SelectMonster == "Demonic Soul" then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
            CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
        elseif (MyLevel >= 2050 and MyLevel <= 2074) or SelectMonster == "Posessed Mummy" then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
            CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
        elseif (MyLevel >= 2075 and MyLevel <= 2099) or SelectMonster == "Peanut Scout" then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
            CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
        elseif (MyLevel >= 2100 and MyLevel <= 2124) or SelectMonster == "Peanut President" then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif (MyLevel >= 2125 and MyLevel <= 2149) or SelectMonster == "Ice Cream Chef" then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif (MyLevel >= 2150 and MyLevel <= 2199) or SelectMonster == "Ice Cream Commander" then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        elseif (MyLevel >= 2200 and MyLevel <= 2224) or SelectMonster == "Cookie Crafter" then
            Mon = "Cookie Crafter"
            LevelQuest = 1
            NameQuest = "CakeQuest1"
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295)
            CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
        elseif (MyLevel >= 2225 and MyLevel <= 2249) or SelectMonster == "Cake Guard" then
            Mon = "Cake Guard"
            LevelQuest = 2
            NameQuest = "CakeQuest1"
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295)
            CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
        elseif (MyLevel >= 2250 and MyLevel <= 2274) or SelectMonster == "Baking Staff" then
            Mon = "Baking Staff"
            LevelQuest = 1
            NameQuest = "CakeQuest2"
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391)
            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
        elseif (MyLevel >= 2275 and MyLevel <= 2299) or SelectMonster == "Head Baker" then
            Mon = "Head Baker"
            LevelQuest = 2
            NameQuest = "CakeQuest2"
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391)
            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
        elseif (MyLevel >= 2300 and MyLevel <= 2324) or SelectMonster == "Cocoa Warrior" then
            Mon = "Cocoa Warrior"
            LevelQuest = 1
            NameQuest = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
        elseif (MyLevel >= 2325 and MyLevel <= 2349) or SelectMonster == "Chocolate Bar Battler" then
            Mon = "Chocolate Bar Battler"
            LevelQuest = 2
            NameQuest = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
        elseif (MyLevel >= 2350 and MyLevel <= 2374) or SelectMonster == "Sweet Thief" then
            Mon = "Sweet Thief"
            LevelQuest = 1
            NameQuest = "ChocQuest2"
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
        elseif (MyLevel >= 2375 and MyLevel <= 2399) or SelectMonster == "Candy Rebel" then
            Mon = "Candy Rebel"
            LevelQuest = 2
            NameQuest = "ChocQuest2"
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
        elseif (MyLevel >= 2400 and MyLevel <= 2424) or SelectMonster == "Candy Pirate" then
            Mon = "Candy Pirate"
            LevelQuest = 1
            NameQuest = "CandyQuest1"
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
        elseif (MyLevel >= 2425 and MyLevel <= 2449) or SelectMonster == "Snow Demon" then
            Mon = "Snow Demon"
            LevelQuest = 2
            NameQuest = "CandyQuest1"
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
        elseif (MyLevel >= 2450 and MyLevel <= 2474) or SelectMonster == "Isle Outlaw" then
            Mon = "Isle Outlaw"
            LevelQuest = 1
            NameQuest = "TikiQuest1"
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
        elseif (MyLevel >= 2475 and MyLevel <= 2524) or SelectMonster == "Island Boy" then
            Mon = "Island Boy"
            LevelQuest = 2
            NameQuest = "TikiQuest1"
            NameMon = "Island Boy"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
        elseif (MyLevel >= 2525 and MyLevel <= 2549) or SelectMonster == "Isle Champion" then
            Mon = "Isle Champion"
            LevelQuest = 2
            NameQuest = "TikiQuest2"
            NameMon = "Isle Champion"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375)
        elseif (MyLevel >= 2550 and MyLevel <= 2574) or SelectMonster == "Serpent Hunter" then
            Mon = "Serpent Hunter"
            LevelQuest = 1
            NameQuest = "TikiQuest3"
            NameMon = "Serpent Hunter"
            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434)
            CFrameMon = CFrame.new(-16521.0625, 106.09285, 1488.78467, 0.469467044, 0, 0.882950008, 0, 1, 0, -0.882950008, 0, 0.469467044)
        elseif (MyLevel >= 2575 and MyLevel <= 2649) or SelectMonster == "Skull Slayer" then
            Mon = "Skull Slayer"
            LevelQuest = 2
            NameQuest = "TikiQuest3"
            NameMon = "Skull Slayer"
            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434)
            CFrameMon = CFrame.new(-16855.043, 122.457253, 1478.15308, -0.999392271, 0, -0.0348687991, 0, 1, 0, 0.0348687991, 0, -0.999392271)
        elseif (MyLevel >= 2650 and MyLevel <= 2674) or SelectMonster == "Sea Chanter" then
            Mon = "Sea Chanter"
            LevelQuest = 1
            NameQuest = "SubmergedQuest2"
            NameMon = "Sea Chanter"
            CFrameQuest = CFrame.new(10882, -2086, 10035)
            CFrameMon = CFrame.new(10677, -2088, 10075)
        elseif (MyLevel >= 2675 and MyLevel <= 2699) or SelectMonster == "Ocean Prophets" then
            Mon = "Ocean Prophets"
            LevelQuest = 2
            NameQuest = "SubmergedQuest2"
            NameMon = "Ocean Prophets"
            CFrameQuest = CFrame.new(10882, -2086, 10035)
            CFrameMon = CFrame.new(11057, -2008, 10153)
            CFrameMon2 = CFrame.new(10922, -2008, 10202)
        elseif MyLevel >= 2700 or SelectMonster == "Grand Devotee" then
            Mon = "Grand Devotee"
            LevelQuest = 2
            NameQuest = "SubmergedQuest3"
            NameMon = "Grand Devotee"
            CFrameQuest = CFrame.new(9639, -1992, 9615)
            CFrameMon = CFrame.new(9657, -1988, 10075)
            CFrameMon2 = CFrame.new(9588, -1993, 9794)
        end
    end
end

teleportLocations = {
    [2753915549] = {
        {Name = "WindMill", CFrame = CFrame.new(980, 17, 1429)},
        {Name = "Marine", CFrame = CFrame.new(-2566, 7, 2045)},
        {Name = "Middle Town", CFrame = CFrame.new(-690, 15, 1582)},
        {Name = "Jungle", CFrame = CFrame.new(-1613, 37, 149)},
        {Name = "Pirate Village", CFrame = CFrame.new(-1181, 5, 3804)},
        {Name = "Desert", CFrame = CFrame.new(944, 21, 4373)},
        {Name = "Snow Island", CFrame = CFrame.new(1348, 105, -1320)},
        {Name = "MarineFord", CFrame = CFrame.new(-4915, 51, 4281)},
        {Name = "Colosseum", CFrame = CFrame.new(-1428, 7, -2793)},
        {Name = "Sky Island 1", CFrame = CFrame.new(-4869, 733, -2667)},
        {Name = "Sky Island 2", Entrance = Vector3.new(-4608, 873, -1668)},
        {Name = "Sky Island 3", Entrance = Vector3.new(-7895, 5547, -380)},
        {Name = "Prison", CFrame = CFrame.new(4875, 6, 735)},
        {Name = "Magma Village", CFrame = CFrame.new(-5248, 13, 8505)},
        {Name = "Under Water Island", Entrance = Vector3.new(61164, 12, 1820)},
        {Name = "Fountain City", CFrame = CFrame.new(5127, 60, 4105)},
        {Name = "Shank Room", CFrame = CFrame.new(-1442, 30, -28)},
        {Name = "Mob Island", CFrame = CFrame.new(-2850, 7, 5355)}
    },
    [4442272183] = {
        {Name = "The Cafe", CFrame = CFrame.new(-380, 77, 256)},
        {Name = "First Spot", CFrame = CFrame.new(-11, 29, 2772)},
        {Name = "Dark Area", CFrame = CFrame.new(3780, 23, -3499)},
        {Name = "Flamingo Mansion", CFrame = CFrame.new(-484, 332, 595)},
        {Name = "Flamingo Room", CFrame = CFrame.new(2284, 15, 876)},
        {Name = "Green Zone", CFrame = CFrame.new(-2449, 73, -3211)},
        {Name = "Factory", CFrame = CFrame.new(424, 211, -428)},
        {Name = "Colosseum", CFrame = CFrame.new(-1504, 220, 1369)},
        {Name = "Zombie Island", CFrame = CFrame.new(-5622, 492, -782)},
        {Name = "Two Snow Mountain", CFrame = CFrame.new(753, 408, -5275)},
        {Name = "Ice And Cold", CFrame = CFrame.new(-6128, 16, -5040)},
        {Name = "Cursed Ship", CFrame = CFrame.new(923, 125, 32886)},
        {Name = "Ice Castle", CFrame = CFrame.new(6148, 294, -6741)},
        {Name = "Forgotten Island", CFrame = CFrame.new(-3033, 318, -10075)},
        {Name = "Ussop Island", CFrame = CFrame.new(4817, 8, 2864)},
        {Name = "Mini Sky Island", CFrame = CFrame.new(-289, 49326, -35249)}
    },
    [7449423635] = {
        {Name = "Mansion", Entrance = Vector3.new(-12550, 337, -7507)},
        {Name = "Port Town", CFrame = CFrame.new(-291, 7, 5344)},
        {Name = "Great Tree", CFrame = CFrame.new(2681, 1683, -7191)},
        {Name = "Castle On The Sea", CFrame = CFrame.new(-5074, 315, -2991)},
        {Name = "MiniSky", CFrame = CFrame.new(-261, 49326, -35254)},
        {Name = "Hydra Island", CFrame = CFrame.new(5255, 1004, 345)},
        {Name = "Floating Turtle", CFrame = CFrame.new(-13275, 532, -7579)},
        {Name = "Haunted Castle", CFrame = CFrame.new(-9515, 164, 5786)},
        {Name = "Ice Cream Island", CFrame = CFrame.new(-903, 80, -10989)},
        {Name = "Peanut Island", CFrame = CFrame.new(-2063, 50, -10233)},
        {Name = "Cake Island", CFrame = CFrame.new(-1885, 19, -11667)},
        {Name = "Cocoa Island", CFrame = CFrame.new(88, 74, -12319)},
        {Name = "Candy Island", CFrame = CFrame.new(-1014, 149, -14556)},
        {Name = "Tiki Outpost", CFrame = CFrame.new(-16219, 9, 446)}
    }
}

bossOptions = {}
if World1 then
    bossOptions = {"The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Saber Expert"}
elseif World2 then
    bossOptions = {"Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain", "Darkbeard", "Order", "Awakened Ice Admiral", "Tide Keeper"}
elseif World3 then
    bossOptions = {"Stone", "Island Empress", "Rocket Admiral", "Captain Elephant", "Beautiful Pirate", "rip_indra True Form", "Longma", "Soul Reaper", "Cake Queen", "Cake Prince", "Dough King"}
end

bossFallbackCFrames = {
    ["The Gorilla King"] = CFrame.new(-1223, 7, -502),
    ["Bobby"] = CFrame.new(-1147, 33, 4350),
    ["Yeti"] = CFrame.new(1221, 139, -1488),
    ["Stone"] = CFrame.new(-1049, 41, 6791),
    ["Island Empress"] = CFrame.new(5713, 603, 202),
    ["Longma"] = CFrame.new(-10171.7051, 406.981995, -9552.31738),
    ["Tyrant of the Skies"] = CFrame.new(-16194.0049, 155.218445, 1420.71997),
    ["Tyrant of the Skies [Lv. 2600] [Raid Boss]"] = CFrame.new(-16194.0049, 155.218445, 1420.71997),
    ["Dough King"] = CFrame.new(-2151, 89, -12404)
}

masteryModeOptions = {"Farm Level Mastery", "Farm Level Mastery No Quest"}
bossFarmModeOptions = {"No Quest", "Quest If Available"}
masteryWeaponOptions = {"Devil Fruit", "Gun"}
masteryQuestOptions = {"Quest", "No Quest"}
superhumanFarmMethodOptions = {"Auto Farm Level", "Auto Farm Bone", "Auto Farm Sea of Treats"}
positionMethodOptions = {"Top", "Bottom", "Behind", "Front"}

questMobOptions = {
    "Arctic Warrior", "Baking Staff", "Bandit", "Brute", "Cake Guard", "Candy Pirate", "Candy Rebel", "Chief Petty Officer",
    "Chocolate Bar Battler", "Cocoa Warrior", "Cookie Crafter", "Dangerous Prisoner", "Dark Master", "Demonic Soul", "Desert Bandit",
    "Desert Officer", "Dragon Crew Archer", "Dragon Crew Warrior", "Factory Staff", "Fishman Captain", "Fishman Commando",
    "Fishman Raider", "Fishman Warrior", "Forest Pirate", "Galley Captain", "Galley Pirate", "Gladiator", "God's Guard", "Gorilla",
    "Head Baker", "Horned Warrior", "Hydra Enforcer", "Ice Cream Chef", "Ice Cream Commander", "Island Boy", "Isle Champion",
    "Isle Outlaw", "Jungle Pirate", "Lab Subordinate", "Lava Pirate", "Living Zombie", "Magma Ninja", "Marine Captain",
    "Marine Commodore", "Marine Lieutenant", "Marine Rear Admiral", "Mercenary", "Military Soldier", "Military Spy", "Monkey",
    "Musketeer Pirate", "Mythological Pirate", "Peanut President", "Peanut Scout", "Pirate", "Pirate Millionaire",
    "Pistol Billionaire", "Posessed Mummy", "Prisoner", "Raider", "Reborn Skeleton", "Royal Soldier", "Royal Squad",
    "Sea Soldier", "Sea Chanter", "Ocean Prophets", "Serpent Hunter", "Shanda", "Ship Deckhand", "Ship Engineer", "Ship Officer", "Ship Steward", "Skull Slayer",
    "Sky Bandit", "Snow Bandit", "Snow Demon", "Snow Lurker", "Snow Trooper", "Snowman", "Swan Pirate", "Sweet Thief",
    "Toga Warrior", "Vampire", "Venomous Assailant", "Water Fighter", "Winter Warrior", "Zombie", "Grand Devotee"
}

state.selectedQuestMob = questMobOptions[1]
state.bossFarmMode = bossFarmModeOptions[1]

materialOptions = {}
if World1 then
    materialOptions = {"Farm Leather + Scrap Metal", "Farm Fish Tail", "Farm Magma Ore", "Farm Angel Wings"}
elseif World2 then
    materialOptions = {"Farm Leather + Scrap Metal", "Farm Radiactive Material", "Farm Magma Ore", "Farm Vampire Fang", "Farm Mystic Droplet", "Farm Ectoplasm"}
elseif World3 then
    materialOptions = {"Farm Leather + Scrap Metal", "Farm Fish Tail", "Farm Mini Tusk", "Farm Dragon Scale", "Farm Conjured Cocoa", "Farm Fire Flower", "Farm Blaze Ember"}
end

_G.SelectBoss = bossOptions[1] or ""
_G.SelectMaterial = materialOptions[1] or ""

bossQuestData = {
    ["The Gorilla King"] = {QuestName = "JungleQuest", QuestLevel = 3, QuestCFrame = CFrame.new(-1598.08911, 36.5501175, 153.377838)},
    ["Bobby"] = {QuestName = "BuggyQuest1", QuestLevel = 3, QuestCFrame = CFrame.new(-1141.07483, 5.10001802, 3831.5498)},
    ["Yeti"] = {QuestName = "SnowQuest", QuestLevel = 3, QuestCFrame = CFrame.new(1389.74451, 89.1519318, -1298.90796)},
    ["Vice Admiral"] = {QuestName = "MarineQuest2", QuestLevel = 2, QuestCFrame = CFrame.new(-5039.58643, 28.3500385, 4324.68018)},
    ["Warden"] = {QuestName = "ImpelQuest", QuestLevel = 1, QuestCFrame = CFrame.new(5191.86133, 3.84020686, 686.438721)},
    ["Chief Warden"] = {QuestName = "ImpelQuest", QuestLevel = 2, QuestCFrame = CFrame.new(5191.86133, 3.84020686, 686.438721)},
    ["Swan"] = {QuestName = "ImpelQuest", QuestLevel = 3, QuestCFrame = CFrame.new(5191.86133, 3.84020686, 686.438721)},
    ["Magma Admiral"] = {QuestName = "MagmaQuest", QuestLevel = 3, QuestCFrame = CFrame.new(-5313.37012, 11.9500084, 8515.29395)},
    ["Fishman Lord"] = {QuestName = "FishmanQuest", QuestLevel = 3, QuestCFrame = CFrame.new(61122.65234375, 19.497442245483, 1569.3997802734)},
    ["Wysper"] = {QuestName = "SkyExp1Quest", QuestLevel = 3, QuestCFrame = CFrame.new(-4721.88867, 844.874695, -1949.96643)},
    ["Thunder God"] = {QuestName = "SkyExp2Quest", QuestLevel = 3, QuestCFrame = CFrame.new(-7906.81592, 5635.6626, -1411.99194)},
    ["Cyborg"] = {QuestName = "FountainQuest", QuestLevel = 3, QuestCFrame = CFrame.new(5259.81982, 38.3500175, 4050.0293)},
    ["Diamond"] = {QuestName = "Area1Quest", QuestLevel = 3, QuestCFrame = CFrame.new(-429.543518, 72.7699966, 1836.18188)},
    ["Jeremy"] = {QuestName = "Area2Quest", QuestLevel = 3, QuestCFrame = CFrame.new(632.698608, 74.1055908, 918.666321)},
    ["Fajita"] = {QuestName = "MarineQuest3", QuestLevel = 3, QuestCFrame = CFrame.new(-2440.79639, 72.7140732, -3216.06812)},
    ["Smoke Admiral"] = {QuestName = "IceSideQuest", QuestLevel = 3, QuestCFrame = CFrame.new(-6064.06885, 16.2422857, -4902.97852)},
    ["Awakened Ice Admiral"] = {QuestName = "FrostQuest", QuestLevel = 3, QuestCFrame = CFrame.new(5667.6582, 27.7997818, -6486.08984)},
    ["Tide Keeper"] = {QuestName = "ForgottenQuest", QuestLevel = 3, QuestCFrame = CFrame.new(-3054.44458, 236.544281, -10142.8193)},
    ["Stone"] = {QuestName = "PiratePortQuest", QuestLevel = 3, QuestCFrame = CFrame.new(-450.104645, 108.681458, 5950.72607)}
}

espTags = {
    PlayerTag = "ZyphraxBF_PlayerTag",
    PlayerHighlight = "ZyphraxBF_PlayerHighlight",
    ChestTag = "ZyphraxBF_ChestTag",
    FruitTag = "ZyphraxBF_FruitTag",
    FlowerTag = "ZyphraxBF_FlowerTag",
    BerryTag = "ZyphraxBF_BerryTag",
    SpecialIslandTag = "ZyphraxBF_SpecialIslandTag"
}

specialIslandNames = {
    ["Mirage Island"] = true,
    ["Kitsune Island"] = true,
    ["PrehistoricIsland"] = true,
    ["Prehistoric Island"] = true
}

local flowerEspInfo = {
    Flower1 = {Label = "Blue Flower", Color = Color3.fromRGB(77, 169, 255)},
    Flower2 = {Label = "Red Flower", Color = Color3.fromRGB(255, 85, 85)}
}

function getCurrentSeaLabel()
    if Sea1 then
        return "First Sea"
    elseif Sea2 then
        return "Second Sea"
    elseif Sea3 then
        return "Third Sea"
    end

    return "Unknown Sea"
end

function getTeleportLocationEntries()
    local entries = teleportLocations[game.PlaceId]
    if entries and #entries > 0 then
        return entries
    end

    if Sea1 then
        return teleportLocations[2753915549] or {}
    elseif Sea2 then
        return teleportLocations[4442272183] or {}
    elseif Sea3 then
        return teleportLocations[7449423635] or {}
    end

    return {}
end

function getLocationNames()
    local names = {}
    for _, entry in ipairs(getTeleportLocationEntries()) do
        table.insert(names, entry.Name)
    end
    return names
end

function getSelectedLocation()
    for _, entry in ipairs(getTeleportLocationEntries()) do
        if entry.Name == state.selectedLocation then
            return entry
        end
    end
    return nil
end

function teleportToLocationEntry(entry)
    if type(entry) ~= "table" then
        return false
    end

    local target = entry.CFrame
    if not target and entry.Entrance then
        target = CFrame.new(entry.Entrance)
    end

    if not target then
        return false
    end

    if entry.Entrance then
        requestEntrance(entry.Entrance)
        task.wait(0.5)
    end

    return TP1(target)
end

function getAdornmentPart(item)
    if not item then
        return nil
    end

    if item:IsA("Tool") then
        return item:FindFirstChild("Handle")
    end

    if item:IsA("Model") then
        return item.PrimaryPart
            or item:FindFirstChild("HumanoidRootPart")
            or item:FindFirstChild("Handle")
            or item:FindFirstChildWhichIsA("BasePart", true)
    end

    if item:IsA("BasePart") then
        return item
    end

    return nil
end

function registerEspInstance(tagName, instance)
    if not tagName or not instance then
        return
    end

    local registry = espInstanceRegistry[tagName]
    if not registry then
        registry = setmetatable({}, {__mode = "k"})
        espInstanceRegistry[tagName] = registry
    end

    registry[instance] = true
end

function clearRenderedEspSet(renderedSet, tagName)
    for part in pairs(renderedSet) do
        if part and part.Parent then
            local billboard = part:FindFirstChild(tagName)
            if billboard then
                billboard:Destroy()
            end
        end
        renderedSet[part] = nil
    end
end

function clearEspTag(tagName)
    local registry = espInstanceRegistry[tagName]
    if registry then
        for instance in pairs(registry) do
            registry[instance] = nil
            if instance and instance.Parent then
                instance:Destroy()
            end
        end
        return
    end

    for _, descendant in ipairs(Workspace:GetDescendants()) do
        if descendant.Name == tagName then
            descendant:Destroy()
        end
    end
end

function ensureBillboard(part, tagName, color, offset)
    if not part then
        return nil, nil
    end

    local billboard = part:FindFirstChild(tagName)
    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Name = tagName
        billboard.Size = UDim2.new(0, 180, 0, 52)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = offset or Vector3.new(0, 2.5, 0)
        billboard.Parent = part

        local label = Instance.new("TextLabel")
        label.Name = "TextLabel"
        label.Size = UDim2.fromScale(1, 1)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
    end

    local label = billboard:FindFirstChild("TextLabel")
    if label then
        label.TextColor3 = color
    end

    registerEspInstance(tagName, billboard)

    return billboard, label
end

function isFlowerEspItem(item)
    return item and flowerEspInfo[item.Name] ~= nil
end

function isSpecialIslandEspItem(item)
    return item and specialIslandNames[item.Name] == true
end

function buildNearestEspCandidates(parts, originPosition, maxDistance, extraDataBuilder)
    local candidates = {}
    local tracked = {}

    for _, part in ipairs(parts) do
        if part and part.Parent and not tracked[part] then
            tracked[part] = true
            local distance = (part.Position - originPosition).Magnitude
            if distance <= maxDistance then
                local entry = {
                    part = part,
                    distance = distance
                }

                if extraDataBuilder then
                    extraDataBuilder(entry, part)
                end

                candidates[#candidates + 1] = entry
            end
        end
    end

    table.sort(candidates, function(a, b)
        return a.distance < b.distance
    end)

    return candidates
end

function renderWorldEspCandidates(renderedSet, tagName, color, offset, candidates, maxRender, labelBuilder)
    local visibleParts = {}

    for index = 1, math.min(#candidates, maxRender) do
        local entry = candidates[index]
        local part = entry.part
        if part and part.Parent then
            visibleParts[part] = true
            renderedSet[part] = true
            local _, label = ensureBillboard(part, tagName, color, offset)
            if label then
                label.Text = labelBuilder(entry)
            end
        end
    end

    for part in pairs(renderedSet) do
        if not visibleParts[part] then
            if part and part.Parent then
                local billboard = part:FindFirstChild(tagName)
                if billboard then
                    billboard:Destroy()
                end
            end
            renderedSet[part] = nil
        end
    end
end

function clearTrackedChestESP()
    for part in pairs(chestEspRendered) do
        if part and part.Parent then
            local billboard = part:FindFirstChild(espTags.ChestTag)
            if billboard then
                billboard:Destroy()
            end
        end
        chestEspRendered[part] = nil
    end
end

function getBerryBushDisplayName(bush)
    if not bush then
        return nil
    end

    for attributeName, hasBerry in pairs(bush:GetAttributes()) do
        if hasBerry then
            return attributeName
        end
    end

    return nil
end

function findNearestBerryBush()
    local hrp = getHumanoidRootPart()
    if not hrp then
        return nil, nil, nil
    end

    local bestBush
    local bestName
    local bestDistance

    for _, bush in ipairs(CollectionService:GetTagged("BerryBush")) do
        local berryName = getBerryBushDisplayName(bush)
        local bushPart = bush and bush.Parent and getAdornmentPart(bush.Parent)
        if berryName and bushPart then
            local distance = (bushPart.Position - hrp.Position).Magnitude
            if not bestDistance or distance < bestDistance then
                bestDistance = distance
                bestBush = bush
                bestName = berryName
            end
        end
    end

    return bestBush, bestName, bestDistance
end

function pressInteractKey()
    VirtualInputManager:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, "E", false, game)
end

function getPrehistoricIsland()
    local map = Workspace:FindFirstChild("Map")
    return map and map:FindFirstChild("PrehistoricIsland") or nil
end

function getPrehistoricSkullCFrame()
    local island = getPrehistoricIsland()
    local core = island and island:FindFirstChild("Core")
    local relic = core and core:FindFirstChild("PrehistoricRelic")
    local skull = relic and relic:FindFirstChild("Skull")
    return skull and CFrame.new(skull.Position) or nil
end

function clearPrehistoricLava()
    local island = getPrehistoricIsland()
    if not island then
        return
    end

    local core = island:FindFirstChild("Core")
    local interiorLava = core and core:FindFirstChild("InteriorLava")
    if interiorLava and interiorLava:IsA("Model") then
        pcall(function()
            interiorLava:Destroy()
        end)
    end

    for _, descendant in ipairs(island:GetDescendants()) do
        local loweredName = string.lower(descendant.Name or "")
        if string.find(loweredName, "lava", 1, true) and (descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("Model")) then
            pcall(function()
                descendant:Destroy()
            end)
        end
    end
end

function getActiveVolcanoRock()
    local island = getPrehistoricIsland()
    local core = island and island:FindFirstChild("Core")
    local volcanoRocks = core and core:FindFirstChild("VolcanoRocks")
    if not volcanoRocks then
        return nil
    end

    for _, rockModel in ipairs(volcanoRocks:GetChildren()) do
        if rockModel:IsA("Model") then
            local rock = rockModel:FindFirstChild("volcanorock")
            if rock and rock:IsA("MeshPart") then
                local color = rock.Color
                if color == Color3.fromRGB(185, 53, 56) or color == Color3.fromRGB(185, 53, 57) then
                    return rock
                end
            end
        end
    end

    return nil
end

function UseSkill(skillKey)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        VirtualInputManager:SendKeyEvent(true, skillKey, false, game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, skillKey, false, game)
    end
end

function useWeaponTypeSkills(weaponType)
    local tool = equipSelectedWeapon(normalizeWeaponType(weaponType), nil, true)
    if not tool then
        return
    end

    clickAttack()
    for _, skillKey in ipairs({"Z", "X", "C", "V", "F"}) do
        pcall(function()
            UseSkill(skillKey)
        end)
    end
end

function useMasterySkillsIfNeeded(target, equippedTool)
    if not (state.autoMastery or _G.AutoFarmFruits) or not target or not state.masteryAimbot then
        return
    end

    local humanoid = target:FindFirstChild("Humanoid")
    if not humanoid or humanoid.MaxHealth <= 0 then
        return
    end

    local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100
    if healthPercent > KillPercent then
        return
    end

    local tool = equippedTool or equipMasteryWeapon()
    if not tool then
        return
    end

    local masteryLevelValue = tool:FindFirstChild("Level")
    local masteryLevel = masteryLevelValue and tonumber(masteryLevelValue.Value) or 1
    if masteryLevel < 1 then
        return
    end

    local skillKeys = {"Z", "X", "C", "V", "F"}
    local skillEnabled = {
        Z = SkillZ,
        X = SkillX,
        C = SkillC,
        V = SkillV,
        F = SkillF
    }

    for _, skillKey in ipairs(skillKeys) do
        if skillEnabled[skillKey] then
            aimToolAtTarget(tool, target)
            UseSkill(skillKey)
            task.wait(0.05)
        end
    end
end

function getToolMousePosValue(tool)
    if not tool then
        return nil
    end

    local direct = tool:FindFirstChild("MousePos")
    if direct and direct:IsA("Vector3Value") then
        return direct
    end

    local nested = tool:FindFirstChild("MousePos", true)
    if nested and nested:IsA("Vector3Value") then
        return nested
    end

    return nil
end

function faceMasteryTarget(aimPart)
    local hrp = getHumanoidRootPart()
    if not hrp or not aimPart then
        return
    end

    local lookPosition = Vector3.new(aimPart.Position.X, hrp.Position.Y, aimPart.Position.Z)
    if (lookPosition - hrp.Position).Magnitude <= 1 then
        return
    end

    hrp.CFrame = CFrame.new(hrp.Position, lookPosition)
end

function getMasteryAimPart(target)
    if not target then
        return nil
    end

    return target:FindFirstChild("HumanoidRootPart")
        or target:FindFirstChild("Head")
        or target:FindFirstChildWhichIsA("BasePart")
end

function aimToolAtTarget(tool, target)
    local aimPart = getMasteryAimPart(target)
    if not tool or not aimPart then
        return aimPart
    end

    faceMasteryTarget(aimPart)

    local mousePos = getToolMousePosValue(tool)
    if mousePos then
        mousePos.Value = aimPart.Position
    end

    return aimPart
end

function equipMasteryWeapon()
    local masteryType = normalizeWeaponType(state.masteryWeaponType)

    if masteryType == "Blox Fruit" then
        local data = LocalPlayer:FindFirstChild("Data")
        local devilFruitValue = data and data:FindFirstChild("DevilFruit")
        local devilFruitName = devilFruitValue and devilFruitValue.Value
        if devilFruitName and devilFruitName ~= "" then
            local equippedFruit = equipSelectedWeapon(nil, devilFruitName, true)
            if equippedFruit then
                return equippedFruit
            end
        end
    end

    if state.selectedWeapon and state.selectedWeapon ~= "Auto Detect" then
        for _, tool in ipairs(getAllTools()) do
            if tool.Name == state.selectedWeapon and tool.ToolTip == masteryType then
                return equipSelectedWeapon(nil, state.selectedWeapon, true)
            end
        end
    end

    return equipSelectedWeapon(masteryType, nil, true)
end

function performMasteryAttack(target)
    if not target then
        return
    end

    local targetRoot = target:FindFirstChild("HumanoidRootPart")
    local aimPart = getMasteryAimPart(target)
    if not targetRoot or not aimPart then
        return
    end

    local equippedTool = equipMasteryWeapon()
    if not equippedTool then
        return
    end

    aimToolAtTarget(equippedTool, target)

    if normalizeWeaponType(state.masteryWeaponType) == "Gun" then
        local cooldown = equippedTool:FindFirstChild("Cooldown")
        if cooldown and cooldown:IsA("NumberValue") then
            cooldown.Value = 0
        end

        local fired = false
        if state.masteryAimbot then
            fired = fireGunToolAtTarget(equippedTool, target)
        end

        if not fired then
            clickAttack()
        end
        useMasterySkillsIfNeeded(target, equippedTool)
    else
        clickAttack()
        useMasterySkillsIfNeeded(target, equippedTool)
    end
end

function getBountyStat()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    return leaderstats and leaderstats:FindFirstChild("Bounty/Honor") or nil
end

function getBountyValue()
    local stat = getBountyStat()
    return stat and stat.Value or 0
end

function formatCompactNumber(value)
    value = tonumber(value) or 0
    local absValue = math.abs(value)

    if absValue >= 1000000 then
        return string.format("%.2fM", value / 1000000)
    elseif absValue >= 1000 then
        return string.format("%.2fK", value / 1000)
    end

    return tostring(math.floor(value + 0.5))
end

function getCombatPlayerOptions()
    local options = {"Nearest Enemy"}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(options, player.Name)
        end
    end

    table.sort(options, function(a, b)
        if a == "Nearest Enemy" then
            return true
        elseif b == "Nearest Enemy" then
            return false
        end

        return a < b
    end)

    return options
end

function refreshCombatPlayerDropdownOptions()
    local options = getCombatPlayerOptions()
    if not combatPlayerDropdown then
        return options
    end

    pcall(function()
        if type(combatPlayerDropdown.Refresh) == "function" then
            combatPlayerDropdown:Refresh(options)
        elseif type(combatPlayerDropdown.SetOptions) == "function" then
            combatPlayerDropdown:SetOptions(options)
        elseif type(combatPlayerDropdown.SetValues) == "function" then
            combatPlayerDropdown:SetValues(options)
        elseif type(combatPlayerDropdown.Clear) == "function" and type(combatPlayerDropdown.Add) == "function" then
            combatPlayerDropdown:Clear()
            for _, option in ipairs(options) do
                combatPlayerDropdown:Add(option)
            end
        end
    end)

    return options
end

function isPlayerCharacterAlive(player)
    local character = player and player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local root = character and character:FindFirstChild("HumanoidRootPart")
    return character ~= nil and humanoid ~= nil and root ~= nil and humanoid.Health > 0
end

function getPlayerLevelValue(player)
    local data = player and player:FindFirstChild("Data")
    local level = data and data:FindFirstChild("Level")
    return level and tonumber(level.Value) or nil
end

function getBountyMinTargetLevel()
    local localLevel = getPlayerLevelValue(LocalPlayer)
    if not localLevel or localLevel <= 0 then
        return nil
    end

    return math.max(1, math.floor(localLevel * 0.75))
end

function isBountyLevelEligible(player)
    local minLevel = getBountyMinTargetLevel()
    local targetLevel = getPlayerLevelValue(player)
    if not minLevel or not targetLevel then
        return true
    end

    return targetLevel >= minLevel
end

function arePlayersAllied(firstPlayer, secondPlayer)
    return firstPlayer ~= nil
        and secondPlayer ~= nil
        and firstPlayer.Team ~= nil
        and firstPlayer.Team == secondPlayer.Team
end

function clearExpiredBountySkips()
    local now = tick()
    for playerName, expiresAt in pairs(state.bounty.skipTargets) do
        if expiresAt <= now then
            state.bounty.skipTargets[playerName] = nil
        end
    end
end

function isPlayerSkippedForBounty(playerName)
    local expiresAt = playerName and state.bounty.skipTargets[playerName] or nil
    return expiresAt ~= nil and expiresAt > tick()
end

function isValidCombatTarget(player, enemyOnly)
    if not player or player == LocalPlayer or not isPlayerCharacterAlive(player) then
        return false
    end

    if enemyOnly and arePlayersAllied(LocalPlayer, player) then
        return false
    end

    if enemyOnly and not isBountyLevelEligible(player) then
        return false
    end

    if isPlayerSkippedForBounty(player.Name) then
        return false
    end

    local hrp = getHumanoidRootPart()
    local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and targetRoot then
        return (targetRoot.Position - hrp.Position).Magnitude <= (state.bounty.maxDistance or 17000)
    end

    return targetRoot ~= nil
end

function getSelectedCombatPlayer(enemyOnly)
    local selectedName = state.bounty.selectedPlayer
    if not selectedName or selectedName == "" or selectedName == "Nearest Enemy" then
        return nil
    end

    local player = Players:FindFirstChild(selectedName)
    if enemyOnly then
        return isValidCombatTarget(player, true) and player or nil
    end

    if player and player ~= LocalPlayer and isPlayerCharacterAlive(player) and not isPlayerSkippedForBounty(player.Name) then
        return player
    end

    return nil
end

function getNearestCombatPlayer(enemyOnly)
    local hrp = getHumanoidRootPart()
    local bestPlayer = nil
    local bestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        local isValid = enemyOnly and isValidCombatTarget(player, true)
            or (player ~= LocalPlayer and isPlayerCharacterAlive(player) and not isPlayerSkippedForBounty(player.Name))

        if isValid then
            local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local distance = hrp and targetRoot and (targetRoot.Position - hrp.Position).Magnitude or math.huge
            if distance < bestDistance then
                bestDistance = distance
                bestPlayer = player
            end
        end
    end

    return bestPlayer
end

function getPreferredCombatPlayer(enemyOnly)
    clearExpiredBountySkips()

    local selectedPlayer = getSelectedCombatPlayer(enemyOnly)
    if selectedPlayer then
        return selectedPlayer
    end

    return getNearestCombatPlayer(enemyOnly)
end

function clearBountyTarget()
    state.bounty.currentTarget = nil
    state.bounty.lastTargetHealth = nil
    state.bounty.lastDamageTick = 0
end

function getAimbotHoldKeyCode()
    return Enum.KeyCode[state.aimbot.holdKey] or Enum.KeyCode.Q
end

function getAimbotTargetPart(character)
    if not character then
        return nil
    end

    return character:FindFirstChild("Head")
        or character:FindFirstChild("HumanoidRootPart")
        or character:FindFirstChild("UpperTorso")
        or character:FindFirstChild("Torso")
end

function isAimbotFriend(player)
    if not player or player == LocalPlayer then
        return false
    end

    local success, isFriend = pcall(function()
        return LocalPlayer:IsFriendsWith(player.UserId)
    end)
    return success and isFriend or false
end

function getAimbotScreenPosition(worldPosition)
    local camera = Workspace.CurrentCamera
    if not camera or typeof(worldPosition) ~= "Vector3" then
        return nil, false
    end

    local viewportPoint, onScreen = camera:WorldToViewportPoint(worldPosition)
    return Vector2.new(viewportPoint.X, viewportPoint.Y), onScreen and viewportPoint.Z > 0
end

function getAimbotViewportCenter()
    local camera = Workspace.CurrentCamera
    local viewportSize = camera and camera.ViewportSize or Vector2.new(0, 0)
    return Vector2.new(viewportSize.X * 0.5, viewportSize.Y * 0.5)
end

function isValidManualAimbotTarget(player, requireFov)
    if not player or player == LocalPlayer or not isPlayerCharacterAlive(player) then
        return false
    end

    if state.aimbot.teamCheck and arePlayersAllied(LocalPlayer, player) then
        return false
    end

    if state.aimbot.ignoreFriends and isAimbotFriend(player) then
        return false
    end

    local aimPart = getAimbotTargetPart(player.Character)
    if not aimPart then
        return false
    end

    if requireFov then
        local screenPosition, onScreen = getAimbotScreenPosition(aimPart.Position)
        if not onScreen or not screenPosition then
            return false
        end

        local screenDistance = (screenPosition - getAimbotViewportCenter()).Magnitude
        if screenDistance > (tonumber(state.aimbot.fovRadius) or 150) then
            return false
        end
    end

    return true
end

function clearAimbotHighlight()
    clearEspTag("ZyphraxBF_AimbotHighlight")
    state.aimbot.highlightedPlayer = nil
end

function updateAimbotHighlight(targetPlayer)
    if not state.aimbot.highlightTarget then
        clearAimbotHighlight()
        return
    end

    local character = targetPlayer and targetPlayer.Character
    if not character then
        clearAimbotHighlight()
        return
    end

    local currentHighlight = character:FindFirstChild("ZyphraxBF_AimbotHighlight")
    if state.aimbot.highlightedPlayer == targetPlayer and currentHighlight then
        return
    end

    clearAimbotHighlight()

    local highlight = Instance.new("Highlight")
    highlight.Name = "ZyphraxBF_AimbotHighlight"
    highlight.FillColor = Color3.fromRGB(255, 64, 64)
    highlight.FillTransparency = 0.35
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    registerEspInstance("ZyphraxBF_AimbotHighlight", highlight)
    state.aimbot.highlightedPlayer = targetPlayer
end

function releaseManualAimbot()
    state.aimbot.lockedPlayer = nil
    state.aimbot.status = state.aimbot.enabled and "Ready" or "Disabled"
    updateAimbotHighlight(nil)
end

function getPreferredManualAimbotPlayer()
    local selectedPlayer = getSelectedCombatPlayer(false)
    if selectedPlayer and isValidManualAimbotTarget(selectedPlayer, true) then
        return selectedPlayer
    end

    local bestPlayer = nil
    local bestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if isValidManualAimbotTarget(player, true) then
            local targetPart = getAimbotTargetPart(player.Character)
            local screenPosition = targetPart and getAimbotScreenPosition(targetPart.Position)
            if screenPosition then
                local distance = (screenPosition - getAimbotViewportCenter()).Magnitude
                if distance < bestDistance then
                    bestDistance = distance
                    bestPlayer = player
                end
            end
        end
    end

    return bestPlayer
end

function getLockedManualAimbotPlayer()
    local lockedPlayer = state.aimbot.lockedPlayer
    if isValidManualAimbotTarget(lockedPlayer, false) then
        return lockedPlayer
    end

    state.aimbot.lockedPlayer = nil

    local targetPlayer = getPreferredManualAimbotPlayer()
    state.aimbot.lockedPlayer = targetPlayer
    updateAimbotHighlight(targetPlayer)
    return targetPlayer
end

function ensureAimbotFovCircle()
    if aimbotFovCircle ~= nil then
        return aimbotFovCircle
    end

    local success, circle = pcall(function()
        local newCircle = Drawing.new("Circle")
        newCircle.Visible = false
        newCircle.Filled = false
        newCircle.Thickness = 1.5
        newCircle.NumSides = 64
        newCircle.Color = Color3.fromRGB(255, 255, 255)
        newCircle.Transparency = 0.9
        return newCircle
    end)

    aimbotFovCircle = success and circle or false
    return aimbotFovCircle
end

function updateManualAimbotUi()
    local function setLabelText(label, text)
        if not label then
            return
        end

        local hasSetText, setTextMethod = pcall(function()
            return label.SetText
        end)

        if hasSetText and type(setTextMethod) == "function" then
            setTextMethod(label, text)
        else
            label.Text = text
        end
    end

    if aimbotBindLabel then
        setLabelText(aimbotBindLabel, "Hold Key: " .. tostring(state.aimbot.holdKey))
    end

    if aimbotStatusLabel then
        local lockedPlayer = state.aimbot.lockedPlayer
        local statusText = state.aimbot.status
        if lockedPlayer and lockedPlayer.Parent then
            statusText = "Locked: " .. lockedPlayer.Name
        end
        setLabelText(aimbotStatusLabel, "Aimbot: " .. statusText)
    end
end

function updateManualAimbotVisuals()
    local circle = ensureAimbotFovCircle()
    if circle and circle ~= false then
        circle.Position = getAimbotViewportCenter()
        circle.Radius = tonumber(state.aimbot.fovRadius) or 150
        circle.Visible = state.aimbot.enabled and state.aimbot.showFov
    end
end

function updateManualAimbot(deltaTime)
    updateManualAimbotVisuals()

    if not state.aimbot.enabled or not state.aimbot.holdActive then
        if state.aimbot.lockedPlayer then
            releaseManualAimbot()
            updateManualAimbotUi()
        end
        return
    end

    local targetPlayer = getLockedManualAimbotPlayer()
    local targetPart = targetPlayer and getAimbotTargetPart(targetPlayer.Character)
    local camera = Workspace.CurrentCamera
    if not targetPlayer or not targetPart or not camera then
        state.aimbot.status = "Searching"
        updateManualAimbotUi()
        return
    end

    local desired = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
    local smoothness = math.max(tonumber(state.aimbot.smoothness) or 3, 1)
    local alpha = math.clamp((deltaTime or 0.016) * (45 / smoothness), 0.08, 1)
    camera.CFrame = camera.CFrame:Lerp(desired, alpha)
    state.aimbot.status = "Locked"
    updateAimbotHighlight(targetPlayer)
    updateManualAimbotUi()
end

function skipBountyTarget(playerName, duration)
    if playerName and playerName ~= "" then
        state.bounty.skipTargets[playerName] = tick() + (duration or 20)
    end

    clearBountyTarget()
end

function fireGunToolAtTarget(tool, targetCharacter)
    local aimPart = aimToolAtTarget(tool, targetCharacter)
    if not tool or not aimPart then
        return false
    end

    local cooldown = tool:FindFirstChild("Cooldown")
    if cooldown and cooldown:IsA("NumberValue") then
        cooldown.Value = 0
    end

    local shooter = tool:FindFirstChild("RemoteFunctionShoot")
    if not shooter then
        return false
    end

    pcall(function()
        if tool.Name == "Soul Guitar" then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local soulGuitarRemote = humanoid and humanoid:FindFirstChild("Soul Guitar")
            if soulGuitarRemote and soulGuitarRemote.InvokeServer then
                soulGuitarRemote:InvokeServer("TAP", aimPart.CFrame)
            end
        end

        shooter:InvokeServer(aimPart.Position, aimPart)
    end)

    return true
end

function updateCombatAim(targetCharacter, allowAutoShoot)
    local equippedTool = equipSelectedWeapon(nil, nil, true)
    if not equippedTool or not targetCharacter then
        return
    end

    local weaponType = normalizeWeaponType(equippedTool.ToolTip or equippedTool:GetAttribute("WeaponType"))

    if state.bounty.aimbotSkills or allowAutoShoot then
        aimToolAtTarget(equippedTool, targetCharacter)
    end

    if state.bounty.aimbotGun or (allowAutoShoot and weaponType == "Gun") then
        fireGunToolAtTarget(equippedTool, targetCharacter)
    end
end

function getBountySkillEnabled(skillKey)
    if skillKey == "Z" then
        return state.bounty.skillZ
    elseif skillKey == "X" then
        return state.bounty.skillX
    elseif skillKey == "C" then
        return state.bounty.skillC
    elseif skillKey == "V" then
        return state.bounty.skillV
    elseif skillKey == "F" then
        return state.bounty.skillF
    end

    return false
end

function getBountySkillHoldDelay(skillKey)
    local rawValue
    if skillKey == "Z" then
        rawValue = state.bounty.holdDelayZ
    elseif skillKey == "X" then
        rawValue = state.bounty.holdDelayX
    elseif skillKey == "C" then
        rawValue = state.bounty.holdDelayC
    elseif skillKey == "V" then
        rawValue = state.bounty.holdDelayV
    elseif skillKey == "F" then
        rawValue = state.bounty.holdDelayF
    else
        rawValue = 1
    end

    return math.clamp(tonumber(rawValue) or 1, 1, 10)
end

function tryAutoActivateBountySkill(skillKey)
    local skillState = bountySkillState[skillKey]
    if not skillState or skillState.holding or not getBountySkillEnabled(skillKey) then
        return
    end

    local now = tick()
    local holdDelay = getBountySkillHoldDelay(skillKey)
    if now - (skillState.lastUse or 0) < holdDelay then
        return
    end

    skillState.lastUse = now
    skillState.holding = true
    task.spawn(function()
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, skillKey, false, game)
            task.wait(holdDelay)
            VirtualInputManager:SendKeyEvent(false, skillKey, false, game)
        end)
        skillState.holding = false
    end)
end

function autoActivateBountySkills(targetCharacter)
    if not state.bounty.autoFarm or not targetCharacter or not state.bounty.currentTarget then
        return
    end

    local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetHumanoid or targetHumanoid.Health <= 0 or not targetRoot then
        return
    end

    local hrp = getHumanoidRootPart()
    if hrp then
        local maxActivationDistance = math.max((tonumber(state.bounty.playerDistance) or 20) + 40, 60)
        if (targetRoot.Position - hrp.Position).Magnitude > maxActivationDistance then
            return
        end
    end

    tryAutoActivateBountySkill("Z")
    tryAutoActivateBountySkill("X")
    tryAutoActivateBountySkill("C")
    tryAutoActivateBountySkill("V")
    tryAutoActivateBountySkill("F")
end

function getCombatFollowCFrame(targetRoot, isAutoFarm)
    if not targetRoot then
        return nil
    end

    local mode = state.bounty.positionMethod or "Top"
    local verticalOffset = tonumber(state.bounty.playerDistance) or 20
    local distanceOffset = math.clamp(math.floor(verticalOffset / 2), 8, 20)

    if isAutoFarm then
        verticalOffset = math.clamp(verticalOffset, 8, 25)
        distanceOffset = math.clamp(distanceOffset, 6, 18)
    end

    local baseOffset = Vector3.new(0, verticalOffset, 0)
    if mode == "Bottom" then
        baseOffset = Vector3.new(0, -verticalOffset, 0)
    elseif mode == "Behind" then
        baseOffset = Vector3.new(0, 0, distanceOffset)
    elseif mode == "Front" then
        baseOffset = Vector3.new(0, 0, -distanceOffset)
    end

    return targetRoot.CFrame * CFrame.new(baseOffset)
end

function moveToCombatPlayer(player, isAutoFarm)
    local character = player and player.Character
    local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        return false
    end

    local desired = getCombatFollowCFrame(targetRoot, isAutoFarm)
    if not desired then
        return false
    end

    moveToPlayerTarget(desired, 0, 0, true)
    return true
end

function updateBountyProgressTracking(targetPlayer)
    local character = targetPlayer and targetPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return false
    end

    if state.bounty.currentTarget ~= targetPlayer.Name then
        state.bounty.currentTarget = targetPlayer.Name
        state.bounty.lastTargetHealth = humanoid.Health
        state.bounty.lastDamageTick = tick()
        return true
    end

    if humanoid.Health < (state.bounty.lastTargetHealth or humanoid.Health) then
        state.bounty.lastTargetHealth = humanoid.Health
        state.bounty.lastDamageTick = tick()
        return true
    end

    if tick() - (state.bounty.lastDamageTick or 0) >= (state.bounty.targetTimeout or 6.5) then
        skipBountyTarget(targetPlayer.Name, 20)
        state.bounty.status = "Switching target"
        return false
    end

    return true
end

function isPirateRaidBlockingAutomation()
    return state.autoPirateRaid and state.autoPirateRaidBusy
end

function isNonBountyMovementAutomationActive()
    return _G.AutoFarm
        or _G.AutoNear
        or _G.AutoBossFarm
        or _G.AutoFarmFruits
        or _G.AutoFarmMaterial
        or _G.AutoSecondWorld
        or _G.AutoThirdWorld
        or state.autoSelectedMobNoQuest
        or state.autoSelectedMobQuest
        or state.autoChest
        or state.autoEliteHunter
        or state.autoFactoryRaid
        or isPirateRaidBlockingAutomation()
        or state.autoKitsuneIsland
        or state.autoCollectAzureEmber
        or state.autoTweenFruit
        or state.autoMirageGear
        or state.autoAdvancedFruitDealer
        or state.dragon.autoDojoTrainer
        or state.dragon.autoDragonHunter
        or state.dragon.autoDracoV2V3
        or state.raceQuest.autoV2
        or state.raceQuest.autoV3
        or state.v4Trial.autoLever
        or state.v4Trial.autoRaceDoor
        or state.v4Trial.autoHumanGhoulTrial
        or state.v4Trial.autoCompleteTrial
        or state.v4Trial.autoKillTrialPlayer
        or isQuestAutomationActive()
        or isSeaCombatActive()
end

function updateCombatStatusUi()
    if combatPlayerCountLabel then
        combatPlayerCountLabel.Text = string.format("Players: %d / 12", #Players:GetPlayers())
    end

    if combatTargetLabel then
        local targetName = state.bounty.currentTarget or state.bounty.selectedPlayer or "None"
        combatTargetLabel.Text = "Target: " .. tostring(targetName)
    end

    if bountyCurrentLabel then
        bountyCurrentLabel.Text = "Current Bounty: " .. formatCompactNumber(getBountyValue())
    end

    if bountyEarnedLabel then
        local startValue = state.bounty.startValue
        local earnedValue = startValue and math.max(getBountyValue() - startValue, 0) or 0
        bountyEarnedLabel.Text = "Earned: " .. formatCompactNumber(earnedValue)
    end

    if bountyStatusLabel then
        bountyStatusLabel.Text = "Status: " .. tostring(state.bounty.status or "Idle")
    end
end

function isBottomHudIndicatorVisible(indicatorName)
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainGui = playerGui and playerGui:FindFirstChild("Main")
    local bottomHudList = mainGui and mainGui:FindFirstChild("BottomHUDList")
    local indicator = bottomHudList and bottomHudList:FindFirstChild(indicatorName)
    if not indicator then
        return false
    end

    if indicator:IsA("GuiObject") and indicator.Visible then
        return true
    end

    local indicatorText = indicator:FindFirstChild("Text", true)
    if indicatorText and indicatorText:IsA("GuiObject") and indicatorText.Visible then
        return true
    end

    local textLabel = indicator:FindFirstChildWhichIsA("TextLabel", true)
        or indicator:FindFirstChildWhichIsA("TextButton", true)
    return textLabel ~= nil and textLabel.Visible
end

function getBottomHudBountyBlockReason()
    if isBottomHudIndicatorVisible("SafeZone") then
        return "Safe zone"
    end

    if isBottomHudIndicatorVisible("PvpDisabled") then
        return "PvP disabled"
    end

    return nil
end

function getBountyIgnoreReason(targetRoot)
    if not state.bounty.ignoreSafeZonePlayers or not targetRoot then
        return nil
    end

    local hrp = getHumanoidRootPart()
    if not hrp or (targetRoot.Position - hrp.Position).Magnitude > 350 then
        return nil
    end

    return getBottomHudBountyBlockReason()
end

function runTweenToPlayerStep()
    if isNonBountyMovementAutomationActive() then
        state.bounty.status = "Tween paused by other automation"
        return
    end

    local targetPlayer = getPreferredCombatPlayer(false)
    if not targetPlayer then
        clearBountyTarget()
        state.bounty.status = "Waiting for player"
        stopTeleport()
        return
    end

    state.bounty.currentTarget = targetPlayer.Name
    state.bounty.status = "Tweening to " .. targetPlayer.Name
    moveToCombatPlayer(targetPlayer, false)

    local targetRoot = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local ignoreReason = getBountyIgnoreReason(targetRoot)
    if ignoreReason then
        skipBountyTarget(targetPlayer.Name, 20)
        state.bounty.status = "Ignored target: " .. ignoreReason
        stopTeleport()
        return
    end

    updateCombatAim(targetPlayer.Character, false)
end

function runAutoBountyStep()
    if isNonBountyMovementAutomationActive() then
        state.bounty.status = "Bounty paused by other automation"
        return
    end

    if state.bounty.startValue == nil then
        state.bounty.startValue = getBountyValue()
    end

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainGui = playerGui and playerGui:FindFirstChild("Main")
    if mainGui then
        local pvpDisabled = mainGui:FindFirstChild("PvpDisabled")
        if pvpDisabled and pvpDisabled.Visible then
            CommF:InvokeServer("EnablePvp")
        end

        local inCombat = mainGui:FindFirstChild("InCombat")
        if inCombat then
            inCombat.Visible = false
        end

        local safeZone = mainGui:FindFirstChild("SafeZone")
        if safeZone then
            safeZone.Visible = false
        end
    end

    AutoHaki()

    local targetPlayer = getPreferredCombatPlayer(true)
    if not targetPlayer then
        clearBountyTarget()
        local minLevel = getBountyMinTargetLevel()
        if minLevel then
            state.bounty.status = "Searching target (Lv. " .. tostring(minLevel) .. "+)"
        else
            state.bounty.status = "Searching for target"
        end
        stopTeleport()

        if state.bounty.autoHop and tick() - (state.bounty.lastHopTick or 0) >= 120 then
            state.bounty.lastHopTick = tick()
            Hop()
        end

        return
    end

    local character = targetPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not targetRoot or humanoid.Health <= 0 then
        skipBountyTarget(targetPlayer.Name, 15)
        return
    end

    if not updateBountyProgressTracking(targetPlayer) then
        return
    end

    local ignoreReason = getBountyIgnoreReason(targetRoot)
    if ignoreReason then
        skipBountyTarget(targetPlayer.Name, 20)
        state.bounty.status = "Ignored target: " .. ignoreReason
        stopTeleport()
        return
    end

    targetRoot.CanCollide = false
    state.bounty.status = "Hunting " .. targetPlayer.Name

    moveToCombatPlayer(targetPlayer, true)
    updateCombatAim(character, false)
    autoActivateBountySkills(character)
    clickAttack()
end

seaLevelTargets = {
    ["Level 1"] = CFrame.new(-11888, 1, 16193),
    ["Level 2"] = CFrame.new(-11001, 1, 21056),
    ["Level 3"] = CFrame.new(-9995, 1, 24741),
    ["Level 4"] = CFrame.new(-8657, 1, 29984),
    ["Level 5"] = CFrame.new(-8627, 1, 34267),
    ["Level 6"] = CFrame.new(-2552, 1, 75051)
}
mirageRouteSwitchDistance = 700

seaTeamOptions = {"Pirates", "Marines"}
seaBoatOptions = {"Dinghy", "PirateSloop", "PirateBrigade", "PirateGrandBrigade", "MarineSloop", "MarineBrigade", "MarineGrandBrigade"}
seaWeaponOptions = {"Melee", "Sword", "Gun", "Devil Fruit"}
seaMobNames = {
    Shark = true,
    Piranha = true,
    ["Fish Crew Member"] = true,
    Terrorshark = true,
    PirateBrigade = true,
    PirateGrandBrigade = true
}
seaShipNames = {
    PirateBrigade = true,
    PirateGrandBrigade = true
}
seaBoatDockCFrame = CFrame.new(-16192, 11, 1741, 0.927989781, 0, -0.372605681, -0, 1, 0, 0.372605681, 0, 0.927989781)
seaSkillHookInstalled = false
seaEnemySharkNames = {
    Shark = true,
    Piranha = true,
    Terrorshark = true
}
seaEnemyFishCrewNames = {
    ["Fish Crew Member"] = true
}
seaEnemyPirateShipNames = {
    PirateBrigade = true,
    PirateGrandBrigade = true
}
seaEnemySharkTokens = {"shark", "piranha"}
seaEnemyFishCrewTokens = {"fish crew", "fisherman"}
seaEnemyPirateShipTokens = {"piratebrigade", "pirategrandbrigade", "pirate ship"}

function isSeaCombatActive()
    return state.sea.attackMobs or state.sea.attackSeaBeasts
end

function isQuestAutomationActive()
    local quests = state.quests
    local dragon = state.dragon
    local raceQuest = state.raceQuest
    local craft = state.craft
    return state.autoBoneFarm
        or state.autoYama
        or state.autoHolyTorch
        or state.autoTushita
        or state.autoTyrant
        or state.autoCDK
        or state.autoSanguineArt
        or state.autoDojoTrainer
        or state.autoBlazeEmbers
        or dragon.autoDojoTrainer
        or dragon.autoDragonHunter
        or dragon.autoDracoV2V3
        or raceQuest.autoV2
        or raceQuest.autoV3
        or craft.autoCraftVolcanicMagnet
        or craft.autoCollectDragonEgg
        or craft.autoAuraColor
        or craft.autoBaristaCousin
        or craft.autoTradeAzureEmber
        or quests.autoObservation
        or quests.autoCakePrince
        or quests.autoDoughKing
        or quests.autoSoulReaper
        or quests.autoSharkmanKarate
        or quests.autoElectricClaw
        or quests.autoGodhuman
        or quests.autoDungeon
        or quests.autoLawRaid
end

function isCoreAutomationActive()
    return _G.AutoFarm
        or _G.AutoNear
        or _G.AutoBossFarm
        or _G.AutoFarmFruits
        or _G.AutoFarmMaterial
        or _G.AutoSecondWorld
        or _G.AutoThirdWorld
        or state.autoSelectedMobNoQuest
        or state.autoSelectedMobQuest
        or state.autoChest
        or state.autoEliteHunter
        or state.autoFactoryRaid
        or isPirateRaidBlockingAutomation()
        or state.autoBerry
        or state.autoMirageTeleport
        or state.autoKitsuneIsland
        or state.autoCollectAzureEmber
        or state.autoTweenFruit
        or state.autoMirageGear
        or state.autoAdvancedFruitDealer
        or state.dragon.autoDojoTrainer
        or state.dragon.autoDragonHunter
        or state.dragon.autoDracoV2V3
        or state.raceQuest.autoV2
        or state.raceQuest.autoV3
        or state.v4Trial.autoLever
        or state.v4Trial.autoRaceDoor
        or state.v4Trial.autoHumanGhoulTrial
        or state.v4Trial.autoCompleteTrial
        or state.v4Trial.autoKillTrialPlayer
        or state.sea.autoPrehistoricTeleport
        or state.sea.autoDefendVolcano
end

function isMovementAutomationActive()
    return _G.AutoFarm
        or _G.AutoNear
        or _G.AutoBossFarm
        or _G.AutoFarmFruits
        or _G.AutoFarmMaterial
        or _G.AutoSecondWorld
        or _G.AutoThirdWorld
        or state.autoSelectedMobNoQuest
        or state.autoSelectedMobQuest
        or state.autoChest
        or state.autoEliteHunter
        or state.autoFactoryRaid
        or isPirateRaidBlockingAutomation()
        or state.autoKitsuneIsland
        or state.autoCollectAzureEmber
        or state.autoTweenFruit
        or state.autoMirageGear
        or state.autoAdvancedFruitDealer
        or state.dragon.autoDojoTrainer
        or state.dragon.autoDragonHunter
        or state.dragon.autoDracoV2V3
        or state.raceQuest.autoV2
        or state.raceQuest.autoV3
        or state.v4Trial.autoLever
        or state.v4Trial.autoRaceDoor
        or state.v4Trial.autoHumanGhoulTrial
        or state.v4Trial.autoCompleteTrial
        or state.v4Trial.autoKillTrialPlayer
        or state.bounty.autoFarm
        or state.bounty.tweenToPlayer
        or isQuestAutomationActive()
        or isSeaCombatActive()
end

function setSeaSkillAim(enabled, position)
    state.sea.skillAimEnabled = enabled == true and position ~= nil
    state.sea.skillAimPosition = state.sea.skillAimEnabled and position or nil
end

function getSeaEnemyCategory(enemyName)
    if seaEnemyPirateShipNames[enemyName] or enemyNameHasToken(enemyName, seaEnemyPirateShipTokens) then
        return "pirateShips"
    end

    if seaEnemyFishCrewNames[enemyName] or enemyNameHasToken(enemyName, seaEnemyFishCrewTokens) then
        return "fishCrew"
    end

    if seaEnemySharkNames[enemyName] or enemyNameHasToken(enemyName, seaEnemySharkTokens) then
        return "sharks"
    end

    return nil
end

function isSeaEnemyCategoryEnabled(category)
    if category == "sharks" then
        return state.sea.attackSharks
    end

    if category == "fishCrew" then
        return state.sea.attackFishCrew
    end

    if category == "pirateShips" then
        return state.sea.attackPirateShips
    end

    return false
end

function getSeaBoatTeam()
    if string.find(state.sea.boat, "Marine", 1, true) then
        return "Marines"
    end

    if string.find(state.sea.boat, "Pirate", 1, true) then
        return "Pirates"
    end

    return state.sea.team
end

function ensureSeaTeam()
    local targetTeam = getSeaBoatTeam()
    local currentTeam = LocalPlayer.Team and LocalPlayer.Team.Name or nil
    if targetTeam and currentTeam ~= targetTeam then
        CommF:InvokeServer("SetTeam", targetTeam)
    end
end

function isSeaBoatOwnedByLocalPlayer(boatModel)
    local ownerValue = boatModel and boatModel:FindFirstChild("Owner")
    local owner = ownerValue and ownerValue.Value or nil
    return owner == LocalPlayer or (owner and owner.Name == LocalPlayer.Name) or false
end

function isLocalPlayerDrivingBoatSeat(seat)
    local humanoid = getHumanoid()
    return seat ~= nil and humanoid ~= nil and seat.Occupant == humanoid
end

function getSeaBoatModel()
    local boats = Workspace:FindFirstChild("Boats")
    if not boats then
        return nil
    end

    local humanoid = getHumanoid()
    if humanoid then
        for _, boat in ipairs(boats:GetChildren()) do
            local seat = boat:FindFirstChild("VehicleSeat", true)
            if seat and seat.Occupant == humanoid then
                return boat
            end
        end
    end

    local selectedBoat = boats:FindFirstChild(state.sea.boat)
    local ownedFallback = nil

    for _, boat in ipairs(boats:GetChildren()) do
        if isSeaBoatOwnedByLocalPlayer(boat) then
            if boat.Name == state.sea.boat then
                return boat
            end

            if not ownedFallback then
                ownedFallback = boat
            end
        end
    end

    return ownedFallback or selectedBoat
end

function getSeaBoatSeat(boatModel)
    local boat = boatModel or getSeaBoatModel()
    if not boat then
        return nil
    end

    return boat:FindFirstChild("VehicleSeat", true)
end

function clearSeaBoatSpeedHack(seat)
    local targetSeat = seat or seaBoatSpeedSeat
    if not targetSeat then
        return
    end

    local helper = targetSeat:FindFirstChild("ZyphraxBoatSpeed")
    if helper then
        helper:Destroy()
    end

    if seaBoatSpeedSeat == targetSeat then
        seaBoatSpeedSeat = nil
    end
end

function getSeaBoatDriveDirection(seat, autoForward)
    if not seat then
        return nil
    end

    local throttle = tonumber(seat.ThrottleFloat) or tonumber(seat.Throttle) or 0
    local steer = tonumber(seat.SteerFloat) or tonumber(seat.Steer) or 0
    local rootPart = seat.AssemblyRootPart or seat
    local currentVelocity = rootPart.AssemblyLinearVelocity
    local horizontalVelocity = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)

    if math.abs(throttle) < 0.05 and autoForward then
        throttle = 1
    end

    if horizontalVelocity.Magnitude > 2 and math.abs(steer) < 0.15 and math.abs(throttle) > 0.05 then
        return horizontalVelocity.Unit
    end

    local direction = (seat.CFrame.LookVector * throttle) + (seat.CFrame.RightVector * steer * 0.35)
    direction = Vector3.new(direction.X, 0, direction.Z)

    if direction.Magnitude <= 0.05 then
        return nil
    end

    return direction.Unit
end

function applySeaBoatSpeedHack(boatModel, seat)
    if seaBoatSpeedSeat and seaBoatSpeedSeat ~= seat then
        clearSeaBoatSpeedHack(seaBoatSpeedSeat)
    end

    if not seat then
        clearSeaBoatSpeedHack()
        return
    end

    seaBoatSpeedSeat = seat

    local speedValue = math.max(tonumber(state.sea.boatSpeed) or 0, 0)
    pcall(function()
        seat.MaxSpeed = speedValue
    end)

    local occupiedByLocal = isLocalPlayerDrivingBoatSeat(seat)
    local direction = getSeaBoatDriveDirection(seat, occupiedByLocal and state.sea.autoPressW)
    if not occupiedByLocal or speedValue <= 0 or not direction then
        clearSeaBoatSpeedHack(seat)
        return
    end

    local helper = seat:FindFirstChild("ZyphraxBoatSpeed")
    if not helper then
        helper = Instance.new("BodyVelocity")
        helper.Name = "ZyphraxBoatSpeed"
        helper.P = 12000
        helper.MaxForce = Vector3.new(1000000000, 0, 1000000000)
        helper.Parent = seat
    end

    helper.MaxForce = Vector3.new(1000000000, 0, 1000000000)
    helper.Velocity = direction * speedValue

    local rootPart = seat.AssemblyRootPart or seat
    local currentVelocity = rootPart.AssemblyLinearVelocity
    rootPart.AssemblyLinearVelocity = Vector3.new(direction.X * speedValue, currentVelocity.Y, direction.Z * speedValue)
end

function stopSeaBoatTween()
    if seaBoatTween then
        pcall(function()
            seaBoatTween:Cancel()
        end)
    end

    seaBoatTween = nil
    seaBoatTweenTarget = nil
    seaBoatTweenSeat = nil
end

function tweenSeaBoatTo(targetCFrame)
    local seat = getSeaBoatSeat()
    if not seat or not targetCFrame then
        return false
    end

    local desired = typeof(targetCFrame) == "CFrame" and targetCFrame or CFrame.new(targetCFrame)
    if seaBoatTweenSeat == seat and seaBoatTweenTarget and (seaBoatTweenTarget.Position - desired.Position).Magnitude <= 5 then
        return true
    end

    stopSeaBoatTween()

    local speed = math.max(tonumber(state.sea.boatTweenSpeed) or 350, 1)
    local distance = (desired.Position - seat.Position).Magnitude
    seaBoatTweenSeat = seat
    seaBoatTweenTarget = desired
    seaBoatTween = TweenService:Create(seat, TweenInfo.new(math.max(distance / speed, 0.05), Enum.EasingStyle.Linear), {CFrame = desired})
    seaBoatTween:Play()
    return true
end

function getSeaSailingTarget()
    local prehistoric = Workspace:FindFirstChild("_WorldOrigin")
        and Workspace._WorldOrigin:FindFirstChild("Locations")
        and Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")

    if prehistoric then
        return prehistoric.CFrame * CFrame.new(0, 50, 0)
    end

    if state.sea.autoMirageSail then
        local routeNames = {"Level 4", "Level 5"}
        local routeIndex = state.sea.mirageRouteIndex == 5 and 2 or 1
        local routeName = routeNames[routeIndex]
        local currentTarget = seaLevelTargets[routeName]
        local referencePart = getSeaBoatSeat(getSeaBoatModel()) or getHumanoidRootPart()

        if currentTarget and referencePart and (referencePart.Position - currentTarget.Position).Magnitude <= mirageRouteSwitchDistance then
            routeIndex = routeIndex == 1 and 2 or 1
            routeName = routeNames[routeIndex]
            currentTarget = seaLevelTargets[routeName]
        end

        state.sea.mirageRouteIndex = routeIndex == 1 and 4 or 5
        if currentTarget then
            return currentTarget * CFrame.new(0, 50, 0)
        end
    end

    local seaLevelTarget = seaLevelTargets[state.sea.seaLevel] or seaLevelTargets["Level 1"]
    return seaLevelTarget * CFrame.new(0, 50, 0)
end

function getSeaBoatHealthValue(container)
    if not container then
        return nil
    end

    local healthObject = container:FindFirstChild("Health") or container:FindFirstChild("Humanoid")
    if not healthObject then
        return nil
    end

    local success, value = pcall(function()
        if healthObject:IsA("Humanoid") then
            return healthObject.Health
        end

        return healthObject.Value
    end)

    if success and typeof(value) == "number" then
        return value
    end

    success, value = pcall(function()
        return healthObject.Health
    end)

    if success and typeof(value) == "number" then
        return value
    end

    return nil
end

function getSeaEnemyTargetPart(enemy)
    if not enemy then
        return nil
    end

    return enemy:FindFirstChild("HumanoidRootPart")
        or enemy:FindFirstChild("Engine")
        or enemy:FindFirstChild("VehicleSeat")
        or enemy:FindFirstChildWhichIsA("BasePart", true)
end

function isSeaEnemyAlive(enemy)
    local category = enemy and getSeaEnemyCategory(enemy.Name) or nil
    if not enemy or not category or not isSeaEnemyCategoryEnabled(category) then
        return false
    end

    if category == "pirateShips" then
        local shipHealth = getSeaBoatHealthValue(enemy)
        return shipHealth and shipHealth > 0 or false
    end

    local humanoid = enemy:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0 or false
end

function getNearestSeaEnemy()
    local hrp = getHumanoidRootPart()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not hrp or not enemies then
        return nil
    end

    local bestEnemy
    local bestDistance

    for _, enemy in ipairs(enemies:GetChildren()) do
        if isSeaEnemyAlive(enemy) then
            local targetPart = getSeaEnemyTargetPart(enemy)
            if targetPart then
                local distance = (targetPart.Position - hrp.Position).Magnitude
                if not bestDistance or distance < bestDistance then
                    bestDistance = distance
                    bestEnemy = enemy
                end
            end
        end
    end

    return bestEnemy
end

function getNearestSeaBeast()
    local hrp = getHumanoidRootPart()
    local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
    if not hrp or not seaBeasts then
        return nil
    end

    local bestTarget
    local bestDistance

    for _, seaBeast in ipairs(seaBeasts:GetChildren()) do
        local targetPart = seaBeast:FindFirstChild("HumanoidRootPart")
        local healthValue = getSeaBoatHealthValue(seaBeast)
        if seaBeast.Name == "SeaBeast1" and targetPart and healthValue and healthValue > 0 then
            local distance = (targetPart.Position - hrp.Position).Magnitude
            if not bestDistance or distance < bestDistance then
                bestDistance = distance
                bestTarget = seaBeast
            end
        end
    end

    return bestTarget
end

function shouldPauseSeaSailing()
    return (state.sea.attackMobs and getNearestSeaEnemy() ~= nil)
        or (state.sea.attackSeaBeasts and getNearestSeaBeast() ~= nil)
end

function equipSeaWeapon()
    return equipSelectedWeapon(normalizeWeaponType(state.sea.weaponType), nil, true)
end

function useSeaSkills()
    local aimPosition = state.sea.skillAimPosition
    if not state.sea.skillAimEnabled or not aimPosition then
        return
    end

    local equippedTool = equipSeaWeapon()
    if equippedTool then
        local mousePos = equippedTool:FindFirstChild("MousePos")
        if mousePos and mousePos:IsA("Vector3Value") then
            mousePos.Value = aimPosition
        end
    end

    if state.sea.skillZ then
        UseSkill("Z")
    end
    if state.sea.skillX then
        UseSkill("X")
    end
    if state.sea.skillC then
        UseSkill("C")
    end
    if state.sea.skillV then
        UseSkill("V")
    end
    if state.sea.skillF then
        UseSkill("F")
    end
end

function moveToSeaTarget(targetCFrame, offset)
    local hrp = getHumanoidRootPart()
    if not hrp or not targetCFrame then
        return
    end

    local targetPosition = targetCFrame.Position + Vector3.new(0, offset, 0)
    local desiredY = math.max(targetPosition.Y, SEA_COMBAT_MIN_Y)
    local boat = getSeaBoatModel()
    local seat = getSeaBoatSeat(boat)

    if boat and seat and isSeaBoatOwnedByLocalPlayer(boat) then
        desiredY = math.max(desiredY, seat.Position.Y + SEA_COMBAT_BOAT_CLEARANCE)
    end

    desiredY = math.max(desiredY, hrp.Position.Y - 5)

    local desired = CFrame.new(targetPosition.X, desiredY, targetPosition.Z)
    if (hrp.Position - desired.Position).Magnitude > 40 then
        TP1(desired)
    else
        stopTeleport()
        hrp.CFrame = desired
    end
end

function updateSeaCombatPosition(targetPart, safeHeight)
    local humanoid = getHumanoid()
    if not humanoid or not targetPart then
        return
    end

    local attackHeight = math.max(tonumber(state.sea.attackDistance) or 30, 1)
    if humanoid.Health < humanoid.MaxHealth * 0.35 then
        moveToSeaTarget(targetPart.CFrame, safeHeight)
    elseif humanoid.Health > humanoid.MaxHealth * 0.5 then
        moveToSeaTarget(targetPart.CFrame, attackHeight)
    end
end

function installSeaSkillHook()
    if seaSkillHookInstalled or _G.__ZyphraxSeaSkillHookInstalled then
        seaSkillHookInstalled = true
        return
    end

    if not getrawmetatable or not newcclosure or not getnamecallmethod or not setreadonly then
        return
    end

    seaSkillHookInstalled = true
    _G.__ZyphraxSeaSkillHookInstalled = true

    local metatable = getrawmetatable(game)
    local oldNamecall = metatable.__namecall
    setreadonly(metatable, false)

    metatable.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        local remoteInstance = args[1]
        local zyphraxState = _G.__ZyphraxSeaSkillState
        local aimPosition = zyphraxState and zyphraxState.sea and zyphraxState.sea.skillAimPosition or nil

        if zyphraxState
            and zyphraxState.running
            and zyphraxState.sea
            and zyphraxState.sea.skillAimEnabled
            and aimPosition
            and method == "FireServer"
            and typeof(remoteInstance) == "Instance"
            and remoteInstance:IsA("RemoteEvent")
            and remoteInstance.Name == "RemoteEvent"
        then
            local secondArg = args[2]
            local argumentType = typeof(secondArg)
            if argumentType == "Vector3" then
                args[2] = aimPosition
                return oldNamecall(unpack(args))
            elseif argumentType == "CFrame" then
                args[2] = CFrame.new(aimPosition)
                return oldNamecall(unpack(args))
            end
        end

        return oldNamecall(...)
    end)

    setreadonly(metatable, true)
end

pcall(installSeaSkillHook)

function MaterialMon()
    MMonList, MPos = getMaterialRoute(_G.SelectMaterial)
    MMon = MMonList and MMonList[1] or nil
end

function getMaterialRoute(selection)
    if selection == "Farm Leather + Scrap Metal" then
        return Sea2 and {"Factory Staff"} or {"Brute"}, Sea2 and CFrame.new(295, 73, -56) or CFrame.new(-1145, 15, 4350)
    elseif selection == "Farm Fish Tail" then
        if World1 then
            return {"Fishman Warrior", "Fishman Commando"}, CFrame.new(61123, 19, 1569)
        elseif World3 then
            return {"Fishman Raider", "Fishman Captain"}, CFrame.new(-10407, 332, -8757)
        end
    elseif selection == "Farm Magma Ore" then
        if World1 then
            return {"Military Spy", "Military Soldier"}, CFrame.new(-5815, 84, 8820)
        elseif World2 then
            return {"Magma Ninja", "Lava Pirate"}, CFrame.new(-5428, 78, -5959)
        end
    elseif selection == "Farm Angel Wings" then
        return {"God's Guard"}, CFrame.new(-4698, 845, -1912)
    elseif selection == "Farm Radiactive Material" then
        return {"Factory Staff"}, CFrame.new(295, 73, -56)
    elseif selection == "Farm Vampire Fang" then
        return {"Vampire"}, CFrame.new(-6033, 7, -1317)
    elseif selection == "Farm Mystic Droplet" then
        return {"Water Fighter", "Sea Soldier"}, CFrame.new(-3385, 239, -10542)
    elseif selection == "Farm Ectoplasm" then
        return {"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"}, CFrame.new(1198, 126, 33031)
    elseif selection == "Farm Mini Tusk" then
        return {"Mythological Pirate"}, CFrame.new(-13545, 470, -6917)
    elseif selection == "Farm Dragon Scale" then
        return {"Dragon Crew Archer", "Dragon Crew Warrior"}, CFrame.new(6594, 383, 139)
    elseif selection == "Farm Conjured Cocoa" then
        return {"Chocolate Bar Battler", "Cocoa Warrior"}, CFrame.new(620, 78, -12581)
    elseif selection == "Farm Fire Flower" then
        return dragonDojoTargets.FireFlower, CFrame.new(2942, 120, -6975)
    elseif selection == "Farm Blaze Ember" then
        return {"Hydra Enforcer", "Venomous Assailant"}, CFrame.new(5255, 1004, 345)
    end

    return nil, nil
end

function refreshInventoryCache(force)
    local cache = state.inventoryCache
    if not force and tick() - (cache.updatedAt or 0) < 2 then
        return cache
    end

    cache.updatedAt = tick()
    cache.counts = {}
    cache.unlocked = {}
    cache.materials = {}

    local ok, items = pcall(function()
        return CommF:InvokeServer("getInventory")
    end)

    if ok and type(items) == "table" then
        for _, item in ipairs(items) do
            if type(item) == "table" and item.Name then
                local count = tonumber(item.Count) or 0
                local normalizedCount = count
                if normalizedCount <= 0 and item.Type ~= "Material" then
                    normalizedCount = 1
                end
                cache.counts[item.Name] = math.max(cache.counts[item.Name] or 0, normalizedCount)
                if count > 0 or item.Type ~= "Material" then
                    cache.unlocked[item.Name] = true
                end
                if item.Type == "Material" then
                    cache.materials[item.Name] = count
                end
            end
        end
    end

    return cache
end

function getInventoryCount(itemName)
    return refreshInventoryCache().counts[itemName] or 0
end

function hasInventoryItem(itemName)
    if refreshInventoryCache().unlocked[itemName] == true then
        return true
    end

    return hasToolNamed(itemName) or hasWeaponInInventory(itemName)
end

function getMaterialInventory()
    return refreshInventoryCache().materials
end

function getToolInstanceByName(toolName)
    return hasToolNamed(toolName)
end

function getToolLevel(toolName)
    local tool = getToolInstanceByName(toolName)
    local levelValue = tool and tool:FindFirstChild("Level")
    return levelValue and tonumber(levelValue.Value) or nil
end

function setQuestWeapon(toolName)
    state.weaponType = "Melee"
    state.selectedWeapon = toolName
    equipToolByName(toolName)
end

function runAutoSuperhumanTraining(styleName)
    local farmMethod = state.quests.superhumanMethod or "Auto Farm Level"
    return withCombatWeaponOverride("AutoSuperhuman", "Melee", styleName, function()
        equipToolByName(styleName, true)

        if farmMethod == "Auto Farm Bone" then
            runAutoBoneFarm(false, true)
        elseif farmMethod == "Auto Farm Sea of Treats" then
            runSeaOfTreatsTrainingStep("Training " .. styleName .. " at Sea of Treats", function()
                return state.quests.autoSuperhuman
            end)
        else
            runCurrentLevelQuestStep("Training " .. styleName .. " mastery", function()
                return state.quests.autoSuperhuman
            end)
        end
    end)
end

function runAutoStyleMasteryTraining(styleName, statusText, isEnabled)
    return withCombatWeaponOverride("StyleMastery", "Melee", styleName, function()
        equipToolByName(styleName, true)
        runCurrentLevelQuestStep(statusText or ("Training " .. styleName .. " mastery"), isEnabled)
    end)
end

function getOwnedStyleName(styleNames)
    for _, styleName in ipairs(styleNames) do
        if hasToolNamed(styleName) then
            return styleName
        end
    end

    return nil
end

function getRaidIslandTarget()
    local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
    if not locations then
        return nil
    end

    for islandIndex = 5, 1, -1 do
        local island = locations:FindFirstChild("Island " .. islandIndex)
        if island then
            return island.CFrame * CFrame.new(0, 80, 100)
        end
    end

    return nil
end

function findNearestRaidEnemy(maxDistance)
    local hrp = getHumanoidRootPart()
    local enemies = Workspace:FindFirstChild("Enemies")
    local bestEnemy
    local bestDistance = maxDistance or math.huge

    if not hrp or not enemies then
        return nil
    end

    for _, enemy in ipairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
        if humanoid and enemyRoot and humanoid.Health > 0 then
            local distance = (enemyRoot.Position - hrp.Position).Magnitude
            if distance < bestDistance then
                bestDistance = distance
                bestEnemy = enemy
            end
        end
    end

    return bestEnemy
end

function isRaidActive()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainGui = playerGui and playerGui:FindFirstChild("Main")
    local timer = mainGui and mainGui:FindFirstChild("Timer")
    return timer and timer.Visible == true or false
end

function getRaidSummonClickDetector()
    if not fireclickdetector then
        return nil
    end

    local map = Workspace:FindFirstChild("Map")
    if not map then
        return nil
    end

    if Sea2 then
        local button = map:FindFirstChild("CircleIsland", true)
        button = button and button:FindFirstChild("RaidSummon2", true)
        button = button and button:FindFirstChild("Button", true)
        button = button and button:FindFirstChild("Main", true)
        return button and button:FindFirstChildOfClass("ClickDetector") or nil
    elseif Sea3 then
        local button = map:FindFirstChild("Boat Castle", true)
        button = button and button:FindFirstChild("RaidSummon2", true)
        button = button and button:FindFirstChild("Button", true)
        button = button and button:FindFirstChild("Main", true)
        return button and button:FindFirstChildOfClass("ClickDetector") or nil
    end

    return nil
end

function getLawRaidClickDetector()
    if not fireclickdetector then
        return nil
    end

    local map = Workspace:FindFirstChild("Map")
    local button = map and map:FindFirstChild("CircleIsland", true)
    button = button and button:FindFirstChild("RaidSummon", true)
    button = button and button:FindFirstChild("Button", true)
    button = button and button:FindFirstChild("Main", true)
    return button and button:FindFirstChildOfClass("ClickDetector") or nil
end

function getObservationTarget()
    local seaLabel = getCurrentSeaLabel()
    return observationTargets[seaLabel]
end

function isObservationImageVisible()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local screenGui = playerGui and playerGui:FindFirstChild("ScreenGui")
    return screenGui and screenGui:FindFirstChild("ImageLabel") ~= nil
end

function toggleObservation()
    if tick() - lastObservationToggleAt < 1 then
        return false
    end

    lastObservationToggleAt = tick()
    VirtualInputManager:SendKeyEvent(true, "E", false, game)
    task.wait(0.15)
    VirtualInputManager:SendKeyEvent(false, "E", false, game)
    return true
end

function getCakeMobs()
    return cakeMobNames
end

function getCurrentQuestEnemyByNames(targetNames)
    local enemy = findClosestNamedEnemyByNames(targetNames)
    if enemy then
        return enemy
    end

    return nil
end

function attackTargetNames(targetNames, isEnabled, fallbackCFrame, offset)
    local enemy = getCurrentQuestEnemyByNames(targetNames)
    if enemy then
        attackEnemy(enemy, offset or 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running and isEnabled() and enemy.Parent and humanoid and humanoid.Health > 0
        end)
        return true
    end

    moveToReplicaOrFallback(targetNames, fallbackCFrame, offset)
    return false
end

function getCakePrinceSpawnerResponse()
    local ok, response = pcall(function()
        return CommF:InvokeServer("CakePrinceSpawner")
    end)

    if not ok then
        return nil
    end

    return response
end

function parseCakePrinceRemaining(response)
    response = response == nil and getCakePrinceSpawnerResponse() or response
    if type(response) ~= "string" then
        return nil
    end

    local values = {}
    for number in string.gmatch(response, "%d+") do
        table.insert(values, tonumber(number))
    end

    return values[#values]
end

function isCakeMirrorOpen()
    local map = Workspace:FindFirstChild("Map")
    local cakeLoaf = map and map:FindFirstChild("CakeLoaf")
    local bigMirror = cakeLoaf and cakeLoaf:FindFirstChild("BigMirror")
    local other = bigMirror and bigMirror:FindFirstChild("Other")
    return other and other.Transparency ~= 1 or false
end

function shouldTryCakePrinceSpawner(response)
    if type(response) ~= "string" then
        return isCakeMirrorOpen()
    end

    local lowered = string.lower(response)
    return string.find(lowered, "open the portal now", 1, true) ~= nil
        or string.find(lowered, "boss is spawning", 1, true) ~= nil
        or parseCakePrinceRemaining(response) == 0
        or isCakeMirrorOpen()
end

function tryActivateCakePrinceSpawner()
    if tick() - lastCakePrinceAttempt <= 2 then
        return false
    end

    lastCakePrinceAttempt = tick()
    local response = getCakePrinceSpawnerResponse()
    if not shouldTryCakePrinceSpawner(response) then
        return false
    end

    pcall(function()
        CommF:InvokeServer("CakePrinceSpawner", true)
    end)
    pcall(function()
        CommF:InvokeServer("CakePrinceSpawner")
    end)
    return true
end

function findCakePrinceEnemy()
    return findClosestNamedEnemyByNames(cakePrinceBossNames) or findClosestEnemyByTokens({"cake prince"})
end

function getCakePrinceReplicaRoot()
    return getReplicaRootByNames(cakePrinceBossNames) or findReplicaRootByToken("cake prince")
end

function findDoughKingEnemy()
    return findClosestNamedEnemyByNames(doughKingBossNames) or findClosestEnemyByTokens({"dough king"})
end

function getDoughKingReplicaRoot()
    return getReplicaRootByNames(doughKingBossNames) or findReplicaRootByToken("dough king")
end

function formatCakeEncounterRemaining(labelPrefix, requireSweetChalice)
    local response = getCakePrinceSpawnerResponse()
    if type(response) ~= "string" then
        return labelPrefix .. ": --"
    end

    if isCakeMirrorOpen() or shouldTryCakePrinceSpawner(response) then
        if requireSweetChalice and hasToolNamed("Sweet Chalice") then
            return labelPrefix .. ": Ready"
        elseif not requireSweetChalice then
            return labelPrefix .. ": Ready"
        end
    end

    local remaining = parseCakePrinceRemaining(response)
    if remaining ~= nil then
        if requireSweetChalice and remaining == 0 and not hasToolNamed("Sweet Chalice") then
            return labelPrefix .. " Left: 0 | Need Sweet Chalice"
        end
        return string.format("%s Left: %d", labelPrefix, remaining)
    end

    return labelPrefix .. ": --"
end

function hasSwordNamed(toolName)
    return hasToolNamed(toolName) or hasWeaponInInventory(toolName)
end

function hasCDK()
    return hasSwordNamed("Cursed Dual Katana")
end

function getAlucardFragmentCount()
    return getMaterialInventory()["Alucard Fragment"] or 0
end

function findHazeTarget()
    local hrp = getHumanoidRootPart()
    local bestEnemy
    local bestDistance
    local bestReplicaRoot
    local bestReplicaDistance

    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies and hrp then
        for _, enemy in ipairs(enemies:GetChildren()) do
            local root = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChild("Humanoid")
            if root and humanoid and humanoid.Health > 0 and enemy:FindFirstChild("HazeESP", true) then
                local distance = (root.Position - hrp.Position).Magnitude
                if not bestDistance or distance < bestDistance then
                    bestDistance = distance
                    bestEnemy = enemy
                end
            end
        end
    end

    if bestEnemy then
        return bestEnemy, nil
    end

    for _, replica in ipairs(ReplicatedStorage:GetDescendants()) do
        if replica:IsA("Model") and replica:FindFirstChild("HazeESP", true) then
            local root = replica:FindFirstChild("HumanoidRootPart")
            if root and hrp then
                local distance = (root.Position - hrp.Position).Magnitude
                if not bestReplicaDistance or distance < bestReplicaDistance then
                    bestReplicaDistance = distance
                    bestReplicaRoot = root
                end
            end
        end
    end

    return nil, bestReplicaRoot
end

function findCDKFinalBossEnemy()
    return findClosestNamedEnemyByNames(cdkFinalBossNames) or findClosestEnemyByTokens({"cursed skeleton boss"})
end

function getCDKFinalBossReplicaRoot()
    return getReplicaRootByNames(cdkFinalBossNames) or findReplicaRootByToken("cursed skeleton boss")
end

function runAutoCDKFinalStage()
    local finalBoss = findCDKFinalBossEnemy()
    if finalBoss then
        attackEnemy(finalBoss, 20, function()
            local humanoid = finalBoss:FindFirstChild("Humanoid")
            return state.running and state.autoCDK and finalBoss.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    local replicaRoot = getCDKFinalBossReplicaRoot()
    if replicaRoot then
        TP1(replicaRoot.CFrame * CFrame.new(0, 20, 0))
        return
    end

    pcall(function()
        CommF:InvokeServer("CDKQuest", "Progress", "Good")
        CommF:InvokeServer("CDKQuest", "Progress", "Evil")
    end)

    TP1(cdkFinalPedestalCFrame)
    task.wait(0.15)
    pressInteractKey()
    TP1(cdkFinalBossFallbackCFrame)
end

function runAutoCDK()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    if hasCDK() then
        return
    end

    if not hasSwordNamed("Yama") then
        runAutoYama(true)
        return
    end

    if not hasSwordNamed("Tushita") then
        runAutoTushita()
        return
    end

    local fragments = getAlucardFragmentCount()
    if fragments < 3 then
        pcall(function()
            CommF:InvokeServer("CDKQuest", "Progress", "Evil")
            CommF:InvokeServer("CDKQuest", "StartTrial", "Evil")
        end)

        if fragments == 0 then
            attackWorldTarget({"Mythological Pirate", "Mythological Pirate [Lv. 1850]"}, function()
                return state.running and state.autoCDK
            end, cdkMythologicalPirateCFrame, 20)
        elseif fragments == 1 then
            local hazeEnemy, hazeReplicaRoot = findHazeTarget()
            if hazeEnemy then
                attackEnemy(hazeEnemy, 20, function()
                    local humanoid = hazeEnemy:FindFirstChild("Humanoid")
                    return state.running and state.autoCDK and hazeEnemy.Parent and humanoid and humanoid.Health > 0 and hazeEnemy:FindFirstChild("HazeESP", true)
                end)
            elseif hazeReplicaRoot then
                TP1(hazeReplicaRoot.CFrame * CFrame.new(0, 20, 0))
            else
                TP1(CFrame.new(-9515, 164, 5786))
            end
        else
            runAutoSoulReaper(true)
        end
        return
    end

    if fragments < 6 then
        pcall(function()
            CommF:InvokeServer("CDKQuest", "Progress", "Good")
            CommF:InvokeServer("CDKQuest", "StartTrial", "Good")
        end)

        if fragments == 3 then
            for _, stageCFrame in ipairs(cdkGoodTrialPath) do
                if not state.running or not state.autoCDK then
                    break
                end
                TP1(stageCFrame)
                task.wait(0.2)
            end
        elseif fragments == 4 then
            TP1(cdkGoodTrialStage2CFrame)
        else
            attackWorldTarget({"Cake Queen", "Cake Queen [Lv. 2175] [Boss]"}, function()
                return state.running and state.autoCDK
            end, cdkCakeQueenCFrame, 20)
        end
        return
    end

    runAutoCDKFinalStage()
end

function runSelectedMobFarm(useQuest)
    if not state.selectedQuestMob or state.selectedQuestMob == "" then
        return
    end

    SelectMonster = state.selectedQuestMob
    CheckQuest()

    local canFarm = true
    if useQuest then
        canFarm = ensureQuestStarted()
    end

    if not canFarm then
        return
    end

    local enemy = findClosestNamedEnemy(Mon)
    if enemy then
        attackEnemy(enemy, 25, function()
            if useQuest then
                local questGui = getQuestGui()
                return state.running and state.autoSelectedMobQuest and questGui and questGui.Visible and enemy.Parent and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0
            end

            return state.running and state.autoSelectedMobNoQuest and enemy.Parent and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0
        end)
    else
        local mobTarget = getMobFarmTarget(CFrameMon, CFrameMon2, 40)
        if isUsableTargetCFrame(mobTarget) then
            moveToMobTarget(mobTarget, 20, 40)
        end
    end
end

function ensureBossQuestStarted(bossName)
    local questInfo = bossQuestData[bossName]
    if not questInfo then
        return true
    end

    local questGui = getQuestGui()
    local questTitle = getQuestTitleText()

    if questGui and questGui.Visible and not textContains(questTitle, bossName) then
        CommF:InvokeServer("AbandonQuest")
        task.wait(0.25)
        return false
    end

    if not questGui or not questGui.Visible then
        TP1(questInfo.QuestCFrame)

        local hrp = getHumanoidRootPart()
        if hrp and (hrp.Position - questInfo.QuestCFrame.Position).Magnitude <= 20 then
            CommF:InvokeServer("StartQuest", questInfo.QuestName, questInfo.QuestLevel)
        end

        return false
    end

    return true
end

local secondSeaDoorCFrame = CFrame.new(1347.65271, 37.3906517, -1325.07715, 0.484830558, 2.71348792e-08, 0.874608099, -2.34559963e-08, 1, -1.80225808e-08, -0.874608099, -1.17769057e-08, 0.484830558)
iceAdmiralBossCFrame = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
bartiloQuestCFrame = CFrame.new(-456.28952, 73.0200958, 299.895966)
swanPirateFarmCFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
jeremyBossCFrame = CFrame.new(2099.88159, 448.931, 648.997375)
donSwanRoomCFrame = CFrame.new(2288.802, 15.1870775, 863.034607)
ripIndraRoomCFrame = CFrame.new(-26952.2891, 21.5294781, 329.351562, -0.453972578, 0, -0.891015649, 0, 1, 0, 0.891015649, 0, -0.453972578)
colosseumDoorCFrame = CFrame.new(-1836.1412353515625, 10.458294868469238, 1692.491943359375)
colosseumPuzzlePath = {
    CFrame.new(-1850.49329, 13.1789551, 1750.89685),
    CFrame.new(-1858.87305, 19.3777466, 1712.01807),
    CFrame.new(-1803.94324, 16.5789185, 1750.89685),
    CFrame.new(-1858.55835, 16.8604317, 1724.79541),
    CFrame.new(-1869.54224, 15.987854, 1681.00659),
    CFrame.new(-1800.0979, 16.4978027, 1684.52368),
    CFrame.new(-1819.26343, 14.795166, 1717.90625),
    CFrame.new(-1813.51843, 14.8604736, 1724.79541)
}

function hasToolNamed(toolName)
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    return (character and character:FindFirstChild(toolName)) or (backpack and backpack:FindFirstChild(toolName)) or nil
end

function hasWeaponInInventory(weaponName)
    local ok, items = pcall(function()
        return CommF:InvokeServer("getInventory")
    end)

    if ok and type(items) == "table" then
        for _, item in ipairs(items) do
            if type(item) == "table" and item.Type == "Sword" and item.Name == weaponName then
                return true
            end
        end
    end

    return false
end

function getEliteHunterProgress()
    local ok, progress = pcall(function()
        return CommF:InvokeServer("EliteHunter", "Progress")
    end)

    return ok and tonumber(progress) or 0
end

function hasGodsChalice()
    return hasToolNamed("God's Chalice") or hasToolNamed("Gods Chalice")
end

function equipToolByName(toolName, forceEquip)
    local character = getCharacter()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer:FindFirstChild("Backpack")

    if character:FindFirstChild(toolName) then
        return character[toolName]
    end

    if not shouldAutoEquipNow(forceEquip) then
        return character:FindFirstChild(toolName) or (backpack and backpack:FindFirstChild(toolName)) or nil
    end

    if humanoid and backpack and backpack:FindFirstChild(toolName) then
        humanoid:EquipTool(backpack[toolName])
        task.wait(0.05)
    end

    return character:FindFirstChild(toolName) or (backpack and backpack:FindFirstChild(toolName)) or nil
end

function normalizeTargetNames(targetNames)
    if type(targetNames) == "table" then
        return targetNames
    end

    return {targetNames}
end

function findClosestNamedEnemyByNames(targetNames)
    for _, targetName in ipairs(normalizeTargetNames(targetNames)) do
        local enemy = findClosestNamedEnemy(targetName)
        if enemy then
            return enemy
        end
    end

    return nil
end

function getReplicaRootByNames(targetNames)
    for _, targetName in ipairs(normalizeTargetNames(targetNames)) do
        local replica = ReplicatedStorage:FindFirstChild(targetName, true)
        local root = replica and replica:FindFirstChild("HumanoidRootPart")
        if root then
            return root
        end
    end

    return nil
end

function findReplicaRootByToken(token)
    local loweredToken = string.lower(token or "")
    if loweredToken == "" then
        return nil
    end

    for _, replica in ipairs(ReplicatedStorage:GetDescendants()) do
        if replica:IsA("Model") and string.find(string.lower(replica.Name), loweredToken, 1, true) then
            local root = replica:FindFirstChild("HumanoidRootPart")
            if root then
                return root
            end
        end
    end

    return nil
end

function findSoulReaperEnemy()
    return findClosestNamedEnemyByNames(soulReaperBossNames) or findClosestEnemyByTokens({"soul reaper"})
end

function getSoulReaperReplicaRoot()
    return getReplicaRootByNames(soulReaperBossNames) or findReplicaRootByToken("soul reaper")
end

function moveToReplicaOrFallback(targetNames, fallbackCFrame, offset)
    local targetOffset = offset or 20
    local replicaRoot = getReplicaRootByNames(targetNames)
    if replicaRoot then
        TP1(replicaRoot.CFrame * CFrame.new(0, targetOffset, 0))
    elseif fallbackCFrame then
        TP1(fallbackCFrame)
    end
end

function attackWorldTarget(targetNames, isEnabled, fallbackCFrame, offset)
    local enemy = findClosestNamedEnemyByNames(targetNames)
    if enemy then
        attackEnemy(enemy, offset or 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running and isEnabled() and enemy.Parent and humanoid and humanoid.Health > 0
        end)
        return true
    end

    moveToReplicaOrFallback(targetNames, fallbackCFrame, offset)
    return false
end

function questTitleContainsAll(tokens)
    local questGui = getQuestGui()
    local questTitle = getQuestTitleText()
    if not questGui or not questGui.Visible then
        return false
    end

    for _, token in ipairs(tokens) do
        if not textContains(questTitle, token) then
            return false
        end
    end

    return true
end

function attemptTrevorAccess()
    local unlockables = CommF:InvokeServer("GetUnlockables")
    if type(unlockables) == "table" and unlockables.FlamingoAccess == true then
        return true
    end

    local storedFruitNames = {}
    local inventoryFruits = CommF:InvokeServer("getInventoryFruits")
    if type(inventoryFruits) == "table" then
        for _, fruitInfo in ipairs(inventoryFruits) do
            if type(fruitInfo) == "table" and fruitInfo.Name then
                storedFruitNames[fruitInfo.Name] = true
            end
        end
    end

    local fruitToLoad = nil
    local purchasableFruits = CommF:InvokeServer("GetFruits")
    if type(purchasableFruits) == "table" then
        for _, fruitInfo in ipairs(purchasableFruits) do
            if type(fruitInfo) == "table"
                and fruitInfo.Name
                and tonumber(fruitInfo.Price)
                and fruitInfo.Price >= 1000000
                and storedFruitNames[fruitInfo.Name]
            then
                fruitToLoad = fruitInfo.Name
                break
            end
        end
    end

    if fruitToLoad and not hasToolNamed(fruitToLoad) then
        CommF:InvokeServer("LoadFruit", fruitToLoad)
        return false
    end

    CommF:InvokeServer("TalkTrevor", "1")
    CommF:InvokeServer("TalkTrevor", "2")
    CommF:InvokeServer("TalkTrevor", "3")

    unlockables = CommF:InvokeServer("GetUnlockables")
    return type(unlockables) == "table" and unlockables.FlamingoAccess == true
end

function runAutoSecondWorld()
    local level = LocalPlayer.Data and LocalPlayer.Data:FindFirstChild("Level")
    if not level or level.Value < 700 then
        return
    end

    local progress = CommF:InvokeServer("DressrosaQuestProgress")
    if type(progress) ~= "table" then
        return
    end

    if progress.UsedKey == false then
        if not hasToolNamed("Key") then
            CommF:InvokeServer("DressrosaQuestProgress", "Detective")
        else
            equipToolByName("Key")
            TP1(secondSeaDoorCFrame)
        end
        return
    end

    if progress.KilledIceBoss == false then
        attackWorldTarget({"Ice Admiral", "Ice Admiral [Lv. 700] [Boss]"}, function()
            return _G.AutoSecondWorld
        end, iceAdmiralBossCFrame, 20)
        return
    end

    CommF:InvokeServer("TravelDressrosa")
end

function runAutoThirdWorld()
    local level = LocalPlayer.Data and LocalPlayer.Data:FindFirstChild("Level")
    if not level or level.Value < 1500 then
        return
    end

    local bartiloProgress = CommF:InvokeServer("BartiloQuestProgress", "Bartilo")
    if bartiloProgress == 0 then
        if questTitleContainsAll({"Swan Pirates", "50"}) then
            attackWorldTarget("Swan Pirate", function()
                return _G.AutoThirdWorld
            end, swanPirateFarmCFrame, 20)
        else
            TP1(bartiloQuestCFrame)

            local hrp = getHumanoidRootPart()
            if hrp and (hrp.Position - bartiloQuestCFrame.Position).Magnitude <= 20 then
                CommF:InvokeServer("StartQuest", "BartiloQuest", 1)
            end
        end
        return
    end

    if bartiloProgress == 1 then
        CommF:InvokeServer("BartiloQuestProgress", "Bartilo")
        attackWorldTarget("Jeremy", function()
            return _G.AutoThirdWorld
        end, jeremyBossCFrame, 20)
        return
    end

    if bartiloProgress == 2 then
        local hrp = getHumanoidRootPart()
        if not hrp then
            return
        end

        if (hrp.Position - colosseumDoorCFrame.Position).Magnitude > 1500 then
            TP1(colosseumDoorCFrame)
        else
            stopTeleport()
            for _, waypoint in ipairs(colosseumPuzzlePath) do
                if not state.running or not _G.AutoThirdWorld then
                    break
                end

                hrp.CFrame = waypoint
                task.wait(1)
            end
        end
        return
    end

    if bartiloProgress ~= 3 then
        return
    end

    local unlockables = CommF:InvokeServer("GetUnlockables")
    if type(unlockables) == "table" and unlockables.FlamingoAccess == true then
        CommF:InvokeServer("TravelZou")
        return
    end

    local zProgress = CommF:InvokeServer("ZQuestProgress", "Check")
    if type(unlockables) == "table" and unlockables.FlamingoAccess == nil then
        if zProgress == nil then
            if not attackWorldTarget({"Don Swan", "Don Swan [Lv. 1000] [Boss]"}, function()
                return _G.AutoThirdWorld
            end, donSwanRoomCFrame, 20) then
                return
            end
        elseif zProgress == 1 then
            if not attackWorldTarget({"rip_indra", "rip_indra True Form"}, function()
                return _G.AutoThirdWorld
            end, ripIndraRoomCFrame, 20) then
                return
            end
        end
    end

    if attemptTrevorAccess() then
        CommF:InvokeServer("TravelZou")
    end
end

function runAutoObservation()
    local targetInfo = getObservationTarget()
    if not targetInfo then
        return
    end

    local enemy = findClosestNamedEnemy(targetInfo.Enemy)
    if not enemy then
        TP1(targetInfo.Spawn)
        if state.quests.autoObservationHop and tick() - lastObservationHop > 90 then
            lastObservationHop = tick()
            Hop()
        end
        return
    end

    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
    local hrp = getHumanoidRootPart()
    if not enemyRoot or not hrp then
        return
    end

    if not isObservationImageVisible() then
        toggleObservation()
        moveAboveTarget(enemyRoot.CFrame, 50)
        return
    end

    stopTeleport()
    hrp.CFrame = enemyRoot.CFrame * CFrame.new(3, 0, 0)
end

function runAutoCakePrince()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local cakePrince = findCakePrinceEnemy()
    if cakePrince then
        attackEnemy(cakePrince, 20, function()
            local humanoid = cakePrince:FindFirstChild("Humanoid")
            return state.running and state.quests.autoCakePrince and cakePrince.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    local replicaRoot = getCakePrinceReplicaRoot()
    if replicaRoot then
        TP1(replicaRoot.CFrame * CFrame.new(0, 20, 0))
        return
    end

    if tryActivateCakePrinceSpawner() then
        TP1(CFrame.new(-1820, 211, -12297))
        return
    end

    local cakeMob = findClosestNamedEnemyByNames(getCakeMobs()) or findClosestEnemyByTokens(cakeMobTokens)
    if cakeMob then
        attackEnemy(cakeMob, 20, function()
            local humanoid = cakeMob:FindFirstChild("Humanoid")
            return state.running
                and state.quests.autoCakePrince
                and cakeMob.Parent
                and humanoid
                and humanoid.Health > 0
                and findCakePrinceEnemy() == nil
        end)
    else
        moveToReplicaOrFallback(getCakeMobs(), CFrame.new(-1820, 211, -12297), 20)
    end
end

function runAutoDoughKing()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local doughKing = findDoughKingEnemy()
    if doughKing then
        attackEnemy(doughKing, 20, function()
            local humanoid = doughKing:FindFirstChild("Humanoid")
            return state.running and state.quests.autoDoughKing and doughKing.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    if hasToolNamed("Sweet Chalice") then
        equipToolByName("Sweet Chalice")
        TP1(bossFallbackCFrames["Dough King"])

        if tryActivateCakePrinceSpawner() then
            task.wait(0.2)
        end

        local mirrorBoss = findDoughKingEnemy()
        if mirrorBoss then
            attackEnemy(mirrorBoss, 20, function()
                local humanoid = mirrorBoss:FindFirstChild("Humanoid")
                return state.running and state.quests.autoDoughKing and mirrorBoss.Parent and humanoid and humanoid.Health > 0
            end)
            return
        end

        local mirrorReplica = getDoughKingReplicaRoot()
        if mirrorReplica then
            TP1(mirrorReplica.CFrame * CFrame.new(0, 20, 0))
            return
        end

        local cakeMob = findClosestNamedEnemyByNames(getCakeMobs()) or findClosestEnemyByTokens(cakeMobTokens)
        if cakeMob then
            attackEnemy(cakeMob, 20, function()
                local humanoid = cakeMob:FindFirstChild("Humanoid")
                return state.running
                    and state.quests.autoDoughKing
                    and cakeMob.Parent
                    and humanoid
                    and humanoid.Health > 0
                    and findDoughKingEnemy() == nil
            end)
        else
            moveToReplicaOrFallback(getCakeMobs(), CFrame.new(-1820, 211, -12297), 20)
        end
        return
    end

    local cocoaMob = findClosestNamedEnemyByNames(cocoaMobNames) or findClosestEnemyByTokens(cocoaMobTokens)
    if cocoaMob then
        attackEnemy(cocoaMob, 20, function()
            local humanoid = cocoaMob:FindFirstChild("Humanoid")
            return state.running and state.quests.autoDoughKing and cocoaMob.Parent and humanoid and humanoid.Health > 0
        end)
    else
        moveToReplicaOrFallback(cocoaMobNames, CFrame.new(231, 23, -12194), 20)
    end
end

function tryBuyBoneSurprise()
    if tick() - lastBoneSurpriseAttempt < 3 then
        return
    end

    lastBoneSurpriseAttempt = tick()
    pcall(function()
        CommF:InvokeServer("Bones", "Buy", 1, 1)
    end)
end

function runAutoBoneFarm(rollSurprise, forceRun)
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local isForced = forceRun == true

    if rollSurprise then
        tryBuyBoneSurprise()
    end

    local boneMob = findClosestNamedEnemyByNames(boneMobNames) or findClosestEnemyByTokens(boneMobTokens)
    if boneMob then
        attackEnemy(boneMob, 20, function()
            local humanoid = boneMob:FindFirstChild("Humanoid")
            return state.running
                and (state.autoBoneFarm or state.quests.autoSoulReaper or isForced)
                and boneMob.Parent
                and humanoid
                and humanoid.Health > 0
                and (state.autoBoneFarm or isForced or not hasToolNamed("Hallow Essence"))
        end)
    else
        local moveTarget
        local replicaRoot = getReplicaRootByNames(boneMobNames)
            or findReplicaRootByToken("reborn skeleton")
            or findReplicaRootByToken("living zombie")
            or findReplicaRootByToken("demonic soul")
            or findReplicaRootByToken("posessed mummy")
        if replicaRoot then
            moveTarget = replicaRoot.CFrame * CFrame.new(0, 20, 0)
        elseif state.quests.autoSoulReaperHop and not state.autoBoneFarm and not isForced then
            Hop()
        else
            moveTarget = CFrame.new(-9515, 164, 5786)
        end

        if moveTarget then
            local now = tick()
            if not lastBoneFarmMoveCFrame
                or (lastBoneFarmMoveCFrame.Position - moveTarget.Position).Magnitude > 15
                or now - lastBoneFarmMoveAt >= BONE_FARM_MOVE_INTERVAL
            then
                lastBoneFarmMoveAt = now
                lastBoneFarmMoveCFrame = moveTarget
                TP1(moveTarget)
            end
        end
    end
end

seaTreatsTrainingMobNames = {
    "Cookie Crafter",
    "Cake Guard",
    "Baking Staff",
    "Head Baker",
    "Cocoa Warrior",
    "Chocolate Bar Battler",
    "Sweet Thief",
    "Candy Rebel",
    "Candy Pirate",
    "Snow Demon"
}

function runSeaOfTreatsTrainingStep(statusText, isEnabled)
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return statusText or "Traveling to Zou"
    end

    local enemy = findClosestNamedEnemyByNames(seaTreatsTrainingMobNames)
    if enemy then
        attackEnemy(enemy, 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running and isEnabled() and enemy.Parent and humanoid and humanoid.Health > 0
        end)
    else
        moveToReplicaOrFallback(seaTreatsTrainingMobNames, CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875), 20)
    end

    return statusText or "Training at Sea of Treats"
end

function runAutoBerry()
    local bush, berryName = findNearestBerryBush()
    if not bush or not berryName then
        berryAttemptCache.key = nil
        berryAttemptCache.attempts = 0
        if state.autoBerryHop and tick() - lastBerryHop > 10 then
            lastBerryHop = tick()
            Hop()
        end
        return
    end

    local hrp = getHumanoidRootPart()
    if not hrp then
        return
    end

    local berryKey = tostring(bush) .. ":" .. tostring(berryName)
    if berryAttemptCache.key == berryKey and tick() - (berryAttemptCache.lastTry or 0) <= 2 then
        berryAttemptCache.attempts = (berryAttemptCache.attempts or 0) + 1
    else
        berryAttemptCache.key = berryKey
        berryAttemptCache.attempts = 1
    end
    berryAttemptCache.lastTry = tick()

    local bushModel = bush.Parent
    local bushPart = bushModel and getAdornmentPart(bushModel)
    local berryPart = bushModel and bushModel:FindFirstChild(berryName)

    if berryPart and berryPart:IsA("BasePart") then
        local targetCFrame = berryPart.CFrame + Vector3.new(0, 1, 0)
        if (hrp.Position - targetCFrame.Position).Magnitude > 4 then
            TP1(targetCFrame)
        else
            stopTeleport()
            hrp.CFrame = targetCFrame
        end
    elseif bushPart then
        local targetCFrame = CFrame.new(bushPart.Position + Vector3.new(0, 2, 0))
        if (hrp.Position - targetCFrame.Position).Magnitude > 4 then
            TP1(targetCFrame)
        else
            stopTeleport()
            hrp.CFrame = targetCFrame
        end
    end

    pressInteractKey()
    task.wait(0.05)
    pressInteractKey()

    if berryAttemptCache.attempts >= 8 then
        stopTeleport()
        if bushPart then
            hrp.CFrame = CFrame.new(bushPart.Position + Vector3.new(math.random(-6, 6), 2, math.random(-6, 6)))
        end
        berryAttemptCache.attempts = 0
    end
end

function runAutoFactoryRaid()
    if not Sea2 then
        CommF:InvokeServer("TravelDressrosa")
        return
    end

    local core = getFactoryCoreEnemy()
    if core then
        attackEnemy(core, 20, function()
            local humanoid = core:FindFirstChild("Humanoid")
            return state.running and state.autoFactoryRaid and core.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    TP1(CFrame.new(448.46756, 199.356781, -441.389252))
end

function runAutoKitsuneIsland()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local target = getKitsuneIslandTargetCFrame()
    if target then
        TP1(target)
    end
end

function runAutoCollectAzureEmber()
    local emberTemplate = Workspace:FindFirstChild("EmberTemplate")
    local emberPart = emberTemplate and emberTemplate:FindFirstChild("Part", true)
    if emberPart then
        TP1(emberPart.CFrame * CFrame.new(0, 2, 0))
    end
end

function runAutoKitsunePray()
    local remote = getNetRemote("RF/KitsuneStatuePray")
    if remote and remote.InvokeServer then
        pcall(function()
            remote:InvokeServer()
        end)
    end
end

function runAutoMirageGear()
    local gear = getMirageGearPart()
    if gear then
        TP1(gear.CFrame * CFrame.new(0, 4, 0))
    end
end

function runAutoAdvancedFruitDealer()
    local target = getAdvancedFruitDealerCFrame()
    if target then
        TP1(target * CFrame.new(0, 4, 0))
    end
end

function runAutoSanguineArt()
    if hasToolNamed("Sanguine Art") then
        setQuestWeapon("Sanguine Art")
        pcall(function()
            CommF:InvokeServer("BuySanguineArt", true)
            CommF:InvokeServer("BuySanguineArt")
        end)
        return
    end

    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    if hasToolNamed("Leviathan Heart") then
        equipToolByName("Leviathan Heart")
    end

    pcall(function()
        CommF:InvokeServer("BuySanguineArt", true)
        CommF:InvokeServer("BuySanguineArt")
    end)
end

function runDragonNpcInteraction(npcName, payload, clearFieldName)
    local targetCFrame = getDragonNpcCFrame(npcName)
    local hrp = getHumanoidRootPart()
    if targetCFrame and hrp and (hrp.Position - targetCFrame.Position).Magnitude > 5 then
        TP1(targetCFrame * CFrame.new(0, 3, 0))
        return "Teleporting to NPC: " .. npcName
    end

    if invokeDragonQuest(payload) and clearFieldName then
        state.dragon[clearFieldName] = nil
    end

    return "Interacting with NPC: " .. npcName
end

function runCurrentLevelQuestStep(statusText, isEnabled)
    CheckQuest()

    if not ensureQuestStarted() then
        return statusText or ("Getting Quest: " .. tostring(NameMon ~= "" and NameMon or Mon))
    end

    local enemy = findClosestNamedEnemy(Mon)
    if enemy then
        attackEnemy(enemy, 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running and isEnabled() and enemy.Parent and humanoid and humanoid.Health > 0
        end)
    else
        local mobTarget = getMobFarmTarget(CFrameMon, CFrameMon2, 40)
        if isUsableTargetCFrame(mobTarget) then
            moveToMobTarget(mobTarget, 10, 40)
        end
    end

    return statusText or ("Killing: " .. tostring(NameMon ~= "" and NameMon or Mon))
end

function attackSeaBeastStep(seaBeast)
    local targetPart = seaBeast and seaBeast:FindFirstChild("HumanoidRootPart")
    if not targetPart then
        return false
    end

    local playerHumanoid = getHumanoid()
    if playerHumanoid then
        playerHumanoid.Sit = false
    end

    AutoHaki()
    equipSeaWeapon()
    setSeaSkillAim(true, targetPart.Position)
    updateSeaCombatPosition(targetPart, 150)
    targetPart.CanCollide = false
    targetPart.Size = Vector3.new(120, 120, 120)
    targetPart.Transparency = 1
    clickAttack()
    return true
end

function runSeaObjectiveStep(targetNames, isEnabled, roamLevel, roamKey)
    local includesSeaBeast = false
    local enemyTargetNames = {}

    for _, targetName in ipairs(normalizeTargetNames(targetNames)) do
        if targetName == "Sea Beast" then
            includesSeaBeast = true
        else
            table.insert(enemyTargetNames, targetName)
        end
    end

    local enemy = #enemyTargetNames > 0 and findClosestNamedEnemyByNames(enemyTargetNames) or nil
    if enemy then
        attackEnemy(enemy, 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running and isEnabled() and enemy.Parent and humanoid and humanoid.Health > 0
        end)
        return "Hunting: " .. enemy.Name
    end

    if includesSeaBeast then
        local seaBeast = getNearestSeaBeast()
        if seaBeast and attackSeaBeastStep(seaBeast) then
            return "Hunting: Sea Beast"
        end
    end

    ensureSeaBoatForQuest(getCachedSeaRoamCFrame(roamKey or "SeaObjective", roamLevel or "Level 6"))
    return "Searching Sea Events"
end

function runAutoEliteHunterStep(allowHop)
    if state.stopEliteOnChalice and hasGodsChalice() then
        return "Stopped on God's Chalice"
    end

    local questTitle = getQuestTitleText()
    local questActive = textContains(questTitle, "Diablo") or textContains(questTitle, "Deandre") or textContains(questTitle, "Urban")

    if not questActive then
        local response = CommF:InvokeServer("EliteHunter")
        if allowHop and type(response) == "string" and textContains(response, "come back later") then
            Hop()
        end
        return "Getting Elite Hunter Quest"
    end

    local eliteBoss = findClosestNamedEnemyByNames(eliteHunterTargetNames)
    if eliteBoss then
        attackEnemy(eliteBoss, 20, function()
            local humanoid = eliteBoss:FindFirstChild("Humanoid")
            return state.running and eliteBoss.Parent and humanoid and humanoid.Health > 0
        end)
        return "Killing Elite Hunter: " .. eliteBoss.Name
    end

    moveToReplicaOrFallback(eliteHunterTargetNames, pirateRaidFallbackCFrame, 20)
    return "Searching Elite Hunter"
end

function runAutoFireFlowers(requiredAmount)
    local fireFlowerCount = getInventoryCount("Fire Flower")
    if fireFlowerCount >= requiredAmount then
        return "Fire Flowers Ready"
    end

    local flowerModel, flowerPart = getFireFlowerTarget()
    if flowerPart then
        local hrp = getHumanoidRootPart()
        if hrp and (hrp.Position - flowerPart.Position).Magnitude > 3 then
            TP1(flowerPart.CFrame)
        else
            local prompt = flowerModel and flowerModel:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt and fireproximityprompt then
                fireproximityprompt(prompt)
                task.wait(0.5)
            end
        end
        return "Collecting Fire Flower"
    end

    attackWorldTarget(dragonDojoTargets.FireFlower, function()
        return state.running and (state.dragon.autoDracoV2V3 or state.raceQuest.autoV2)
    end, CFrame.new(2942, 120, -6975), 20)
    return string.format("Getting Fire Flowers: %d/%d", fireFlowerCount, requiredAmount or 5)
end

function runCollectDinosaurBonesStep()
    if getInventoryCount("Dinosaur Bones") >= 99 then
        return "Dinosaur Bones Ready"
    end

    local island = getPrehistoricIsland()
    if LocalPlayer:GetAttribute("PrehistoricIslandParticipant") and island then
        for _, object in ipairs(Workspace:GetChildren()) do
            if object.Name == "DinoBone" and object:IsA("BasePart") and (object.Position - island:GetPivot().Position).Magnitude <= 1500 then
                TP1(object.CFrame + Vector3.new(0, 2, 0))
                return "Collecting Dinosaur Bones"
            end
        end
    end

    ensureSeaBoatForQuest(getCachedSeaRoamCFrame("PrehistoricSearch", "Level 6"))
    return "Searching Prehistoric Island"
end

function runAutoCollectDragonEgg()
    local egg = getDragonEggInstance()
    local eggPart = egg and (getAdornmentPart(egg) or egg:FindFirstChildWhichIsA("BasePart", true))
    if eggPart then
        TP1(eggPart.CFrame * CFrame.new(0, 2, 0))
        state.craft.status = "Collecting Dragon Egg"
        return "Collecting Dragon Egg"
    end

    if getPrehistoricIsland() then
        runAutoDefendVolcano()
        state.craft.status = "Waiting for Dragon Egg"
        return "Waiting for Dragon Egg"
    end

    ensureSeaBoatForQuest(getCachedSeaRoamCFrame("DragonEggSearch", "Level 6"))
    state.craft.status = "Searching Prehistoric Island"
    return "Searching Prehistoric Island"
end

function runDojoBeltQuestStep()
    local dragonState = state.dragon
    local beltQuestState = refreshDojoQuestState()
    if type(beltQuestState) ~= "table" or type(beltQuestState.Quest) ~= "table" then
        dragonState.status = runDragonNpcInteraction("Dojo Trainer", {
            NPC = "Dojo Trainer",
            Command = "RequestQuest"
        }, "currentBeltQuest")
        syncLegacyDragonFlags()
        return dragonState.status
    end

    if beltQuestState.Timeout or beltQuestState.Completed then
        dragonState.currentBeltQuest = nil
        dragonState.status = "Refreshing Belt Quest"
        syncLegacyDragonFlags()
        return dragonState.status
    end

    local quest = beltQuestState.Quest
    local beltName = quest.BeltName
    local previousBelt = dragonState.currentBelt
    local remoteProgress = tonumber(quest.Progress) or 0
    if previousBelt ~= beltName then
        dragonState.greenTimer = 0
        dragonState.purpleProgress = nil
        dragonState.startPurpleProgress = 0
        dragonState.blackProgress = nil
    end
    local currentProgress = math.max(dragonState.beltProgress[beltName] or 0, remoteProgress)
    dragonState.currentBelt = beltName
    dragonState.beltProgress[beltName] = currentProgress

    if beltName == "Green" then
        if getSeaDangerLevel() >= 500 and dragonState.greenTimer > 0 then
            currentProgress = math.max(currentProgress, remoteProgress + (tick() - dragonState.greenTimer))
        end
        dragonState.greenTimer = tick()
    elseif beltName == "Purple" then
        local eliteProgress = getEliteHunterProgress()
        if dragonState.purpleProgress == nil then
            dragonState.startPurpleProgress = currentProgress
            dragonState.purpleProgress = eliteProgress
        else
            currentProgress = math.max(currentProgress, dragonState.startPurpleProgress + (eliteProgress - dragonState.purpleProgress))
        end
    elseif beltName == "Black" then
        if dragonState.blackProgress == nil then
            dragonState.blackProgress = getInventoryCount("Dinosaur Bones")
        else
            currentProgress = math.max(currentProgress, getInventoryCount("Dinosaur Bones") - dragonState.blackProgress)
        end
    elseif beltName == "Blue" and hasDroppedPlayerFruit() then
        currentProgress = 1
    end

    dragonState.beltProgress[beltName] = currentProgress

    local requiredProgress = ({
        White = 20,
        Yellow = 5,
        Orange = 1,
        Green = 330,
        Blue = 1,
        Purple = 3,
        Red = 1,
        Black = 3
    })[beltName] or 1

    if hasInventoryItem("Dojo Belt (" .. beltName .. ")") or currentProgress >= requiredProgress then
        dragonState.status = runDragonNpcInteraction("Dojo Trainer", {
            NPC = "Dojo Trainer",
            Command = "ClaimQuest"
        }, "currentBeltQuest")
        if hasInventoryItem("Dojo Belt (" .. beltName .. ")") then
            dragonState.currentBeltQuest = nil
            dragonState.beltProgress[beltName] = nil
            dragonState.currentBelt = "Null"
        end
        syncLegacyDragonFlags()
        return dragonState.status
    end

    if beltName == "White" then
        dragonState.status = runCurrentLevelQuestStep("Belt Quest: White", function()
            return state.dragon.autoDojoTrainer or state.dragon.autoDracoV2V3
        end)
    elseif beltName == "Yellow" then
        dragonState.status = runSeaObjectiveStep(dragonDojoTargets.Yellow, function()
            return state.dragon.autoDojoTrainer or state.dragon.autoDracoV2V3
        end, "Level 6", "DojoYellow")
    elseif beltName == "Green" then
        ensureSeaBoatForQuest(getCachedSeaRoamCFrame("DojoGreen", "Level 6"))
        dragonState.status = string.format("Belt Quest: Green [ %d / %d ]", math.floor(currentProgress), requiredProgress)
    elseif beltName == "Purple" then
        dragonState.status = runAutoEliteHunterStep(false)
    elseif beltName == "Red" then
        dragonState.status = runSeaObjectiveStep(dragonDojoTargets.Red, function()
            return state.dragon.autoDojoTrainer or state.dragon.autoDracoV2V3
        end, "Level 6", "DojoRed")
    elseif beltName == "Blue" then
        dragonState.status = "Waiting for dropped-by-player fruit"
    elseif beltName == "Orange" then
        dragonState.status = "Orange Belt requires successful player trade"
    elseif beltName == "Black" then
        if not getPrehistoricIsland() and not hasInventoryItem("Volcanic Magnet") then
            dragonState.status = runAutoCraftVolcanicMagnet()
        else
            dragonState.status = runCollectDinosaurBonesStep()
        end
        if getPrehistoricIsland() then
            runAutoDefendVolcano()
        end
    else
        dragonState.status = "Unsupported Belt Quest: " .. tostring(beltName)
    end

    syncLegacyDragonFlags()
    return dragonState.status
end

function runAutoDragonHunter()
    local dragonState = state.dragon
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        dragonState.hunterStatus = "Traveling To Third Sea"
        syncLegacyDragonFlags()
        return dragonState.hunterStatus
    end

    local emberTemplate = Workspace:FindFirstChild("EmberTemplate")
    local emberPart = emberTemplate and emberTemplate:FindFirstChild("Part", true)
    if emberPart then
        TP1(emberPart.CFrame * CFrame.new(0, 2, 0))
        dragonState.hunterStatus = "Collecting Blaze Ember"
        syncLegacyDragonFlags()
        return dragonState.hunterStatus
    end

    if tick() - (dragonState.lastHunterRefresh or 0) >= 2 then
        dragonState.lastHunterRefresh = tick()
        local refreshedQuest = invokeDragonHunter({
            Context = "Check"
        })
        if type(refreshedQuest) == "table" then
            dragonState.currentDragonHunterQuest = refreshedQuest
        elseif refreshedQuest ~= nil then
            dragonState.currentDragonHunterQuest = nil
        end
    end

    if type(dragonState.currentDragonHunterQuest) ~= "table" or not dragonState.currentDragonHunterQuest.Text then
        local hunterCFrame = getDragonNpcCFrame("DragonHunter")
        local hrp = getHumanoidRootPart()
        if hunterCFrame and hrp and (hrp.Position - hunterCFrame.Position).Magnitude > 12 then
            TP1(hunterCFrame)
            dragonState.hunterStatus = "Teleporting to Dragon Hunter"
        else
            local response = invokeDragonHunter({
                Context = "Check"
            })
            if type(response) == "table" and response.Text then
                dragonState.currentDragonHunterQuest = response
            else
                invokeDragonHunter({
                    Context = "RequestQuest"
                })
            end
            dragonState.hunterStatus = "Getting Dragon Hunter Quest"
        end
        syncLegacyDragonFlags()
        return dragonState.hunterStatus
    end

    local questText = tostring(dragonState.currentDragonHunterQuest.Text or "")
    if textContains(questText, "Destroy 10 trees") then
        local tree = getHydraTreePart()
        if tree then
            TP1(tree.CFrame * CFrame.new(0, 4, 0))
            clickAttack()
            useWeaponTypeSkills("Melee")
            dragonState.hunterStatus = "Breaking Hydra Island Trees"
        else
            TP1(CFrame.new(5255, 1004, 345))
            dragonState.hunterStatus = "Searching Hydra Trees"
        end
        syncLegacyDragonFlags()
        return dragonState.hunterStatus
    end

    local targetNames = textContains(questText, "Venomous Assailants") and {"Venomous Assailant"} or {"Hydra Enforcer"}
    attackWorldTarget(targetNames, function()
        return state.dragon.autoDragonHunter or state.dragon.autoDracoV2V3 or state.craft.autoCraftVolcanicMagnet
    end, CFrame.new(5255, 1004, 345), 20)
    dragonState.hunterStatus = "Killing: " .. targetNames[1]
    syncLegacyDragonFlags()
    return dragonState.hunterStatus
end

function runAutoDojoTrainer()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        state.dragon.status = "Traveling To Third Sea"
        syncLegacyDragonFlags()
        return state.dragon.status
    end

    state.dragon.status = runDojoBeltQuestStep()
    syncLegacyDragonFlags()
    return state.dragon.status
end

function runAutoBlazeEmbers()
    return runAutoDragonHunter()
end

function runAutoDracoV2V3()
    local dragonState = state.dragon
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        dragonState.dracoStatus = "Traveling To Third Sea"
        syncLegacyDragonFlags()
        return dragonState.dracoStatus
    end

    if not hasInventoryItem("Dojo Belt (Black)") then
        dragonState.dracoStatus = runDojoBeltQuestStep()
        syncLegacyDragonFlags()
        return dragonState.dracoStatus
    end

    local dracoQuest = refreshDracoQuestState()
    if type(dracoQuest) ~= "table" then
        dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
            NPC = "Dragon Wizard",
            Command = "Speak"
        }, "currentDracoQuest")
        syncLegacyDragonFlags()
        return dragonState.dracoStatus
    end

    if not (dracoQuest.TetherLearned or dracoQuest.CanLearnTether) then
        dragonState.dracoStatus = "Waiting for Dragon Wizard progression"
        syncLegacyDragonFlags()
        return dragonState.dracoStatus
    end

    if not dracoQuest.FoundPrehistoric then
        if not hasInventoryItem("Volcanic Magnet") then
            dragonState.dracoStatus = runAutoCraftVolcanicMagnet()
        else
            dragonState.dracoStatus = runCollectDinosaurBonesStep()
            if getPrehistoricIsland() then
                runAutoDefendVolcano()
            end
        end
        syncLegacyDragonFlags()
        return dragonState.dracoStatus
    end

    if getPlayerRaceName() ~= "Draco" then
        if dracoQuest.CanTransform or dracoQuest.CanTransformFree then
            dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
                NPC = "Dragon Wizard",
                Command = "DragonRace"
            }, "currentDracoQuest")
        elseif dracoQuest.TetherLearned then
            if hasInventoryItem("Dragon Egg") then
                dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
                    NPC = "Dragon Wizard",
                    Command = "DragonRace"
                }, "currentDracoQuest")
            else
                dragonState.dracoStatus = runAutoCollectDragonEgg()
            end
        else
            dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
                NPC = "Dragon Wizard",
                Command = "LearnTether"
            }, "currentDracoQuest")
        end
        syncLegacyDragonFlags()
        return dragonState.dracoStatus
    end

    local dracoStage = dracoQuest.AvailableVQuest
    if dracoStage == "V2" or dracoStage == "V3" then
        dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
            NPC = "Dragon Wizard",
            Command = "Ascension",
            Action = "Begin"
        }, "currentDracoQuest")
    elseif dracoStage == "V2InProgress" then
        if getInventoryCount("Fire Flower") < 5 then
            dragonState.dracoStatus = runAutoFireFlowers(5)
        else
            dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
                NPC = "Dragon Wizard",
                Command = "Ascension",
                Action = "Complete"
            }, "currentDracoQuest")
        end
    elseif dracoStage == "V3InProgress" then
        dragonState.dracoStatus = runSeaObjectiveStep(dragonDojoTargets.Red, function()
            return state.dragon.autoDracoV2V3
        end, "Level 6", "DracoV3")
        refreshDracoQuestState(true)
    elseif dracoStage == "V2TurnInReady" then
        if getPlayerBeli() < 1000000 then
            dragonState.dracoStatus = runCurrentLevelQuestStep("Training for Draco V2 turn-in", function()
                return state.dragon.autoDracoV2V3
            end)
        else
            dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
                NPC = "Dragon Wizard",
                Command = "Ascension",
                Action = "Complete"
            }, "currentDracoQuest")
        end
    elseif dracoStage == "V3TurnInReady" then
        if getPlayerBeli() < 3000000 then
            dragonState.dracoStatus = runCurrentLevelQuestStep("Training for Draco V3 turn-in", function()
                return state.dragon.autoDracoV2V3
            end)
        else
            dragonState.dracoStatus = runDragonNpcInteraction("Dragon Wizard", {
                NPC = "Dragon Wizard",
                Command = "Ascension",
                Action = "Complete"
            }, "currentDracoQuest")
        end
    else
        dragonState.dracoStatus = "Draco quest ready"
    end

    syncLegacyDragonFlags()
    return dragonState.dracoStatus
end

function runAutoRaceV2()
    if not Sea2 then
        CommF:InvokeServer("TravelDressrosa")
        state.raceQuest.statusV2 = "Traveling To Second Sea"
        return state.raceQuest.statusV2
    end

    local raceName = getPlayerRaceName()
    if raceName == "Draco" then
        state.raceQuest.statusV2 = "Race V2 skipped for Draco"
        return state.raceQuest.statusV2
    end
    if hasRaceEvolved() or not hasInventoryItem("Warrior Helmet") then
        state.raceQuest.statusV2 = "Race V2 requirements not met"
        return state.raceQuest.statusV2
    end

    local progress = CommF:InvokeServer("Alchemist", "1")
    local alchemistCFrame = getDragonNpcCFrame("Alchemist") or getNpcTargetCFrame("Alchemist")

    if progress == 0 or progress == 2 then
        if progress ~= 2 or getPlayerBeli() >= 500000 then
            if alchemistCFrame and getHumanoidRootPart() and (getHumanoidRootPart().Position - alchemistCFrame.Position).Magnitude >= 5 then
                TP1(alchemistCFrame)
            else
                CommF:InvokeServer("Alchemist", progress == 0 and "2" or "3")
            end
            state.raceQuest.statusV2 = "Interacting with Alchemist"
        else
            state.raceQuest.statusV2 = "Waiting for $500,000"
        end
        return state.raceQuest.statusV2
    end

    if progress == 1 then
        for flowerIndex = 1, 2 do
            local flower = Workspace:FindFirstChild("Flower" .. flowerIndex)
            if flower and flower:IsA("BasePart") and flower.Transparency ~= 1 and not hasToolNamed("Flower " .. flowerIndex) then
                TP1(flower.CFrame)
                state.raceQuest.statusV2 = "Collecting Flower: " .. flowerIndex
                return state.raceQuest.statusV2
            end
        end

        if not hasToolNamed("Flower 3") then
            attackWorldTarget({"Swan Pirate"}, function()
                return state.raceQuest.autoV2
            end, swanPirateFarmCFrame, 20)
            state.raceQuest.statusV2 = "Getting Flower: 3"
            return state.raceQuest.statusV2
        end
    end

    state.raceQuest.statusV2 = "Race V2 ready"
    return state.raceQuest.statusV2
end

function runAutoRaceV3()
    if not Sea2 then
        CommF:InvokeServer("TravelDressrosa")
        state.raceQuest.statusV3 = "Traveling To Second Sea"
        return state.raceQuest.statusV3
    end

    local raceName = getPlayerRaceName()
    if raceName == "Draco" then
        state.raceQuest.statusV3 = "Race V3 skipped for Draco"
        return state.raceQuest.statusV3
    end
    if not hasRaceEvolved() then
        state.raceQuest.statusV3 = "Race V3 requires evolved race"
        return state.raceQuest.statusV3
    end
    if raceName == "Skypiea" or raceName == "Cyborg" or raceName == "Ghoul" then
        state.raceQuest.statusV3 = raceName .. " is unsupported in donor Zyphrax route"
        return state.raceQuest.statusV3
    end
    if state.raceQuest.completedV3[raceName] then
        state.raceQuest.statusV3 = raceName .. " Race V3 completed"
        return state.raceQuest.statusV3
    end

    local progress = CommF:InvokeServer("Wenlocktoad", "1")
    local wenlockCFrame = getDragonNpcCFrame("Wenlocktoad") or getNpcTargetCFrame("Wenlocktoad")

    if progress == -2 then
        state.raceQuest.completedV3[raceName] = true
        state.raceQuest.statusV3 = raceName .. " Race V3 completed"
        return state.raceQuest.statusV3
    end

    if progress == 0 or progress == 2 then
        if progress ~= 2 or getPlayerBeli() >= 2000000 then
            if wenlockCFrame and getHumanoidRootPart() and (getHumanoidRootPart().Position - wenlockCFrame.Position).Magnitude >= 5 then
                TP1(wenlockCFrame)
            else
                CommF:InvokeServer("Wenlocktoad", progress == 0 and "2" or "3")
            end
            state.raceQuest.statusV3 = "Interacting with Wenlocktoad"
        else
            state.raceQuest.statusV3 = "Waiting for $2,000,000"
        end
        return state.raceQuest.statusV3
    end

    if progress == 1 then
        if raceName == "Fishman" or raceName == "Shark" then
            state.raceQuest.statusV3 = runSeaObjectiveStep({"Sea Beast"}, function()
                return state.raceQuest.autoV3
            end, "Level 6", "RaceV3Shark")
            return state.raceQuest.statusV3
        elseif raceName == "Human" then
            for _, bossName in ipairs(raceQuestV3HumanBossNames) do
                local boss = findClosestNamedEnemy(bossName)
                if boss then
                    attackEnemy(boss, 20, function()
                        local humanoid = boss:FindFirstChild("Humanoid")
                        return state.running and state.raceQuest.autoV3 and boss.Parent and humanoid and humanoid.Health > 0
                    end)
                    state.raceQuest.statusV3 = "Killing: " .. bossName
                    return state.raceQuest.statusV3
                end
            end
            for _, bossName in ipairs(raceQuestV3HumanBossNames) do
                local fallback = raceQuestV3HumanBossFallbacks[bossName]
                if fallback then
                    TP1(fallback)
                    state.raceQuest.statusV3 = "Searching: " .. bossName
                    return state.raceQuest.statusV3
                end
            end
        elseif raceName == "Mink" then
            local chestPart = findClosestChestPart()
            if chestPart then
                TP1(chestPart.CFrame * CFrame.new(0, 3, 0))
                state.raceQuest.statusV3 = "Collecting Chests"
            else
                state.raceQuest.statusV3 = "Searching Chests"
            end
            return state.raceQuest.statusV3
        end
    end

    state.raceQuest.statusV3 = "Race V3 ready"
    return state.raceQuest.statusV3
end

function requestV4TrialEntrance()
    local now = os.clock()
    if now - (state.v4Trial.lastEntranceRequest or 0) < 1 then
        return
    end

    state.v4Trial.lastEntranceRequest = now
    requestEntrance(v4TrialTempleEntrance)
end

function getV4RaceDoorTarget()
    local raceName = getPlayerRaceName()
    return v4TrialRaceDoorTargets[raceName]
end

function tweenToV4TreeTop()
    if not Sea3 then
        return
    end

    TP1(v4TrialTreeTopCFrame)
end

function tweenToV4Temple()
    if not Sea3 then
        return
    end

    requestV4TrialEntrance()
    TP1(v4TrialTempleCFrame)
end

function tweenToV4Lever()
    if not Sea3 then
        return
    end

    requestV4TrialEntrance()
    TP1(v4TrialLeverCFrame)
end

function tweenToV4BuyGear()
    if not Sea3 then
        return
    end

    requestV4TrialEntrance()
    TP1(v4TrialGearCFrame)
end

function tweenToV4RaceDoor()
    if not Sea3 then
        return
    end

    local target = getV4RaceDoorTarget()
    if not target then
        return
    end

    requestV4TrialEntrance()
    TP1(target)
end

function findV4TrialStartPoint()
    for _, descendant in ipairs(Workspace:GetDescendants()) do
        if descendant.Name == "StartPoint" and descendant:IsA("BasePart") then
            return descendant
        end
    end

    return nil
end

function findV4TrialSkyPart()
    local skyTrial = Workspace:FindFirstChild("Map")
        and Workspace.Map:FindFirstChild("SkyTrial")
        and Workspace.Map.SkyTrial:FindFirstChild("Model")
    if skyTrial then
        for _, descendant in ipairs(skyTrial:GetDescendants()) do
            if descendant:IsA("BasePart") and v4TrialSkyPartNames[descendant.Name] then
                return descendant
            end
        end
    end

    for _, descendant in ipairs(Workspace:GetDescendants()) do
        if descendant:IsA("BasePart") and v4TrialSkyPartNames[descendant.Name] then
            return descendant
        end
    end

    return nil
end

function getNearestTrialPlayer(maxDistance)
    local hrp = getHumanoidRootPart()
    if not hrp then
        return nil
    end

    local nearestPlayer
    local nearestDistance = maxDistance or 100

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local targetHumanoid = character and character:FindFirstChildOfClass("Humanoid")
            local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
            if targetHumanoid and targetRoot and targetHumanoid.Health > 0 then
                local distance = (targetRoot.Position - hrp.Position).Magnitude
                if distance <= nearestDistance then
                    nearestDistance = distance
                    nearestPlayer = player
                end
            end
        end
    end

    return nearestPlayer
end

function runAutoV4HumanGhoulTrialStep()
    if not Sea3 then
        return
    end

    local enemy = findNearestEnemy(1200)
    if enemy then
        attackEnemy(enemy, 20, function()
            local humanoid = enemy:FindFirstChild("Humanoid")
            return state.running
                and (state.v4Trial.autoHumanGhoulTrial or state.v4Trial.autoCompleteTrial)
                and enemy.Parent
                and humanoid
                and humanoid.Health > 0
        end)
    end
end

function runAutoV4LeverStep()
    if not Sea3 or isTeleporting then
        return
    end

    local hrp = getHumanoidRootPart()
    if not hrp then
        return
    end

    if (hrp.Position - v4TrialLeverCFrame.Position).Magnitude > 20 then
        tweenToV4Lever()
    end
end

function runAutoV4RaceDoorStep()
    if not Sea3 or isTeleporting then
        return
    end

    local target = getV4RaceDoorTarget()
    local hrp = getHumanoidRootPart()
    if not target or not hrp then
        return
    end

    if (hrp.Position - target.Position).Magnitude > 20 then
        tweenToV4RaceDoor()
    end
end

function runAutoV4CompleteTrialStep()
    if not Sea3 or isTeleporting then
        return
    end

    local raceName = getPlayerRaceName()
    if raceName == "Human" or raceName == "Ghoul" then
        runAutoV4HumanGhoulTrialStep()
        return
    elseif raceName == "Mink" or raceName == "Rabbit" then
        local startPoint = findV4TrialStartPoint()
        if startPoint then
            TP1(startPoint.CFrame * CFrame.new(0, 10, 0))
        end
        return
    elseif raceName == "Cyborg" then
        TP1(v4TrialCyborgTrialCFrame)
        return
    elseif raceName == "Skypiea" or raceName == "Angel" then
        local skyPart = findV4TrialSkyPart()
        if skyPart then
            TP1(skyPart.CFrame)
        end
        return
    elseif raceName == "Fishman" or raceName == "Shark" then
        local seaBeast = getNearestSeaBeast()
        local seaBeastRoot = seaBeast and seaBeast:FindFirstChild("HumanoidRootPart")
        if seaBeastRoot then
            moveToFarmPosition(seaBeastRoot.CFrame, 20, true)
            AutoHaki()
            useWeaponTypeSkills("Melee")
            useWeaponTypeSkills("Blox Fruit")
            useWeaponTypeSkills("Sword")
            useWeaponTypeSkills("Gun")
        end
        return
    end

    local fallbackTarget = getV4RaceDoorTarget()
    if fallbackTarget then
        TP1(fallbackTarget)
    end
end

function runAutoV4KillTrialPlayerStep()
    if not Sea3 or isTeleporting then
        return
    end

    local targetPlayer = getNearestTrialPlayer(100)
    local targetCharacter = targetPlayer and targetPlayer.Character
    local targetHumanoid = targetCharacter and targetCharacter:FindFirstChildOfClass("Humanoid")
    local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetHumanoid or not targetRoot or targetHumanoid.Health <= 0 then
        return
    end

    moveToPlayerTarget(targetRoot.CFrame, 0, 5, true)
    AutoHaki()
    equipSelectedWeapon(nil, nil, true)
    updateCombatAim(targetCharacter, true)
    clickAttack()
end

function runAutoCraftVolcanicMagnet()
    if hasInventoryItem("Volcanic Magnet") or getPrehistoricIsland() then
        state.craft.status = "Volcanic Magnet ready"
        return state.craft.status
    end

    if getInventoryCount("Scrap Metal") < 10 then
        runMaterialRouteStep("Farm Leather + Scrap Metal", function()
            return state.running
        end)
        state.craft.status = "Farming Scrap Metal"
        return state.craft.status
    end

    if getInventoryCount("Blaze Ember") < 15 then
        state.craft.status = runAutoDragonHunter()
        return state.craft.status
    end

    local hunterCFrame = getDragonNpcCFrame("DragonHunter")
    if hunterCFrame and getHumanoidRootPart() and (getHumanoidRootPart().Position - hunterCFrame.Position).Magnitude > 3 then
        TP1(hunterCFrame)
    else
        CommF:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
    end

    state.craft.status = "Crafting Volcanic Magnet"
    return state.craft.status
end

function runNeededBerryCollection(missingNames)
    local bestBush
    local bestName
    local bestDistance
    local hrp = getHumanoidRootPart()
    if not hrp then
        return false
    end

    for _, bush in ipairs(CollectionService:GetTagged("BerryBush")) do
        local bushPart = bush and bush.Parent and getAdornmentPart(bush.Parent)
        if bushPart then
            for _, berryName in ipairs(missingNames) do
                if bush:GetAttribute(berryName) then
                    local distance = (bushPart.Position - hrp.Position).Magnitude
                    if not bestDistance or distance < bestDistance then
                        bestBush = bush
                        bestName = berryName
                        bestDistance = distance
                    end
                end
            end
        end
    end

    if not bestBush or not bestName then
        if state.craft.autoCraftHop then
            Hop()
            return true
        end
        return false
    end

    local bushPart = bestBush.Parent and getAdornmentPart(bestBush.Parent)
    local berryPart = bestBush.Parent and bestBush.Parent:FindFirstChild(bestName)
    if berryPart and berryPart:IsA("BasePart") then
        TP1(berryPart.CFrame + Vector3.new(0, 1, 0))
    elseif bushPart then
        TP1(bushPart.CFrame + Vector3.new(0, 2, 0))
    end
    pressInteractKey()
    state.craft.status = "Collecting Berry: " .. bestName
    return true
end

function runAutoAuraColor()
    if Sea1 then
        state.craft.status = "Aura craft requires Second or Third Sea"
        return state.craft.status
    end

    local selectedAura = state.craft.selectedAura
    if not selectedAura or selectedAura == "" then
        state.craft.status = "Select Aura first"
        return state.craft.status
    end
    if hasAuraColorUnlocked(selectedAura) then
        state.craft.status = selectedAura .. " already unlocked"
        return state.craft.status
    end

    local requirements = getAuraCraftRequirements(selectedAura)
    if type(requirements) ~= "table" then
        state.craft.status = "No aura recipe data"
        return state.craft.status
    end

    local missingNames = {}
    for _, requirement in ipairs(requirements) do
        local itemName = requirement.Name
        local itemAmount = tonumber(requirement.Amount) or 0
        if itemName and getInventoryCount(itemName) < itemAmount then
            table.insert(missingNames, itemName)
        end
    end

    if #missingNames > 0 then
        if not runNeededBerryCollection(missingNames) then
            state.craft.status = "Missing craft items: " .. table.concat(missingNames, ", ")
        end
        return state.craft.status
    end

    local baristaCFrame = getDragonNpcCFrame("Barista") or getNpcTargetCFrame("Barista")
    if baristaCFrame and getHumanoidRootPart() and (getHumanoidRootPart().Position - baristaCFrame.Position).Magnitude > 3 then
        TP1(baristaCFrame)
    else
        invokeFruitCustomizer({
            StorageName = selectedAura,
            Type = "AuraSkin",
            Context = "Craft"
        })
    end

    state.craft.status = "Crafting Aura: " .. selectedAura
    return state.craft.status
end

function runAutoBaristaCousin()
    if Sea1 then
        state.craft.status = "Barista Cousin requires Second or Third Sea"
        return state.craft.status
    end

    if tick() - (state.craft.lastBaristaAttempt or 0) < 5 then
        return state.craft.status
    end

    state.craft.lastBaristaAttempt = tick()
    local colorName, rarity = CommF:InvokeServer("ColorsDealer", "1")
    if type(colorName) ~= "string" then
        state.craft.status = "Waiting for Barista Cousin"
        return state.craft.status
    end

    local result = CommF:InvokeServer("ColorsDealer", "2")
    if result == 0 then
        state.craft.status = "Waiting for Beli to buy Barista color"
    else
        state.craft.status = string.format("Buying Barista Color: %s [%s]", colorName, tonumber(rarity) and tonumber(rarity) >= 3 and "LEGENDARY" or "Rare")
    end

    return state.craft.status
end

function runAutoTradeAzureEmber()
    if not Sea3 then
        state.craft.status = "Azure trade requires Third Sea"
        return state.craft.status
    end
    if not Lighting:GetAttribute("IsBlueMoon") or Lighting:GetAttribute("BlueMoonEnded") then
        state.craft.status = "Waiting for Blue Moon"
        return state.craft.status
    end
    if getInventoryCount("Azure Ember") < (state.craft.azureTradeAmount or 20) then
        state.craft.status = "Waiting for Azure Ember"
        return state.craft.status
    end

    runAutoKitsunePray()
    state.craft.status = "Trading Azure Ember"
    return state.craft.status
end

function runAutoYama(forceEliteProgress)
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    if hasToolNamed("Yama") or hasWeaponInInventory("Yama") then
        return
    end

    if getEliteHunterProgress() < 30 then
        if forceEliteProgress == true then
            runAutoEliteHunterStep(true)
        end
        return
    end

    local map = Workspace:FindFirstChild("Map")
    local waterfall = map and map:FindFirstChild("Waterfall")
    local sealedKatana = waterfall and waterfall:FindFirstChild("SealedKatana")
    local handle = sealedKatana and sealedKatana:FindFirstChild("Handle")
    local clickDetector = handle and handle:FindFirstChildOfClass("ClickDetector")
    if not handle or not clickDetector then
        return
    end

    TP1(handle.CFrame * CFrame.new(0, 3, 0))
    pcall(function()
        fireclickdetector(clickDetector)
    end)
end

function runAutoHolyTorch()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    if hasToolNamed("Tushita") or hasWeaponInInventory("Tushita") then
        return
    end

    if not hasToolNamed("Holy Torch") then
        requestEntrance(Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625))
        TP1(CFrame.new(5711.87451171875, 45.82802963256836, 254.17005920410156))
        return
    end

    equipToolByName("Holy Torch")
    for _, torchCFrame in ipairs(holyTorchPath) do
        if not state.running or (not state.autoHolyTorch and not state.autoTushita) then
            break
        end

        TP1(torchCFrame)
        pressInteractKey()
        task.wait(0.2)
    end
end

function runAutoTushita()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    if hasToolNamed("Tushita") or hasWeaponInInventory("Tushita") then
        return
    end

    runAutoHolyTorch()
    if not hasToolNamed("Holy Torch") then
        return
    end

    local longma = findClosestNamedEnemyByNames(longmaBossNames)
    if longma then
        attackEnemy(longma, 20, function()
            local humanoid = longma:FindFirstChild("Humanoid")
            return state.running and state.autoTushita and longma.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    local replicaRoot = getReplicaRootByNames(longmaBossNames)
    if replicaRoot then
        TP1(replicaRoot.CFrame * CFrame.new(0, 20, 0))
    else
        TP1(bossFallbackCFrames["Longma"])
    end
end

function runAutoTyrant()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local tyrant = findClosestNamedEnemyByNames(tyrantBossNames) or findClosestEnemyByTokens({"tyrant of the skies"})
    if tyrant then
        attackEnemy(tyrant, 35, function()
            local humanoid = tyrant:FindFirstChild("Humanoid")
            return state.running and state.autoTyrant and tyrant.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    local tyrantMob = findClosestNamedEnemyByNames(tyrantMobNames)
    if tyrantMob then
        attackEnemy(tyrantMob, 30, function()
            local humanoid = tyrantMob:FindFirstChild("Humanoid")
            return state.running
                and state.autoTyrant
                and tyrantMob.Parent
                and humanoid
                and humanoid.Health > 0
                and findClosestNamedEnemyByNames(tyrantBossNames) == nil
        end)
        return
    end

    local tyrantReplica = getReplicaRootByNames(tyrantBossNames)
    if tyrantReplica then
        TP1(tyrantReplica.CFrame * CFrame.new(0, 20, 0))
        return
    end

    if tick() - lastTyrantSearchTick > 2 then
        lastTyrantSearchTick = tick()
        lastTyrantSearchIndex = (lastTyrantSearchIndex % #tyrantSearchPoints) + 1
    end

    TP1(tyrantSearchPoints[lastTyrantSearchIndex > 0 and lastTyrantSearchIndex or 1])
end

function runAutoPrehistoricTeleport()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local skullCFrame = getPrehistoricSkullCFrame()
    if skullCFrame then
        TP1(skullCFrame)
        state.sea.autoPrehistoricTeleport = false
    end
end

function runAutoDefendVolcano()
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    AutoHaki()
    pcall(clearPrehistoricLava)

    local volcanoRock = getActiveVolcanoRock()
    if not volcanoRock then
        local skullCFrame = getPrehistoricSkullCFrame()
        if skullCFrame then
            TP1(skullCFrame)
        end
        return
    end

    TP1(CFrame.new(volcanoRock.Position))

    local hrp = getHumanoidRootPart()
    if hrp and (hrp.Position - volcanoRock.Position).Magnitude <= 4 then
        if state.sea.volcanoUseMelee then
            useWeaponTypeSkills("Melee")
        end
        if state.sea.volcanoUseSword then
            useWeaponTypeSkills("Sword")
        end
        if state.sea.volcanoUseGun then
            useWeaponTypeSkills("Gun")
        end
        if not state.sea.volcanoUseMelee and not state.sea.volcanoUseSword and not state.sea.volcanoUseGun then
            requestCombatEquip()
            equipSelectedWeapon()
            clickAttack()
        end
    end
end

function runAutoSoulReaper(forceRun)
    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local soulReaperActive = state.quests.autoSoulReaper or forceRun == true

    local soulReaper = findSoulReaperEnemy()
    if soulReaper then
        attackEnemy(soulReaper, 20, function()
            local humanoid = soulReaper:FindFirstChild("Humanoid")
            return state.running and soulReaperActive and soulReaper.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    if hasToolNamed("Hallow Essence") then
        local altarCFrame = CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)
        local essence = equipToolByName("Hallow Essence")
        TP1(altarCFrame)

        local hrp = getHumanoidRootPart()
        if hrp and (hrp.Position - altarCFrame.Position).Magnitude <= 12 then
            pcall(function()
                if essence and essence.Activate then
                    essence:Activate()
                end
            end)

            clickAttack()
            task.wait(0.2)
        end
        return
    end

    local replicaRoot = getSoulReaperReplicaRoot()
    if replicaRoot then
        TP1(replicaRoot.CFrame * CFrame.new(5, 10, 7))
        return
    end

    runAutoBoneFarm(true, soulReaperActive)
end

function runAutoSuperhuman()
    local beli = LocalPlayer.Data and LocalPlayer.Data:FindFirstChild("Beli")
    local fragments = LocalPlayer.Data and LocalPlayer.Data:FindFirstChild("Fragments")
    local currentBeli = beli and beli.Value or 0
    local currentFragments = fragments and fragments.Value or 0

    if hasInventoryItem("Superhuman") then
        setQuestWeapon("Superhuman")
        pcall(function()
            CommF:InvokeServer("BuySuperhuman")
        end)
        return
    end

    local blackLegLevel = getToolLevel("Black Leg")
    local electroLevel = getToolLevel("Electro")
    local fishmanLevel = getToolLevel("Fishman Karate")
    local dragonClawLevel = getToolLevel("Dragon Claw")

    if not blackLegLevel and hasInventoryItem("Death Step") then
        blackLegLevel = 300
    end
    if not electroLevel and hasInventoryItem("Electric Claw") then
        electroLevel = 400
    end
    if not fishmanLevel and hasInventoryItem("Sharkman Karate") then
        fishmanLevel = 400
    end
    if not dragonClawLevel and hasInventoryItem("Dragon Talon") then
        dragonClawLevel = 400
    end

    if not hasInventoryItem("Black Leg") and not hasInventoryItem("Death Step") then
        if currentBeli >= 150000 then
            CommF:InvokeServer("BuyBlackLeg")
        end
        return
    end

    if blackLegLevel and blackLegLevel < 300 then
        runAutoSuperhumanTraining("Black Leg")
        return
    end

    if not hasInventoryItem("Electro") and blackLegLevel and blackLegLevel >= 300 and currentBeli >= 300000 then
        CommF:InvokeServer("BuyElectro")
        return
    end

    if electroLevel and electroLevel < 300 then
        runAutoSuperhumanTraining("Electro")
        return
    end

    if not hasInventoryItem("Fishman Karate") and electroLevel and electroLevel >= 300 and currentBeli >= 750000 then
        CommF:InvokeServer("BuyFishmanKarate")
        return
    end

    if fishmanLevel and fishmanLevel < 300 then
        runAutoSuperhumanTraining("Fishman Karate")
        return
    end

    if not hasInventoryItem("Dragon Claw") and fishmanLevel and fishmanLevel >= 300 and currentFragments >= 1500 then
        CommF:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        CommF:InvokeServer("BlackbeardReward", "DragonClaw", "2")
        return
    end

    if dragonClawLevel and dragonClawLevel < 300 then
        runAutoSuperhumanTraining("Dragon Claw")
        return
    end

    if dragonClawLevel and dragonClawLevel >= 300 and currentBeli >= 3000000 then
        CommF:InvokeServer("BuySuperhuman")
    end
end

function runAutoDeathStep()
    if hasInventoryItem("Death Step") then
        setQuestWeapon("Death Step")
        return
    end

    local blackLegLevel = getToolLevel("Black Leg")
    if blackLegLevel then
        if blackLegLevel >= 450 then
            CommF:InvokeServer("BuyDeathStep")
            setQuestWeapon("Death Step")
        else
            runAutoStyleMasteryTraining("Black Leg", "Training Black Leg mastery", function()
                return state.quests.autoDeathStep or state.quests.autoGodhuman
            end)
        end
        return
    end

    CommF:InvokeServer("BuyBlackLeg")
end

function runAutoSharkmanKarate()
    if hasInventoryItem("Sharkman Karate") then
        setQuestWeapon("Sharkman Karate")
        return
    end

    CommF:InvokeServer("BuyFishmanKarate")

    local fishmanLevel = getToolLevel("Fishman Karate")
    if fishmanLevel and fishmanLevel < 400 then
        runAutoStyleMasteryTraining("Fishman Karate", "Training Fishman Karate mastery", function()
            return state.quests.autoSharkmanKarate or state.quests.autoGodhuman
        end)
        return
    end

    local result = CommF:InvokeServer("BuySharkmanKarate")
    if type(result) == "string" and textContains(result, "keys") then
        if hasInventoryItem("Water Key") then
            TP1(CFrame.new(-2604.6958, 239.432526, -10315.1982))
            CommF:InvokeServer("BuySharkmanKarate")
        elseif Sea2 then
            attackWorldTarget({"Tide Keeper [Lv. 1475] [Boss]", "Tide Keeper"}, function()
                return state.quests.autoSharkmanKarate
            end, CFrame.new(-3570.18652, 123.328949, -11555.9072), 20)
        else
            CommF:InvokeServer("TravelDressrosa")
        end
    else
        CommF:InvokeServer("BuySharkmanKarate")
    end
end

function runAutoElectricClaw()
    if hasInventoryItem("Electric Claw") then
        state.quests.electricClawStage = 0
        setQuestWeapon("Electric Claw")
        return
    end

    local electroLevel = getToolLevel("Electro")
    if not electroLevel then
        CommF:InvokeServer("BuyElectro")
        return
    end

    if electroLevel < 400 then
        runAutoStyleMasteryTraining("Electro", "Training Electro mastery", function()
            return state.quests.autoElectricClaw or state.quests.autoGodhuman
        end)
        return
    end

    if not Sea3 then
        CommF:InvokeServer("TravelZou")
        return
    end

    local startCFrame = CFrame.new(-10371.4717, 330.764496, -10131.4199)
    local questCFrame = CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438)
    local hrp = getHumanoidRootPart()
    if not hrp then
        return
    end

    if state.quests.electricClawStage == 0 then
        if (hrp.Position - startCFrame.Position).Magnitude > 10 then
            TP1(startCFrame)
            return
        end

        CommF:InvokeServer("BuyElectricClaw", "Start")
        state.quests.electricClawStage = 1
        return
    end

    if state.quests.electricClawStage == 1 then
        if (hrp.Position - questCFrame.Position).Magnitude > 10 then
            TP1(questCFrame)
            return
        end

        state.quests.electricClawStage = 2
        return
    end

    if (hrp.Position - startCFrame.Position).Magnitude > 10 then
        TP1(startCFrame)
        return
    end

    if state.quests.electricClawStage == 2 then
        CommF:InvokeServer("BuyElectricClaw")
        state.quests.electricClawStage = 0
    else
        TP1(questCFrame)
    end
end

function runAutoDragonTalon()
    if hasInventoryItem("Dragon Talon") then
        setQuestWeapon("Dragon Talon")
        return
    end

    local dragonClawLevel = getToolLevel("Dragon Claw")
    if not dragonClawLevel then
        CommF:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        CommF:InvokeServer("BlackbeardReward", "DragonClaw", "2")
        return
    end

    if dragonClawLevel < 400 then
        runAutoStyleMasteryTraining("Dragon Claw", "Training Dragon Claw mastery", function()
            return state.quests.autoDragonTalon or state.quests.autoGodhuman
        end)
        return
    end

    CommF:InvokeServer("BuyDragonTalon")
end

function runAutoGodhuman()
    if hasInventoryItem("Godhuman") then
        setQuestWeapon("Godhuman")
        return
    end

    if not hasInventoryItem("Superhuman") then
        runAutoSuperhuman()
        return
    end

    if not hasInventoryItem("Death Step") then
        runAutoDeathStep()
        return
    end

    if not hasInventoryItem("Sharkman Karate") then
        runAutoSharkmanKarate()
        return
    end

    if not hasInventoryItem("Electric Claw") then
        runAutoElectricClaw()
        return
    end

    if not hasInventoryItem("Dragon Talon") then
        runAutoDragonTalon()
        return
    end

    local materials = getMaterialInventory()

    if (materials["Magma Ore"] or 0) >= 20
        and (materials["Mystic Droplet"] or 0) >= 10
        and (materials["Fish Tail"] or 0) >= 20
        and (materials["Dragon Scale"] or 0) >= 10
    then
        CommF:InvokeServer("BuyGodhuman")
        return
    end

    if (materials["Magma Ore"] or 0) < 20 then
        if Sea2 then
            attackWorldTarget({"Magma Ninja [Lv. 1175]", "Lava Pirate [Lv. 1200]"}, function()
                return state.quests.autoGodhuman
            end, CFrame.new(-5525.38037, 17.856924, -5577.93359), 20)
        else
            CommF:InvokeServer("TravelDressrosa")
        end
        return
    end

    if (materials["Mystic Droplet"] or 0) < 10 then
        if Sea2 then
            attackWorldTarget({"Sea Soldier [Lv. 1425]", "Sea Soldier"}, function()
                return state.quests.autoGodhuman
            end, CFrame.new(-2955.86328, 15.635495, -9725.28027), 20)
        else
            CommF:InvokeServer("TravelDressrosa")
        end
        return
    end

    if (materials["Fish Tail"] or 0) < 20 then
        if Sea3 then
            attackWorldTarget({"Fishman Raider [Lv. 1775]", "Fishman Captain [Lv. 1800]"}, function()
                return state.quests.autoGodhuman
            end, CFrame.new(-10322.40039, 390.944733, -8580.09082), 20)
        else
            CommF:InvokeServer("TravelZou")
        end
        return
    end

    if (materials["Dragon Scale"] or 0) < 10 then
        if Sea3 then
            attackWorldTarget({"Dragon Crew Warrior [Lv. 1575]", "Dragon Crew Warrior"}, function()
                return state.quests.autoGodhuman
            end, CFrame.new(6241.99512, 51.5220833, -1243.97717), 20)
        else
            CommF:InvokeServer("TravelZou")
        end
        return
    end
end

function runAutoDungeon()
    if Sea1 then
        return
    end

    if state.quests.autoSelectDungeon then
        runAutoSelectDungeon()
    end

    if not isRaidActive() then
        if hasToolNamed("Special Microchip") then
            runAutoStartRaid()
        else
            runAutoBuyChip()
        end
        return
    end

    local raidEnemy = findNearestRaidEnemy(6000)
    if raidEnemy then
        attackEnemy(raidEnemy, 25, function()
            local humanoid = raidEnemy:FindFirstChild("Humanoid")
            return state.running and state.quests.autoDungeon and isRaidActive() and raidEnemy.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    local islandTarget = getRaidIslandTarget()
    if islandTarget then
        TP1(islandTarget)
    end
end

function runAutoAwaken()
    if Sea1 then
        return
    end

    CommF:InvokeServer("Awakener", "Check")
    CommF:InvokeServer("Awakener", "Awaken")
end

function runAutoSelectDungeon()
    local chipMap = {
        ["Flame-Flame"] = "Flame",
        ["Ice-Ice"] = "Ice",
        ["Quake-Quake"] = "Quake",
        ["Light-Light"] = "Light",
        ["Dark-Dark"] = "Dark",
        ["String-String"] = "String",
        ["Rumble-Rumble"] = "Rumble",
        ["Magma-Magma"] = "Magma",
        ["Human-Human: Buddha"] = "Human: Buddha",
        ["Human-Human: Buddha Fruit"] = "Human: Buddha",
        ["Sand-Sand"] = "Sand",
        ["Bird-Bird: Phoenix"] = "Bird: Phoenix"
    }

    for toolName, chipName in pairs(chipMap) do
        if hasToolNamed(toolName) then
            state.quests.selectedChip = chipName
            return
        end
    end
end

function runAutoBuyChip()
    if Sea1 or isRaidActive() then
        return
    end

    local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
    if locations and locations:FindFirstChild("Island 1") then
        return
    end

    if not hasToolNamed("Special Microchip") then
        CommF:InvokeServer("RaidsNpc", "Select", state.quests.selectedChip)
    end
end

function runAutoStartRaid()
    if Sea1 or isRaidActive() or not hasToolNamed("Special Microchip") then
        return
    end

    local detector = getRaidSummonClickDetector()
    if detector then
        local detectorPart = detector.Parent
        if detectorPart and not detectorPart:IsA("BasePart") then
            detectorPart = detectorPart:FindFirstAncestorWhichIsA("BasePart")
        end

        local hrp = getHumanoidRootPart()
        if detectorPart and hrp and (hrp.Position - detectorPart.Position).Magnitude > 20 then
            TP1(detectorPart.CFrame * CFrame.new(0, 5, 0))
            return
        end

        fireclickdetector(detector)
    end
end

function runAutoLawRaid()
    if not Sea2 then
        CommF:InvokeServer("TravelDressrosa")
        return
    end

    if state.quests.autoBuyLawChip and not hasToolNamed("Microchip") then
        CommF:InvokeServer("BlackbeardReward", "Microchip", "1")
        CommF:InvokeServer("BlackbeardReward", "Microchip", "2")
    end

    local order = findClosestNamedEnemyByNames({"Order [Lv. 1250] [Raid Boss]", "Order"})
    if order then
        attackEnemy(order, 50, function()
            local humanoid = order:FindFirstChild("Humanoid")
            return state.running and state.quests.autoLawRaid and order.Parent and humanoid and humanoid.Health > 0
        end)
        return
    end

    local orderReplica = getReplicaRootByNames({"Order [Lv. 1250] [Raid Boss]", "Order"})
    if orderReplica then
        TP1(orderReplica.CFrame * CFrame.new(0, 50, 25))
        return
    end

    if hasToolNamed("Microchip") then
        local detector = getLawRaidClickDetector()
        if detector then
            fireclickdetector(detector)
        end
    end
end

function updatePlayerESP()
    if not state.espPlayers then
        clearEspTag(espTags.PlayerTag)
        clearEspTag(espTags.PlayerHighlight)
        return
    end

    local localRoot = getHumanoidRootPart()
    if not localRoot then
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local root = character and character:FindFirstChild("HumanoidRootPart")
            local head = character and character:FindFirstChild("Head")

            if character and humanoid and root and humanoid.Health > 0 then
                local distance = (root.Position - localRoot.Position).Magnitude
                if distance <= PLAYER_ESP_MAX_DISTANCE then
                    local _, label = ensureBillboard(head or root, espTags.PlayerTag, Color3.fromRGB(82, 196, 255), Vector3.new(0, 3, 0))
                    if label then
                        local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                        label.Text = string.format("%s\n%d%% | %.0f studs", player.Name, healthPercent, distance)
                    end

                    local highlight = character:FindFirstChild(espTags.PlayerHighlight)
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = espTags.PlayerHighlight
                        highlight.FillTransparency = 0.8
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = character
                    end

                    registerEspInstance(espTags.PlayerHighlight, highlight)
                    highlight.FillColor = Color3.fromRGB(34, 110, 255)
                    highlight.OutlineColor = Color3.fromRGB(145, 221, 255)
                else
                    local tagPart = head or root
                    local billboard = tagPart and tagPart:FindFirstChild(espTags.PlayerTag)
                    if billboard then
                        billboard:Destroy()
                    end

                    local highlight = character:FindFirstChild(espTags.PlayerHighlight)
                    if highlight then
                        highlight:Destroy()
                    end
                end
            elseif character then
                local highlight = character:FindFirstChild(espTags.PlayerHighlight)
                if highlight then
                    highlight:Destroy()
                end

                local tagPart = head or root
                local billboard = tagPart and tagPart:FindFirstChild(espTags.PlayerTag)
                if billboard then
                    billboard:Destroy()
                end
            end
        end
    end
end

function updateChestESP()
    if not state.espChests then
        clearTrackedChestESP()
        return
    end

    local localRoot = getHumanoidRootPart()
    if not localRoot then
        return
    end

    local candidates = {}
    local trackedOwners = {}
    pruneChestCache(tick())
    refreshChestCache(false)

    for _, part in ipairs(chestScanCache.parts) do
        local owner = getChestOwner(part)
        local ownerKey = owner or part
        if part and part.Parent and not trackedOwners[ownerKey] then
            trackedOwners[ownerKey] = true
            local distance = (part.Position - localRoot.Position).Magnitude
            if distance <= MAX_CHEST_ESP_DISTANCE then
                local renderPart = getChestDisplayPart(part)
                insertNearestCandidate(candidates, {
                    part = renderPart or part,
                    distance = distance
                }, MAX_CHEST_ESP_RENDER)
            end
        end
    end

    local visibleParts = setmetatable({}, {__mode = "k"})
    for index = 1, #candidates do
        local entry = candidates[index]
        local part = entry.part
        if part and part.Parent then
            visibleParts[part] = true
            chestEspRendered[part] = true
            local _, label = ensureBillboard(part, espTags.ChestTag, Color3.fromRGB(255, 214, 122), Vector3.new(0, 2.5, 0))
            if label then
                label.Text = string.format("Chest\n%.0f studs", entry.distance)
            end
        end
    end

    for part in pairs(chestEspRendered) do
        if not visibleParts[part] then
            if part and part.Parent then
                local billboard = part:FindFirstChild(espTags.ChestTag)
                if billboard then
                    billboard:Destroy()
                end
            end
            chestEspRendered[part] = nil
        end
    end
end

function updateFruitESP()
    if not state.espFruits then
        clearRenderedEspSet(fruitEspRendered, espTags.FruitTag)
        clearEspTag(espTags.FruitTag)
        return
    end

    local localRoot = getHumanoidRootPart()
    if not localRoot then
        return
    end

    local candidates = buildNearestEspCandidates(getFruitSpawnHandles(false), localRoot.Position, WORLD_ESP_MAX_DISTANCE, function(entry, part)
        entry.label = part.Parent and part.Parent.Name or "Fruit"
    end)

    renderWorldEspCandidates(
        fruitEspRendered,
        espTags.FruitTag,
        Color3.fromRGB(136, 255, 156),
        Vector3.new(0, 2.5, 0),
        candidates,
        WORLD_ESP_MAX_RENDER,
        function(entry)
            return string.format("%s\n%.0f studs", entry.label, entry.distance)
        end
    )
end

function updateFlowerESP()
    if not state.espFlowers then
        clearRenderedEspSet(flowerEspRendered, espTags.FlowerTag)
        clearEspTag(espTags.FlowerTag)
        return
    end

    local localRoot = getHumanoidRootPart()
    if not localRoot then
        return
    end

    local candidates = {}
    local tracked = {}

    for _, item in ipairs(getFlowerEspItems(false)) do
        local info = flowerEspInfo[item.Name]
        local part = getAdornmentPart(item)
        if info and part and not tracked[part] then
            tracked[part] = true
            local distance = (part.Position - localRoot.Position).Magnitude
            if distance <= WORLD_ESP_MAX_DISTANCE then
                candidates[#candidates + 1] = {
                    part = part,
                    distance = distance,
                    info = info
                }
            end
        end
    end

    table.sort(candidates, function(a, b)
        return a.distance < b.distance
    end)

    local visibleParts = {}
    for index = 1, math.min(#candidates, WORLD_ESP_MAX_RENDER) do
        local entry = candidates[index]
        local part = entry.part
        if part and part.Parent then
            visibleParts[part] = true
            flowerEspRendered[part] = true
            local _, label = ensureBillboard(part, espTags.FlowerTag, entry.info.Color, Vector3.new(0, 2.5, 0))
            if label then
                label.Text = string.format("%s\n%.0f studs", entry.info.Label, entry.distance)
            end
        end
    end

    for part in pairs(flowerEspRendered) do
        if not visibleParts[part] then
            if part and part.Parent then
                local billboard = part:FindFirstChild(espTags.FlowerTag)
                if billboard then
                    billboard:Destroy()
                end
            end
            flowerEspRendered[part] = nil
        end
    end
end

function updateBerryESP()
    if not state.espBerries then
        clearRenderedEspSet(berryEspRendered, espTags.BerryTag)
        clearEspTag(espTags.BerryTag)
        return
    end

    local localRoot = getHumanoidRootPart()
    if not localRoot then
        return
    end

    local candidates = {}
    local tracked = {}
    for _, bush in ipairs(CollectionService:GetTagged("BerryBush")) do
        local berryName = getBerryBushDisplayName(bush)
        local bushPart = bush and bush.Parent and getAdornmentPart(bush.Parent)
        if berryName and bushPart and not tracked[bushPart] then
            tracked[bushPart] = true
            local distance = (bushPart.Position - localRoot.Position).Magnitude
            if distance <= WORLD_ESP_MAX_DISTANCE then
                candidates[#candidates + 1] = {
                    part = bushPart,
                    distance = distance,
                    berryName = berryName
                }
            end
        end
    end

    table.sort(candidates, function(a, b)
        return a.distance < b.distance
    end)

    renderWorldEspCandidates(
        berryEspRendered,
        espTags.BerryTag,
        Color3.fromRGB(255, 235, 92),
        Vector3.new(0, 3, 0),
        candidates,
        WORLD_ESP_MAX_RENDER,
        function(entry)
            return string.format("%s\n%.0f studs", entry.berryName, entry.distance)
        end
    )
end

function updateSpecialIslandESP()
    if not state.espSpecialIslands then
        clearRenderedEspSet(specialIslandEspRendered, espTags.SpecialIslandTag)
        clearEspTag(espTags.SpecialIslandTag)
        return
    end

    local localRoot = getHumanoidRootPart()
    if not localRoot then
        return
    end

    local candidates = {}
    local tracked = {}
    for _, item in ipairs(getSpecialIslandEspItems(false)) do
        local part = getAdornmentPart(item)
        if part and not tracked[part] then
            tracked[part] = true
            local distance = (part.Position - localRoot.Position).Magnitude
            if distance <= WORLD_ESP_MAX_DISTANCE then
                candidates[#candidates + 1] = {
                    part = part,
                    distance = distance,
                    label = item.Name
                }
            end
        end
    end

    table.sort(candidates, function(a, b)
        return a.distance < b.distance
    end)

    renderWorldEspCandidates(
        specialIslandEspRendered,
        espTags.SpecialIslandTag,
        Color3.fromRGB(222, 153, 255),
        Vector3.new(0, 3.5, 0),
        candidates,
        WORLD_ESP_MAX_RENDER,
        function(entry)
            return string.format("%s\n%.0f studs", entry.label, entry.distance)
        end
    )
end

function cleanupESP()
    clearRenderedEspSet(chestEspRendered, espTags.ChestTag)
    clearRenderedEspSet(fruitEspRendered, espTags.FruitTag)
    clearRenderedEspSet(flowerEspRendered, espTags.FlowerTag)
    clearRenderedEspSet(berryEspRendered, espTags.BerryTag)
    clearRenderedEspSet(specialIslandEspRendered, espTags.SpecialIslandTag)
    clearEspTag(espTags.PlayerTag)
    clearEspTag(espTags.PlayerHighlight)
    clearEspTag(espTags.ChestTag)
    clearEspTag(espTags.FruitTag)
    clearEspTag(espTags.FlowerTag)
    clearEspTag(espTags.BerryTag)
    clearEspTag(espTags.SpecialIslandTag)
end

function stopZyphraxBloxFruitHub(deleteWindow)
    if not state.running then
        return
    end

    pcall(function()
        saveZyphraxConfig(true)
    end)

    state.running = false
    if fastAttackController and fastAttackController.Stop then
        pcall(function()
            fastAttackController:Stop()
        end)
    end
    state.fastAttack = false
    state.autoMastery = false
    state.autoSelectedMobNoQuest = false
    state.autoSelectedMobQuest = false
    _G.AutoFarm = false
    _G.AutoNear = false
    _G.AutoBossFarm = false
    _G.AutoFarmFruits = false
    _G.AutoFarmMaterial = false
    _G.AutoSecondWorld = false
    _G.AutoThirdWorld = false
    _G.AutoActiveRaceV3 = false
    _G.AutoActiveRaceV4 = false
    _G.WalkWater = false
    _G.CheckPoint = false
    _G.InfiniteSoru = false
    _G.DodgeNoCD = false
    _G.SpinPosition = false
    _G.InfiniteGeppo = false
    _G.InfiniteJump = false
    state.espFlowers = false
    state.espBerries = false
    state.autoChest = false
    state.autoChestHop = false
    state.autoEliteHunter = false
    state.autoEliteHop = false
    state.stopEliteOnChalice = false
    state.autoPirateRaid = false
    state.autoPirateRaidBusy = false
    state.autoMirageTeleport = false
    state.autoBuyRandomFruit = false
    state.autoBoneFarm = false
    state.autoBoneSurprise = false
    state.fruitNotifications = true
    state.autoTweenFruit = false
    state.autoTweenFruitHop = false
    state.mirageNotifications = false
    state.kitsuneNotifications = false
    state.prehistoricNotifications = false
    state.autoFactoryRaid = false
    state.autoKitsuneIsland = false
    state.autoCollectAzureEmber = false
    state.autoKitsunePray = false
    state.autoMirageGear = false
    state.autoAdvancedFruitDealer = false
    state.autoSanguineArt = false
    state.autoDojoTrainer = false
    state.autoBlazeEmbers = false
    state.dragon.autoDojoTrainer = false
    state.dragon.autoDragonHunter = false
    state.dragon.autoDracoV2V3 = false
    state.dragon.currentBelt = "Null"
    state.dragon.currentBeltQuest = nil
    state.dragon.currentDracoQuest = nil
    state.dragon.currentDragonHunterQuest = nil
    state.dragon.beltProgress = {}
    state.dragon.localProgress = {}
    state.dragon.greenTimer = 0
    state.dragon.purpleProgress = nil
    state.dragon.startPurpleProgress = 0
    state.dragon.blackProgress = nil
    state.dragon.killedTerrorshark = false
    state.dragon.lastDojoRefresh = 0
    state.dragon.lastDracoRefresh = 0
    state.dragon.lastHunterRefresh = 0
    state.dragon.status = "Idle"
    state.dragon.hunterStatus = "Idle"
    state.dragon.dracoStatus = "Idle"
    state.raceQuest.autoV2 = false
    state.raceQuest.autoV3 = false
    state.raceQuest.completedV3 = {}
    state.raceQuest.statusV2 = "Idle"
    state.raceQuest.statusV3 = "Idle"
    state.v4Trial.autoLever = false
    state.v4Trial.autoRaceDoor = false
    state.v4Trial.autoHumanGhoulTrial = false
    state.v4Trial.autoCompleteTrial = false
    state.v4Trial.autoKillTrialPlayer = false
    state.v4Trial.lastEntranceRequest = 0
    lastAutoFruitHop = 0
    state.craft.autoCraftVolcanicMagnet = false
    state.craft.autoCollectDragonEgg = false
    state.craft.autoTradeAzureEmber = false
    state.craft.autoAuraColor = false
    state.craft.autoCraftHop = false
    state.craft.autoBaristaCousin = false
    state.craft.status = "Idle"
    state.autoEnablePvP = false
    state.autoObservationHaki = false
    state.autoBerry = false
    state.autoBerryHop = false
    state.autoYama = false
    state.autoHolyTorch = false
    state.autoTushita = false
    state.autoTyrant = false
    state.autoCDK = false
    state.bounty.autoFarm = false
    state.bounty.autoHop = false
    state.bounty.tweenToPlayer = false
    state.bounty.aimbotSkills = false
    state.bounty.aimbotGun = false
    state.bounty.skillZ = true
    state.bounty.skillX = true
    state.bounty.skillC = false
    state.bounty.skillV = false
    state.bounty.skillF = false
    state.bounty.holdDelayZ = 1
    state.bounty.holdDelayX = 1
    state.bounty.holdDelayC = 1
    state.bounty.holdDelayV = 1
    state.bounty.holdDelayF = 1
    state.bounty.positionMethod = "Top"
    state.bounty.ignoreSafeZonePlayers = false
    state.bounty.lockEnabled = false
    state.bounty.selectedPlayer = "Nearest Enemy"
    state.bounty.status = "Idle"
    state.bounty.currentTarget = nil
    state.bounty.lastTargetHealth = nil
    state.bounty.lastDamageTick = 0
    state.bounty.lastHopTick = 0
    state.bounty.startValue = nil
    state.bounty.skipTargets = {}
    for _, skillKey in ipairs({"Z", "X", "C", "V", "F"}) do
        local skillState = bountySkillState[skillKey]
        if skillState then
            skillState.lastUse = 0
            skillState.holding = false
        end
        pcall(function()
            VirtualInputManager:SendKeyEvent(false, skillKey, false, game)
        end)
    end
    state.aimbot.enabled = false
    state.aimbot.holdActive = false
    state.aimbot.lockedPlayer = nil
    state.aimbot.highlightedPlayer = nil
    state.aimbot.status = "Disabled"
    for key, value in pairs(state.quests) do
        if type(value) == "boolean" then
            state.quests[key] = false
        end
    end
    state.quests.electricClawStage = 0
    state.quests.selectedChip = "Flame"
    state.sea.autoEvents = false
    state.sea.autoSail = false
    state.sea.attackMobs = false
    state.sea.attackSharks = true
    state.sea.attackFishCrew = true
    state.sea.attackPirateShips = true
    state.sea.attackSeaBeasts = false
    state.sea.autoPrehistoricTeleport = false
    state.sea.autoDefendVolcano = false
    state.sea.autoMirageSail = false
    state.sea.mirageRouteIndex = 4
    state.sea.volcanoUseMelee = false
    state.sea.volcanoUseSword = false
    state.sea.volcanoUseGun = false
    state.sea.destroyRocks = false
    state.sea.autoPressW = false
    SelectMonster = nil
    StartBring = false
    dojoQuestClaimed = false
    dojoQuestText = ""
    dragonHunterClaimed = false
    dragonHunterText = ""
    specialNotificationState.mirage = false
    specialNotificationState.kitsune = false
    specialNotificationState.prehistoric = false

    stopTeleport()
    stopSeaBoatTween()
    clearSeaBoatSpeedHack()
    clearCombatEquipRequest()
    setSeaSkillAim(false)
    releaseManualAimbot()
    if aimbotFovCircle and aimbotFovCircle ~= false then
        pcall(function()
            aimbotFovCircle.Visible = false
            aimbotFovCircle:Remove()
        end)
    end
    aimbotFovCircle = nil
    disconnectAll()
    cleanupESP()
    clearTrackedChestESP()
    clearAimbotHighlight()

    local hrp = getHumanoidRootPart()
    if hrp then
        local bodyClip = hrp:FindFirstChild("ZyphraxBodyClip")
        if bodyClip then
            bodyClip:Destroy()
        end
        local spinEffect = hrp:FindFirstChild("SpinEffect")
        if spinEffect then
            spinEffect:Destroy()
        end
    end

    if getgenv().canDodgeOriginal then
        getgenv().canDodge = getgenv().canDodgeOriginal
    end

    if deleteWindow ~= false and state.window and state.window.Delete then
        pcall(function()
            state.window:Delete()
        end)
    end
end

_G.ZyphraxBloxFruitHub = {
    Stop = stopZyphraxBloxFruitHub
}

task.spawn(function()
    while state.running do
        local movementActive = isMovementAutomationActive()
        if not movementActive then
            if isTeleporting then
                stopTeleport()
            end
            StartBring = false
            clearCombatEquipRequest()
        elseif not state.autoEquipTool then
            clearCombatEquipRequest()
        end

        task.wait(0.05)
    end
end)

task.spawn(function()
    while state.running do
        pcall(function()
            local hrp = getHumanoidRootPart()
            if not hrp then
                return
            end

            local bodyClip = hrp:FindFirstChild("ZyphraxBodyClip")
            if isMovementAutomationActive() then
                if not bodyClip then
                    bodyClip = Instance.new("BodyVelocity")
                    bodyClip.Name = "ZyphraxBodyClip"
                    bodyClip.MaxForce = Vector3.new(100000, 100000, 100000)
                    bodyClip.Velocity = Vector3.new(0, 0, 0)
                    bodyClip.Parent = hrp
                end
            elseif bodyClip then
                bodyClip:Destroy()
            end
        end)

        task.wait(0.2)
    end
end)

addConnection(RunService.Stepped:Connect(function()
    if isMovementAutomationActive() then
        local now = tick()
        if now - lastMovementNoClipUpdate < MOVEMENT_NOCLIP_INTERVAL then
            return
        end
        lastMovementNoClipUpdate = now

        local character = LocalPlayer.Character
        if not character then
            return
        end

        for _, descendant in ipairs(character:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.CanCollide then
                descendant.CanCollide = false
            end
        end
    end
end))

task.spawn(function()
    while state.running do
        if _G.AutoHaki and isMovementAutomationActive() then
            pcall(AutoHaki)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(function()
                if ensureQuestStarted() then
                    local enemy = findClosestNamedEnemy(Mon)
                    if enemy then
                        attackEnemy(enemy, 30, function()
                            local questGui = getQuestGui()
                            return state.running and _G.AutoFarm and questGui and questGui.Visible and enemy.Parent and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0
                        end)
                    else
                        local mobTarget = getMobFarmTarget(CFrameMon, CFrameMon2, 40)
                        if isUsableTargetCFrame(mobTarget) then
                            StartBring = false
                            moveToMobTarget(mobTarget, 20, 40)
                        end
                    end
                end
            end)
        else
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoNear and not _G.AutoFarm and not _G.AutoBossFarm and not _G.AutoFarmFruits and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(function()
                local enemy = findNearestEnemy(4000)
                if enemy then
                    attackEnemy(enemy, 20, function()
                        return state.running and _G.AutoNear and enemy.Parent and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0
                    end)
                end
            end)
        else
            task.wait(0.1)
        end

        task.wait(0.05)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoSelectedMobNoQuest and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not state.autoSelectedMobQuest then
            pcall(function()
                runSelectedMobFarm(false)
            end)
        else
            if not state.autoSelectedMobQuest then
                SelectMonster = nil
            end
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoSelectedMobQuest and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not state.autoSelectedMobNoQuest then
            pcall(function()
                runSelectedMobFarm(true)
            end)
        else
            if not state.autoSelectedMobNoQuest then
                SelectMonster = nil
            end
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoBossFarm and _G.SelectBoss ~= "" and not _G.AutoFarm and not _G.AutoNear and not _G.AutoFarmFruits and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(function()
                local canFarmBoss = true
                if state.bossFarmMode == "Quest If Available" then
                    canFarmBoss = ensureBossQuestStarted(_G.SelectBoss)
                end

                if not canFarmBoss then
                    return
                end

                local boss = findClosestNamedEnemy(_G.SelectBoss)

                if boss then
                    attackEnemy(boss, 20, function()
                        if state.bossFarmMode == "Quest If Available" and bossQuestData[_G.SelectBoss] then
                            local questGui = getQuestGui()
                            return state.running and _G.AutoBossFarm and questGui and questGui.Visible and boss.Parent and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0
                        end

                        return state.running and _G.AutoBossFarm and boss.Parent and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0
                    end)
                else
                    local replica = ReplicatedStorage:FindFirstChild(_G.SelectBoss)
                    local replicaRoot = replica and replica:FindFirstChild("HumanoidRootPart")

                    if replicaRoot then
                        TP1(replicaRoot.CFrame * CFrame.new(0, 10, 0))
                    elseif bossFallbackCFrames[_G.SelectBoss] then
                        TP1(bossFallbackCFrames[_G.SelectBoss])
                    end
                end
            end)
        else
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoSecondWorld and not _G.AutoThirdWorld and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(runAutoSecondWorld)
        else
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoThirdWorld and not _G.AutoSecondWorld and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(runAutoThirdWorld)
        else
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoFarmFruits and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(function()
                CheckQuest()

                local canFarm = true
                if state.masteryQuestCheck == "Quest" then
                    canFarm = ensureQuestStarted()
                end

                if canFarm then
                    local enemy = findClosestNamedEnemy(Mon)

                    if enemy then
                        local humanoid = enemy:FindFirstChild("Humanoid")
                        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
                        local head = enemy:FindFirstChild("Head")

                        if humanoid and enemyRoot and humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()

                                MonFarm = enemy.Name
                                PosMon = enemyRoot.CFrame
                                StartBring = true

                                enemyRoot.CanCollide = false
                                humanoid.WalkSpeed = 0
                                enemyRoot.Size = Vector3.new(60, 60, 60)

                                if head then
                                    head.CanCollide = false
                                end

                                BringMob(enemy.Name)
                                moveToMasteryFarmPosition(enemyRoot.CFrame)
                                local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100
                                if healthPercent <= KillPercent then
                                    performMasteryAttack(enemy)
                                else
                                    requestCombatEquip()
                                    equipSelectedWeapon()
                                    clickAttack()
                                end
                            until not state.running or not _G.AutoFarmFruits or not enemy.Parent or humanoid.Health <= 0

                            StartBring = false
                        end
                    elseif isUsableTargetCFrame(CFrameMon) then
                        moveToMasteryFarmPosition(CFrameMon)
                    end
                end
            end)
        else
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoFarmMaterial and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest then
            pcall(function()
                MaterialMon()
                local materialTargets = MMonList or (MMon and {MMon}) or nil
                if not materialTargets or not MPos then
                    return
                end

                local enemy = findClosestNamedEnemyByNames(materialTargets)
                if enemy then
                    attackEnemy(enemy, 20, function()
                        return state.running and _G.AutoFarmMaterial and enemy.Parent and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0
                    end)
                else
                    moveToReplicaOrFallback(materialTargets, MPos, 20)
                end
            end)
        else
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        pcall(function()
            if state.quests.autoSelectDungeon then
                runAutoSelectDungeon()
            end
            if state.quests.autoBuyChip then
                runAutoBuyChip()
            end
            if state.quests.autoStartRaid then
                runAutoStartRaid()
            end
            if state.quests.autoAwaken then
                runAutoAwaken()
            end
            if state.quests.autoSuperhuman then
                runAutoSuperhuman()
            end
            if state.quests.autoDeathStep then
                runAutoDeathStep()
            end
            if state.quests.autoDragonTalon then
                runAutoDragonTalon()
            end
            if state.autoSanguineArt then
                runAutoSanguineArt()
            end
        end)

        if state.dragon.autoDojoTrainer and not state.dragon.autoDracoV2V3 then
            pcall(runAutoDojoTrainer)
        end
        if state.dragon.autoDragonHunter and not state.dragon.autoDracoV2V3 then
            pcall(runAutoDragonHunter)
        end
        if state.dragon.autoDracoV2V3 then
            pcall(runAutoDracoV2V3)
        end
        if state.raceQuest.autoV2 then
            pcall(runAutoRaceV2)
        end
        if state.raceQuest.autoV3 then
            pcall(runAutoRaceV3)
        end
        if Sea3 then
            if state.v4Trial.autoLever then
                pcall(runAutoV4LeverStep)
            end
            if state.v4Trial.autoRaceDoor then
                pcall(runAutoV4RaceDoorStep)
            end
            if state.v4Trial.autoHumanGhoulTrial then
                pcall(runAutoV4HumanGhoulTrialStep)
            end
            if state.v4Trial.autoCompleteTrial then
                pcall(runAutoV4CompleteTrialStep)
            end
            if state.v4Trial.autoKillTrialPlayer then
                pcall(runAutoV4KillTrialPlayerStep)
            end
        end

        task.wait(0.5)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoBerry
            and not _G.AutoFarm
            and not _G.AutoNear
            and not _G.AutoBossFarm
            and not _G.AutoFarmFruits
            and not _G.AutoFarmMaterial
            and not state.autoSelectedMobNoQuest
            and not state.autoSelectedMobQuest
            and not state.autoChest
            and not state.autoEliteHunter
            and not isPirateRaidBlockingAutomation()
            and not state.autoMirageTeleport
            and not isQuestAutomationActive()
            and not state.sea.autoPrehistoricTeleport
            and not state.sea.autoDefendVolcano
        then
            pcall(runAutoBerry)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoFactoryRaid
            and not _G.AutoFarm
            and not _G.AutoNear
            and not _G.AutoBossFarm
            and not _G.AutoFarmFruits
            and not _G.AutoFarmMaterial
            and not state.autoSelectedMobNoQuest
            and not state.autoSelectedMobQuest
            and not state.autoChest
            and not state.autoEliteHunter
            and not isPirateRaidBlockingAutomation()
            and not state.autoMirageTeleport
        then
            pcall(runAutoFactoryRaid)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoKitsuneIsland
            and not _G.AutoFarm
            and not _G.AutoNear
            and not _G.AutoBossFarm
            and not _G.AutoFarmFruits
            and not _G.AutoFarmMaterial
            and not state.autoSelectedMobNoQuest
            and not state.autoSelectedMobQuest
            and not state.autoChest
            and not state.autoEliteHunter
            and not isPirateRaidBlockingAutomation()
        then
            pcall(runAutoKitsuneIsland)
        else
            task.wait(0.35)
        end

        task.wait(0.35)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoCollectAzureEmber then
            pcall(runAutoCollectAzureEmber)
        else
            task.wait(0.35)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoMirageGear then
            pcall(runAutoMirageGear)
        else
            task.wait(0.35)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoAdvancedFruitDealer then
            pcall(runAutoAdvancedFruitDealer)
        else
            task.wait(0.35)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoTweenFruit
            and not _G.AutoFarm
            and not _G.AutoNear
            and not _G.AutoBossFarm
            and not _G.AutoFarmFruits
            and not _G.AutoFarmMaterial
            and not state.autoSelectedMobNoQuest
            and not state.autoSelectedMobQuest
            and not state.autoChest
            and not state.autoEliteHunter
            and not isPirateRaidBlockingAutomation()
            and not state.autoMirageTeleport
            and not state.autoAdvancedFruitDealer
            and not isQuestAutomationActive()
        then
            pcall(runAutoTweenFruitStep)
        else
            task.wait(0.45)
        end

        task.wait(0.3)
    end
end)

task.spawn(function()
    while state.running do
        if tick() - lastFruitScan >= 5 then
            lastFruitScan = tick()
            pcall(scanFruitSpawnNotifications)
        end
        pcall(updateSpecialIslandNotifications)
        pcall(scanDragonNotifications)

        if state.craft.autoCraftVolcanicMagnet then
            pcall(runAutoCraftVolcanicMagnet)
        end
        if state.craft.autoCollectDragonEgg then
            pcall(runAutoCollectDragonEgg)
        end
        if state.craft.autoTradeAzureEmber then
            pcall(runAutoTradeAzureEmber)
        end
        if state.craft.autoAuraColor then
            pcall(runAutoAuraColor)
        end
        if state.craft.autoBaristaCousin then
            pcall(runAutoBaristaCousin)
        end
        if state.autoKitsunePray and not state.craft.autoTradeAzureEmber then
            pcall(runAutoKitsunePray)
        end

        syncLegacyDragonFlags()

        local bush, berryName = findNearestBerryBush()
        if berryStatusLabel then
            berryStatusLabel.Text = berryName and ("Nearest Berry: " .. berryName) or "Nearest Berry: None"
        end

        if eliteHunterProgressLabel then
            eliteHunterProgressLabel.Text = string.format("Elite Hunter Progress: %d", getEliteHunterProgress())
        end

        if observationStatusLabel then
            local visionRadius = LocalPlayer:FindFirstChild("VisionRadius")
            observationStatusLabel.Text = "Observation Level: " .. tostring(visionRadius and visionRadius.Value or "--")
        end

        if raceInfoLabels.race then
            local data = LocalPlayer:FindFirstChild("Data")
            local stats = data and data:FindFirstChild("Stats")
            raceInfoLabels.race.Text = "Race: " .. tostring(data and data:FindFirstChild("Race") and data.Race.Value or "--")
            if raceInfoLabels.rerolls then
                raceInfoLabels.rerolls.Text = "Race Rerolls: " .. tostring(data and data:FindFirstChild("RaceRerolls") and data.RaceRerolls.Value or "--")
            end
            if raceInfoLabels.statRefunds then
                raceInfoLabels.statRefunds.Text = "Stat Refunds: " .. tostring(data and data:FindFirstChild("StatRefunds") and data.StatRefunds.Value or "--")
            end
            if raceInfoLabels.fruitCap then
                raceInfoLabels.fruitCap.Text = "Fruit Cap: " .. tostring(data and data:FindFirstChild("FruitCap") and data.FruitCap.Value or "--")
            end
            if raceInfoLabels.points then
                raceInfoLabels.points.Text = "Available Points: " .. tostring(data and data:FindFirstChild("Points") and data.Points.Value or "--")
            end
            if stats then
                if raceInfoLabels.melee then
                    raceInfoLabels.melee.Text = "Melee: " .. tostring(stats:FindFirstChild("Melee") and stats.Melee:FindFirstChild("Level") and stats.Melee.Level.Value or "--")
                end
                if raceInfoLabels.defense then
                    raceInfoLabels.defense.Text = "Defense: " .. tostring(stats:FindFirstChild("Defense") and stats.Defense:FindFirstChild("Level") and stats.Defense.Level.Value or "--")
                end
                if raceInfoLabels.sword then
                    raceInfoLabels.sword.Text = "Sword: " .. tostring(stats:FindFirstChild("Sword") and stats.Sword:FindFirstChild("Level") and stats.Sword.Level.Value or "--")
                end
                if raceInfoLabels.gun then
                    raceInfoLabels.gun.Text = "Gun: " .. tostring(stats:FindFirstChild("Gun") and stats.Gun:FindFirstChild("Level") and stats.Gun.Level.Value or "--")
                end
                if raceInfoLabels.fruit then
                    local fruitStat = stats:FindFirstChild("Demon Fruit")
                    raceInfoLabels.fruit.Text = "Blox Fruit: " .. tostring(fruitStat and fruitStat:FindFirstChild("Level") and fruitStat.Level.Value or "--")
                end
            end
        end

        if mirageStatusLabel then
            mirageStatusLabel.Text = specialNotificationState.mirage and "Mirage Status: Spawned" or "Mirage Status: Not Spawned"
        end

        if kitsuneStatusLabel then
            kitsuneStatusLabel.Text = specialNotificationState.kitsune and "Kitsune Status: Spawned" or "Kitsune Status: Not Spawned"
        end

        if prehistoricStatusLabel then
            prehistoricStatusLabel.Text = specialNotificationState.prehistoric and "Prehistoric Status: Spawned" or "Prehistoric Status: Not Spawned"
        end

        if fruitNotifyStatusLabel then
            fruitNotifyStatusLabel.Text = state.fruitNotifications and "Fruit Notify: Enabled" or "Fruit Notify: Disabled"
        end

        if dojoQuestStatusLabel then
            dojoQuestStatusLabel.Text = "Dojo Quest: " .. (state.dragon.status ~= "" and state.dragon.status or "Waiting")
        end

        if blazeQuestStatusLabel then
            blazeQuestStatusLabel.Text = "Dragon Hunter: " .. (state.dragon.hunterStatus ~= "" and state.dragon.hunterStatus or "Waiting")
        end

        if state.ui.dragon.beltInfoLabel then
            local beltName = state.dragon.currentBelt or "Null"
            local beltProgress = beltName ~= "Null" and math.floor(tonumber(state.dragon.beltProgress[beltName] or 0)) or 0
            state.ui.dragon.beltInfoLabel.Text = "Belt: " .. tostring(beltName) .. " [" .. tostring(beltProgress) .. "]"
        end

        if dracoRaceStatusLabel then
            dracoRaceStatusLabel.Text = "Draco: " .. (state.dragon.dracoStatus ~= "" and state.dragon.dracoStatus or "Idle")
        end

        if raceV2StatusLabel then
            raceV2StatusLabel.Text = "Race V2: " .. (state.raceQuest.statusV2 ~= "" and state.raceQuest.statusV2 or "Idle")
        end

        if raceV3StatusLabel then
            raceV3StatusLabel.Text = "Race V3: " .. (state.raceQuest.statusV3 ~= "" and state.raceQuest.statusV3 or "Idle")
        end

        if craftStatusLabel then
            craftStatusLabel.Text = "Craft: " .. (state.craft.status ~= "" and state.craft.status or "Idle")
        end

        task.wait(1)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoYama
            and not isCoreAutomationActive()
            and not state.autoHolyTorch
            and not state.autoTushita
            and not state.autoTyrant
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoYama)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoHolyTorch
            and not isCoreAutomationActive()
            and not state.autoTushita
            and not state.autoYama
            and not state.autoTyrant
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoHolyTorch)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoTushita
            and not isCoreAutomationActive()
            and not state.autoYama
            and not state.autoTyrant
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoTushita)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoTyrant
            and not isCoreAutomationActive()
            and not state.autoYama
            and not state.autoHolyTorch
            and not state.autoTushita
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoTyrant)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoCDK
            and not isCoreAutomationActive()
            and not state.autoYama
            and not state.autoHolyTorch
            and not state.autoTushita
            and not state.autoTyrant
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoCDK)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoObservation
            and not isCoreAutomationActive()
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoObservation)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoCakePrince
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoCakePrince)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoDoughKing
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoDoughKing)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoBoneFarm
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(function()
                runAutoBoneFarm(state.autoBoneSurprise)
            end)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoSoulReaper
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoSoulReaper)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoGodhuman
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoGodhuman)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoSharkmanKarate
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoSharkmanKarate)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoElectricClaw
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoDungeon
            and not state.quests.autoLawRaid
        then
            pcall(runAutoElectricClaw)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoDungeon
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoLawRaid
        then
            pcall(runAutoDungeon)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.quests.autoLawRaid
            and not isCoreAutomationActive()
            and not state.quests.autoObservation
            and not state.quests.autoCakePrince
            and not state.quests.autoDoughKing
            and not state.quests.autoSoulReaper
            and not state.quests.autoGodhuman
            and not state.quests.autoSharkmanKarate
            and not state.quests.autoElectricClaw
            and not state.quests.autoDungeon
        then
            pcall(runAutoLawRaid)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoChest and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest and not state.autoEliteHunter and not isPirateRaidBlockingAutomation() and not state.autoMirageTeleport then
            if isTeleporting and teleportTargetCFrame then
                task.wait(0.1)
            else
                pcall(function()
                    local chestPart = findClosestChestPart()
                    if chestPart then
                        tryCollectChest(chestPart)
                    elseif state.autoChestHop then
                        Hop()
                        task.wait(2)
                    end
                end)
            end
        else
            task.wait(0.25)
        end

        task.wait(0.25)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoEliteHunter and Sea3 and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest and not state.autoChest and not isPirateRaidBlockingAutomation() and not state.autoMirageTeleport then
            pcall(function()
                if state.stopEliteOnChalice and hasGodsChalice() then
                    state.autoEliteHunter = false
                    state.autoEliteHop = false
                    stopTeleport()
                    return
                end

                local questTitle = getQuestTitleText()
                local questActive = textContains(questTitle, "Diablo") or textContains(questTitle, "Deandre") or textContains(questTitle, "Urban")

                if not questActive then
                    local response = CommF:InvokeServer("EliteHunter")
                    if state.autoEliteHop and type(response) == "string" and textContains(response, "come back later") then
                        Hop()
                        task.wait(2)
                    else
                        task.wait(1)
                    end
                    return
                end

                local eliteBoss = findClosestNamedEnemyByNames(eliteHunterTargetNames)
                if eliteBoss then
                    attackEnemy(eliteBoss, 20, function()
                        local humanoid = eliteBoss:FindFirstChild("Humanoid")
                        return state.running and state.autoEliteHunter and eliteBoss.Parent and humanoid and humanoid.Health > 0
                    end)
                else
                    moveToReplicaOrFallback(eliteHunterTargetNames, pirateRaidFallbackCFrame, 20)
                end
            end)
        else
            task.wait(0.25)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoPirateRaid and Sea3 and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest and not state.autoChest and not state.autoEliteHunter and not state.autoMirageTeleport then
            pcall(function()
                local raidEnemy = findClosestEnemyByTokens(pirateRaidEnemyTokens)
                if raidEnemy then
                    state.autoPirateRaidBusy = true
                    attackEnemy(raidEnemy, 20, function()
                        local humanoid = raidEnemy:FindFirstChild("Humanoid")
                        return state.running and state.autoPirateRaid and raidEnemy.Parent and humanoid and humanoid.Health > 0
                    end)
                    return
                end

                local hrp = getHumanoidRootPart()
                if hrp and (hrp.Position - pirateRaidFallbackCFrame.Position).Magnitude > 3000 then
                    state.autoPirateRaidBusy = true
                    pcall(function()
                        CommF:InvokeServer("requestEntrance", Vector3.new(-4987.30908, 314.515503, -3060.17725))
                    end)
                elseif hrp and (hrp.Position - pirateRaidFallbackCFrame.Position).Magnitude > 120 then
                    state.autoPirateRaidBusy = true
                    TP1(pirateRaidFallbackCFrame)
                else
                    state.autoPirateRaidBusy = false
                    StartBring = false
                    stopTeleport()
                    task.wait(0.35)
                end
            end)
        else
            state.autoPirateRaidBusy = false
            task.wait(0.25)
        end

        task.wait(0.15)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoMirageTeleport and Sea3 and not _G.AutoFarm and not _G.AutoNear and not _G.AutoBossFarm and not _G.AutoFarmFruits and not _G.AutoFarmMaterial and not state.autoSelectedMobNoQuest and not state.autoSelectedMobQuest and not state.autoChest and not state.autoEliteHunter and not isPirateRaidBlockingAutomation() then
            pcall(function()
                local mirageTarget = getMirageIslandTargetCFrame()
                if mirageTarget then
                    TP1(mirageTarget)
                end
            end)
        else
            task.wait(0.5)
        end

        task.wait(0.5)
    end
end)

task.spawn(function()
    while state.running do
        if state.autoBuyRandomFruit then
            pcall(function()
                CommF:InvokeServer("Cousin", "Buy")
            end)
            task.wait(3)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while state.running do
        pcall(function()
            if cakePrinceRemainingLabel then
                cakePrinceRemainingLabel.Text = formatCakeEncounterRemaining("Cake Prince", false)
            end
            if doughKingRemainingLabel then
                doughKingRemainingLabel.Text = formatCakeEncounterRemaining("Dough King", true)
            end
        end)

        task.wait(1)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.autoPrehistoricTeleport and not state.sea.autoSail and not state.sea.autoDefendVolcano and not state.sea.autoEvents then
            pcall(runAutoPrehistoricTeleport)
            task.wait(0.5)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.autoDefendVolcano and not state.sea.autoSail and not state.sea.autoEvents then
            pcall(runAutoDefendVolcano)
            task.wait(0.15)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while state.running do
        if state.autoEnablePvP then
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                local mainGui = playerGui and playerGui:FindFirstChild("Main")
                local pvpDisabled = mainGui and mainGui:FindFirstChild("PvpDisabled")
                if pvpDisabled and pvpDisabled.Visible then
                    CommF:InvokeServer("EnablePvp")
                end
            end)
            task.wait(0.2)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while state.running do
        if state.autoObservationHaki and not state.autoBerry and not state.autoChest and not state.bounty.autoFarm then
            pcall(function()
                if not isObservationImageVisible() and tick() - lastObservationToggleAt >= 6 then
                    toggleObservation()
                end
            end)
            task.wait(2)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while state.running do
        pcall(updateCombatStatusUi)
        task.wait(0.25)
    end
end)

task.spawn(function()
    while state.running do
        if state.bounty.tweenToPlayer and not state.bounty.autoFarm then
            pcall(runTweenToPlayerStep)
            task.wait(0.1)
        else
            task.wait(0.25)
        end
    end
end)

task.spawn(function()
    while state.running do
        if state.bounty.autoFarm then
            pcall(runAutoBountyStep)
            task.wait(0.1)
        else
            task.wait(0.25)
        end
    end
end)

task.spawn(function()
    while state.running do
        if state.bounty.lockEnabled and getBountyValue() >= (state.bounty.lockValue or 0) then
            LocalPlayer:Kick("Successfully! Bounty Farm")
            break
        end

        task.wait(0.5)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoActiveRaceV3 then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, "Y", false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, "Y", false, game)
            end)
        end

        task.wait(0.8)
    end
end)

task.spawn(function()
    while state.running do
        if _G.AutoActiveRaceV4 then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, "T", false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, "T", false, game)
            end)
        end

        task.wait(0.8)
    end
end)

task.spawn(function()
    while state.running do
        task.wait(1)

        pcall(function()
            local waterBase = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("WaterBase-Plane")
            if not waterBase then
                return
            end

            if _G.WalkWater then
                waterBase.Size = Vector3.new(1000, 112, 1000)
                waterBase.Transparency = 0.8
                waterBase.CanCollide = true
            else
                waterBase.Size = Vector3.new(1000, 80, 1000)
                waterBase.Transparency = 1
                waterBase.CanCollide = false
            end
        end)
    end
end)

task.spawn(function()
    while state.running do
        task.wait(0.1)

        if _G.InfiniteSoru then
            pcall(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("Soru") and getgc then
                    for _, fn in next, getgc() do
                        if typeof(fn) == "function" and getfenv and getupvalues and getfenv(fn).script == character.Soru then
                            for _, upvalue in next, getupvalues(fn) do
                                if typeof(upvalue) == "table" and upvalue.LastUse then
                                    upvalue.LastUse = 0
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while state.running do
        task.wait(0.1)

        if _G.InfiniteGeppo then
            pcall(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("Geppo") and getgc then
                    for _, fn in next, getgc() do
                        if typeof(fn) == "function" and getfenv and getupvalues and getfenv(fn).script == character.Geppo then
                            for _, upvalue in next, getupvalues(fn) do
                                if typeof(upvalue) == "table" and upvalue.LastUse then
                                    upvalue.LastUse = 0
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

addConnection(UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        pcall(function()
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local hrp = character and character:FindFirstChild("HumanoidRootPart")

            if humanoid then
                humanoid:ChangeState("Jumping")
            end

            if hrp and not hrp:FindFirstChild("JumpBoost") then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "JumpBoost"
                bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVelocity.Velocity = Vector3.new(0, 50, 0)
                bodyVelocity.Parent = hrp
                Debris:AddItem(bodyVelocity, 0.2)
            end
        end)
    end
end))

addConnection(UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if input.KeyCode == getAimbotHoldKeyCode() then
        state.aimbot.holdActive = true
        state.aimbot.status = "Searching"
        updateManualAimbotUi()
    end
end))

addConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if input.KeyCode == getAimbotHoldKeyCode() then
        state.aimbot.holdActive = false
        releaseManualAimbot()
        updateManualAimbotUi()
    end
end))

addConnection(RunService.RenderStepped:Connect(function(deltaTime)
    pcall(updateManualAimbot, deltaTime)
end))

task.spawn(function()
    while state.running do
        task.wait(10)

        if _G.CheckPoint then
            pcall(function()
                local hrp = getHumanoidRootPart()
                if hrp then
                    CommF:InvokeServer("SetSpawnPoint")
                end
            end)
        end
    end
end)

task.spawn(function()
    while state.running do
        task.wait(0.1)

        if _G.SpinPosition then
            pcall(function()
                local hrp = getHumanoidRootPart()
                if not hrp then
                    return
                end

                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(30), 0)
                local effect = hrp:FindFirstChild("SpinEffect")
                if not effect then
                    effect = Instance.new("BodyAngularVelocity")
                    effect.Name = "SpinEffect"
                    effect.MaxTorque = Vector3.new(0, math.huge, 0)
                    effect.AngularVelocity = Vector3.new(0, math.rad(60), 0)
                    effect.Parent = hrp
                end
            end)
        else
            pcall(function()
                local hrp = getHumanoidRootPart()
                local effect = hrp and hrp:FindFirstChild("SpinEffect")
                if effect then
                    effect:Destroy()
                end
            end)
        end
    end
end)

if fastAttackController and fastAttackController.Start then
    fastAttackController:Start()
end

task.spawn(function()
    while state.running do
        if StartBring and MonFarm ~= "" and (_G.BringMonster or _G.BringMob) then
            pcall(function()
                BringMob(MonFarm)
            end)
            RunService.Heartbeat:Wait()
        else
            task.wait()
        end
    end
end)

task.spawn(function()
    while state.running do
        pcall(function()
            for stat, enabled in pairs(state.autoStats) do
                if enabled then
                    addPoint(stat)
                end
            end
        end)

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.espPlayers then
            pcall(updatePlayerESP)
            task.wait()
        end
        if state.espChests then
            pcall(updateChestESP)
            task.wait()
        end
        if state.espFruits then
            pcall(updateFruitESP)
            task.wait()
        end
        if state.espFlowers then
            pcall(updateFlowerESP)
            task.wait()
        end
        if state.espBerries then
            pcall(updateBerryESP)
            task.wait()
        end
        if state.espSpecialIslands then
            pcall(updateSpecialIslandESP)
            task.wait()
        end
        task.wait(1.5)
    end
end)

task.spawn(function()
    while state.running do
        pcall(function()
            local boat = getSeaBoatModel()
            local seat = getSeaBoatSeat(boat)
            local activeBoatControl = state.sea.autoSail or isSeaCombatActive()

            if boat and activeBoatControl and (boat ~= lastBoatCollisionBoat or tick() - lastBoatCollisionUpdate >= 2) then
                lastBoatCollisionBoat = boat
                lastBoatCollisionUpdate = tick()
                for _, descendant in ipairs(boat:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        descendant.CanCollide = false
                    end
                end
            elseif not boat then
                lastBoatCollisionBoat = nil
            end

            applySeaBoatSpeedHack(boat, seat)
        end)

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.autoSail then
            pcall(function()
                local humanoid = getHumanoid()
                local hrp = getHumanoidRootPart()
                if not humanoid or not hrp then
                    return
                end

                local boat = getSeaBoatModel()
                local seat = getSeaBoatSeat(boat)
                local ownerValue = boat and boat:FindFirstChild("Owner") or nil
                local owner = ownerValue and ownerValue.Value or nil
                local ownedByLocalPlayer = owner == LocalPlayer or (owner and owner.Name == LocalPlayer.Name) or false

                if boat and seat and ownedByLocalPlayer then
                    if not humanoid.Sit then
                        TP1(seat.CFrame * CFrame.new(0, 1, 0))
                    elseif shouldPauseSeaSailing() then
                        stopSeaBoatTween()
                    else
                        tweenSeaBoatTo(getSeaSailingTarget())
                    end
                else
                    humanoid.Sit = false
                    stopSeaBoatTween()
                    TP1(seaBoatDockCFrame)

                    if (seaBoatDockCFrame.Position - hrp.Position).Magnitude <= 10 then
                        local now = os.clock()
                        if now - state.sea.lastBoatBuyAttempt >= 1 then
                            state.sea.lastBoatBuyAttempt = now
                            ensureSeaTeam()
                            CommF:InvokeServer("BuyBoat", state.sea.boat)
                        end
                    end
                end
            end)
        else
            stopSeaBoatTween()
            task.wait(0.1)
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.attackMobs then
            pcall(function()
                local enemy = getNearestSeaEnemy()
                if not enemy then
                    if not state.sea.attackSeaBeasts then
                        setSeaSkillAim(false)
                    end
                    return
                end

                local targetPart = getSeaEnemyTargetPart(enemy)
                if not targetPart then
                    return
                end

                repeat
                    task.wait()

                    if not state.running or not state.sea.attackMobs or not enemy.Parent or not isSeaEnemyAlive(enemy) then
                        break
                    end

                    local playerHumanoid = getHumanoid()
                    local enemyHumanoid = enemy:FindFirstChild("Humanoid")
                    if playerHumanoid then
                        playerHumanoid.Sit = false
                    end

                    AutoHaki()
                    equipSeaWeapon()

                    if seaShipNames[enemy.Name] then
                        local aimPart = enemy:FindFirstChild("Sails") or targetPart
                        setSeaSkillAim(true, aimPart.Position)
                        updateSeaCombatPosition(targetPart, 120)
                        targetPart.CanCollide = false
                        targetPart.Size = enemy.Name == "PirateGrandBrigade" and Vector3.new(60, 120, 60) or Vector3.new(60, 60, 60)
                        targetPart.Transparency = 1
                        pcall(function()
                            enemyHumanoid:ChangeState(11)
                            enemyHumanoid:ChangeState(14)
                        end)
                    else
                        if enemy.Name == "Terrorshark" then
                            setSeaSkillAim(true, targetPart.Position)
                        else
                            setSeaSkillAim(false)
                        end

                        updateSeaCombatPosition(targetPart, 120)
                        targetPart.CanCollide = false
                        targetPart.Size = Vector3.new(40, 40, 40)
                        targetPart.Transparency = 1
                        if enemyHumanoid then
                            enemyHumanoid:ChangeState(11)
                            enemyHumanoid:ChangeState(14)
                        end
                    end

                    clickAttack()
                until false

                if not state.sea.attackSeaBeasts then
                    setSeaSkillAim(false)
                end
            end)
        else
            if not state.sea.attackSeaBeasts then
                setSeaSkillAim(false)
            end
            task.wait(0.1)
        end

        task.wait(0.05)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.attackSeaBeasts then
            pcall(function()
                local seaBeast = getNearestSeaBeast()
                local targetPart = seaBeast and seaBeast:FindFirstChild("HumanoidRootPart") or nil
                if not seaBeast or not targetPart then
                    if not state.sea.attackMobs then
                        setSeaSkillAim(false)
                    end
                    return
                end

                repeat
                    task.wait()

                    if not state.running or not state.sea.attackSeaBeasts or not seaBeast.Parent or (getSeaBoatHealthValue(seaBeast) or 0) <= 0 then
                        break
                    end

                    local playerHumanoid = getHumanoid()
                    if playerHumanoid then
                        playerHumanoid.Sit = false
                    end

                    AutoHaki()
                    equipSeaWeapon()
                    setSeaSkillAim(true, targetPart.Position)
                    updateSeaCombatPosition(targetPart, 150)
                    targetPart.CanCollide = false
                    targetPart.Size = Vector3.new(120, 120, 120)
                    targetPart.Transparency = 1
                    clickAttack()
                until false

                if not state.sea.attackMobs then
                    setSeaSkillAim(false)
                end
            end)
        else
            if not state.sea.attackMobs then
                setSeaSkillAim(false)
            end
            task.wait(0.1)
        end

        task.wait(0.05)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.autoPressW then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, "W", false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, "W", false, game)
            end)
        end

        task.wait(0.15)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.destroyRocks then
            pcall(function()
                local hrp = getHumanoidRootPart()
                local rocks = Workspace:FindFirstChild("Rocks")
                if not hrp or not rocks then
                    return
                end

                for _, rock in ipairs(rocks:GetChildren()) do
                    if rock:IsA("MeshPart") and (rock.Position - hrp.Position).Magnitude < 250 then
                        rock:Destroy()
                    end
                end
            end)
        end

        task.wait(0.2)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.skillAimEnabled and state.sea.skillAimPosition then
            pcall(useSeaSkills)
        end

        task.wait(0.35)
    end
end)

task.spawn(function()
    while state.running do
        if state.sea.skillAimEnabled then
            pcall(function()
                local notifications = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("Notifications")
                if not notifications then
                    return
                end

                for _, notification in ipairs(notifications:GetChildren()) do
                    local textObject = notification:FindFirstChild("Text")
                    local textValue = nil
                    if textObject and textObject:IsA("TextLabel") then
                        textValue = textObject.Text
                    else
                        pcall(function()
                            textValue = notification.Text
                        end)
                    end
                    if notification.Name == "NotificationTemplate" and typeof(textValue) == "string" and string.find(textValue, "Skill locked!", 1, true) then
                        notification:Destroy()
                    end
                end
            end)
        end

        task.wait(0.2)
    end
end)

boatOptions = {"Pirate Sloop", "Enforcer", "Rocket Boost", "Dinghy", "Pirate Basic", "Pirate Brigade"}

shopAbilities = {
    {Name = "Buy Geppo $10,000", Callback = function() CommF:InvokeServer("BuyHaki", "Geppo") end},
    {Name = "Buy Buso Haki $25,000", Callback = function() CommF:InvokeServer("BuyHaki", "Buso") end},
    {Name = "Buy Soru $25,000", Callback = function() CommF:InvokeServer("BuyHaki", "Soru") end},
    {Name = "Buy Observation Haki $750,000", Callback = function() CommF:InvokeServer("KenTalk", "Buy") end}
}

shopStyles = {
    {Name = "Buy Black Leg $150,000", Callback = function() CommF:InvokeServer("BuyBlackLeg") end},
    {Name = "Buy Electro $550,000", Callback = function() CommF:InvokeServer("BuyElectro") end},
    {Name = "Buy Water Kung Fu $750,000", Callback = function() CommF:InvokeServer("BuyFishmanKarate") end},
    {Name = "Buy Dragon Claw 1,500F", Callback = function() CommF:InvokeServer("BlackbeardReward", "DragonClaw", "1"); CommF:InvokeServer("BlackbeardReward", "DragonClaw", "2") end},
    {Name = "Buy Superhuman $3,000,000", Callback = function() CommF:InvokeServer("BuySuperhuman") end},
    {Name = "Buy Death Step $5,000,000 5,000F", Callback = function() CommF:InvokeServer("BuyDeathStep") end},
    {Name = "Buy Sharkman Karate $2,500,000 5,000F", Callback = function() CommF:InvokeServer("BuySharkmanKarate", true); CommF:InvokeServer("BuySharkmanKarate") end},
    {Name = "Buy Electric Claw $3,000,000 5,000F", Callback = function() CommF:InvokeServer("BuyElectricClaw") end},
    {Name = "Buy Dragon Talon $3,000,000 5,000F", Callback = function() CommF:InvokeServer("BuyDragonTalon") end},
    {Name = "Buy God Human $5,000,000 5,000F", Callback = function() CommF:InvokeServer("BuyGodhuman") end},
    {Name = "Buy Sanguine Art $5,000,000 5,000F", Callback = function() CommF:InvokeServer("BuySanguineArt", true); CommF:InvokeServer("BuySanguineArt") end}
}

shopSwords = {
    {Name = "Cutlass $1,000", Callback = function() CommF:InvokeServer("BuyItem", "Cutlass") end},
    {Name = "Katana $1,000", Callback = function() CommF:InvokeServer("BuyItem", "Katana") end},
    {Name = "Iron Mace $25,000", Callback = function() CommF:InvokeServer("BuyItem", "Iron Mace") end},
    {Name = "Dual Katana $12,000", Callback = function() CommF:InvokeServer("BuyItem", "Duel Katana") end},
    {Name = "Triple Katana $60,000", Callback = function() CommF:InvokeServer("BuyItem", "Triple Katana") end},
    {Name = "Pipe $100,000", Callback = function() CommF:InvokeServer("BuyItem", "Pipe") end},
    {Name = "Dual-Headed Blade $400,000", Callback = function() CommF:InvokeServer("BuyItem", "Dual-Headed Blade") end},
    {Name = "Bisento $1,200,000", Callback = function() CommF:InvokeServer("BuyItem", "Bisento") end},
    {Name = "Soul Cane $750,000", Callback = function() CommF:InvokeServer("BuyItem", "Soul Cane") end},
    {Name = "Pole v2 5,000F", Callback = function() CommF:InvokeServer("ThunderGodTalk") end}
}

shopGuns = {
    {Name = "Slingshot $5,000", Callback = function() CommF:InvokeServer("BuyItem", "Slingshot") end},
    {Name = "Musket $8,000", Callback = function() CommF:InvokeServer("BuyItem", "Musket") end},
    {Name = "Flintlock $10,500", Callback = function() CommF:InvokeServer("BuyItem", "Flintlock") end},
    {Name = "Refined Slingshot $30,000", Callback = function() CommF:InvokeServer("BuyItem", "Refined Slingshot") end},
    {Name = "Refined Flintlock $65,000", Callback = function() CommF:InvokeServer("BuyItem", "Refined Flintlock") end},
    {Name = "Cannon $100,000", Callback = function() CommF:InvokeServer("BuyItem", "Cannon") end},
    {Name = "Kabucha 1,500F", Callback = function() CommF:InvokeServer("BlackbeardReward", "Slingshot", "1"); CommF:InvokeServer("BlackbeardReward", "Slingshot", "2") end},
    {Name = "Bizarre Rifle 250 Ectoplasm", Callback = function() CommF:InvokeServer("Ectoplasm", "Buy", 1) end}
}

shopUtility = {
    {Name = "Reset Stats 2,500F", Callback = function() CommF:InvokeServer("BlackbeardReward", "Refund", "1"); CommF:InvokeServer("BlackbeardReward", "Refund", "2") end},
    {Name = "Random Race 3,000F", Callback = function() CommF:InvokeServer("BlackbeardReward", "Reroll", "1"); CommF:InvokeServer("BlackbeardReward", "Reroll", "2") end},
    {Name = "Black Cape $50,000", Callback = function() CommF:InvokeServer("BuyItem", "Black Cape") end},
    {Name = "Swordsman Hat $150,000", Callback = function() CommF:InvokeServer("BuyItem", "Swordsman Hat") end},
    {Name = "Tomoe Ring $500,000", Callback = function() CommF:InvokeServer("BuyItem", "Tomoe Ring") end},
    {Name = "Open Haki Color", Callback = function() LocalPlayer.PlayerGui.Main.Colors.Visible = true end},
    {Name = "Open Titles", Callback = function() CommF:InvokeServer("getTitles"); LocalPlayer.PlayerGui.Main.Titles.Visible = true end},
    {Name = "Open Inventory", Callback = function() CommF:InvokeServer("getInventoryWeapons"); task.wait(1); LocalPlayer.PlayerGui.Main.Inventory.Visible = true end},
    {Name = "Open Fruit Inventory", Callback = function() CommF:InvokeServer("getInventoryFruits"); LocalPlayer.PlayerGui.Main.FruitInventory.Visible = true end},
    {Name = "Join Pirates Team", Callback = function() CommF:InvokeServer("SetTeam", "Pirates") end},
    {Name = "Join Marines Team", Callback = function() CommF:InvokeServer("SetTeam", "Marines") end}
}

function addShopButtons(group, items)
    for _, item in ipairs(items) do
        group:AddButton({
            Name = item.Name,
            Callback = item.Callback
        })
    end
end

local function loadZyphraxUiLibrary()
    local source = readWorkspaceFile(ZYPHRAX_UI_FILE)
    local librarySource = nil

    if source then
        local url = source:match("HttpGet%(%s*[\"']([^\"']+)[\"']%s*%)")
        if url then
            local ok, result = pcall(function()
                return game:HttpGet(url)
            end)
            if ok and type(result) == "string" and result ~= "" then
                librarySource = result
            end
        elseif source:find("function LIB:CreateWindow", 1, true) then
            librarySource = source
        end
    end

    if not librarySource then
        librarySource = game:HttpGet(ZYPHRAX_UI_FALLBACK_URL)
    end

    local chunk, compileError = loadstring(librarySource)
    if not chunk then
        error("Failed to compile Zyphrax UI library: " .. tostring(compileError))
    end

    local ok, library = pcall(chunk)
    if not ok then
        error("Failed to initialize Zyphrax UI library: " .. tostring(library))
    end

    return library
end

local function createCompatLabel(nativeParagraph, initialText)
    local label = {
        _text = initialText or "",
        _native = nativeParagraph
    }

    local function setText(self, value)
        local text = tostring(value or "")
        rawset(self, "_text", text)
        if self._native and self._native.SetTitle then
            self._native:SetTitle(text)
        end
    end

    return setmetatable(label, {
        __index = function(self, key)
            if key == "Text" then
                return rawget(self, "_text")
            end
            if key == "SetText" then
                return setText
            end
            if key == "Destroy" then
                return function(target)
                    if target._native and target._native.Destroy then
                        target._native:Destroy()
                    end
                end
            end
            return rawget(self, key)
        end,
        __newindex = function(self, key, value)
            if key == "Text" then
                setText(self, value)
                return
            end
            rawset(self, key, value)
        end
    })
end

local function createCompatGroup(nativeTab, groupData)
    local compatGroup = {}
    local sectionCreated = false

    local function ensureSection()
        if sectionCreated then
            return
        end

        nativeTab:Section({
            Title = groupData.Name or "Controls"
        })
        sectionCreated = true
    end

    function compatGroup:AddButton(data)
        ensureSection()
        return nativeTab:Button({
            Title = data.Name or data.Title or "Button",
            Desc = data.Description or data.Desc,
            Locked = data.Locked,
            Callback = data.Callback
        })
    end

    function compatGroup:AddToggle(data)
        ensureSection()
        return nativeTab:Toggle({
            Title = data.Name or data.Title or "Toggle",
            Desc = data.Description or data.Desc,
            Default = data.Default ~= nil and data.Default or data.Value,
            Locked = data.Locked,
            Icon = data.Icon,
            Callback = data.Callback
        })
    end

    function compatGroup:AddSlider(data)
        ensureSection()
        local step = tonumber(data.Increment or data.Step)
        if not step and tonumber(data.Decimals) then
            step = 1 / (10 ^ math.max(tonumber(data.Decimals), 0))
        end

        return nativeTab:Slider({
            Title = data.Name or data.Title or "Slider",
            Desc = data.Description or data.Desc,
            Step = step or 1,
            Locked = data.Locked,
            Value = {
                Min = tonumber(data.Min) or 0,
                Max = tonumber(data.Max) or 100,
                Default = tonumber(data.Default) or tonumber(data.Min) or 0
            },
            Callback = data.Callback
        })
    end

    function compatGroup:AddDropdown(data)
        ensureSection()
        local dropdown = nativeTab:Dropdown({
            Title = data.Name or data.Title or "Dropdown",
            Desc = data.Description or data.Desc,
            Values = data.Options or data.Values or {},
            Value = data.Default or data.Value,
            Multi = data.Multi,
            AllowNone = data.AllowNone,
            Locked = data.Locked,
            Callback = data.Callback
        })

        function dropdown:SetOptions(values)
            self:Refresh(values)
        end

        function dropdown:SetValues(values)
            self:Refresh(values)
        end

        return dropdown
    end

    function compatGroup:AddLabel(data)
        ensureSection()
        local text = data.Text or data.Name or ""
        local paragraph = nativeTab:Paragraph({
            Title = text,
            Desc = ""
        })
        return createCompatLabel(paragraph, text)
    end

    return compatGroup
end

local function createCompatTab(nativeTab)
    local compatTab = {}

    function compatTab:AddGroup(groupData)
        return createCompatGroup(nativeTab, groupData or {})
    end

    return compatTab
end

local function createCompatWindow(nativeWindow, library)
    local compatWindow = {
        _native = nativeWindow,
        _library = library,
        _title = nil,
        _sectionCount = 0,
        _tabCount = 0
    }

    function compatWindow:CreateSection()
        self._sectionCount = self._sectionCount + 1
        if self._sectionCount > 1 and self._native.Divider then
            self._native:Divider()
        end

        return {
            AddTab = function(_, data)
                local nativeTab = self._native:Tab({
                    Title = data.Name or data.Title or "Tab",
                    Icon = data.Icon or "layout-dashboard",
                    Desc = data.Description or data.Desc
                })

                self._tabCount = self._tabCount + 1
                if self._tabCount == 1 and self._native.SelectTab then
                    self._native:SelectTab(1)
                end

                return createCompatTab(nativeTab)
            end
        }
    end

    function compatWindow:SetToggleKey(key)
        if self._native.SetToggleKey then
            self._native:SetToggleKey(key)
        end
    end

    function compatWindow:Notify(data)
        local title = data.Title or "Notification"
        local content = data.Description or data.Content or ""
        local duration = data.Duration or data.Time or 3
        local delivered = false

        if self._library and self._library.Notify then
            delivered = pcall(function()
                self._library:Notify({
                    Title = title,
                    Content = content,
                    Icon = data.Icon or "bell",
                    Duration = duration
                })
            end)
        end

        if not delivered and StarterGui and StarterGui.SetCore then
            delivered = pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = title,
                    Text = content,
                    Duration = duration
                })
            end)
        end

        if not delivered then
            warn(string.format("[Zyphrax Notify] %s: %s", tostring(title), tostring(content)))
        end
    end

    function compatWindow:Delete()
        local parents = {
            game:GetService("CoreGui"),
            LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
        }

        for _, parent in ipairs(parents) do
            local gui = parent and self._title and parent:FindFirstChild(self._title)
            if gui then
                gui:Destroy()
            end
        end
    end

    return compatWindow
end

Library = loadZyphraxUiLibrary()

Window = createCompatWindow(Library:CreateWindow({
    Title = "Zyphrax Hub | Blox Fruits",
    Icon = "rbxassetid://125623993645104",
    Author = "Blox Fruits",
    Folder = "ZyphraxHub",
    Size = UDim2.fromOffset(620, 370),
    LiveSearchDropdown = true,
    FileSaveName = "zyphraxhub-bloxfruit-config.json"
}), Library)
Window._title = "Zyphrax Hub | Blox Fruits"

state.window = Window
Window:SetToggleKey(Enum.KeyCode.RightControl)

FarmSection = Window:CreateSection({
    Name = "Farming",
    Icon = "rbxassetid://98092584632154"
})
FarmTab = FarmSection:AddTab({
    Name = "Level Farm",
    Description = "Core farming, resources, and world progression",
    Icon = "rbxassetid://94219370057308"
})

farmGroup = FarmTab:AddGroup({
    Name = "Core Farming",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

resourceFarmGroup = FarmTab:AddGroup({
    Name = "Resources",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

worldGroup = FarmTab:AddGroup({
    Name = "World Progression",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

statsGroup = FarmTab:AddGroup({
    Name = "Auto Stats",
    Side = "Right",
    Icon = "rbxassetid://10723427199"
})

TargetsTab = FarmSection:AddTab({
    Name = "Targets",
    Description = "Bosses and selected mob automation",
    Icon = "rbxassetid://94219370057308"
})

bossGroup = TargetsTab:AddGroup({
    Name = "Boss Routes",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

selectedMobGroup = TargetsTab:AddGroup({
    Name = "Selected Mobs",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

MasteryTab = FarmSection:AddTab({
    Name = "Mastery",
    Description = "Mastery paths and material farming",
    Icon = "rbxassetid://94219370057308"
})

masteryFarmGroup = MasteryTab:AddGroup({
    Name = "Mastery Route",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

masterySkillGroup = MasteryTab:AddGroup({
    Name = "Mastery Skills",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

materialFarmGroup = MasteryTab:AddGroup({
    Name = "Material Route",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

ProgressionSection = Window:CreateSection({
    Name = "Progression",
    Icon = "rbxassetid://98092584632154"
})

QuestsTab = ProgressionSection:AddTab({
    Name = "Quest Routes",
    Description = "Quest chains, boss unlocks, and legendary routes",
    Icon = "rbxassetid://94219370057308"
})

questChainGroup = QuestsTab:AddGroup({
    Name = "Quest Chains",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

questUnlockGroup = QuestsTab:AddGroup({
    Name = "Boss Unlocks",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

questLegendaryGroup = QuestsTab:AddGroup({
    Name = "Legendary Unlocks",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

RaidTab = ProgressionSection:AddTab({
    Name = "Raids",
    Description = "Raid chips, dungeon route, and awakening",
    Icon = "rbxassetid://94219370057308"
})

raidControlGroup = RaidTab:AddGroup({
    Name = "Raid Controls",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

raidDungeonGroup = RaidTab:AddGroup({
    Name = "Dungeon, Awakening & Law",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

FightingStyleTab = ProgressionSection:AddTab({
    Name = "Fighting Styles",
    Description = "Automatic fighting style progression",
    Icon = "rbxassetid://94219370057308"
})

fightingStyleMainGroup = FightingStyleTab:AddGroup({
    Name = "Core Styles",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

fightingStyleAdvancedGroup = FightingStyleTab:AddGroup({
    Name = "Advanced Styles",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

SpecialSection = Window:CreateSection({
    Name = "Special",
    Icon = "rbxassetid://98092584632154"
})

StacksTab = SpecialSection:AddTab({
    Name = "Stacks",
    Description = "Berry, elite hunter, factory, and fruit tracking",
    Icon = "rbxassetid://94219370057308"
})

berryGroup = StacksTab:AddGroup({
    Name = "Berry Group",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

eliteHunterGroup = StacksTab:AddGroup({
    Name = "Elite Hunter Group",
    Side = "Right",
    Icon = "rbxassetid://10723427199"
})

factoryRaidGroup = StacksTab:AddGroup({
    Name = "Factory & Fruit",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

ObservationTab = SpecialSection:AddTab({
    Name = "Observation",
    Description = "Observation farming and status",
    Icon = "rbxassetid://94219370057308"
})

observationGroup = ObservationTab:AddGroup({
    Name = "Observation Farm",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

DojoTab = SpecialSection:AddTab({
    Name = "Dojo",
    Description = "Dojo whole, blaze embers, and crafting",
    Icon = "rbxassetid://94219370057308"
})

dojoGroup = DojoTab:AddGroup({
    Name = "Dojo Whole",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

dojoCraftGroup = DojoTab:AddGroup({
    Name = "Dragon Craft",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

MirageTab = SpecialSection:AddTab({
    Name = "Mirage Island",
    Description = "Mirage route, notifications, and gear tools",
    Icon = "rbxassetid://94219370057308"
})

mirageGroup = MirageTab:AddGroup({
    Name = "Mirage",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

KitsuneTab = SpecialSection:AddTab({
    Name = "Kitsune Island",
    Description = "Kitsune route, azure ember, and shrine tools",
    Icon = "rbxassetid://94219370057308"
})

PrehistoricTab = SpecialSection:AddTab({
    Name = "Prehistoric & Volcano",
    Description = "Volcano Auto Defend and other shits",
    Icon = "rbxassetid://94219370057308"
})


seaPrehistoricGroup = PrehistoricTab:AddGroup({
    Name = "Prehistoric & Volcano",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})
seaPrehistoricGroups = PrehistoricTab:AddGroup({
    Name = "Status",
    Side = "Right",
    Icon = "rbxassetid://10723427199"
})

kitsuneGroup = KitsuneTab:AddGroup({
    Name = "Kitsune",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

RaceTab = SpecialSection:AddTab({
    Name = "Race",
    Description = "Race activation and race status",
    Icon = "rbxassetid://94219370057308"
})

raceGroup = RaceTab:AddGroup({
    Name = "Race Skills",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

V4TrialTab = SpecialSection:AddTab({
    Name = "V4 Trial",
    Description = "Tree top, lever, and race door helpers",
    Icon = "rbxassetid://94219370057308"
})

v4TrialGroup = V4TrialTab:AddGroup({
    Name = "V4 Trial Tools",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

StatsInfoTab = SpecialSection:AddTab({
    Name = "Stats Info",
    Description = "Live race and stat information",
    Icon = "rbxassetid://94219370057308"
})

statsInfoGroup = StatsInfoTab:AddGroup({
    Name = "Info Stats",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

WorldSection = Window:CreateSection({
    Name = "World",
    Icon = "rbxassetid://98092584632154"
})

TeleportTab = WorldSection:AddTab({
    Name = "Teleport",
    Description = "Island teleports and sea travel",
    Icon = "rbxassetid://94219370057308"
})

teleportGroup = TeleportTab:AddGroup({
    Name = "Island Teleport",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

seaGroup = TeleportTab:AddGroup({
    Name = "Sea Travel",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

VisualTab = WorldSection:AddTab({
    Name = "ESP",
    Description = "Players, pickups, and island ESP",
    Icon = "rbxassetid://94219370057308"
})

espGroup = VisualTab:AddGroup({
    Name = "World ESP",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

infoGroup = VisualTab:AddGroup({
    Name = "Island ESP & Info",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

SeaSection = Window:CreateSection({
    Name = "Sea",
    Icon = "rbxassetid://98092584632154"
})

SeaEventTab = SeaSection:AddTab({
    Name = "Events",
    Description = "Sea routes, encounters, and prehistoric search",
    Icon = "rbxassetid://94219370057308"
})

seaRouteGroup = SeaEventTab:AddGroup({
    Name = "Route & Search",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})


seaCombatGroup = SeaEventTab:AddGroup({
    Name = "Combat & Defense",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

SeaEventConfigTab = SeaSection:AddTab({
    Name = "Config",
    Description = "Boat movement and sea skill setup",
    Icon = "rbxassetid://94219370057308"
})

seaBoatGroup = SeaEventConfigTab:AddGroup({
    Name = "Boat Control",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

seaSkillGroup = SeaEventConfigTab:AddGroup({
    Name = "Sea Skills",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

ShopSection = Window:CreateSection({
    Name = "Shop",
    Icon = "rbxassetid://98092584632154"
})

ShopAbilitiesTab = ShopSection:AddTab({
    Name = "Abilities",
    Description = "Ability and haki purchases",
    Icon = "rbxassetid://94219370057308"
})

ShopAbilitiesGroup = ShopAbilitiesTab:AddGroup({
    Name = "Abilities",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

ShopStylesTab = ShopSection:AddTab({
    Name = "Styles",
    Description = "Fighting style purchases",
    Icon = "rbxassetid://94219370057308"
})

ShopStylesGroup = ShopStylesTab:AddGroup({
    Name = "Fighting Styles",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

ShopBoatsTab = ShopSection:AddTab({
    Name = "Boats",
    Description = "Boat purchases",
    Icon = "rbxassetid://94219370057308"
})

ShopBoatsGroup = ShopBoatsTab:AddGroup({
    Name = "Boats",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

ShopWeaponsTab = ShopSection:AddTab({
    Name = "Weapons",
    Description = "Sword and gun purchases",
    Icon = "rbxassetid://94219370057308"
})

ShopSwordsGroup = ShopWeaponsTab:AddGroup({
    Name = "Swords",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

ShopGunsGroup = ShopWeaponsTab:AddGroup({
    Name = "Guns",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

ShopUtilityTab = ShopSection:AddTab({
    Name = "Utility",
    Description = "Teams, UI, titles, and random fruit",
    Icon = "rbxassetid://94219370057308"
})

ShopUtilityGroup = ShopUtilityTab:AddGroup({
    Name = "Utility",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

UtilitySection = Window:CreateSection({
    Name = "Utility",
    Icon = "rbxassetid://98092584632154"
})

ConfigTab = UtilitySection:AddTab({
    Name = "Automation",
    Description = "Combat, weapon, position, and race settings",
    Icon = "rbxassetid://94219370057308"
})

automationSettingsGroup = ConfigTab:AddGroup({
    Name = "Combat Automation",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

fruitAutomationGroup = ConfigTab:AddGroup({
    Name = "Fruit Automation",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

positionSettingsGroup = ConfigTab:AddGroup({
    Name = "Farm Position",
    Side = "Right",
    Icon = "rbxassetid://14540833263"
})

weaponSettingsGroup = ConfigTab:AddGroup({
    Name = "Weapon Setup",
    Side = "Right",
    Icon = "rbxassetid://10723427199"
})

raceSettingsGroup = ConfigTab:AddGroup({
    Name = "Race Skills",
    Side = "Left",
    Icon = "rbxassetid://14540833263"
})

MiscUtilityTab = UtilitySection:AddTab({
    Name = "Server & Client",
    Description = "Server actions and client utilities",
    Icon = "rbxassetid://94219370057308"
})

miscUtilityGroup = MiscUtilityTab:AddGroup({
    Name = "Utility",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

MiscMovementTab = UtilitySection:AddTab({
    Name = "Movement",
    Description = "Movement and bypass toggles",
    Icon = "rbxassetid://94219370057308"
})

miscMovementGroup = MiscMovementTab:AddGroup({
    Name = "Movement",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

WindowSection = Window:CreateSection({
    Name = "Window",
    Icon = "rbxassetid://98092584632154"
})

SettingsTab = WindowSection:AddTab({
    Name = "UI",
    Description = "Window and emergency controls",
    Icon = "rbxassetid://94219370057308"
})

settingsGroup = SettingsTab:AddGroup({
    Name = "Controls",
    Side = "Left",
    Icon = "rbxassetid://10723427199"
})

farmGroup:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(value)
        _G.AutoFarm = value
        if value then
            state.autoSelectedMobNoQuest = false
            state.autoSelectedMobQuest = false
            SelectMonster = nil
        end
        if not value then
            StartBring = false
            stopTeleport()
        end
    end
})

farmGroup:AddToggle({
    Name = "Auto Farm Nearest",
    Default = false,
    Callback = function(value)
        _G.AutoNear = value
        if not value then
            StartBring = false
            stopTeleport()
        end
    end
})

farmGroup:AddToggle({
    Name = "Bring Mobs",
    Default = true,
    Callback = function(value)
        _G.BringMonster = value
        _G.BringMob = value
    end
})

resourceFarmGroup:AddToggle({
    Name = "Auto Collect Chest",
    Default = false,
    Callback = function(value)
        state.autoChest = value
        if not value then
            stopTeleport()
        end
    end
})

resourceFarmGroup:AddToggle({
    Name = "Chest Hop",
    Default = false,
    Callback = function(value)
        state.autoChestHop = value
    end
})




worldGroup:AddToggle({
    Name = "Auto Second Sea [Lv. 700]",
    Default = false,
    Callback = function(value)
        _G.AutoSecondWorld = value
        if value then
            _G.AutoThirdWorld = false
        else
            stopTeleport()
        end
    end
})

worldGroup:AddToggle({
    Name = "Auto Third Sea [Lv. 1500]",
    Default = false,
    Callback = function(value)
        _G.AutoThirdWorld = value
        if value then
            _G.AutoSecondWorld = false
        else
            stopTeleport()
        end
    end
})

statsGroup:AddToggle({
    Name = "Auto Melee",
    Default = false,
    Callback = function(value)
        state.autoStats.Melee = value
    end
})

statsGroup:AddToggle({
    Name = "Auto Defense",
    Default = false,
    Callback = function(value)
        state.autoStats.Defense = value
    end
})

statsGroup:AddToggle({
    Name = "Auto Sword",
    Default = false,
    Callback = function(value)
        state.autoStats.Sword = value
    end
})

statsGroup:AddToggle({
    Name = "Auto Demon Fruit",
    Default = false,
    Callback = function(value)
        state.autoStats["Demon Fruit"] = value
    end
})

statsGroup:AddToggle({
    Name = "Auto Gun",
    Default = false,
    Callback = function(value)
        state.autoStats.Gun = value
    end
})

bossGroup:AddDropdown({
    Name = "Select Boss",
    Options = #bossOptions > 0 and bossOptions or {"No Bosses Found"},
    Default = (#bossOptions > 0 and _G.SelectBoss) or "No Bosses Found",
    Callback = function(value)
        if value ~= "No Bosses Found" then
            _G.SelectBoss = value
        end
    end
})

bossGroup:AddDropdown({
    Name = "Boss Farm Mode",
    Options = bossFarmModeOptions,
    Default = state.bossFarmMode,
    Callback = function(value)
        state.bossFarmMode = value
    end
})

bossGroup:AddToggle({
    Name = "Auto Farm Boss",
    Default = false,
    Callback = function(value)
        _G.AutoBossFarm = value
        if not value then
            stopTeleport()
        end
    end
})

selectedMobGroup:AddDropdown({
    Name = "Mob Dropdown Quest",
    Options = questMobOptions,
    Default = state.selectedQuestMob,
    Callback = function(value)
        state.selectedQuestMob = value
    end
})

selectedMobGroup:AddToggle({
    Name = "Auto Farm Selected Mob No Quest",
    Default = false,
    Callback = function(value)
        state.autoSelectedMobNoQuest = value
        if value then
            state.autoSelectedMobQuest = false
        else
            SelectMonster = nil
        end
    end
})

selectedMobGroup:AddToggle({
    Name = "Auto Farm Selected Mob With Quest",
    Default = false,
    Callback = function(value)
        state.autoSelectedMobQuest = value
        if value then
            state.autoSelectedMobNoQuest = false
        else
            SelectMonster = nil
        end
    end
})

masteryFarmGroup:AddDropdown({
    Name = "Select Mastery Weapon",
    Options = masteryWeaponOptions,
    Default = state.masteryWeaponType,
    Callback = function(value)
        state.masteryWeaponType = value
    end
})

masteryFarmGroup:AddDropdown({
    Name = "Quest Check",   
    Options = masteryQuestOptions,
    Default = state.masteryQuestCheck,
    Callback = function(value)
        state.masteryQuestCheck = value
        _G.selectFruitFarm = value == "Quest" and "Farm Level Mastery" or "Farm Level Mastery No Quest"
    end
})

masteryFarmGroup:AddToggle({
    Name = "Mastery Aimbot",
    Default = true,
    Callback = function(value)
        state.masteryAimbot = value
    end
})

masteryFarmGroup:AddToggle({
    Name = "Auto Farm Mastery",
    Default = false,
    Callback = function(value)
        state.autoMastery = value
        if value then
            _G.AutoFarmFruits = false
        end
        if not value then
            StartBring = false
            stopTeleport()
        end
    end
})

masteryFarmGroup:AddToggle({
    Name = "Auto Farm Level Mastery [Dedicated]",
    Default = false,
    Callback = function(value)
        _G.AutoFarmFruits = value
        if value then
            state.autoMastery = true
            _G.AutoFarm = false
            _G.AutoNear = false
            _G.AutoBossFarm = false
        else
            StartBring = false
            stopTeleport()
        end
    end
})

masterySkillGroup:AddSlider({
    Name = "Health Percentage",
    Min = 1,
    Max = 100,
    Default = KillPercent,
    Decimals = 0,
    ValueName = "%",
    Callback = function(value)
        KillPercent = math.clamp(math.floor(value), 1, 100)
    end
})

masterySkillGroup:AddToggle({
    Name = "Auto Skill Z",
    Default = true,
    Callback = function(value)
        SkillZ = value
    end
})

masterySkillGroup:AddToggle({
    Name = "Auto Skill X",
    Default = false,
    Callback = function(value)
        SkillX = value
    end
})

masterySkillGroup:AddToggle({
    Name = "Auto Skill C",
    Default = false,
    Callback = function(value)
        SkillC = value
    end
})

masterySkillGroup:AddToggle({
    Name = "Auto Skill V",
    Default = false,
    Callback = function(value)
        SkillV = value
    end
})

masterySkillGroup:AddToggle({
    Name = "Auto Skill F",
    Default = false,
    Callback = function(value)
        SkillF = value
    end
})

materialFarmGroup:AddDropdown({
    Name = "Select Material",
    Options = materialOptions,
    Default = _G.SelectMaterial,
    Callback = function(value)
        _G.SelectMaterial = value
    end
})

materialFarmGroup:AddToggle({
    Name = "Auto Farm Material",
    Default = false,
    Callback = function(value)
        _G.AutoFarmMaterial = value
        if not value then
            StartBring = false
            stopTeleport()
        end
    end
})

questChainGroup:AddToggle({
    Name = "Auto Observation",
    Default = false,
    Callback = function(value)
        state.quests.autoObservation = value
        if not value then
            stopTeleport()
        end
    end
})

questChainGroup:AddToggle({
    Name = "Observation Hop",
    Default = false,
    Callback = function(value)
        state.quests.autoObservationHop = value
    end
})

cakePrinceRemainingLabel = questUnlockGroup:AddLabel({
    Text = "Cake Prince Left: --"
})

doughKingRemainingLabel = questUnlockGroup:AddLabel({
    Text = "Dough King Left: --"
})

questUnlockGroup:AddToggle({
    Name = "Auto Cake Prince",
    Default = false,
    Callback = function(value)
        state.quests.autoCakePrince = value
        if not value then
            stopTeleport()
        end
    end
})

questUnlockGroup:AddToggle({
    Name = "Auto Dough King",
    Default = false,
    Callback = function(value)
        state.quests.autoDoughKing = value
        if not value then
            stopTeleport()
        end
    end
})

questUnlockGroup:AddToggle({
    Name = "Auto Pirate Raid [Castle]",
    Default = false,
    Callback = function(value)
        state.autoPirateRaid = value
        if not value then
            state.autoPirateRaidBusy = false
            StartBring = false
            stopTeleport()
        end
    end
})

questUnlockGroup:AddToggle({
    Name = "Auto Soul Reaper",
    Default = false,
    Callback = function(value)
        state.quests.autoSoulReaper = value
        if not value then
            stopTeleport()
        end
    end
})

questUnlockGroup:AddToggle({
    Name = "Soul Reaper Hop",
    Default = false,
    Callback = function(value)
        state.quests.autoSoulReaperHop = value
    end
})

questUnlockGroup:AddToggle({
    Name = "Auto Farm Bone",
    Default = false,
    Callback = function(value)
        state.autoBoneFarm = value
        if not value then
            stopTeleport()
        end
    end
})

questUnlockGroup:AddToggle({
    Name = "Auto Random Surprise",
    Default = false,
    Callback = function(value)
        state.autoBoneSurprise = value
    end
})

raidDungeonGroup:AddToggle({
    Name = "Auto Raid Farm",
    Default = false,
    Callback = function(value)
        state.quests.autoDungeon = value
    end
})

raidDungeonGroup:AddToggle({
    Name = "Auto Awaken",
    Default = false,
    Callback = function(value)
        state.quests.autoAwaken = value
    end
})

raidControlGroup:AddDropdown({
    Name = "Raid Chip",
    Options = raidChipOptions,
    Default = state.quests.selectedChip,
    Callback = function(value)
        state.quests.selectedChip = value
    end
})

raidControlGroup:AddToggle({
    Name = "Auto Select Dungeon",
    Default = false,
    Callback = function(value)
        state.quests.autoSelectDungeon = value
    end
})

raidControlGroup:AddToggle({
    Name = "Auto Buy Chip",
    Default = false,
    Callback = function(value)
        state.quests.autoBuyChip = value
    end
})

raidControlGroup:AddToggle({
    Name = "Auto Start Raid",
    Default = false,
    Callback = function(value)
        state.quests.autoStartRaid = value
    end
})

raidDungeonGroup:AddToggle({
    Name = "Auto Law Raid",
    Default = false,
    Callback = function(value)
        state.quests.autoLawRaid = value
        if not value then
            stopTeleport()
        end
    end
})

raidDungeonGroup:AddToggle({
    Name = "Auto Buy Law Chip",
    Default = false,
    Callback = function(value)
        state.quests.autoBuyLawChip = value
    end
})

fightingStyleMainGroup:AddToggle({
    Name = "Auto Superhuman",
    Default = false,
    Callback = function(value)
        state.quests.autoSuperhuman = value
    end
})

fightingStyleMainGroup:AddDropdown({
    Name = "Superhuman Farm Method",
    Options = superhumanFarmMethodOptions,
    Default = state.quests.superhumanMethod,
    Callback = function(value)
        state.quests.superhumanMethod = value
    end
})

fightingStyleMainGroup:AddDropdown({
    Name = "Level Method Melee",
    Options = getMeleeWeaponOptions(),
    Default = state.levelFarmMelee,
    Callback = function(value)
        state.levelFarmMelee = value
    end
})

fightingStyleMainGroup:AddDropdown({
    Name = "Bone Method Melee",
    Options = getMeleeWeaponOptions(),
    Default = state.boneFarmMelee,
    Callback = function(value)
        state.boneFarmMelee = value
    end
})

fightingStyleMainGroup:AddDropdown({
    Name = "Sea of Treats Melee",
    Options = getMeleeWeaponOptions(),
    Default = state.seaTreatsFarmMelee,
    Callback = function(value)
        state.seaTreatsFarmMelee = value
    end
})

fightingStyleMainGroup:AddToggle({
    Name = "Auto Death Step",
    Default = false,
    Callback = function(value)
        state.quests.autoDeathStep = value
    end
})

fightingStyleMainGroup:AddToggle({
    Name = "Auto Sharkman Karate",
    Default = false,
    Callback = function(value)
        state.quests.autoSharkmanKarate = value
        if not value then
            stopTeleport()
        end
    end
})

fightingStyleAdvancedGroup:AddToggle({
    Name = "Auto Electric Claw",
    Default = false,
    Callback = function(value)
        state.quests.autoElectricClaw = value
        if not value then
            state.quests.electricClawStage = 0
            stopTeleport()
        end
    end
})

fightingStyleAdvancedGroup:AddToggle({
    Name = "Auto Dragon Talon",
    Default = false,
    Callback = function(value)
        state.quests.autoDragonTalon = value
    end
})

fightingStyleAdvancedGroup:AddToggle({
    Name = "Auto Godhuman",
    Default = false,
    Callback = function(value)
        state.quests.autoGodhuman = value
        if not value then
            stopTeleport()
        end
    end
})

fightingStyleAdvancedGroup:AddToggle({
    Name = "Auto Sanguine Art",
    Default = false,
    Callback = function(value)
        state.autoSanguineArt = value
        if not value then
            stopTeleport()
        end
    end
})

questLegendaryGroup:AddToggle({
    Name = "Auto Yama",
    Default = false,
    Callback = function(value)
        state.autoYama = value
        if not value then
            stopTeleport()
        end
    end
})

questLegendaryGroup:AddToggle({
    Name = "Auto Holy Torch",
    Default = false,
    Callback = function(value)
        state.autoHolyTorch = value
        if not value then
            stopTeleport()
        end
    end
})

questLegendaryGroup:AddToggle({
    Name = "Auto Tushita",
    Default = false,
    Callback = function(value)
        state.autoTushita = value
        if not value then
            stopTeleport()
        end
    end
})

questLegendaryGroup:AddToggle({
    Name = "Auto CDK",
    Default = false,
    Callback = function(value)
        state.autoCDK = value
        if value then
            state.autoYama = false
            state.autoHolyTorch = false
            state.autoTushita = false
            state.autoTyrant = false
        end
        if not value then
            stopTeleport()
        end
    end
})

questLegendaryGroup:AddToggle({
    Name = "Auto Tyrant Of The Skies",
    Default = false,
    Callback = function(value)
        state.autoTyrant = value
        if not value then
            stopTeleport()
        end
    end
})

addShopButtons(ShopAbilitiesGroup, shopAbilities)
addShopButtons(ShopStylesGroup, shopStyles)
addShopButtons(ShopSwordsGroup, shopSwords)
addShopButtons(ShopGunsGroup, shopGuns)
addShopButtons(ShopUtilityGroup, shopUtility)

ShopUtilityGroup:AddButton({
    Name = "Buy Random Fruit",
    Callback = function()
        CommF:InvokeServer("Cousin", "Buy")
    end
})

ShopUtilityGroup:AddToggle({
    Name = "Auto Buy Random Fruit",
    Default = false,
    Callback = function(value)
        state.autoBuyRandomFruit = value
    end
})

ShopBoatsGroup:AddDropdown({
    Name = "Select Boat",
    Options = boatOptions,
    Default = state.selectedBoat,
    Callback = function(value)
        state.selectedBoat = value
    end
})

ShopBoatsGroup:AddButton({
    Name = "Buy Boat",
    Callback = function()
        CommF:InvokeServer("BuyBoat", state.selectedBoat)
    end
})

miscUtilityGroup:AddToggle({
    Name = "Hide Chat",
    Default = false,
    Callback = function(value)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not value)
    end
})

miscUtilityGroup:AddToggle({
    Name = "Hide Leaderboard",
    Default = false,
    Callback = function(value)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, not value)
    end
})

miscUtilityGroup:AddButton({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {
            "KITTGAMING","ENYU_IS_PRO","FUDD10","BIGNEWS","THEGREATACE","SUB2GAMERROBOT_EXP1",
            "STRAWHATMAIME","SUB2OFFICIALNOOBIE","SUB2NOOBMASTER123","SUB2DAIGROCK","AXIORE",
            "TANTAIGAMIMG","STRAWHATMAINE","JCWK","FUDD10_V2","SUB2FER999","MAGICBIS","TY_FOR_WATCHING","STARCODEHEO"
        }
        for _, code in ipairs(codes) do
            pcall(function()
                ReplicatedStorage.Remotes.Redeem:InvokeServer(code)
            end)
        end
    end
})

miscUtilityGroup:AddButton({
    Name = "FPS Boost",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, v in ipairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                v.Enabled = false
            end
        end
    end
})

miscUtilityGroup:AddButton({
    Name = "Remove Fog",
    Callback = function()
        pcall(function()
            if Lighting:FindFirstChild("LightingLayers") then
                Lighting.LightingLayers:Destroy()
            end
            if Lighting:FindFirstChild("Sky") then
                Lighting.Sky:Destroy()
            end
            Lighting.FogEnd = 9e9
        end)
    end
})

miscUtilityGroup:AddButton({
    Name = "Remove Lava",
    Callback = function()
        for _, container in ipairs({Workspace, ReplicatedStorage}) do
            for _, v in ipairs(container:GetDescendants()) do
                if v.Name == "Lava" then
                    v:Destroy()
                end
            end
        end
    end
})

miscUtilityGroup:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

miscUtilityGroup:AddButton({
    Name = "Server Hop",
    Callback = function()
        Hop()
    end
})

miscMovementGroup:AddToggle({
    Name = "Walk Water",
    Default = false,
    Callback = function(value)
        _G.WalkWater = value
    end
})

miscMovementGroup:AddToggle({
    Name = "Auto Set Home Point",
    Default = false,
    Callback = function(value)
        _G.CheckPoint = value
    end
})

miscMovementGroup:AddToggle({
    Name = "Infinite Soru",
    Default = false,
    Callback = function(value)
        _G.InfiniteSoru = value
    end
})

miscMovementGroup:AddToggle({
    Name = "Dodge No CD",
    Default = false,
    Callback = function(value)
        _G.DodgeNoCD = value

        if value then
            if not _G.__ZyphraxDodgeNoCDHooked then
                _G.__ZyphraxDodgeNoCDHooked = true
                local oldCanDodge = getgenv().canDodge
                if oldCanDodge == nil and typeof(canDodge) == "function" then
                    oldCanDodge = canDodge
                end
                if oldCanDodge then
                    getgenv().canDodgeOriginal = oldCanDodge
                    getgenv().canDodge = function(...)
                        local character = LocalPlayer.Character
                        if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then
                            return false
                        end
                        return character.Humanoid.Health > 0
                    end
                end
            end
        elseif getgenv().canDodgeOriginal then
            getgenv().canDodge = getgenv().canDodgeOriginal
        end
    end
})

miscMovementGroup:AddToggle({
    Name = "Spin Position",
    Default = false,
    Callback = function(value)
        _G.SpinPosition = value
    end
})

miscMovementGroup:AddToggle({
    Name = "Infinite Geppo",
    Default = false,
    Callback = function(value)
        _G.InfiniteGeppo = value
    end
})

miscMovementGroup:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(value)
        _G.InfiniteJump = value
    end
})

locationNames = getLocationNames()
state.selectedLocation = locationNames[1]

teleportGroup:AddDropdown({
    Name = "Select Location",
    Options = locationNames,
    Default = state.selectedLocation,
    Callback = function(value)
        state.selectedLocation = value
    end
})

teleportGroup:AddButton({
    Name = "Teleport To Selected",
    Callback = function()
        local selected = getSelectedLocation()
        if not selected then
            return
        end

        teleportToLocationEntry(selected)
    end
})

seaGroup:AddButton({
    Name = "Travel To First Sea",
    Callback = function()
        CommF:InvokeServer("TravelMain")
    end
})

seaGroup:AddButton({
    Name = "Travel To Second Sea",
    Callback = function()
        CommF:InvokeServer("TravelDressrosa")
    end
})

seaGroup:AddButton({
    Name = "Travel To Third Sea",
    Callback = function()
        CommF:InvokeServer("TravelZou")
    end
})

seaRouteGroup:AddDropdown({
    Name = "Sea Team",
    Options = seaTeamOptions,
    Default = state.sea.team,
    Callback = function(value)
        state.sea.team = value
    end
})

seaRouteGroup:AddDropdown({
    Name = "Sea Boat",
    Options = seaBoatOptions,
    Default = state.sea.boat,
    Callback = function(value)
        state.sea.boat = value
    end
})

seaRouteGroup:AddDropdown({
    Name = "Sea Level Route",
    Options = {"Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6"},
    Default = state.sea.seaLevel,
    Callback = function(value)
        state.sea.seaLevel = value
    end
})

seaRouteGroup:AddToggle({
    Name = "Auto Sail",
    Default = false,
    Callback = function(value)
        state.sea.autoSail = value
        if not value then
            stopSeaBoatTween()
            clearSeaBoatSpeedHack()
        end
    end
})

seaRouteGroup:AddToggle({
    Name = "Auto Sea Events",
    Default = false,
    Callback = function(value)
        state.sea.autoEvents = value
        state.sea.autoSail = value
        state.sea.attackMobs = value
        state.sea.attackSeaBeasts = value
        state.sea.destroyRocks = value
        state.autoMirageTeleport = value
        if not value then
            stopSeaBoatTween()
            clearSeaBoatSpeedHack()
            stopTeleport()
        end
    end
})


seaPrehistoricGroup:AddToggle({
    Name = "Fly To Prehistoric",
    Default = false,
    Callback = function(value)
        state.sea.autoPrehistoricTeleport = value
    end
})

seaRouteGroup:AddButton({
    Name = "Check Mirage Status",
    Callback = function()
        local map = Workspace:FindFirstChild("Map")
        local mirage = map and (map:FindFirstChild("MysticIsland") or map:FindFirstChild("Mirage Island"))
        Window:Notify({
            Title = "Sea Events",
            Description = mirage and "Mirage Island found." or "Mirage Island not found.",
            Duration = 3
        })
    end
})

seaCombatGroup:AddToggle({
    Name = "Attack Sea Mobs",
    Default = false,
    Callback = function(value)
        state.sea.attackMobs = value
        if not value and not state.sea.attackSeaBeasts then
            setSeaSkillAim(false)
        end
    end
})

seaCombatGroup:AddToggle({
    Name = "Attack Sharks / Piranhas",
    Default = true,
    Callback = function(value)
        state.sea.attackSharks = value
    end
})

seaCombatGroup:AddToggle({
    Name = "Attack Fish Crew / Fisherman",
    Default = true,
    Callback = function(value)
        state.sea.attackFishCrew = value
    end
})

seaCombatGroup:AddToggle({
    Name = "Attack Pirate Ships",
    Default = true,
    Callback = function(value)
        state.sea.attackPirateShips = value
    end
})

seaCombatGroup:AddToggle({
    Name = "Attack Sea Beast",
    Default = false,
    Callback = function(value)
        state.sea.attackSeaBeasts = value
        if not value and not state.sea.attackMobs then
            setSeaSkillAim(false)
        end
    end
})

seaCombatGroup:AddToggle({
    Name = "Destroy Nearest Rock",
    Default = false,
    Callback = function(value)
        state.sea.destroyRocks = value
    end
})

seaCombatGroup:AddToggle({
    Name = "Auto Pirate Raid",
    Default = false,
    Callback = function(value)
        state.autoPirateRaid = value
        if not value then
            state.autoPirateRaidBusy = false
            StartBring = false
            stopTeleport()
        end
    end
})

seaPrehistoricGroup:AddToggle({
    Name = "Auto Defend Prehistoric",
    Default = false,
    Callback = function(value)
        state.sea.autoDefendVolcano = value
    end
})

seaPrehistoricGroup:AddToggle({
    Name = "Volcano Use Melee",
    Default = false,
    Callback = function(value)
        state.sea.volcanoUseMelee = value
    end
})

seaPrehistoricGroup:AddToggle({
    Name = "Volcano Use Sword",
    Default = false,
    Callback = function(value)
        state.sea.volcanoUseSword = value
    end
})

seaPrehistoricGroup:AddToggle({
    Name = "Volcano Use Gun",
    Default = false,
    Callback = function(value)
        state.sea.volcanoUseGun = value
    end
})

seaCombatGroup:AddButton({
    Name = "Teleport To Sea Beast",
    Callback = function()
        local seaBeast = getNearestSeaBeast()
        local targetPart = seaBeast and seaBeast:FindFirstChild("HumanoidRootPart")
        if targetPart then
            TP1(targetPart.CFrame * CFrame.new(0, 100, 0))
        else
            Window:Notify({
                Title = "Sea Events",
                Description = "No Sea Beast found.",
                Duration = 3
            })
        end
    end
})

seaCombatGroup:AddButton({
    Name = "Reset Nearby Sea Enemies",
    Callback = function()
        local hrp = getHumanoidRootPart()
        local enemies = Workspace:FindFirstChild("Enemies")
        if not hrp or not enemies then
            return
        end

        for _, enemy in ipairs(enemies:GetChildren()) do
            local targetPart = getSeaEnemyTargetPart(enemy)
            if targetPart and (targetPart.Position - hrp.Position).Magnitude <= 80 then
                enemy:Destroy()
            end
        end
    end
})

prehistoricStatusLabel = seaPrehistoricGroups:AddLabel({
    Text = "Prehistoric Status: --"
})
seaPrehistoricGroups:AddToggle({
    Name = "Prehistoric Notification",
    Default = false,
    Callback = function(value)
        state.prehistoricNotifications = value
    end
})
seaBoatGroup:AddDropdown({
    Name = "Sea Weapon",
    Options = seaWeaponOptions,
    Default = state.sea.weaponType == "Blox Fruit" and "Devil Fruit" or state.sea.weaponType,
    Callback = function(value)
        state.sea.weaponType = value
    end
})

seaBoatGroup:AddSlider({
    Name = "Sea Farm Distance",
    Min = 10,
    Max = 120,
    Default = state.sea.attackDistance,
    Decimals = 0,
    ValueName = " studs",
    Callback = function(value)
        state.sea.attackDistance = math.floor(value)
    end
})

seaBoatGroup:AddSlider({
    Name = "Boat Tween Speed",
    Min = 50,
    Max = 800,
    Default = state.sea.boatTweenSpeed,
    Decimals = 0,
    ValueName = " speed",
    Callback = function(value)
        state.sea.boatTweenSpeed = math.max(math.floor(value), 1)
    end
})

seaBoatGroup:AddSlider({
    Name = "Boat Speed Hack",
    Min = 50,
    Max = 400,
    Default = state.sea.boatSpeed,
    Decimals = 0,
    ValueName = " speed",
    Callback = function(value)
        state.sea.boatSpeed = math.max(math.floor(value), 1)
    end
})

seaBoatGroup:AddToggle({
    Name = "Auto W",
    Default = false,
    Callback = function(value)
        state.sea.autoPressW = value
    end
})

seaSkillGroup:AddToggle({
    Name = "Sea Skill Z",
    Default = true,
    Callback = function(value)
        state.sea.skillZ = value
    end
})

seaSkillGroup:AddToggle({
    Name = "Sea Skill X",
    Default = true,
    Callback = function(value)
        state.sea.skillX = value
    end
})

seaSkillGroup:AddToggle({
    Name = "Sea Skill C",
    Default = false,
    Callback = function(value)
        state.sea.skillC = value
    end
})

seaSkillGroup:AddToggle({
    Name = "Sea Skill V",
    Default = false,
    Callback = function(value)
        state.sea.skillV = value
    end
})

seaSkillGroup:AddToggle({
    Name = "Sea Skill F",
    Default = false,
    Callback = function(value)
        state.sea.skillF = value
    end
})

espGroup:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(value)
        state.espPlayers = value
        if not value then
            clearEspTag(espTags.PlayerTag)
            clearEspTag(espTags.PlayerHighlight)
        end
    end
})

espGroup:AddToggle({
    Name = "Chest ESP",
    Default = false,
    Callback = function(value)
        state.espChests = value
        if not value then
            clearTrackedChestESP()
        end
    end
})

espGroup:AddToggle({
    Name = "Fruit ESP",
    Default = false,
    Callback = function(value)
        state.espFruits = value
        if not value then
            clearRenderedEspSet(fruitEspRendered, espTags.FruitTag)
            clearEspTag(espTags.FruitTag)
        end
    end
})

espGroup:AddToggle({
    Name = "Flower ESP",
    Default = false,
    Callback = function(value)
        state.espFlowers = value
        if not value then
            clearRenderedEspSet(flowerEspRendered, espTags.FlowerTag)
            clearEspTag(espTags.FlowerTag)
        end
    end
})



infoGroup:AddToggle({
    Name = "Special Island ESP",
    Default = false,
    Callback = function(value)
        state.espSpecialIslands = value
        if not value then
            clearRenderedEspSet(specialIslandEspRendered, espTags.SpecialIslandTag)
            clearEspTag(espTags.SpecialIslandTag)
        end
    end
})

settingsGroup:AddButton({
    Name = "Stop Movement",
    Callback = function()
        stopTeleport()
    end
})

settingsGroup:AddButton({
    Name = "Unload UI",
    Callback = function()
        stopZyphraxBloxFruitHub(true)
    end
})

automationSettingsGroup:AddToggle({
    Name = "Auto Haki",
    Default = true,
    Callback = function(value)
        _G.AutoHaki = value
    end
})

automationSettingsGroup:AddToggle({
    Name = "Auto Observation Haki",
    Default = false,
    Callback = function(value)
        state.autoObservationHaki = value
    end
})

automationSettingsGroup:AddToggle({
    Name = "Auto Enable PvP",
    Default = false,
    Callback = function(value)
        state.autoEnablePvP = value
    end
})

automationSettingsGroup:AddToggle({
    Name = "Fast Attack",
    Default = true,
    Callback = function(value)
        state.fastAttack = value
    end
})

automationSettingsGroup:AddSlider({
    Name = "Fast Attack Delay",
    Min = 0.01,
    Max = 1,
    Default = state.fastAttackDelay,
    Increment = 0.01,
    ValueName = " sec",
    Callback = function(value)
        state.fastAttackDelay = math.clamp(tonumber(value) or FAST_ATTACK_INTERVAL, 0.01, 0.25)
    end
})

fruitNotifyStatusLabel = fruitAutomationGroup:AddLabel({
    Text = "Fruit Notify: Enabled"
})

fruitAutomationGroup:AddToggle({
    Name = "Auto Notify Fruit Spawn",
    Default = true,
    Callback = function(value)
        state.fruitNotifications = value
    end
})



fruitAutomationGroup:AddToggle({
    Name = "Auto Tween To Fruit",
    Default = false,
    Callback = function(value)
        state.autoTweenFruit = value
        if not value then
            state.autoTweenFruitHop = false
            stopTeleport()
        end
    end
})

fruitAutomationGroup:AddToggle({
    Name = "Auto Tween To Fruit ServerHop",
    Default = false,
    Callback = function(value)
        state.autoTweenFruitHop = value
        if value then
            state.autoTweenFruit = true
        end
    end
})



weaponSettingsGroup:AddDropdown({
    Name = "Auto Equip Weapon",
    Options = getWeaponOptions(),
    Default = state.selectedWeapon or "Auto Detect",
    Callback = function(value)
        state.selectedWeapon = value
    end
})

weaponSettingsGroup:AddToggle({
    Name = "Auto Equip Tool",
    Default = true,
    Callback = function(value)
        state.autoEquipTool = value
        if not value then
            clearCombatEquipRequest()
        end
    end
})

weaponSettingsGroup:AddDropdown({
    Name = "Tool To Farm",
    Options = {"Melee", "Sword", "Gun", "Devil Fruit"},
    Default = state.weaponType == "Blox Fruit" and "Devil Fruit" or state.weaponType,
    Callback = function(value)
        state.weaponType = normalizeWeaponType(value)
    end
})

positionSettingsGroup:AddDropdown({
    Name = "Farm Method",
    Options = positionMethodOptions,
    Default = state.positionMethod,
    Callback = function(value)
        state.positionMethod = value
    end
})

positionSettingsGroup:AddSlider({
    Name = "Position X",
    Min = -50,
    Max = 50,
    Default = state.positionOffsetX,
    Decimals = 0,
    ValueName = " studs",
    Callback = function(value)
        state.positionOffsetX = math.floor(value)
    end
})

positionSettingsGroup:AddSlider({
    Name = "Position Y",
    Min = -50,
    Max = 50,
    Default = state.positionOffsetY,
    Decimals = 0,
    ValueName = " studs",
    Callback = function(value)
        state.positionOffsetY = math.floor(value)
    end
})

positionSettingsGroup:AddSlider({
    Name = "Position Z",
    Min = -50,
    Max = 50,
    Default = state.positionOffsetZ,
    Decimals = 0,
    ValueName = " studs",
    Callback = function(value)
        state.positionOffsetZ = math.floor(value)
    end
})

raceSettingsGroup:AddToggle({
    Name = "Auto Active Race V3",
    Default = false,
    Callback = function(value)
        _G.AutoActiveRaceV3 = value
    end
})

raceSettingsGroup:AddToggle({
    Name = "Auto Active Race V4",
    Default = false,
    Callback = function(value)
        _G.AutoActiveRaceV4 = value
    end
})

berryStatusLabel = berryGroup:AddLabel({
    Text = "Nearest Berry: --"
})

berryGroup:AddToggle({
    Name = "Berry ESP",
    Default = false,
    Callback = function(value)
        state.espBerries = value
        if not value then
            clearRenderedEspSet(berryEspRendered, espTags.BerryTag)
            clearEspTag(espTags.BerryTag)
        end
    end
})

berryGroup:AddToggle({
    Name = "Auto Farm Berry",
    Default = false,
    Callback = function(value)
        state.autoBerry = value
        if not value then
            stopTeleport()
        end
    end
})

berryGroup:AddToggle({
    Name = "Berry Hop",
    Default = false,
    Callback = function(value)
        state.autoBerryHop = value
    end
})

berryGroup:AddButton({
    Name = "Clear Berry ESP",
    Callback = function()
        clearRenderedEspSet(berryEspRendered, espTags.BerryTag)
        clearEspTag(espTags.BerryTag)
    end
})

eliteHunterProgressLabel = eliteHunterGroup:AddLabel({
    Text = "Elite Hunter Progress: --"
})

eliteHunterGroup:AddToggle({
    Name = "Auto Elite Hunter",
    Default = false,
    Callback = function(value)
        state.autoEliteHunter = value
        if not value then
            stopTeleport()
        end
    end
})

eliteHunterGroup:AddToggle({
    Name = "Elite Hunter Hop",
    Default = false,
    Callback = function(value)
        state.autoEliteHop = value
    end
})

eliteHunterGroup:AddToggle({
    Name = "Stop On God's Chalice",
    Default = false,
    Callback = function(value)
        state.stopEliteOnChalice = value
    end
})

factoryRaidGroup:AddToggle({
    Name = "Auto Factory Raid",
    Default = false,
    Callback = function(value)
        state.autoFactoryRaid = value
        if not value then
            stopTeleport()
        end
    end
})

observationStatusLabel = observationGroup:AddLabel({
    Text = "Observation Level: --"
})

observationGroup:AddToggle({
    Name = "Auto Observation",
    Default = false,
    Callback = function(value)
        state.quests.autoObservation = value
        if not value then
            stopTeleport()
        end
    end
})

observationGroup:AddToggle({
    Name = "Observation Hop",
    Default = false,
    Callback = function(value)
        state.quests.autoObservationHop = value
    end
})

observationGroup:AddToggle({
    Name = "Auto Observation Haki",
    Default = false,
    Callback = function(value)
        state.autoObservationHaki = value
    end
})

observationGroup:AddButton({
    Name = "Refresh Observation Level",
    Callback = function()
        if not isObservationImageVisible() then
            toggleObservation()
        end
    end
})

dojoQuestStatusLabel = dojoGroup:AddLabel({
    Text = "Dojo Quest: --"
})
state.ui.dragon.dojoQuestLabel = dojoQuestStatusLabel

blazeQuestStatusLabel = dojoGroup:AddLabel({
    Text = "Dragon Hunter: --"
})
state.ui.dragon.hunterLabel = blazeQuestStatusLabel

dracoRaceStatusLabel = dojoGroup:AddLabel({
    Text = "Draco: --"
})
state.ui.dragon.dracoLabel = dracoRaceStatusLabel

state.ui.dragon.beltInfoLabel = dojoGroup:AddLabel({
    Text = "Belt: --"
})

dojoGroup:AddToggle({
    Name = "Auto Dojo Trainer Quest",
    Default = false,
    Callback = function(value)
        state.dragon.autoDojoTrainer = value
        state.autoDojoTrainer = value
        if not value then
            stopTeleport()
        end
        syncLegacyDragonFlags()
    end
})

dojoGroup:AddToggle({
    Name = "Auto Dragon Hunter Quest",
    Default = false,
    Callback = function(value)
        state.dragon.autoDragonHunter = value
        state.autoBlazeEmbers = value
        if not value then
            stopTeleport()
        end
        syncLegacyDragonFlags()
    end
})

dojoGroup:AddToggle({
    Name = "Auto Draco V2 & V3",
    Default = false,
    Callback = function(value)
        state.dragon.autoDracoV2V3 = value
        if not value then
            stopTeleport()
        end
        syncLegacyDragonFlags()
    end
})

craftStatusLabel = dojoCraftGroup:AddLabel({
    Text = "Craft: --"
})
state.ui.craft.statusLabel = craftStatusLabel

dojoCraftGroup:AddToggle({
    Name = "Auto Craft Volcanic Magnet",
    Default = false,
    Callback = function(value)
        state.craft.autoCraftVolcanicMagnet = value
    end
})

dojoCraftGroup:AddToggle({
    Name = "Auto Collect Dragon Egg",
    Default = false,
    Callback = function(value)
        state.craft.autoCollectDragonEgg = value
    end
})

state.craft.auraOptions = getAuraColorOptions()
state.craft.selectedAura = state.craft.selectedAura or state.craft.auraOptions[1]

dojoCraftGroup:AddDropdown({
    Name = "Select Aura",
    Options = #state.craft.auraOptions > 0 and state.craft.auraOptions or {"No Aura Data"},
    Default = (#state.craft.auraOptions > 0 and state.craft.selectedAura) or "No Aura Data",
    Callback = function(value)
        if value ~= "No Aura Data" then
            state.craft.selectedAura = value
        end
    end
})

dojoCraftGroup:AddToggle({
    Name = "Auto Craft Aura Color",
    Default = false,
    Callback = function(value)
        state.craft.autoAuraColor = value
    end
})

dojoCraftGroup:AddToggle({
    Name = "Auto Craft Hop",
    Default = false,
    Callback = function(value)
        state.craft.autoCraftHop = value
    end
})

dojoCraftGroup:AddToggle({
    Name = "Auto Barista Cousin",
    Default = false,
    Callback = function(value)
        state.craft.autoBaristaCousin = value
    end
})

dojoCraftGroup:AddButton({
    Name = "Craft Dragon Storm",
    Callback = function()
        CommF:InvokeServer("CraftItem", "Check", "Dragonstorm")
        CommF:InvokeServer("CraftItem", "Craft", "Dragonstorm")
    end
})

dojoCraftGroup:AddButton({
    Name = "Craft Dragon Heart",
    Callback = function()
        CommF:InvokeServer("CraftItem", "Check", "Dragonheart")
        CommF:InvokeServer("CraftItem", "Craft", "Dragonheart")
    end
})

mirageStatusLabel = mirageGroup:AddLabel({
    Text = "Mirage Status: --"
})



mirageGroup:AddToggle({
    Name = "Mirage Notification",
    Default = false,
    Callback = function(value)
        state.mirageNotifications = value
    end
})



mirageGroup:AddToggle({
    Name = "Teleport To Mirage",
    Default = false,
    Callback = function(value)
        state.autoMirageTeleport = value
        if not value then
            stopTeleport()
        end
    end
})

mirageGroup:AddToggle({
    Name = "Auto Mirage Route [Sea 4-5]",
    Default = false,
    Callback = function(value)
        state.sea.autoMirageSail = value
        state.sea.mirageRouteIndex = 4
        if value then
            state.autoMirageTeleport = true
            state.sea.autoSail = true
        elseif not state.sea.autoEvents then
            state.autoMirageTeleport = false
            state.sea.autoSail = false
            stopSeaBoatTween()
            clearSeaBoatSpeedHack()
        end
    end
})

mirageGroup:AddToggle({
    Name = "Fly To Blue Gear",
    Default = false,
    Callback = function(value)
        state.autoMirageGear = value
        if not value then
            stopTeleport()
        end
    end
})

mirageGroup:AddToggle({
    Name = "Fly To Advanced Fruit Dealer",
    Default = false,
    Callback = function(value)
        state.autoAdvancedFruitDealer = value
        if not value then
            stopTeleport()
        end
    end
})

kitsuneStatusLabel = kitsuneGroup:AddLabel({
    Text = "Kitsune Status: --"
})

kitsuneGroup:AddToggle({
    Name = "Kitsune Notification",
    Default = false,
    Callback = function(value)
        state.kitsuneNotifications = value
    end
})

kitsuneGroup:AddToggle({
    Name = "Auto Find Kitsune Island",
    Default = false,
    Callback = function(value)
        state.autoKitsuneIsland = value
        if value then
            state.sea.seaLevel = "Level 6"
            state.sea.autoSail = true
        elseif not state.sea.autoEvents and not state.sea.autoMirageSail then
            state.sea.autoSail = false
            stopSeaBoatTween()
        end
    end
})

kitsuneGroup:AddToggle({
    Name = "Collect Azure Ember",
    Default = false,
    Callback = function(value)
        state.autoCollectAzureEmber = value
        if not value then
            stopTeleport()
        end
    end
})

kitsuneGroup:AddToggle({
    Name = "Auto Trade Azure Ember",
    Default = false,
    Callback = function(value)
        state.craft.autoTradeAzureEmber = value
        state.autoKitsunePray = value
        syncLegacyDragonFlags()
    end
})

kitsuneGroup:AddSlider({
    Name = "Trade Azure Ember Amount",
    Min = 10,
    Max = 25,
    Default = state.craft.azureTradeAmount,
    Decimals = 0,
    ValueName = " embers",
    Callback = function(value)
        state.craft.azureTradeAmount = math.floor(value)
    end
})

kitsuneGroup:AddButton({
    Name = "Pray At Shrine",
    Callback = function()
        runAutoKitsunePray()
    end
})

raceInfoLabels.race = raceGroup:AddLabel({
    Text = "Race: --"
})

raceInfoLabels.rerolls = raceGroup:AddLabel({
    Text = "Race Rerolls: --"
})

raceV2StatusLabel = raceGroup:AddLabel({
    Text = "Race V2: --"
})
state.ui.raceQuest.v2Label = raceV2StatusLabel

raceV3StatusLabel = raceGroup:AddLabel({
    Text = "Race V3: --"
})
state.ui.raceQuest.v3Label = raceV3StatusLabel

raceGroup:AddToggle({
    Name = "Auto Race V2",
    Default = false,
    Callback = function(value)
        state.raceQuest.autoV2 = value
        if not value then
            stopTeleport()
        end
    end
})

raceGroup:AddToggle({
    Name = "Auto Race V3",
    Default = false,
    Callback = function(value)
        state.raceQuest.autoV3 = value
        if not value then
            stopTeleport()
        end
    end
})

raceGroup:AddToggle({
    Name = "Auto Active Race V3",
    Default = false,
    Callback = function(value)
        _G.AutoActiveRaceV3 = value
    end
})

raceGroup:AddToggle({
    Name = "Auto Active Race V4",
    Default = false,
    Callback = function(value)
        _G.AutoActiveRaceV4 = value
    end
})

v4TrialGroup:AddButton({
    Name = "Tween To Tree Top",
    Callback = function()
        tweenToV4TreeTop()
    end
})

v4TrialGroup:AddButton({
    Name = "Tween To Temple Of Time",
    Callback = function()
        tweenToV4Temple()
    end
})

v4TrialGroup:AddButton({
    Name = "Tween To Lever",
    Callback = function()
        tweenToV4Lever()
    end
})

v4TrialGroup:AddButton({
    Name = "Fly To Buy Gear",
    Callback = function()
        tweenToV4BuyGear()
    end
})

v4TrialGroup:AddButton({
    Name = "Tween To Race Door",
    Callback = function()
        tweenToV4RaceDoor()
    end
})

v4TrialGroup:AddToggle({
    Name = "Auto Lever",
    Default = false,
    Callback = function(value)
        state.v4Trial.autoLever = value
        if value then
            state.v4Trial.autoRaceDoor = false
        end
        if not value then
            stopTeleport()
        end
    end
})

v4TrialGroup:AddToggle({
    Name = "Auto Race Door",
    Default = false,
    Callback = function(value)
        state.v4Trial.autoRaceDoor = value
        if value then
            state.v4Trial.autoLever = false
        end
        if not value then
            stopTeleport()
        end
    end
})

v4TrialGroup:AddToggle({
    Name = "Complete Trial [Human/Ghoul]",
    Default = false,
    Callback = function(value)
        state.v4Trial.autoHumanGhoulTrial = value
        if not value then
            stopTeleport()
        end
    end
})

v4TrialGroup:AddToggle({
    Name = "Complete Trial",
    Default = false,
    Callback = function(value)
        state.v4Trial.autoCompleteTrial = value
        if not value then
            stopTeleport()
        end
    end
})

v4TrialGroup:AddToggle({
    Name = "Auto Kill Player In Trial",
    Default = false,
    Callback = function(value)
        state.v4Trial.autoKillTrialPlayer = value
        if not value then
            stopTeleport()
        end
    end
})

v4TrialGroup:AddButton({
    Name = "Buy V4 Gear",
    Callback = function()
        CommF:InvokeServer("UpgradeRace", "Buy")
    end
})

raceInfoLabels.statRefunds = statsInfoGroup:AddLabel({
    Text = "Stat Refunds: --"
})

raceInfoLabels.fruitCap = statsInfoGroup:AddLabel({
    Text = "Fruit Cap: --"
})

raceInfoLabels.points = statsInfoGroup:AddLabel({
    Text = "Available Points: --"
})

raceInfoLabels.melee = statsInfoGroup:AddLabel({
    Text = "Melee: --"
})

raceInfoLabels.defense = statsInfoGroup:AddLabel({
    Text = "Defense: --"
})

raceInfoLabels.sword = statsInfoGroup:AddLabel({
    Text = "Sword: --"
})

raceInfoLabels.gun = statsInfoGroup:AddLabel({
    Text = "Gun: --"
})

raceInfoLabels.fruit = statsInfoGroup:AddLabel({
    Text = "Blox Fruit: --"
})

task.spawn(function()
    while state.running do
        pcall(function()
            saveZyphraxConfig(false)
        end)
        task.wait(6)
    end
end)

if zyphraxConfigLoaded then
    notifyZyphrax("Config", "Loaded saved settings and enabled autosave.", 3)
end

Window:Notify({
    Title = "Zyphrax Hub | Blox Fruits",
    Description = "Loaded farming, sea events, shop tabs, teleport, ESP, and settings.",
    Duration = 4
})
