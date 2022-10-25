Config = {
    -- Map
    MapType = 1, -- 1 for rcore_casino_map, 2 for Gabz Casino (don't forget to disable rcore_casino_map and remove rcore_casino_map from fxmanifest.lua)

    -- Money Or Casino Chips? 
    UseOnlyMoney = false, -- set to true if you wanna disable using casino chips and use money instead
    ExchangeRate = 5, -- set value of one casino chip, for example, set to 5, if 1 chip equals to 5$ (minimum: 0.1, rounded by 0.1, 0.5 or 1)
    ShowChipsHud = true, -- show/hide the chips hud on the top-right corner
    ChipsInventoryItem = "zetony",
    UseBankMoney = true, -- cash or bank?

    -- Behave in casino?
    RestrictControls = false, -- don't jump, don't attack inside the Casino

    -- Bar
    BarShowSnacks = true, -- disable, if you want to see only drinks in the bartender menu

    -- Inside Track
    IT_STARTING_SOON_TIME = 0, -- *starting soon screen* duration; def: 0
    IT_MAIN_EVENT_MIN_PLAYERS = 1, -- min. players needed for the main event to start; def: 2
    IT_MAIN_EVENT_ENABLED = true, -- when false, the main event will be disabled, big screen will show only purple idle screen; def: true
    IT_MAIN_EVENT_BETTING_TIME = 60 * 5, -- time for players to place bets for main event, shows horses on screen; def: 60 * 5 (5 minutes)
    IT_MAIN_EVENT_RACE_DURATION = 33, -- length of the main event race; def: 33
    IT_MAIN_EVENT_HORSE_ODDS = {1, 5, 6, 15, 16, 30}, -- limit max horse odds for local game (1 to 30), def: {1, 5, 6, 15, 16, 30}  (2 horses of odds from 1 to 5, 2 horses of odds from 6 to 15, 2 horses of odds from 16 to 30)
    IT_MAIN_EVENT_RACE_MAX_BET = 1000, -- max. bet for the main event race
    IT_MAIN_EVENT_RACE_MIN_BET = 10, -- min. bet for the main event race
    IT_LOCAL_RACE_DURATION = 30, -- length of the local race (orange screen) def: 30
    IT_LOCAL_RACE_HORSE_ODDS = {1, 5, 6, 15, 16, 30}, -- limit max horse odds for local game (1 to 30), def: {1, 5, 6, 15, 16, 30}  (2 horses of odds from 1 to 5, 2 horses of odds from 6 to 15, 2 horses of odds from 16 to 30)
    IT_LOCAL_RACE_MAX_BET = 100, -- max. bet for the local race
    IT_LOCAL_RACE_MIN_BET = 10, -- min. bet for the local race

    -- Roulette
    ROULETTE_JUNIOR_ENABLED = true, -- set if you want to have Roulette Junior (blue) table for newbies (low stakes)
    ROULETTE_JUNIOR_COORDS = {1004.790, 57.295, 68.432},
    CASHIER_DAILY_BONUS = 1000, -- daily visitor bonus that players can request at the Cashier, set to 0 if you don't want any daily bonuses. def: 1000
    CASHIER_VIP_PRICE = 1000000, -- price of the VIP casino membership, def: 50000
    CASHIER_VIP_PASS_ITEM = false, -- an inventory item you have to have to be able to purchase the VIP membership. It gets removed after you purchase the VIP. Set to false if no inventory item is needed, and everyone can buy it.
    LUCKY_WHEEL_FREE_DRINKS_FOR = (60 * 60 * 24), -- when someone spins "Free Drinks" at the Lucky Wheel, how long they get free drinks for. def: 24 hours (60 * 60 * 24)
    LUCKY_WHEEL_COOLDOWN = (60 * 60 * 24), -- how long players have to wait for their next spin. def: 24 hours (60 * 60 * 24)
    LUCKY_WHEEL_VEHICLE_ALTERNATIVE = "Money50K", -- if player spins Vehicle, but there is no avaiable podium vehicle at the moment, spin to this item. Def: "Money50K" (the second biggest price)
    LUCKY_WHEEL_CAR_WINABLE = true, -- true: players can win the car, false: car is just a decoration
    LUCKY_WHEEL_PAY_TO_SPIN = 0, -- set price for the spin (chips), set 0 for free spins

    -- Blackjack
    BLACKJACK_JUNIOR_ENABLED = true, -- set if you want to have Blackjack Junior (blue) table for newbies (low stakes)
    BLACKJACK_JUNIOR_COORDS = {1004.183, 53.192, 68.432},

    -- Poker
    POKER_JUNIOR_ENABLED = true, -- set if you want to have Poker Junior (blue) table for newbies (low stakes)
    POKER_JUNIOR_COORDS = {998.439, 61.031, 68.432},

    -- Casino Settings (don't change unless you're told to :)
    CAS_DOUBLECHECK_COORDS = {984.528, 52.299, 70.238},
    CASINO_ENABLE_AMBIENT_PEDS = false, -- standing peds
    CASINO_ENABLE_AMBIENT_PEDS_SLOTS = false, -- peds playing slots
    CASINO_ENABLE_AMBIENT_PEDS_POKER = false, -- peds playing poker
    CASINO_ENABLE_AMBIENT_PEDS_BLACKJACK = false, -- peds playing blackjack
    CASINO_ENABLE_AMBIENT_PEDS_ROULETTE = false, -- peds playing roulette
    CASINO_AMBIENT_PEDS_DENSITY = 3, -- 1: a few, 2: medium, 3: all peds
    CASINO_SAVE_TIMER = 30000,
    DISABLE_IDLE_CAM = true,
    CASINO_ANIM_TIMEOUT = 750, -- pause between animations (in milliseconds), decrease this number to make interaction animations faster, be careful, smaller number can cause desync in animations if players have high ping. def: 750
    PRICES_CURRENCY = "$", -- $, €, £, ¥, ₽, ₩, ₹ ...
    RADAR_ZOOMLEVEL = 0.0, -- customize the radar zoom, from 0.0 (closest) to higher
    ENTER_CASINO_FADEOUT = 0, -- whether to fadeout the screen when entering (loading) casino or not (0: disabled, 1: only first enter, 2: every time)
    --
    JOB_PODIUMCAR_OWNERSHIP_CHECK = true,
    JOB_PODIUMCAR_OWNERSHIP_DELETE_ORIGINAL = true,
    JOB_PODIUMCAR_DELETE_ORIGINAL_FUNCTION_CLIENT = function(vehicleId, plateNumber) -- client function that the car dealer executes after delivering the car
        DeleteVehicle(vehicleId)
    end,

    CASINO_BLIPS_SHORT_RANGE = true, -- true: blips are visible only to players near casino, false: blips are always visible
    CASINO_BLIP_ID = 679, -- 679 is the diamond icon [https://docs.fivem.net/docs/game-references/blips/]
    --
    AMBIENT_SOUNDS = true, -- enable casino background interior sound

    Debug = false,

    -- Plate Settings
    PlateLetters = 3,
    PlateNumbers = 3,
    PlateUseSpace = true,

    -- Drinking
    DrunkSystem = 4,
    -- 1 = built-in, resets drunk level after leaving casino
    -- 2 = esx_status
    -- 3 = evidence:client:SetStatus
    -- 4 = rcore_drunk -- https://store.rcore.cz/package/5161129

    -- Other Resources
    EnableGuidebookIntegration = false, -- https://store.rcore.cz/package/5041989

    -- Society
    EnableSociety = true, -- whether to enable society account
    SocietyLimitFromBalance = 10000, -- if society account has less money than this, it will start paying out reduced money, (SocietyLimitPayoutPercentage)
    SocietyLimitPayoutPercentage = 35, -- example: if SocietyLimitPayoutPercentage is 35%, and SocietyLimitFromBalance is 10000 => 1000 payout at the Cashier will be limited to 350, if the society bank account balance is less than 10 000
    SocietyName = "society_casino", -- id of the society (not a title, I guess, don't change it)
    -- when enabled, all casino payments (Cashier, Bar, Lucky Wheel) go through the society account, players don't get paid if there's not enough money in the 

    -- Job
    BossGrade = 12, -- the max grade (boss) for the casino job
    BossName = "boss",
    JobName = "casino", -- id of the job (not a title, I guess, don't change it)

    -- Teleport In & Out
    LeaveThroughTeleport = false, -- if enabled, people won't be able to leave the casino building, instead, they get prompted once they come near the entrance (useful if your map is too far from Los Santos)
    EnterPosition = vector3(924.994629, 41.465431, 72.273560),
    EnterCheckpointPosition = vector3(923.470093, 47.249229, 80.8), -- custom marker for entering the casino, for example, in front of your custom Casino building in a different city, etc.
    LeavePosition = vector3(973.651611, 137.494629, 80.990433), -- where the player appears *after leaving*, for example, in front of your custom Casino building in a different city, etc.
    LeaveArea = vector3(926.347046, 47.515320, 81.543098), -- where the player is prompted to leave the casino, for example, in front of the main doors,

    -- Ui
    UIFontName = nil, -- font for the UI, set to nil, if you don't want to use a custom font, set to a font name (with ""), if you wanna register and use a font that's inside your /stream/fonts folder
    ShowHowToPlayUI = 0, -- How to play/Info about the game UI (Menu that shows after pressing 'E' to play. (0: disabled, 1: only once, 2: every time after pressing 'E')

    -- Database
    MongoDB = false, -- if you decide to use MongoDB instead of MYSQL, don't forget to edit your MongoDB queries in: server/main/cache.lua, server/main/casino.lua and server/utils/plateGenerator.lua

    -- Tweaks
    VoiceTweak = false, -- keep it false, if you don't have amy voice problems inside casino
    VehicleRGBTweak = true, -- save podium vehicle colors as RGB array (color1, color2), instead of numbers
}

Framework = {
    -- 1 = es_extended
    -- 2 = QBcore
    -- 3 = custom (you need to implement it your self in server/framework/custom.lua)
    Active = 1,
    -- Please follow the installation tutorial: --
    -- https://documentation.rcore.cz/paid-resources/rcore_casino

    -- esx resource name + shared object name
    ES_EXTENDED_RESOURCE_NAME = "es_extended",
    ESX_SHARED_OBJECT = "esx:getSharedObject",
    -- esx extra settings
    BUILTIN_HUD_CHIPS = false,
    BUILTIN_HUD_CHIPS_ICON = "casinochip.png",

    -- qbcore resource name + shared object name
    QB_CORE_RESOURCE_NAME = "qb-core",
    QBCORE_SHARED_OBJECT = "QBCore:GetObject"
}

if Framework.Active == 2 then
    Config.PlateLetters = 4
    Config.PlateNumbers = 4
    Config.PlateUseSpace = false
end

Events = {
    QB_PLAYER_LOADED = "QBCore:Client:OnPlayerLoaded",
    QB_PLAYER_JOB_UPDATE = "QBCore:Client:OnJobUpdate",
    QB_BOSS_MENU = "qb-bossmenu:client:OpenMenu",
    -- use "qb-bossmenu:client:OpenMenu" for qb-managment and "qb-bossmenu:client:openMenu" for qb-bossmenu

    ES_PLAYER_LOADED = "esx:playerLoaded",
    ES_PLAYER_JOB_UPDATE = "esx:setJob",
    ES_BOSS_MENU = "esx_society:openBossMenu"
}

GameplayKeys = {
    TableGamesMaxBet = 44, -- Choose between: (Tab = 204, E = 46, Q = 44, D = 134, Page Down = 207)
    TableGamesGrabCards = 207,
    RouletteHistoryKey = 204
}

AdminGroup = {
    ["god"] = true,
    ["admin"] = true,
    ["dev"] = true,
    ["mod"] = false,
    ["moderator"] = false
}

-- Enable / Disable individual games/activities
GameStates = {{
    activity = "slots",
    title = "Slot Machines",
    enabled = true
}, {
    activity = "luckywheel",
    title = "Lucky Wheel",
    enabled = true
}, {
    activity = "insidetrack",
    title = "Inside Track",
    enabled = true
}, {
    activity = "drinkingbar",
    title = "Drinking Bar",
    enabled = true
}, {
    activity = "roulette",
    title = "Roulette",
    enabled = true
}, {
    activity = "poker",
    title = "Poker",
    enabled = true
}, {
    activity = "blackjack",
    title = "Blackjack",
    enabled = true
}, {
    activity = "cashier",
    title = "Cashier",
    enabled = true
}, {
    activity = "seating",
    title = "Seating",
    enabled = true
}, {
    activity = "cameras",
    title = "Cameras",
    enabled = true
}, {
    activity = "officeelevator",
    title = "Office Elevator",
    enabled = true
}, {
    activity = "officeelevatorout",
    title = "Office Elevator (Down)",
    enabled = true
}, {
    activity = "casinoteleporter",
    title = "Casino Teleporter (In)",
    enabled = true
}, {
    activity = "casinoentrance",
    title = "Casino Entrance",
    enabled = true
}}

-- customize the blip function here
-- used blip icon ids: 
-- Inside Track: 684, Lucky Wheel: 681, Cashier: 683, Table Games: 680, VIP Area / Exterior Icon: 679, 
-- [https://docs.fivem.net/docs/game-references/blips/]

function SetCasinoBlip(coords, blipIcon, blipName, exterior)
    local blip = AddBlipForCoord(coords)
    --------------
    SetBlipSprite(blip, blipIcon)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, exterior and Config.CASINO_BLIPS_SHORT_RANGE or false)
    --------------
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(blip)
    if not exterior then
        table.insert(CasinoBlips, blip)
    end
    return blip
end
