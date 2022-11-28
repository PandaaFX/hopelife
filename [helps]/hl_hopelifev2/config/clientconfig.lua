ClientConfig = {}
ClientConfig.General = {
    EMethods = true, -- it blocks some executers (you cant start/stop or restart scripts when server is on, which means you should wait until restart of server)
    EMethodCheck = 10000, -- default 10000 (dont change it)
    AntiStopper = true, -- it blocks cheaters to stop scripts (when its on you cant start/stop or restart scripts you should wait until restart of server)
    AntiESX = false, -- if you use ESX as framework, you should keep it false.
    AntiGodMode = false, -- if true, it blocks some known methods of godmode BUT if you have a script which uses godmode keep it false.
    AntiSpectate = false, -- Cheater cant spectate when its on (dont forget to add your admin's hex ids or licences to ServerConfig.Whitelist so they can spectate !)
    AntiRadar = false, -- if you use Radar script, you should keep it false
    AntiVision = false, -- if you use Thermal/Night vision script, you should keep it false
    AntiMenyoo = false, -- it blocks menyooasi
    Safe = false, -- it blocks cheater to burn people
    SafeLoopTime = 100, -- don't change it // Default 100
    AntiArmourHack = false,
    MaxArmour = 100,
    MenuDetection = true,
    AntiLagSwitch = true,
    FreeCam = false,
    ScreenshotBasicName = 'screenshot-basic',
    AntiDrown = true,
    AntiSoundSpam = false, -- its blocks cheater to sound spam everyone. if u will use this +0.02 ms
    EulenFreecamDetection = false, -- its blocks eulen freecam cheats
    EulenSpectateDetection = false, -- its blocks eulen spectate cheats
    EulenHealDetection = false, -- its blocks eulen heal cheats
    AntiKillInvisible = false,
    AntiKillEulen = true,
    AntiHitBoxHack = true,
    PickupHack = true,
    BlockSuspensionHack = true,
    DisableTyresBurst = false, 
}


ClientConfig.WLScripts = { -- if you add your script here, you will be able to start,stop or restart this script.
    "ws_farming",
    "ws_loader",
}

ClientConfig.AntiLagSwitch = {
    Detection = true,
    Max = 250
}

ClientConfig.Particle = {
    Detection = false,
    RemoveTime = 10000, -- don't change it // default 10000
}

ClientConfig.AntiFly = {
    PlayerProtect = true, -- if true, it protects aganist car fly
    Distance = 20, -- Max Distance // default 20 
    Class = { -- dont change it
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13
    },
    -- its AntiFly method 2
    PlayerProtection2 = true,
    Distance2 = 5
}


ClientConfig.Blacklistkey = {
    Detection = false,
    CoolDown = 60000,
    Screenshot = false,
    BlacklistKeys = { -- you can add or remove blacklisted keys below, // EDIT IT FOR YOUR SERVER AND DONT FORGET TO INSTALL SCREENSHOTBASIC !
        {key = 121, name = 'INSERT', kick = false},
        {key = 212, name = 'HOME', kick = false},
    },
}

ClientConfig.SpawnVehicle = { -- Anti car spawn
    Detection = false,
    CoolDown = 1000,
    NpcVehicle = false,
    AllowedResources = {
        ['esx_cardealer'] = true,
    },
    DonateCars = { -- its block donate car spawn -- ITS IMPORTANT
        [GetHashKey('i8')] = true,
    }
}

ClientConfig.Weapons = {
    Detection = true, -- if true, you activate blacklisted weapon option. (we recommend you to keep it true)
    AntiExplosiveWeapons = true, -- if true, you block explosive weapons
    RemoveBlacklistWeapon = true, -- if true, it deletes ONLY blacklisted weapon from inventory
    RemoveAllWeapons = false, -- when it detects blacklisted weapon in player's or cheater's inventory it deletes ALL weapons on him (we recommend you to keep it true)
    BLWeaponLog = true, -- it shows on logs(webhook on discord) use of blacklisted weapons
    InfiniteAmmoBlock = true,
    LoopTime = 10000, -- don't change it
    DamageBoostDetection = true,
    MaxDamageModify = 1, --
}

ClientConfig.WhitelistedWeapons = {
    [GetHashKey('WEAPON_UNARMED')] = true,
    [GetHashKey('WEAPON_FLASHLIGHT')] = true,
    [GetHashKey('WEAPON_NIGHTSTICK')] = true,
    [GetHashKey('WEAPON_STUNGUN')] = true,
    [GetHashKey('WEAPON_PISTOL')] = true,
    [GetHashKey('WEAPON_PISTOL_MK2')] = true,
    [GetHashKey('WEAPON_COMBATPISTOL')] = true,
    [GetHashKey('WEAPON_SMG')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE')] = true,
    [GetHashKey('WEAPON_SNIPERRIFLE')] = true,
    [GetHashKey('GADGET_PARACHUTE')] = true,
    [GetHashKey('WEAPON_PEPPERSPRAY')] = true,
    [GetHashKey('WEAPON_ANTIDOTE')] = true,
    [GetHashKey('WEAPON_MICROSMG')] = true,
    [GetHashKey('WEAPON_KNUCKLE')] = true,
    [GetHashKey('WEAPON_SWITCHBLADE')] = true,
    [GetHashKey('WEAPON_BAT')] = true,
    [GetHashKey('WEAPON_MACHETE')] = true,
    [GetHashKey('WEAPON_PISTOL50')] = true,
    [GetHashKey('WEAPON_FLAREGUN')] = true,
    [GetHashKey('WEAPON_REVOLVER')] = true,
    [GetHashKey('WEAPON_DOUBLEACTION')] = true,
    [GetHashKey('WEAPON_NAVYREVOLVER')] = true,
    [GetHashKey('WEAPON_MICROSMG')] = true,
    [GetHashKey('WEAPON_DBSHOTGUN')] = true,
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = true,
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = true,
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = true,
    [GetHashKey('WEAPON_COMPACTRIFLE')] = true,
    [GetHashKey('WEAPON_TACTICALRIFLE')] = true,
    [GetHashKey('WEAPON_GUSENBERG')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = true,
    [GetHashKey('WEAPON_PRECISIONRIFLE')] = true,
    [GetHashKey('WEAPON_PETROLCAN')] = true,
    [GetHashKey('WEAPON_SNOWBALL')] = true,
    [GetHashKey('WEAPON_FLASHBANG')] = true,
    [966099553] = true, -- Default Fivem weapon, not delete this.
    [0] = true, -- Default Fivem weapon, not delete this.
}