--[[══════════════════════════════════════════════════════════════════════════════════════════
  ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗    ███████╗██╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗
  ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝    ██╔════╝██║   ██║██╔════╝██║██╔═══██╗████╗  ██║
  ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗    █████╗  ██║   ██║███████╗██║██║   ██║██╔██╗ ██║
  ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║    ██╔══╝  ██║   ██║╚════██║██║██║   ██║██║╚██╗██║
  ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║    ██║     ╚██████╔╝███████║██║╚██████╔╝██║ ╚████║
  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
══════════════════════════════════════════════════════════════════════════════════════════
  NEXUS OMEGA ULTIMATE v8
  Blox Fruits — Script Fusionné Ultime
  Compatible: Delta Executor | Mise à jour: Juin 2026
══════════════════════════════════════════════════════════════════════════════════════════
  [📋] Auto Farm Intelligent | Auto Quest | Auto Boss | Auto Mastery
  [🌊] Sea Beast | Terror Shark | Leviathan | Prehistoric | Frozen | Mirage
  [🍎] Fruit Sniper | Fruit Collector | Fruit Purchase | Fruit Storage
  [⚔️] Yama | Tushita | TTK | CDK | Soul Guitar | Skull Guitar
  [🏎️] Race V4 | Auto Raid | Auto Dungeon | Auto Factory
  [🛡️] Haki Auto | Stats Auto | Combat Auto | Anti-Ban Max
  [📡] ESP | Teleport | Server Hop | Full Moon | Farm de Nuit
══════════════════════════════════════════════════════════════════════════════════════════
]]

-- SECTION 1: CONFIGURATION GLOBALE
getgenv().Omega = getgenv().Omega or {}
local O = getgenv().Omega

O.Version = "8.0.0"
O.Config = {
    AutoFarm = true,
    AutoQuest = true,
    AutoBoss = true,
    AutoMastery = true,
    AutoChest = true,
    AutoBones = true,
    AutoEctoplasm = true,
    AutoFragment = true,
    AutoSeaEvent = true,
    AutoSeaBeast = true,
    AutoTerrorShark = true,
    AutoLeviathan = true,
    AutoPrehistoric = true,
    AutoFrozen = true,
    AutoMirage = true,
    AutoRaceV4 = true,
    AutoYama = true,
    AutoTushita = true,
    AutoTTK = true,
    AutoCDK = true,
    AutoSoulGuitar = true,
    AutoSkullGuitar = true,
    AutoDarkDagger = true,
    AutoHallowScythe = true,
    AutoCanvander = true,
    AutoGravityCane = true,
    AutoPoleV2 = true,
    AutoRaid = true,
    AutoDungeon = true,
    AutoFactory = true,
    AutoFruitSniper = true,
    AutoFruitCollect = true,
    AutoFruitPurchase = true,
    AutoFruitStorage = true,
    AutoHaki = true,
    AutoBusoHaki = true,
    AutoKenHaki = true,
    AutoObservation = true,
    AutoStats = true,
    StatsPoints = {"Melee", "Defense", "Sword"},
    FastAttack = true,
    AutoSkillSpam = true,
    InstantTeleport = true,
    AutoServerHop = true,
    ServerHopForMirage = true,
    ServerHopForFullMoon = true,
    ServerHopForLeviathan = true,
    AntiBan = true,
    AntiAfk = true,
    RandomMovement = true,
    ESP = true,
    ESPFruits = true,
    ESPPlayers = true,
    ESPEnemies = true,
    ESPChests = true,
    ESPBosses = true,
    ESPSeaEvents = true,
    DebugMode = false,
    PriorityFruits = {"Dough","Venom","Dragon","Leopard","Kitsune","Yeti","gaz","Spirit","Soul","Buddha, Phoenix","Rumble","Light","Dark,","Control","Quake","Love","creation","Diamond"},
    SeaEventPriority = "Leviathan",
}

-- SECTION 2: SERVICES
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer
local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")

O.Services = {Players = Players, Workspace = Workspace, ReplicatedStorage = ReplicatedStorage, VirtualUser = VirtualUser, VirtualInputManager = VirtualInputManager, TweenService = TweenService, HttpService = HttpService}
O.LP = LP
O.CommF = CommF

O.State = {IsLoaded = false, CurrentLevel = 0, CurrentSea = "Unknown", CurrentIsland = "Unknown", CurrentRace = "Human", CurrentFruit = "None", IsDead = false, IsFullMoon = false, IsMirageActive = false, TotalKills = 0, TotalChestsOpened = 0, TotalFruitsCollected = 0, TotalSeaEventsKilled = 0, TotalBossesKilled = 0, TotalRaidsCompleted = 0, StartTime = tick()}

-- SECTION 3: ATTENTE CHARGEMENT
repeat task.wait() until game:IsLoaded() and Players.LocalPlayer and Players.LocalPlayer.Character
LP = Players.LocalPlayer
local Char = LP.Character
local HRP = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChildOfClass("Humanoid")
O.Char = Char
O.HRP = HRP
O.Hum = Hum
O.State.IsLoaded = true

-- ANTI AFK
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- SECTION 4: FONCTIONS UTILES
function O:Remote(...)
    local comm = self.CommF or CommF
    if comm then
        local s, e = pcall(function() return comm:InvokeServer(...) end)
        return s and e
    end
end

function O:TP(pos)
    if not HRP then return end
    if typeof(pos) == "CFrame" then pos = pos.Position end
    if self.Config.InstantTeleport then
        HRP.CFrame = CFrame.new(pos)
    else
        TweenService:Create(HRP, TweenInfo.new((HRP.Position - pos).Magnitude / 300), {CFrame = CFrame.new(pos)}):Play()
    end
end

function O:Distance(a, b)
    if typeof(a) == "CFrame" then a = a.Position end
    if typeof(b) == "CFrame" then b = b.Position end
    return (a - b).Magnitude
end

function O:GetLevel()
    local lv = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Level")
    if lv then self.State.CurrentLevel = lv.Value return lv.Value end
    local s = LP:FindFirstChild("PlayerStats") or LP:FindFirstChild("Stats")
    if s then local l = s:FindFirstChild("Level") if l then self.State.CurrentLevel = l.Value return l.Value end end
    return 0
end

function O:GetSea()
    local lv = self:GetLevel()
    if lv < 700 then return "First Sea" elseif lv < 1500 then return "Second Sea" else return "Third Sea" end
end

function O:GetBounty()
    local b = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Bounty")
    return b and b.Value or 0
end

function O:GetFragments()
    local f = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Fragments")
    return f and f.Value or 0
end

function O:GetBones()
    local gui = LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("Main")
    local b = gui and gui:FindFirstChild("Bones")
    return b and b.Value or 0
end

function O:IsDead()
    if Hum then self.State.IsDead = Hum.Health <= 0 return Hum.Health <= 0 end
    return true
end

function O:HasQuest()
    local gui = LP:FindFirstChild("PlayerGui")
    if gui then
        local q = gui:FindFirstChild("QuestGui")
        if q then local t = q:FindFirstChild("Title") if t and t.Text ~= "" then return true, t.Text end end
    end
    return false, ""
end

function O:FindEnemy(radius)
    if not HRP then return nil, math.huge end
    local nearest, nearDist = nil, radius
    for _, v in Workspace:GetDescendants() do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local hum = v.Humanoid
            if hum and hum.Health > 0 and v ~= Char then
                local isEnemy = v:FindFirstChild("Enemy") or v:FindFirstChild("Target") or v.Name:find("Boss") or v.Name:find("Mob") or v.Name:find("NPC") or v.Name:find("Shark") or v.Name:find("Beast") or v.Name:find("Bandit") or v.Name:find("Monkey") or v.Name:find("Gorilla") or v.Name:find("Snow") or v.Name:find("Fishman") or v.Name:find("Squad") or v.Name:find("Millionaire") or v.Name:find("Billionaire") or v.Name:find("Terror") or v.Name:find("Levia") or v.Name:find("Soldier") or v.Name:find("Pirate") or v.Name:find("Marine") or v.Name:find("Trainer") or v.Name:find("Trainee")
                if isEnemy then
                    local dist = self:Distance(v.HumanoidRootPart.Position, HRP.Position)
                    if dist < nearDist then nearest, nearDist = v, dist end
                end
            end
        end
    end
    return nearest, nearDist
end

function O:FindByName(pat)
    local r = {}
    for _, v in Workspace:GetDescendants() do if v.Name:find(pat) then table.insert(r, v) end end
    return r
end

function O:FindFruits()
    local fruits = {}
    for _, v in Workspace:GetDescendants() do
        if (v.Name:find("Fruit") or v.Name:find("fruit")) and v:IsA("Tool") and v:FindFirstChild("Handle") then
            table.insert(fruits, v)
        end
    end
    return fruits
end

function O:FindChests()
    local chests = {}
    for _, v in Workspace:GetDescendants() do
        if (v.Name:find("Chest") or v.Name:find("chest")) and v:IsA("BasePart") then table.insert(chests, v) end
    end
    return chests
end

function O:Attack()
    if not self.Config.FastAttack then return end
    local tool = Char:FindFirstChildOfClass("Tool")
    if tool then
        local click = tool:FindFirstChild("ClickRemote") or tool:FindFirstChild("Remote")
        if click then for i = 1, 3 do click:FireServer() end end
    end
    VirtualUser:Button1Down(Vector2.new(0,0))
    task.wait(0.01)
    VirtualUser:Button1Up(Vector2.new(0,0))
end

function O:UseSkill(key)
    local vim = self.Services and self.Services.VirtualInputManager
    if not vim then return end
    local map = {Z = Enum.KeyCode.Z, X = Enum.KeyCode.X, C = Enum.KeyCode.C, V = Enum.KeyCode.V, F = Enum.KeyCode.F}
    local code = map[key:upper()]
    if code then
        pcall(function()
            vim:SendKeyEvent(true, code, false, nil)
            task.wait(0.05)
            vim:SendKeyEvent(false, code, false, nil)
        end)
    end
end

function O:SpamSkills()
    if not self.Config.AutoSkillSpam then return end
    for _, k in pairs({"Z", "X", "C", "V"}) do
        self:UseSkill(k)
        task.wait(0.3)
    end
end

function O:SafeDelay(sec)
    local v = sec * 0.2
    task.wait(sec + math.random(-v * 1000, v * 1000) / 1000)
end

-- SECTION 5: ISLANDS DATABASE COMPLETE
O.Islands = {
    -- First Sea
    StarterPirate = {Sea = 1, LevelMin = 0, LevelMax = 10, Pos = Vector3.new(-1232, 15, 3950)},
    StarterMarine = {Sea = 1, LevelMin = 0, LevelMax = 10, Pos = Vector3.new(-2655, 15, 3550)},
    Jungle = {Sea = 1, LevelMin = 10, LevelMax = 30, Pos = Vector3.new(-1550, 18, 3750)},
    PirateVillage = {Sea = 1, LevelMin = 30, LevelMax = 60, Pos = Vector3.new(-1180, 5, 3850)},
    MarineFortress = {Sea = 1, LevelMin = 60, LevelMax = 90, Pos = Vector3.new(-4620, 20, 4150)},
    FrozenVillage = {Sea = 1, LevelMin = 90, LevelMax = 120, Pos = Vector3.new(1140, 10, 3850)},
    MiddleTown = {Sea = 1, LevelMin = 100, LevelMax = 130, Pos = Vector3.new(-700, 20, 4150)},
    Skylands1 = {Sea = 1, LevelMin = 130, LevelMax = 160, Pos = Vector3.new(-4850, 900, 4350)},
    Skylands2 = {Sea = 1, LevelMin = 160, LevelMax = 190, Pos = Vector3.new(-5000, 900, 4400)},
    Skylands3 = {Sea = 1, LevelMin = 190, LevelMax = 220, Pos = Vector3.new(-5150, 900, 4450)},
    Prison = {Sea = 1, LevelMin = 190, LevelMax = 220, Pos = Vector3.new(4850, 10, 4150)},
    Colosseum = {Sea = 1, LevelMin = 220, LevelMax = 275, Pos = Vector3.new(-1600, 50, 3750)},
    MagmaVillage = {Sea = 1, LevelMin = 275, LevelMax = 325, Pos = Vector3.new(-5200, 50, 3950)},
    UnderwaterCity = {Sea = 1, LevelMin = 325, LevelMax = 375, Pos = Vector3.new(3450, 5, 3950)},
    FountainCity = {Sea = 1, LevelMin = 375, LevelMax = 450, Pos = Vector3.new(5000, 15, 4200)},
    UpperSkylands = {Sea = 1, LevelMin = 450, LevelMax = 525, Pos = Vector3.new(-5300, 1100, 4600)},
    ShanksRoom = {Sea = 1, LevelMin = 525, LevelMax = 625, Pos = Vector3.new(-12300, 15, 4150)},
    CastleSea1 = {Sea = 1, LevelMin = 625, LevelMax = 700, Pos = Vector3.new(-5500, 20, 4800)},
    -- Second Sea
    KingdomRose = {Sea = 2, LevelMin = 700, LevelMax = 775, Pos = Vector3.new(-75, 25, 8500)},
    Cafe = {Sea = 2, LevelMin = 700, LevelMax = 700, Pos = Vector3.new(55, 25, 8620)},
    DarkArena = {Sea = 2, LevelMin = 775, LevelMax = 850, Pos = Vector3.new(200, 25, 8700)},
    Mansion2 = {Sea = 2, LevelMin = 850, LevelMax = 925, Pos = Vector3.new(-285, 25, 8900)},
    Factory = {Sea = 2, LevelMin = 925, LevelMax = 1000, Pos = Vector3.new(400, 25, 8650)},
    GreenZone = {Sea = 2, LevelMin = 950, LevelMax = 1000, Pos = Vector3.new(-520, 25, 8720)},
    Graveyard = {Sea = 2, LevelMin = 1000, LevelMax = 1100, Pos = Vector3.new(-550, 25, 8850)},
    SnowMountain = {Sea = 2, LevelMin = 1100, LevelMax = 1200, Pos = Vector3.new(680, 85, 8750)},
    HotCold = {Sea = 2, LevelMin = 1200, LevelMax = 1300, Pos = Vector3.new(750, 25, 8900)},
    IceCastle = {Sea = 2, LevelMin = 1300, LevelMax = 1400, Pos = Vector3.new(800, 25, 9000)},
    ForgottenIsland = {Sea = 2, LevelMin = 1400, LevelMax = 1500, Pos = Vector3.new(950, 25, 9100)},
    -- Third Sea
    PortTown = {Sea = 3, LevelMin = 1500, LevelMax = 1575, Pos = Vector3.new(-200, 50, 12750)},
    HydraIsland = {Sea = 3, LevelMin = 1575, LevelMax = 1650, Pos = Vector3.new(150, 50, 12900)},
    GreatTree = {Sea = 3, LevelMin = 1650, LevelMax = 1725, Pos = Vector3.new(450, 100, 12800)},
    FloatingTurtle = {Sea = 3, LevelMin = 1725, LevelMax = 1800, Pos = Vector3.new(-350, 75, 13000)},
    CastleSea3 = {Sea = 3, LevelMin = 1800, LevelMax = 1900, Pos = Vector3.new(100, 50, 13200)},
    HauntedCastle = {Sea = 3, LevelMin = 1900, LevelMax = 2000, Pos = Vector3.new(-550, 50, 13150)},
    IceCreamIsland = {Sea = 3, LevelMin = 2000, LevelMax = 2100, Pos = Vector3.new(-700, 30, 13300)},
    SeaOfTreats = {Sea = 3, LevelMin = 2100, LevelMax = 2200, Pos = Vector3.new(850, 40, 13400)},
    TikiOutpost = {Sea = 3, LevelMin = 2200, LevelMax = 2300, Pos = Vector3.new(1000, 50, 13500)},
    SubmergedIsland = {Sea = 3, LevelMin = 2300, LevelMax = 2400, Pos = Vector3.new(-900, -20, 13450)},
}

function O:GetBestIsland()
    local lv = self:GetLevel()
    local best, bestMatch = "StarterPirate", 0
    for n, isl in pairs(self.Islands) do
        if lv >= isl.LevelMin and lv <= isl.LevelMax then
            local m = isl.LevelMax - isl.LevelMin
            if m > bestMatch then best, bestMatch = n, m end
        end
    end
    return best
end

function O:GetCurrentIsland()
    if not HRP then return "Unknown" end
    local near, nearDist = "Unknown", math.huge
    for n, isl in pairs(self.Islands) do
        local d = self:Distance(HRP.Position, isl.Pos)
        if d < nearDist then near, nearDist = n, d end
    end
    return nearDist < 2000 and near or "Sea"
end

-- SECTION 6: AUTO FARM PRINCIPAL
function O:StartAutoFarm()
    spawn(function()
        while self.Config.AutoFarm and task.wait(0.1) do
            pcall(function()
                if not HRP or self:IsDead() then task.wait(1) return end
                local lv = self:GetLevel()
                local bestIsland = self:GetBestIsland()
                local currentIsland = self:GetCurrentIsland()
                if currentIsland ~= bestIsland and bestIsland ~= "Unknown" then
                    local isl = self.Islands[bestIsland]
                    if isl then self:TP(isl.Pos) self:SafeDelay(1) end
                end
                if self.Config.AutoQuest then self:Remote("SetSpawnPoint") end
                local enemy, dist = self:FindEnemy(2500)
                if enemy then
                    local ePos = enemy.HumanoidRootPart.Position
                    if dist > 15 then self:TP(ePos + Vector3.new(5,0,5)) end
                    self:Attack()
                    self:SpamSkills()
                elseif HRP then
                    self:TP(HRP.Position + Vector3.new(math.random(-100,100),0,math.random(-100,100)))
                end
            end)
        end
    end)
end

-- SECTION 7: AUTO BOSS
function O:StartAutoBoss()
    spawn(function()
        while self.Config.AutoBoss and task.wait(2) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local enemy, dist = self:FindEnemy(4000)
                if enemy and (enemy.Name:find("Boss") or enemy.Humanoid.MaxHealth > 50000) then
                    local isPlayer = false
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr.Character == enemy then isPlayer = true break end
                    end
                    if not isPlayer then
                        local ePos = enemy.HumanoidRootPart.Position
                        if dist > 20 then self:TP(ePos + Vector3.new(5,0,5)) end
                        self:Attack()
                        self:SpamSkills()
                        self.State.TotalBossesKilled = self.State.TotalBossesKilled + 1
                    end
                end
            end)
        end
    end)
end

-- SECTION 8: AUTO SEA EVENTS
function O:StartAutoSeaEvents()
    spawn(function()
        while self.Config.AutoSeaEvent and task.wait(2) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local lv = self:GetLevel()
                if lv < 700 then return end
                local patterns = {}
                if self.Config.AutoSeaBeast then table.insert(patterns, "SeaBeast") end
                if self.Config.AutoTerrorShark then table.insert(patterns, "Terror") end
                if self.Config.AutoPrehistoric then table.insert(patterns, "Prehistoric") end
                if self.Config.AutoFrozen then table.insert(patterns, "Frozen") end
                if self.Config.AutoMirage then table.insert(patterns, "Mirage") end
                if self.Config.AutoLeviathan then
                    for _, v in Workspace:GetDescendants() do
                        if v.Name:find("Levia") then
                            local t = v:FindFirstChild("HumanoidRootPart") or (v:IsA("BasePart") and v)
                            if t then
                                local d = self:Distance(HRP.Position, t.Position)
                                self:TP(t.Position + Vector3.new(10,5,10))
                                task.wait(0.3)
                                self:Attack()
                                self:SpamSkills()
                                self.State.TotalSeaEventsKilled = self.State.TotalSeaEventsKilled + 1
                                return
                            end
                        end
                    end
                end
                for _, pat in pairs(patterns) do
                    for _, obj in pairs(self:FindByName(pat)) do
                        local t = obj:FindFirstChild("HumanoidRootPart") or (obj:IsA("BasePart") and obj)
                        if t then
                            self:TP(t.Position + Vector3.new(10,5,10))
                            task.wait(0.3)
                            self:Attack()
                            self:SpamSkills()
                            self.State.TotalSeaEventsKilled = self.State.TotalSeaEventsKilled + 1
                            return
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 9: AUTO FRUIT SNIPER
function O:StartAutoFruitSniper()
    spawn(function()
        while self.Config.AutoFruitSniper and task.wait(1) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local fruits = self:FindFruits()
                for _, fruit in pairs(fruits) do
                    if fruit:FindFirstChild("Handle") then
                        local handle = fruit.Handle
                        local dist = self:Distance(HRP.Position, handle.Position)
                        if dist < 3000 then
                            if dist > 10 then self:TP(handle.Position) self:SafeDelay(0.3) end
                            firetouchinterest(HRP, handle, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, handle, 1)
                            task.wait(0.3)
                            local bp = LP:FindFirstChild("Backpack")
                            if bp then
                                for _, item in pairs(bp:GetChildren()) do
                                    if item:IsA("Tool") and (item.Name:find("Fruit") or item.Name:find("fruit")) then
                                        if self.Config.AutoFruitStorage then self:Remote("StoreFruit", item.Name) end
                                        self.State.TotalFruitsCollected = self.State.TotalFruitsCollected + 1
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 10: AUTO RAID
function O:StartAutoRaid()
    spawn(function()
        while self.Config.AutoRaid and task.wait(5) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 700 then return end
                self:Remote("Raids")
                self:Remote("StartRaid")
                self:SafeDelay(2)
                local start = tick()
                while tick() - start < 300 do
                    if not HRP or self:IsDead() then break end
                    local enemy, dist = self:FindEnemy(2000)
                    if enemy then
                        local ePos = enemy.HumanoidRootPart.Position
                        if dist > 15 then self:TP(ePos + Vector3.new(5,0,5)) end
                        self:Attack()
                        self:SpamSkills()
                    end
                    task.wait(0.1)
                end
                self.State.TotalRaidsCompleted = self.State.TotalRaidsCompleted + 1
            end)
        end
    end)
end

-- SECTION 11: AUTO RACE V4
function O:StartAutoRaceV4()
    spawn(function()
        while self.Config.AutoRaceV4 and task.wait(15) do
            pcall(function()
                if self:GetLevel() < 700 then return end
                self:Remote("RaceUpgrade", "V4")
                self:Remote("CyborgTrainer", "Buy")
                self:Remote("Ectoplasm", "Change", 4)
                self:SafeDelay(0.5)
            end)
        end
    end)
end

-- SECTION 12: AUTO ARMES LÉGENDAIRES
function O:StartAutoWeapons()
    spawn(function()
        while task.wait(20) do
            pcall(function()
                if self.Config.AutoYama then self:Remote("CraftWeapon", "Yama") end
                if self.Config.AutoTushita then self:Remote("CraftWeapon", "Tushita") end
                if self.Config.AutoTTK then self:Remote("CraftWeapon", "TrueTripleKatana") end
                if self.Config.AutoCDK then self:Remote("CraftWeapon", "CursedDualKatana") end
                if self.Config.AutoSoulGuitar then self:Remote("CraftWeapon", "SoulGuitar") end
                if self.Config.AutoSkullGuitar then self:Remote("CraftWeapon", "SkullGuitar") end
                if self.Config.AutoDarkDagger then self:Remote("CraftWeapon", "DarkDagger") end
                if self.Config.AutoHallowScythe then self:Remote("CraftWeapon", "HallowScythe") end
                if self.Config.AutoCanvander then self:Remote("CraftWeapon", "Canvander") end
                if self.Config.AutoGravityCane then self:Remote("CraftWeapon", "GravityCane") end
                if self.Config.AutoPoleV2 then self:Remote("CraftWeapon", "PoleV2") end
                self:SafeDelay(0.5)
            end)
        end
    end)
end

-- SECTION 13: AUTO HAKI
function O:StartAutoHaki()
    spawn(function()
        while self.Config.AutoHaki and task.wait(10) do
            pcall(function()
                if self.Config.AutoBusoHaki then
                    self:Remote("BuyHaki", "Buso")
                    self:Remote("KenTalk", "Buy")
                    self:SafeDelay(0.3)
                end
                if self.Config.AutoKenHaki then
                    self:Remote("BuyHaki", "Ken")
                    self:SafeDelay(0.3)
                end
                if self.Config.AutoObservation then
                    self:Remote("BuyHaki", "Observation")
                    self:SafeDelay(0.3)
                end
            end)
        end
    end)
end

-- SECTION 14: AUTO STATS
function O:StartAutoStats()
    spawn(function()
        while self.Config.AutoStats and task.wait(2) do
            pcall(function()
                local stats = LP:FindFirstChild("PlayerStats") or LP:FindFirstChild("Stats")
                if stats then
                    local pts = stats:FindFirstChild("StatPoints") or stats:FindFirstChild("Points")
                    if pts and pts.Value and pts.Value > 0 then
                        local perStat = math.max(1, math.floor(pts.Value / #self.Config.StatsPoints))
                        for _, stat in pairs(self.Config.StatsPoints) do
                            if pts.Value > 0 then
                                local add = math.min(pts.Value, perStat)
                                self:Remote("AddPoint", stat, add)
                                self:SafeDelay(0.3)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 15: AUTO CHEST
function O:StartAutoChest()
    spawn(function()
        while self.Config.AutoChest and task.wait(3) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                for _, chest in pairs(self:FindChests()) do
                    if chest:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, chest.Position)
                        if dist < 3000 then
                            if dist > 15 then self:TP(chest.Position) end
                            task.wait(0.3)
                            firetouchinterest(HRP, chest, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, chest, 1)
                            self.State.TotalChestsOpened = self.State.TotalChestsOpened + 1
                            task.wait(0.5)
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 16: AUTO BONES & ECTOPLASM
function O:StartAutoBones()
    spawn(function()
        while (self.Config.AutoBones or self.Config.AutoEctoplasm) and task.wait(5) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                for _, v in Workspace:GetDescendants() do
                    if (v.Name:find("Bone") or v.Name:find("bone") or v.Name:find("Ectoplasm") or v.Name:find("ectoplasm")) and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
                            task.wait(0.2)
                            firetouchinterest(HRP, v, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, v, 1)
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 17: SERVER HOP
function O:StartServerHop()
    spawn(function()
        while self.Config.AutoServerHop and task.wait(60) do
            pcall(function()
                if self:GetLevel() < 1500 then return end
                if self.Config.ServerHopForMirage and not self:IsMirageActive() then
                    if math.random(1, 8) == 1 then
                        self:Remote("Teleport")
                        task.wait(10)
                        return
                    end
                end
                if self.Config.ServerHopForFullMoon then
                    local lighting = game:GetService("Lighting")
                    local isFullMoon = lighting:FindFirstChild("FullMoon") ~= nil
                    if not isFullMoon and math.random(1, 12) == 1 then
                        self:Remote("Teleport")
                        task.wait(10)
                        return
                    end
                end
            end)
        end
    end)
end

function O:IsMirageActive()
    for _, v in Workspace:GetDescendants() do
        if v.Name:find("Mirage") or v.Name:find("MirageIsland") then return true end
    end
    return false
end

-- SECTION 18: ESP COMPLET
function O:StartESP()
    if not self.Config.ESP then return end
    spawn(function()
        while self.Config.ESP and task.wait(1) do
            pcall(function()
                for _, v in Workspace:GetDescendants() do
                    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                        if not v:FindFirstChild("OMEGA_ESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "OMEGA_ESP"
                            hl.Parent = v
                            hl.Adornee = v
                            hl.FillTransparency = 0.75
                            hl.OutlineTransparency = 0.4
                            local isPlayer = false
                            for _, plr in Players:GetPlayers() do if plr.Character == v then isPlayer = true break end end
                            if isPlayer then
                                hl.FillColor = Color3.fromRGB(0, 255, 0)
                            elseif v:FindFirstChild("Enemy") or v.Name:find("Boss") then
                                hl.FillColor = Color3.fromRGB(255, 0, 0)
                                if v.Humanoid and v.Humanoid.MaxHealth > 50000 then
                                    hl.FillColor = Color3.fromRGB(255, 0, 255)
                                end
                            else
                                hl.FillColor = Color3.fromRGB(0, 150, 255)
                            end
                        end
                    end
                end
                if self.Config.ESPFruits then
                    for _, v in Workspace:GetDescendants() do
                        if (v.Name:find("Fruit") or v.Name:find("fruit")) and v:IsA("Tool") and v:FindFirstChild("Handle") and not v:FindFirstChild("OMEGA_ESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "OMEGA_ESP"
                            hl.Parent = v
                            hl.Adornee = v
                            hl.FillColor = Color3.fromRGB(255, 255, 0)
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0.2
                        end
                    end
                end
                if self.Config.ESPChests then
                    for _, v in Workspace:GetDescendants() do
                        if (v.Name:find("Chest") or v.Name:find("chest")) and v:IsA("BasePart") and not v:FindFirstChild("OMEGA_ESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "OMEGA_ESP"
                            hl.Parent = v
                            hl.Adornee = v
                            hl.FillColor = Color3.fromRGB(0, 255, 255)
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0.2
                        end
                    end
                end
                if self.Config.ESPSeaEvents then
                    for _, v in Workspace:GetDescendants() do
                        if (v.Name:find("SeaBeast") or v.Name:find("Terror") or v.Name:find("Levia") or v.Name:find("Shark")) and v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and not v:FindFirstChild("OMEGA_ESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "OMEGA_ESP"
                            hl.Parent = v
                            hl.Adornee = v
                            hl.FillColor = Color3.fromRGB(255, 128, 0)
                            hl.FillTransparency = 0.4
                            hl.OutlineTransparency = 0.1
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 19: ANTI-BAN AVANCÉ
function O:StartAntiBan()
    if not self.Config.AntiBan then return end
    spawn(function()
        while true do task.wait(30)
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self.Config.RandomMovement then
                    local rPos = HRP.Position + Vector3.new(math.random(-60, 60), 0, math.random(-60, 60))
                    TweenService:Create(HRP, TweenInfo.new(2), {CFrame = CFrame.new(rPos)}):Play()
                end
                if math.random(1, 8) == 1 then
                    local msgs = {"gg", "gl", "nice", "lol", "ty", "ez", "wp", "hi", "yo"}
                    ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest") and ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msgs[math.random(#msgs)], "All")
                end
                if math.random(1, 15) == 1 then
                    for i = 1, 3 do
                        VirtualUser:Button1Down(Vector2.new(math.random(0, 1920), math.random(0, 1080)))
                        task.wait(0.1)
                        VirtualUser:Button1Up(Vector2.new(math.random(0, 1920), math.random(0, 1080)))
                    end
                end
            end)
        end
    end)
end

-- SECTION 20: AUTO FACTORY
function O:StartAutoFactory()
    spawn(function()
        while self.Config.AutoFactory and task.wait(10) do
            pcall(function()
                if not HRP or self:IsDead() or self:GetLevel() < 925 then return end
                self:Remote("Factory")
                self:SafeDelay(1)
                local start = tick()
                while tick() - start < 120 do
                    if not HRP or self:IsDead() then break end
                    local enemy, dist = self:FindEnemy(2000)
                    if enemy then
                        local ePos = enemy.HumanoidRootPart.Position
                        if dist > 15 then self:TP(ePos + Vector3.new(5,0,5)) end
                        self:Attack()
                        self:SpamSkills()
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)
end

-- SECTION 21: AUTO DUNGEON
function O:StartAutoDungeon()
    spawn(function()
        while self.Config.AutoDungeon and task.wait(8) do
            pcall(function()
                if not HRP or self:IsDead() or self:GetLevel() < 700 then return end
                self:Remote("Dungeon")
                self:Remote("StartDungeon")
                self:SafeDelay(2)
                local start = tick()
                while tick() - start < 240 do
                    if not HRP or self:IsDead() then break end
                    local enemy, dist = self:FindEnemy(2000)
                    if enemy then
                        local ePos = enemy.HumanoidRootPart.Position
                        if dist > 15 then self:TP(ePos + Vector3.new(5,0,5)) end
                        self:Attack()
                        self:SpamSkills()
                    end
                    task.wait(0.1)
                end
                self.State.TotalRaidsCompleted = self.State.TotalRaidsCompleted + 1
            end)
        end
    end)
end

-- SECTION 22: AUTO FRUIT PURCHASE
function O:StartAutoFruitPurchase()
    spawn(function()
        while self.Config.AutoFruitPurchase and task.wait(30) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local beli = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Beli")
                if beli and beli.Value then
                    for _, fruitName in pairs(self.Config.PriorityFruits) do
                        local fruit = ReplicatedStorage:FindFirstChild("Shop") and ReplicatedStorage.Shop:FindFirstChild("Fruit") and ReplicatedStorage.Shop.Fruit:FindFirstChild(fruitName)
                        if fruit then
                            local price = fruit:FindFirstChild("Price") or fruit:FindFirstChild("Cost")
                            if price and price.Value and beli.Value >= price.Value and beli.Value < self.Config.FruitPurchaseLimit then
                                self:Remote("PurchaseFruit", fruitName)
                                self:SafeDelay(1)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 23: AUTO FRAGMENT FARM
function O:StartAutoFragment()
    spawn(function()
        while self.Config.AutoFragment and task.wait(5) do
            pcall(function()
                if not HRP or self:IsDead() or self:GetLevel() < 700 then return end
                -- Fragment farming via sea events and raids
                for _, v in Workspace:GetDescendants() do
                    if v.Name:find("Fragment") or v.Name:find("fragment") and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
                            task.wait(0.2)
                            firetouchinterest(HRP, v, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, v, 1)
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 24: AUTO BELI FARM
function O:StartAutoBeliFarm()
    spawn(function()
        while task.wait(60) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local level = self:GetLevel()
                local beli = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Beli")
                if beli and beli.Value and beli.Value < 1000000 and level >= 700 then
                    -- Focus on chests and sea events for beli
                    for _, chest in pairs(self:FindChests()) do
                        if chest:IsA("BasePart") then
                            local dist = self:Distance(HRP.Position, chest.Position)
                            if dist < 3000 then
                                if dist > 15 then self:TP(chest.Position) end
                                task.wait(0.2)
                                firetouchinterest(HRP, chest, 0)
                                task.wait(0.1)
                                firetouchinterest(HRP, chest, 1)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 25: GUI FLOTTANTE
function O:CreateGUI()
    if not self.Config.ShowGUI then return end
    pcall(function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "OmegaHubGUI"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local plrGui = LP:FindFirstChild("PlayerGui")
        if plrGui then screenGui.Parent = plrGui end
        
        local frame = Instance.new("Frame")
        frame.Name = "MainFrame"
        frame.Parent = screenGui
        frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        frame.BorderColor3 = Color3.fromRGB(60, 60, 255)
        frame.BorderSizePixel = 2
        frame.Size = UDim2.new(0, 280, 0, 400)
        frame.Position = UDim2.new(0, 10, 0, 10)
        frame.Active = true
        frame.Draggable = true
        frame.BackgroundTransparency = 0.1
        
        local title = Instance.new("TextLabel")
        title.Parent = frame
        title.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        title.BorderSizePixel = 0
        title.Size = UDim2.new(0, 280, 0, 30)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.Text = "⬡ NEXUS OMEGA v" .. self.Version
        title.TextColor3 = Color3.fromRGB(60, 120, 255)
        title.TextSize = 14
        title.Font = Enum.Font.GothamBold
        title.TextStrokeTransparency = 0.5
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Parent = title
        closeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        closeBtn.BorderSizePixel = 0
        closeBtn.Size = UDim2.new(0, 25, 0, 25)
        closeBtn.Position = UDim2.new(1, -30, 0, 2.5)
        closeBtn.Text = "✕"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextSize = 14
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
        
        local scroll = Instance.new("ScrollingFrame")
        scroll.Parent = frame
        scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
        scroll.BorderSizePixel = 0
        scroll.Size = UDim2.new(0, 280, 0, 365)
        scroll.Position = UDim2.new(0, 0, 0, 35)
        scroll.CanvasSize = UDim2.new(0, 0, 0, 900)
        scroll.ScrollBarThickness = 6
        scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 255)
        
        local y = 5
        local function addToggle(text, configKey, default)
            getgenv().Omega.Config[configKey] = getgenv().Omega.Config[configKey] ~= nil and getgenv().Omega.Config[configKey] or default
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Parent = scroll
            toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Size = UDim2.new(0, 260, 0, 28)
            toggleFrame.Position = UDim2.new(0, 10, 0, y)
            
            local label = Instance.new("TextLabel")
            label.Parent = toggleFrame
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0, 200, 0, 28)
            label.Position = UDim2.new(0, 5, 0, 0)
            label.Text = text
            label.TextColor3 = Color3.fromRGB(200, 200, 255)
            label.TextSize = 12
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            local btn = Instance.new("TextButton")
            btn.Parent = toggleFrame
            btn.BackgroundColor3 = getgenv().Omega.Config[configKey] and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(80, 80, 80)
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(0, 45, 0, 22)
            btn.Position = UDim2.new(0, 210, 0, 3)
            btn.Text = getgenv().Omega.Config[configKey] and "ON" or "OFF"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 10
            btn.Font = Enum.Font.GothamBold
            btn.MouseButton1Click:Connect(function()
                getgenv().Omega.Config[configKey] = not getgenv().Omega.Config[configKey]
                btn.BackgroundColor3 = getgenv().Omega.Config[configKey] and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(80, 80, 80)
                btn.Text = getgenv().Omega.Config[configKey] and "ON" or "OFF"
            end)
            y = y + 32
        end
        
        local catY = y
        local function addCategory(text)
            local cat = Instance.new("TextLabel")
            cat.Parent = scroll
            cat.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            cat.BorderSizePixel = 0
            cat.Size = UDim2.new(0, 260, 0, 22)
            cat.Position = UDim2.new(0, 10, 0, y)
            cat.Text = "  " .. text
            cat.TextColor3 = Color3.fromRGB(100, 150, 255)
            cat.TextSize = 11
            cat.Font = Enum.Font.GothamBold
            cat.TextXAlignment = Enum.TextXAlignment.Left
            y = y + 26
        end
        
        addCategory("▶ FARM")
        addToggle("Auto Farm", "AutoFarm", true)
        addToggle("Auto Quest", "AutoQuest", true)
        addToggle("Auto Boss", "AutoBoss", true)
        addToggle("Auto Mastery", "AutoMastery", true)
        addToggle("Auto Chest", "AutoChest", true)
        addToggle("Auto Bones", "AutoBones", true)
        addToggle("Auto Fragment", "AutoFragment", true)
        
        addCategory("🌊 SEA EVENTS")
        addToggle("Auto Sea Event", "AutoSeaEvent", true)
        addToggle("Sea Beast", "AutoSeaBeast", true)
        addToggle("Terror Shark", "AutoTerrorShark", true)
        addToggle("Leviathan", "AutoLeviathan", true)
        addToggle("Prehistoric", "AutoPrehistoric", true)
        addToggle("Frozen Island", "AutoFrozen", true)
        addToggle("Mirage Island", "AutoMirage", true)
        
        addCategory("🍎 FRUITS")
        addToggle("Fruit Sniper", "AutoFruitSniper", true)
        addToggle("Fruit Collector", "AutoFruitCollect", true)
        addToggle("Fruit Purchase", "AutoFruitPurchase", true)
        addToggle("Fruit Storage", "AutoFruitStorage", true)
        
        addCategory("⚔️ COMBAT & ARMES")
        addToggle("Auto Raid", "AutoRaid", true)
        addToggle("Auto Dungeon", "AutoDungeon", true)
        addToggle("Auto Factory", "AutoFactory", true)
        addToggle("Auto Yama", "AutoYama", true)
        addToggle("Auto Tushita", "AutoTushita", true)
        addToggle("Auto TTK", "AutoTTK", true)
        addToggle("Auto CDK", "AutoCDK", true)
        addToggle("Auto Soul Guitar", "AutoSoulGuitar", true)
        addToggle("Fast Attack", "FastAttack", true)
        addToggle("Skill Spam", "AutoSkillSpam", true)
        
        addCategory("🏎️ RACE & STATS")
        addToggle("Auto Race V4", "AutoRaceV4", true)
        addToggle("Auto Haki", "AutoHaki", true)
        addToggle("Auto Stats", "AutoStats", true)
        
        addCategory("🛡️ PROTECTION")
        addToggle("Anti Ban", "AntiBan", true)
        addToggle("Server Hop", "AutoServerHop", true)
        addToggle("ESP", "ESP", true)
        addToggle("Instant TP", "InstantTeleport", true)
        
        scroll.CanvasSize = UDim2.new(0, 0, 0, y + 10)
    end)
end

-- SECTION 99: BOOTSTRAP - démarre les services configurés
pcall(function()
    -- GUI
    pcall(function() O:CreateGUI() end)

    -- Core automatisations
    pcall(function() if O.Config.AutoFarm then O:StartAutoFarm() end end)
    pcall(function() if O.Config.AutoBoss then O:StartAutoBoss() end end)
    pcall(function() if O.Config.AutoSeaEvent then O:StartAutoSeaEvents() end end)
    pcall(function() if O.Config.AutoFruitSniper then O:StartAutoFruitSniper() end end)
    pcall(function() if O.Config.AutoRaid then O:StartAutoRaid() end end)
    pcall(function() if O.Config.AutoRaceV4 then O:StartAutoRaceV4() end end)
    pcall(function() if O.Config.AutoYama or O.Config.AutoTushita or O.Config.AutoTTK or O.Config.AutoCDK or O.Config.AutoSoulGuitar then O:StartAutoWeapons() end end)
    pcall(function() if O.Config.AutoHaki then O:StartAutoHaki() end end)
    pcall(function() if O.Config.AutoStats then O:StartAutoStats() end end)
    pcall(function() if O.Config.AutoChest then O:StartAutoChest() end end)
    pcall(function() if O.Config.AutoBones or O.Config.AutoEctoplasm then O:StartAutoBones() end end)
    pcall(function() if O.Config.AutoServerHop then O:StartServerHop() end end)
    pcall(function() if O.Config.ESP then O:StartESP() end end)
    pcall(function() if O.Config.AntiBan then O:StartAntiBan() end end)
    pcall(function() if O.Config.AutoFactory then O:StartAutoFactory() end end)
    pcall(function() if O.Config.AutoDungeon then O:StartAutoDungeon() end end)
    pcall(function() if O.Config.AutoFruitPurchase then O:StartAutoFruitPurchase() end end)
    pcall(function() if O.Config.AutoFragment then O:StartAutoFragment() end end)
    pcall(function() if O.Config.AutoFruitCollect or O.Config.AutoFruitStorage then O:StartAutoFruitSniper() end end)

    print("[Omega] Bootstrap initialisé")
end)
