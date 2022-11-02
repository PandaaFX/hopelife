Config = {}

Config.Core = "esx:getSharedObject" -- esx:getSharedObject
Config.Menu = "qb-menu" -- Your qb-menu name
Config.Time = true -- Enable time "HALLOWEEN" on server?
Config.Debug = true -- Enable debug?
Config.OX = false -- You use ox-inventory? [ESX]
Config.Progressbar = "ox_lib" -- "qbcore", "myhic_progbar", "ox_lib", "quasar"
Config.EventAllRestarts = false -- If true, the event start's automatic when have restart the server
Config.PumpkinReward = 1 -- This is the amount of pumpkin's player receive each pick up

Config.adminRanks = { -- [ESX]
   'superadmin',
   'admin',
   'moderator',
}

Config.Commmands = { -- Commands available
   StartEvent = "halloweenstart",
   StopEvent = "halloweenstop",
   RestartDoors = "restartdoors",
}

Config.Peds = { -- Peds spawning when you knock the door
   'a_f_y_business_02',
   'a_m_m_genfat_01',
   'a_m_m_farmer_01',
   'a_m_y_salton_01',
   'u_m_y_zombie_01', -- If the ped is that zombie, then the player dont get reward, and have some laught scare sound! :)
}

Config.BlipSettings = {
   blipEnable = true,
   blipSprite = 489,
   blipDisplay = 4,
   blipScale = 0.65,
   blipColour = 1,
   blipName = "Süßes oder Saures",
}

Config.Drops = { -- This is the drops when people go knock doors
   RareDrops = true, -- Enable rare drops?
   ChanceRare = 50, -- Chance to get rare drop 50%
   Amount = {
      min = 2,
      max = 4,
   },
   Itens = {
      "sweets",
      "schoko",
      "cocktail",
      "pumpkin"
   },
   ItensRare = {
      "ticket",
   }
}

Config.Trade = { -- The people can trade pumpkin's for items, here you put the item and the amount of pumpkin's needed to trade
   [1] = {
       item = "phone", -- Item received
       amount = 5, -- Amount of pumpkins needed
   },
   [2] = {
       item = "goldchain", -- Item received
       amount = 15, -- Amount of pumpkins needed
   },
}

------------- 
--- Language
------------
Config.Language = {
   qbTarget = {
      knockDoor = "Klopf Klopf",
      pickPumpkin = "Kürbis Nehmen",
      tradePumpkins = "Kürbisse tauschen",
   },
   Notify = {
      eventStarted = "Halloween Event gestartet! Viel Spaß",
      doorsRestarted = "Alle Türen zurückgestzt",
      zombieNotify = "Du will die. WraaWrrrrwrwww",
      noSpace = "Du hast keinen Platz im Rucksack",
      noPumpkins = "Du hast nicht genug Kürbisse",
   },
   Progressbars = {
      pickPumpkin = "Kürbis aufnehmen.....",
   },
   qbMenu = {
      headerMenu = "Kürbisverkauf",
      txtHeader = "Hier kannst du deine Kürbisse eintauschen",
      amount = "Menge",
      pumpkins = "Kürbisse",
      close = "Schließen"
   }
}

------------- 
--- Pumpkins & Trading Ped
------------

Config.Objects = {
   -- Ped trading pumpkins
   { Location = vector4(892.62, 3612.46, 32.82, 230.66), ["model"] = "prop_water_corpse_02" },
   -- Sandy Shores
   { Location = vector4(1343.52, 4307.95, 37.97-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(1274.87, 4392.75, 46.18-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(1186.33, 4404.85, 60.40-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(1121.31, 4459.51, 64.63-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(998.76, 4519.80, 83.78-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(843.89, 4509.38, 53.78-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(757.88, 4401.21, 103.76-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(828.57, 4222.88, 52.03-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(762.94, 4180.00, 40.59-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(702.66, 4174.14, 40.96-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(574.10, 4175.24, 38.23-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(530.72, 4225.45, 54.89-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(382.39, 4369.43, 63.16-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(275.05, 4321.76, 45.96-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(268.76, 4404.82, 47.18-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(176.85, 4403.42, 75.95-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(102.29, 4417.92, 71.35-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-60.08, 4407.37, 56.60-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-88.85, 4430.73, 74.45-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-370.26, 4356.50, 55.24-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-433.81, 4342.57, 60.27-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-505.03, 4349.92, 67.19-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-681.89, 4392.19, 26.29-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-837.01, 4414.09, 20.10-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-885.11, 4431.31, 20.93-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-978.17, 4411.26, 19.87-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-1139.02, 4416.25, 11.46-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-1197.16, 4436.93, 30.85-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-1346.48, 4417.34, 29.76-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   -- Paleto Bay
   { Location = vector4(-391.01, 6072.50, 31.50-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-425.23, 6167.06, 31.48-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-389.12, 6195.73, 31.49-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-338.53, 6115.24, 31.45-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-432.69, 6242.61, 30.89-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-417.20, 6309.51, 28.58-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-365.89, 6324.83, 29.86-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-311.13, 6375.53, 30.55-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-256.79, 6433.23, 30.17-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-201.42, 6541.70, 11.10-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-69.92, 6553.71, 31.49-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-34.71, 6637.11, 30.33-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-84.50, 6680.96, 35.07-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(198.12, 6628.44, 31.55-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   -- Los Santos
   { Location = vector4(-292.04, -764.27, 53.25-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-130.15, -838.90, 44.22-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(-55.86, -898.79, 41.55-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(183.16, -1087.76, 29.28-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(256.45, -1156.20, 29.26-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(305.60, -1243.79, 29.49-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(419.51, -1332.68, 46.05-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(463.16, -1322.53, 29.44-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(730.90, -1318.04, 26.32-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
   { Location = vector4(949.91, -1407.12, 31.46-1, 69.0), ["model"] = "prop_veg_crop_03_pump" },
}


------------- 
--- Notify
------------
function Notify(msg, type)
   if type == "primary" then 
      exports['mythic_notify']:DoHudText('inform', msg)
   end
   if type == "success" then
      exports['mythic_notify']:DoHudText('success', msg)
   end
   if type == "error" then
      exports['mythic_notify']:DoHudText('error', msg)
   end
end


function ChangeTime()
   SetWeatherTypePersist("HALLOWEEN")
   SetWeatherTypeNowPersist("HALLOWEEN")
   SetWeatherTypeNow("HALLOWEEN")
   SetOverrideWeather("HALLOWEEN")
   NetworkOverrideClockTime(0, 00, 00)
   SetClockTime(0, 0, 0)
   PauseClock(true)
   Wait(0)
end