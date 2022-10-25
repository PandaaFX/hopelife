Config = {}
-- Accounts for rewards
Config.Accounts = {
    bank = "bank",
    black_money = "black_money"
}

Config.ESXSetting = {
    shared = 'esx:getSharedObject',
    ESX = ESX,
    esx = esx, 
}

-- Webhook

Config.ParkInAll = true -- do you want to restore every car after every restart?

-- functions
function notify(src, msg)
	TriggerClientEvent("esx:showNotification", src, msg) -- serverside
end

function cnotify(msg)
    Config.ESXSetting.ESX.ShowNotification(msg)-- clientside
end

Config.Impoundcommand = "Unpound" -- the command for buying a car 
Config.Impoundprice = 10000 -- from Config.Frakgarageaccount
Config.TestDriveTime = 10 -- in seconds
Config.Frakgarageaccount = "bank"
Config.DisableTestDrive = true -- do you want to disable test drive (this is currently for some peopels buggy)
Config.Frakgarageped = GetHashKey("csb_chin_goon")
Config.Frakgarageblip = {
    name = "Frakgarage (%s)", -- %s = jobname / joblabel
    sprite = 1, 
    scale = 1.0,
    color = 1,
    shortrange = true
}
Config.FrakgarageParkinMarker = {
    type = 1, -- parkIn marker
    type2 = 1, -- menu marker
    size = 5.0, -- size for the parkin marker
    size2 = 2.0, -- size for the menu marker
    color = {100, 100, 100, 100}, -- rgba
    jump = true,
}
Config.Frakgarages = {
    {
        useblip = true,
        job = "admin",
        joblabel = "admin",
        colorPrimary = {222, 33, 444}, --r g b a+
        colorSecondary = {344, 121, 12},
        coords = {
            ["garage"] = {
                open = vector3(-147.810989, 923.221985, 235.706909),
                parkIn = vector3(-145.727478, 915.085693, 235.639526 - 1),
                parkout = vector3(-145.727478, 915.085693, 235.639526),
                parkoutheading = 223.937012, 
                pheading = 34,
                cam = vector4(-141.797806, 924.725281, 236.667358, 48.188972)
            },
        },
        cars = { -- Cars for the shop
            {
                label = "T20", -- Label
                name = "t20", -- carname / spawnname
                price = 1, -- price
            },
            {
                label = "Schafter",
                name = "schafter3",
                price = 1,
            },
        },
    },
    {
        useblip = true,
        job = "ambulance",
        joblabel = "LSPD",
        colorPrimary = {222, 33, 444}, --r g b a+
        colorSecondary = {344, 121, 12},
        coords = {
            ["garage"] = {
                open = vector3(323.3346, -1369.3066, 31.9124),
                parkIn = vector3(314.1808, -1370.8956, 31.8299 - 1),
                parkout = vector3(319.7079, -1370.9806, 31.9028),
                parkoutheading = 100, 
                pheading = 34,
                cam = vector4(313.2252, -1369.2487, 36.0448, 262.8079)
            },
        },
        cars = { -- Cars for the shop
            {
                label = "T20", -- Label
                name = "t20", -- carname / spawnname
                price = 50000, -- price
            },
            {
                label = "Schafter",
                name = "schafter3",
                price = 1000,
            },
        },
    },
}

tune = function(car, currJob) -- this will be applied after you parkout a car
    --[[
        Job request example
        if currJob == "police" then
            ...
        elseif currJob == "ambulance" then
            ...
        end
    ]]
    SetPedIntoVehicle(PlayerPedId(), car, -1)
    Config.ESXSetting.ESX.Game.SetVehicleProperties(car, {
        wheelColor = nil,
        dirtLevel = 0,
        neonEnabled = {false, false, false, false},
        neonColor = nil,
        modEngine = 3,
        modTransmission = 2,
        modTurbo = true,
        modWindows = 2,
        modBrakes = 100,
        fuelLevel = 100,
        modXenon = true,
        windowTint = 1,
        modSmokeEnabled = true,
        modFrontBumper = 1,
        modRearBumper = 2,
        modSpoilers = 1,
        modRightFender = 2,
        modLeftFender = 2,
        modExhaust = 2,
        modSideSkirt = 1,
        tyreSmokeColor = nil,
        plateIndex = 1,
        modLivery = nil
    })
end

Config.Locales = {
    ["pressEtoopenfrakgarage"] = "Drücke ~Input_context~ um die Frakgarage zu öffnen",
    ["boughtCar"] = "Du hast ein %s gekauft, er wurde dir in die Garage geliefert",
    ["nomoney"] = "Dir fehlt %s $ auf deinem Bank Konto",
    ["closedCar"] = "Du hast das Auto abgeschlossen",
    ["openCar"] = "Du hast das Auto aufgeschlossen",
    ["alreadyParkedout"] = "Das Fahrzeug wurde bereits ausgeparkt!",
    ["pressEtoparkIn"] = "Drücke ~Input_context~ um dein Fahrzeug einzuparken",
    ["carisnotout"] = "Dein Fahrzeug ist nicht ausgeparkt",
    ["carparkedin"] = "Du hast das Fahrzeug erfolgreich eingeparkt",
    ["plate"] = "Kennzeichen: %s",
    ["wrongJob"] = "Du hast den falschen Job um das Fahrzeug einzuparken",
    ["TestDriveTime"] = "Du hast %s Sekunden Zeit das Fahrzeug zu testen",
    ["TestdriveOver"] = "Die Testfahrt Zeit ist rum",
    ["InvalidPlate"] = "Das Kennzeichen existiert nicht",
    ["carisnotout"] = "Das Fahrzeug muss ausgeparkt sein",
    ["wrongJob"] = "Du hast den falschen Job",
    ["impounded"] = "Du hast dein Fahrzeug freigekauft!",
    ["oncooldown"] = "Warte bitte bevor du den Command used!",
    ["wrongPlate"] = "Es existiert kein Fahrzeug mit diesem Kennzeichen",
    [""] = "",
    [""] = "",
    [""] = "",
    [""] = "",
    [""] = "",
    [""] = "",
    [""] = "",
    [""] = "",
    [""] = "",
}
-- Debug
Config.Debug = {
    prints = true,
    commands = true
}

