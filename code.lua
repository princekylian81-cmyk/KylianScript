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
    PriorityFruits = {"Dough","Venom","Dragon","Leopard","Kitsune","Yeti","Dark","Spirit","Soul","Buddha"},
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
repeat task.wait() until game:IsLoaded() and LP and LP.Character
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
    if CommF then
        local s, e = pcall(function() return CommF:InvokeServer(...) end)
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
    local map = {Z = Enum.KeyCode.Z, X = Enum.KeyCode.X, C = Enum.KeyCode.C, V = Enum.KeyCode.V, F = Enum.KeyCode.F}
    local code = map[key:upper()]
    if code then
        VirtualInputManager:SendKeyEvent(true, code, false, nil)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, code, false, nil)
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

-- SECTION 26: OVERLAY STATS EN JEU
function O:CreateStatsOverlay()
    if not self.Config.ShowStatsOverlay then return end
    pcall(function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "OmegaStatsOverlay"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local plrGui = LP:FindFirstChild("PlayerGui")
        if plrGui then screenGui.Parent = plrGui end
        
        local frame = Instance.new("Frame")
        frame.Parent = screenGui
        frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
        frame.BorderColor3 = Color3.fromRGB(30, 30, 100)
        frame.BorderSizePixel = 1
        frame.Size = UDim2.new(0, 200, 0, 160)
        frame.Position = UDim2.new(1, -210, 0, 10)
        frame.BackgroundTransparency = 0.2
        frame.Active = true
        frame.Draggable = true
        
        local title = Instance.new("TextLabel")
        title.Parent = frame
        title.BackgroundTransparency = 1
        title.Size = UDim2.new(0, 200, 0, 20)
        title.Position = UDim2.new(0, 0, 0, 2)
        title.Text = "⬡ OMEGA v" .. self.Version
        title.TextColor3 = Color3.fromRGB(60, 120, 255)
        title.TextSize = 12
        title.Font = Enum.Font.GothamBold
        
        local updateOverlay
        updateOverlay = function()
            pcall(function()
                local lv = self:GetLevel()
                local sea = self:GetSea()
                local beli = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Beli") and LP.Data.Beli.Value or 0
                local bounty = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Bounty") and LP.Data.Bounty.Value or 0
                local frags = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Fragments") and LP.Data.Fragments.Value or 0
                local race = self:GetRace()
                local fruit = self:GetFruit()
                local island = self:GetCurrentIsland()
                local hp = Hum and math.floor(Hum.Health) or 0
                local maxHp = Hum and math.floor(Hum.MaxHealth) or 1
                
                local text = ""
                text = text .. "🎯 Niveau: " .. lv .. "\n"
                text = text .. "🌊 Mer: " .. sea .. "\n"
                text = text .. "🏝️ " .. island .. "\n"
                text = text .. "❤️ HP: " .. hp .. "/" .. maxHp .. "\n"
                text = text .. "💰 Beli: " .. self:FormatNumber(beli) .. "\n"
                text = text .. "🏆 Bounty: " .. self:FormatNumber(bounty) .. "\n"
                text = text .. "💎 Frags: " .. self:FormatNumber(frags) .. "\n"
                text = text .. "🧬 Race: " .. race .. "\n"
                text = text .. "🍎 Fruit: " .. fruit .. "\n"
                text = text .. "⚔️ Kills: " .. self.State.TotalKills .. "\n"
                text = text .. "🪦 Chests: " .. self.State.TotalChestsOpened .. "\n"
                text = text .. "🍇 Fruits: " .. self.State.TotalFruitsCollected .. "\n"
                text = text .. "🌊 Sea: " .. self.State.TotalSeaEventsKilled .. "\n"
                text = text .. "👹 Boss: " .. self.State.TotalBossesKilled .. "\n"
                text = text .. "🏛️ Raids: " .. self.State.TotalRaidsCompleted .. "\n"
                
                local textLabel = frame:FindFirstChild("InfoText")
                if not textLabel then
                    textLabel = Instance.new("TextLabel")
                    textLabel.Name = "InfoText"
                    textLabel.Parent = frame
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(0, 190, 0, 135)
                    textLabel.Position = UDim2.new(0, 5, 0, 22)
                    textLabel.TextColor3 = Color3.fromRGB(180, 200, 255)
                    textLabel.TextSize = 10
                    textLabel.Font = Enum.Font.Gotham
                    textLabel.TextXAlignment = Enum.TextXAlignment.Left
                    textLabel.TextYAlignment = Enum.TextYAlignment.Top
                end
                textLabel.Text = text
            end)
        end
        
        spawn(function()
            while screenGui and screenGui.Parent do
                updateOverlay()
                task.wait(2)
            end
        end)
    end)
end

-- SECTION 27: FORMATAGE NOMBRES
function O:FormatNumber(n)
    if not n then return "0" end
    if n >= 1000000 then return string.format("%.1fM", n / 1000000)
    elseif n >= 1000 then return string.format("%.1fK", n / 1000)
    else return tostring(n) end
end

-- SECTION 28: AUTO RESPAWN
function O:StartAutoRespawn()
    spawn(function()
        while true do task.wait(0.5)
            pcall(function()
                if self:IsDead() then
                    local respawnBtn = LP.PlayerGui:FindFirstChild("DeathGui")
                    if respawnBtn then
                        local btn = respawnBtn:FindFirstChild("Respawn") or respawnBtn:FindFirstChild("Button") or respawnBtn:FindFirstChildOfClass("TextButton")
                        if btn then
                            btn:Click()
                            task.wait(2)
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 29: AUTO OBSERVATION HAKI FARM
function O:StartAutoObservationFarm()
    spawn(function()
        while self.Config.AutoObservation and task.wait(30) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 700 then return end
                self:Remote("BuyHaki", "Observation")
                self:SafeDelay(0.3)
                -- Try to farm observation by dodging
                spawn(function()
                    for i = 1, 3 do
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                        task.wait(1)
                    end
                end)
            end)
        end
    end)
end

-- SECTION 30: AUTO MASTERY FARM
function O:StartAutoMasteryFarm()
    spawn(function()
        while self.Config.AutoMastery and task.wait(5) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local tool = Char:FindFirstChildOfClass("Tool")
                if tool then
                    local mastery = tool:FindFirstChild("Mastery")
                    if mastery and mastery.Value >= self.Config.MasteryTarget then
                        -- Switch to next weapon
                        local bp = LP:FindFirstChild("Backpack")
                        if bp then
                            for _, v in pairs(bp:GetChildren()) do
                                if v:IsA("Tool") and v ~= tool then
                                    local m = v:FindFirstChild("Mastery")
                                    if m and m.Value < self.Config.MasteryTarget then
                                        LP.Character.Humanoid:EquipTool(v)
                                        self:SafeDelay(0.5)
                                        break
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

-- SECTION 31: AUTO BATTLE ROYALE / BOUNTY HUNT
function O:StartAutoBountyHunt()
    spawn(function()
        while self.Config.AutoBoss and task.wait(3) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 700 then return end
                -- Find and attack players if bounty hunting
                local nearest, nearDist = nil, 5000
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChildOfClass("Humanoid") then
                        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local dist = self:Distance(HRP.Position, plr.Character.HumanoidRootPart.Position)
                            if dist < nearDist and dist > 50 then
                                nearest = plr.Character
                                nearDist = dist
                            end
                        end
                    end
                end
                if nearest then
                    local ePos = nearest.HumanoidRootPart.Position
                    if nearDist > 20 then
                        self:TP(ePos + Vector3.new(5,0,5))
                    end
                    self:Attack()
                    self:SpamSkills()
                end
            end)
        end
    end)
end

-- SECTION 32: AUTO FRUIT RAIN COLLECTOR
function O:StartAutoFruitRain()
    spawn(function()
        while task.wait(3) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                -- Check for fruit rain event
                for _, v in Workspace:GetDescendants() do
                    if v.Name:find("FruitRain") or v.Name:find("Rain") then
                        local fruits = self:FindFruits()
                        for _, fruit in pairs(fruits) do
                            if fruit:FindFirstChild("Handle") then
                                local dist = self:Distance(HRP.Position, fruit.Handle.Position)
                                if dist < 5000 then
                                    if dist > 10 then self:TP(fruit.Handle.Position) end
                                    firetouchinterest(HRP, fruit.Handle, 0)
                                    task.wait(0.05)
                                    firetouchinterest(HRP, fruit.Handle, 1)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 33: AUTO SEA OF TREATS FARM
function O:StartAutoSeaOfTreats()
    spawn(function()
        while self.Config.AutoSeaEvent and task.wait(5) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 2100 then return end
                for _, v in Workspace:GetDescendants() do
                    if v.Name:find("Cake") or v.Name:find("cake") or v.Name:find("Treat") or v.Name:find("Candy") and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 3000 then
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

-- SECTION 34: AUTO GHOST / HAUNTED CASTLE FARM
function O:StartAutoHauntedCastle()
    spawn(function()
        while task.wait(4) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 1900 then return end
                for _, v in Workspace:GetDescendants() do
                    if (v.Name:find("Ghost") or v.Name:find("ghost") or v.Name:find("Soul") or v.Name:find("soul")) and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
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

-- SECTION 35: AUTO TIKI OUTPOST FARM
function O:StartAutoTikiFarm()
    spawn(function()
        while task.wait(4) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 2200 then return end
                for _, v in Workspace:GetDescendants() do
                    if (v.Name:find("Totem") or v.Name:find("Tiki") or v.Name:find("Relic")) and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
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

-- SECTION 36: AUTO SUBMERGED ISLAND FARM
function O:StartAutoSubmergedFarm()
    spawn(function()
        while task.wait(4) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 2300 then return end
                for _, v in Workspace:GetDescendants() do
                    if (v.Name:find("Pearl") or v.Name:find("Coral") or v.Name:find("Submerged") or v.Name:find("Treasure")) and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
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

-- SECTION 37: AUTO HYDRA ISLAND FARM
function O:StartAutoHydraFarm()
    spawn(function()
        while task.wait(4) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 1575 then return end
                for _, v in Workspace:GetDescendants() do
                    if (v.Name:find("Hydra") or v.Name:find("Dragon") or v.Name:find("Scale")) and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
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

-- SECTION 38: AUTO GREAT TREE FARM
function O:StartAutoGreatTreeFarm()
    spawn(function()
        while task.wait(4) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 1650 then return end
                for _, v in Workspace:GetDescendants() do
                    if (v.Name:find("Apple") or v.Name:find("Leaf") or v.Name:find("Branch")) and v:IsA("BasePart") then
                        local dist = self:Distance(HRP.Position, v.Position)
                        if dist < 2000 then
                            if dist > 10 then self:TP(v.Position) end
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

-- SECTION 39: CASTLE ON THE SEA DEFENSE
function O:StartAutoCastleDefense()
    spawn(function()
        while self.Config.AutoBoss and task.wait(3) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 1800 then return end
                for _, v in Workspace:GetDescendants() do
                    if v.Name:find("Castle") or v.Name:find("Flag") or v.Name:find("Enemy") then
                        if v:FindFirstChild("HumanoidRootPart") then
                            local dist = self:Distance(HRP.Position, v.HumanoidRootPart.Position)
                            if dist < 3000 then
                                if dist > 20 then self:TP(v.HumanoidRootPart.Position + Vector3.new(5,0,5)) end
                                self:Attack()
                                self:SpamSkills()
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 40: SYSTÈME DE PRIORITÉ INTELLIGENT
function O:StartPrioritySystem()
    spawn(function()
        while true do task.wait(10)
            pcall(function()
                local lv = self:GetLevel()
                local sea = self:GetSea()
                local hp, maxHp = self:GetHealth()
                local hpPercent = hp / maxHp
                
                -- Auto heal by teleporting to safe zone if needed
                if hpPercent < 0.3 and self.Config.AutoFarm then
                    if sea == "First Sea" then self:TPToIsland("StarterPirate")
                    elseif sea == "Second Sea" then self:TPToIsland("KingdomRose")
                    elseif sea == "Third Sea" then self:TPToIsland("PortTown") end
                    task.wait(3)
                end
                
                -- Auto eat fruit if enabled
                if self.Config.AutoEatFruit and self.Config.FruitToEat ~= "" then
                    local bp = LP:FindFirstChild("Backpack")
                    if bp then
                        for _, item in pairs(bp:GetChildren()) do
                            if item:IsA("Tool") and (item.Name:find("Fruit") or item.Name:find(self.Config.FruitToEat)) then
                                LP.Character.Humanoid:EquipTool(item)
                                task.wait(0.5)
                                -- Eat the fruit
                                local eatRemote = item:FindFirstChild("EatRemote") or item:FindFirstChild("Remote")
                                if eatRemote then eatRemote:FireServer() end
                                self.Config.AutoEatFruit = false
                                break
                            end
                        end
                    end
                end
                
                -- Update state
                self:GetLevel()
                self:GetSea()
                self:GetCurrentIsland()
                self:GetRace()
                self:GetFruit()
            end)
        end
    end)
end

-- SECTION 41: MONITORING & AUTOMATIC ADAPTATION
function O:StartAdaptiveSystem()
    spawn(function()
        while true do task.wait(30)
            pcall(function()
                local lv = self:GetLevel()
                
                -- Auto adjust stats based on level
                if lv < 100 then
                    self.Config.StatsPoints = {"Melee", "Defense"}
                    self.Config.AutoCombatMode = "Melee"
                elseif lv < 500 then
                    self.Config.StatsPoints = {"Melee", "Defense", "Sword"}
                    self.Config.AutoCombatMode = "Sword"
                elseif lv < 1500 then
                    self.Config.StatsPoints = {"Melee", "Defense", "Blox Fruit"}
                    self.Config.AutoCombatMode = "Fruit"
                else
                    self.Config.StatsPoints = {"Melee", "Defense", "Sword", "Blox Fruit"}
                    self.Config.AutoCombatMode = "Smart"
                end
                
                -- Auto adjust sea event priority based on level
                if lv < 1000 then
                    if self.Config.AutoSeaBeast then self.Config.AutoSeaEventPriority = "SeaBeast" end
                elseif lv < 1500 then
                    if self.Config.AutoTerrorShark then self.Config.AutoSeaEventPriority = "TerrorShark" end
                else
                    if self.Config.AutoLeviathan then self.Config.AutoSeaEventPriority = "Leviathan" end
                end
            end)
        end
    end)
end

-- SECTION 42: WATER WALK & FLY AUTO
function O:StartAutoMobility()
    spawn(function()
        while true do task.wait(1)
            pcall(function()
                if not HRP then return end
                -- Auto water walk when in sea
                local pos = HRP.Position
                if pos.Y < -5 and self.Config.AutoFarm then
                    HRP.CFrame = CFrame.new(pos.X, 5, pos.Z)
                end
            end)
        end
    end)
end

-- SECTION 43: AUTO FISHING
function O:StartAutoFishing()
    spawn(function()
        while task.wait(5) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 700 then return end
                -- Auto fish if rod equipped
                local tool = Char:FindFirstChildOfClass("Tool")
                if tool and tool.Name:find("Rod") or tool and tool.Name:find("Fishing") then
                    local fishRemote = tool:FindFirstChild("FishRemote") or tool:FindFirstChild("Remote")
                    if fishRemote then
                        fishRemote:FireServer()
                        task.wait(1)
                    end
                end
            end)
        end
    end)
end

-- SECTION 44: AUTO GRAPPLE / SWORD SKILLS
function O:StartAutoSwordSkills()
    spawn(function()
        while self.Config.AutoSkillSpam and task.wait(2) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local tool = Char:FindFirstChildOfClass("Tool")
                if tool then
                    if tool.ToolTip == "Sword" or tool.Name:find("Katana") or tool.Name:find("Sword") or tool.Name:find("Blade") or tool.Name:find("Saber") or tool.Name:find("Yama") or tool.Name:find("Tushita") or tool.Name:find("CDK") or tool.Name:find("TTK") or tool.Name:find("Canvander") then
                        for _, k in pairs({"Z", "X", "C"}) do
                            self:UseSkill(k)
                            task.wait(0.2)
                        end
                    end
                end
            end)
        end
    end)
end

-- SECTION 45: AUTO GUN SKILLS
function O:StartAutoGunSkills()
    spawn(function()
        while self.Config.AutoSkillSpam and task.wait(2) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local tool = Char:FindFirstChildOfClass("Tool")
                if tool and tool.ToolTip == "Gun" then
                    for _, k in pairs({"Z", "X"}) do
                        self:UseSkill(k)
                        task.wait(0.3)
                    end
                end
            end)
        end
    end)
end

-- SECTION 46: AUTO FRUIT SKILLS
function O:StartAutoFruitSkills()
    spawn(function()
        while self.Config.AutoSkillSpam and task.wait(2) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                local tool = Char:FindFirstChildOfClass("Tool")
                if tool and tool.ToolTip == "Blox Fruit" then
                    for _, k in pairs({"Z", "X", "C", "V"}) do
                        self:UseSkill(k)
                        task.wait(0.4)
                    end
                end
            end)
        end
    end)
end

-- SECTION 47: AUTO GOD MODE (TELEPORT DODGE)
function O:StartAutoDodge()
    spawn(function()
        while self.Config.AutoDodge and task.wait(0.5) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if Hum and Hum.Health < Hum.MaxHealth * 0.3 then
                    -- Teleport away to dodge
                    local safePos = HRP.Position + Vector3.new(math.random(30, 60), 0, math.random(30, 60))
                    self:TP(safePos)
                    task.wait(1)
                end
            end)
        end
    end)
end

-- SECTION 48: AUTO AURA / HAKI VISUAL
function O:StartAutoHakiVisual()
    spawn(function()
        while self.Config.AutoBusoHaki and task.wait(30) do
            pcall(function()
                if not HRP then return end
                -- Activate haki visual
                local hakiObj = Char:FindFirstChild("Haki")
                if not hakiObj then
                    self:Remote("Buso")
                    self:SafeDelay(0.5)
                end
            end)
        end
    end)
end

-- SECTION 49: AUTO CLAN / GUILD
function O:StartAutoGuild()
    spawn(function()
        while task.wait(60) do
            pcall(function()
                if not HRP or self:IsDead() then return end
                if self:GetLevel() < 700 then return end
                -- Join guild
                self:Remote("JoinGuild")
                self:Remote("Guild")
            end)
        end
    end)
end

-- SECTION 50: DÉMARRAGE GÉNÉRAL
function O:StartAll()
    print("═══════════════════════════════════════════════════════════════════")
    print("  ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗")
    print("  ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝")
    print("  ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗")
    print("  ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║")
    print("  ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║")
    print("  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝")
    print("═══════════════════════════════════════════════════════════════════")
    print("  NEXUS OMEGA ULTIMATE v" .. self.Version)
    print("  Chargement de " .. self:CountSections() .. " modules...")
    print("═══════════════════════════════════════════════════════════════════")
    
    -- Attente chargement complet
    repeat task.wait() until game:IsLoaded() and LP and LP.Character
    Char = LP.Character
    HRP = Char:WaitForChild("HumanoidRootPart")
    Hum = Char:WaitForChildOfClass("Humanoid")
    O.Char = Char
    O.HRP = HRP
    O.Hum = Hum
    O.State.IsLoaded = true
    
    -- Anti AFK
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    
    print("[1/50] Anti AFK activé")
    
    -- Démarrage des modules
    local modules = {
        {"Auto Farm", self.Config.AutoFarm, self.StartAutoFarm},
        {"Auto Boss", self.Config.AutoBoss, self.StartAutoBoss},
        {"Sea Events", self.Config.AutoSeaEvent, self.StartAutoSeaEvents},
        {"Fruit Sniper", self.Config.AutoFruitSniper, self.StartAutoFruitSniper},
        {"Auto Raid", self.Config.AutoRaid, self.StartAutoRaid},
        {"Race V4", self.Config.AutoRaceV4, self.StartAutoRaceV4},
        {"Armes Légendaires", true, self.StartAutoWeapons},
        {"Auto Haki", self.Config.AutoHaki, self.StartAutoHaki},
        {"Auto Stats", self.Config.AutoStats, self.StartAutoStats},
        {"Auto Chest", self.Config.AutoChest, self.StartAutoChest},
        {"Auto Bones", self.Config.AutoBones or self.Config.AutoEctoplasm, self.StartAutoBones},
        {"Server Hop", self.Config.AutoServerHop, self.StartAutoServerHop},
        {"ESP", self.Config.ESP, self.StartESP},
        {"Anti Ban", self.Config.AntiBan, self.StartAntiBan},
        {"Auto Factory", self.Config.AutoFactory, self.StartAutoFactory},
        {"Auto Dungeon", self.Config.AutoDungeon, self.StartAutoDungeon},
        {"Fruit Purchase", self.Config.AutoFruitPurchase, self.StartAutoFruitPurchase},
        {"Auto Fragment", self.Config.AutoFragment, self.StartAutoFragment},
        {"Beli Farm", true, self.StartAutoBeliFarm},
        {"Auto Respawn", true, self.StartAutoRespawn},
        {"Observation Farm", self.Config.AutoObservation, self.StartAutoObservationFarm},
        {"Mastery Farm", self.Config.AutoMastery, self.StartAutoMasteryFarm},
        {"Bounty Hunt", self.Config.AutoBoss, self.StartAutoBountyHunt},
        {"Fruit Rain", true, self.StartAutoFruitRain},
        {"Sea of Treats", self.Config.AutoSeaEvent, self.StartAutoSeaOfTreats},
        {"Haunted Castle", true, self.StartAutoHauntedCastle},
        {"Tiki Farm", true, self.StartAutoTikiFarm},
        {"Submerged Farm", true, self.StartAutoSubmergedFarm},
        {"Hydra Farm", true, self.StartAutoHydraFarm},
        {"Great Tree", true, self.StartAutoGreatTreeFarm},
        {"Castle Defense", self.Config.AutoBoss, self.StartAutoCastleDefense},
        {"Priority System", true, self.StartPrioritySystem},
        {"Adaptive System", true, self.StartAdaptiveSystem},
        {"Auto Mobility", true, self.StartAutoMobility},
        {"Auto Fishing", true, self.StartAutoFishing},
        {"Sword Skills", self.Config.AutoSkillSpam, self.StartAutoSwordSkills},
        {"Gun Skills", self.Config.AutoSkillSpam, self.StartAutoGunSkills},
        {"Fruit Skills", self.Config.AutoSkillSpam, self.StartAutoFruitSkills},
        {"Auto Dodge", self.Config.AutoDodge, self.StartAutoDodge},
        {"Haki Visual", self.Config.AutoBusoHaki, self.StartAutoHakiVisual},
        {"Auto Guild", true, self.StartAutoGuild},
    }
    
    local loaded = 0
    for _, module in pairs(modules) do
        if module[2] then
            local s, e = pcall(module[3], self)
            if s then
                loaded = loaded + 1
            end
        end
    end
    
    -- GUI et Overlay
    self:CreateGUI()
    self:CreateStatsOverlay()
    
    print("═══════════════════════════════════════════════════════════════════")
    print("  ✅ NEXUS OMEGA ULTIMATE v" .. self.Version .. " — CHARGÉ !")
    print("  📋 Modules actifs: " .. loaded .. "/" .. #modules)
    print("  🎯 Bon farm !")
    print("═══════════════════════════════════════════════════════════════════")
end

function O:CountSections()
    local count = 0
    for _, v in pairs(self) do
        if type(v) == "function" and v.Name and v.Name:find("Start") then
            count = count + 1
        end
    end
    return count
end

function O:TPToIsland(name)
    local isl = self.Islands[name]
    if isl and isl.Pos then
        self:TP(isl.Pos)
        return true
    end
    return false
end

function O:GetHealth()
    if Hum then return Hum.Health, Hum.MaxHealth end
    return 0, 100
end

function O:StartAutoServerHop()
    -- Alias pour ServerHop
    self:StartServerHop()
end

-- LANCEMENT FINAL
O:StartAll()
