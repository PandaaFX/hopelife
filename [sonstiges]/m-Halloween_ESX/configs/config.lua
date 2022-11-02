Config = {}

Config.Core = "esx:getSharedObject" -- esx:getSharedObject
Config.Menu = "qb-menu" -- Your qb-menu name
Config.Time = true -- Enable time "HALLOWEEN" on server?
Config.Debug = true -- Enable debug?
Config.OX = false -- You use ox-inventory? [ESX]
Config.Progressbar = "qbcore" -- "qbcore", "myhic_progbar", "ox_lib", "quasar"
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
   'a_m_m_eastsa_02',
   'a_m_m_soucent_02',
   'a_m_y_business_01',
   'a_m_y_indian_01',
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
      "phone",
      "goldchain",
   },
   ItensRare = {
      "lockpick",
      "advancedlockpick",
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
      knockDoor = "Knock Door",
      pickPumpkin = "Pick Pumpkin",
      tradePumpkins = "Trade Pumpkins",
   },
   Notify = {
      eventStarted = "Event Halloween Started!",
      doorsRestarted = "All doors restarted!",
      sameDoor = "I already give you something! Run away!",
      zombieNotify = "What are you doing here? GO AWAY!!!",
      noSpace = "You don't have space in your inventory.",
      noPumpkins = "You don't have enough pumpkins",
   },
   Progressbars = {
      pickPumpkin = "Picking up the pump...",
   },
   qbMenu = {
      headerMenu = "Tranding Pumpkins",
      txtHeader = "Here you can exchange pumpkins for valuable items!",
      amount = "Amount:",
      pumpkins = "pumpkins",
      close = "Close"
   }
}

------------- 
--- Pumpkins & Trading Ped
------------

Config.Objects = {
   -- Ped trading pumpkins
   { ["x"] = 892.62, ["y"] = 3612.46, ["z"] = 32.82, ["h"] = 230.66, ["model"] = "prop_water_corpse_02" },
   -- Sandy Shores
   { ["x"] = 1343.52, ["y"] = 4307.95, ["z"] = 37.97-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 1274.87, ["y"] = 4392.75, ["z"] = 46.18-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 1186.33, ["y"] = 4404.85, ["z"] = 60.40-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 1121.31, ["y"] = 4459.51, ["z"] = 64.63-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 998.76, ["y"] = 4519.80, ["z"] = 83.78-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 843.89, ["y"] = 4509.38, ["z"] = 53.78-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 757.88, ["y"] = 4401.21, ["z"] = 103.76-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 828.57, ["y"] = 4222.88, ["z"] = 52.03-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 762.94, ["y"] = 4180.00, ["z"] = 40.59-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 702.66, ["y"] = 4174.14, ["z"] = 40.96-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 574.10, ["y"] = 4175.24, ["z"] = 38.23-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 530.72, ["y"] = 4225.45, ["z"] = 54.89-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 382.39, ["y"] = 4369.43, ["z"] = 63.16-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 275.05, ["y"] = 4321.76, ["z"] = 45.96-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 268.76, ["y"] = 4404.82, ["z"] = 47.18-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 176.85, ["y"] = 4403.42, ["z"] = 75.95-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 102.29, ["y"] = 4417.92, ["z"] = 71.35-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -60.08, ["y"] = 4407.37, ["z"] = 56.60-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -88.85, ["y"] = 4430.73, ["z"] = 74.45-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -370.26, ["y"] = 4356.50, ["z"] = 55.24-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -433.81, ["y"] = 4342.57, ["z"] = 60.27-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -505.03, ["y"] = 4349.92, ["z"] = 67.19-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -681.89, ["y"] = 4392.19, ["z"] = 26.29-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -837.01, ["y"] = 4414.09, ["z"] = 20.10-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -885.11, ["y"] = 4431.31, ["z"] = 20.93-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -978.17, ["y"] = 4411.26, ["z"] = 19.87-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -1139.02, ["y"] = 4416.25, ["z"] = 11.46-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -1197.16, ["y"] = 4436.93, ["z"] = 30.85-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -1346.48, ["y"] = 4417.34, ["z"] = 29.76-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   -- Paleto Bay
   { ["x"] = -391.01, ["y"] = 6072.50, ["z"] = 31.50-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -425.23, ["y"] = 6167.06, ["z"] = 31.48-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -389.12, ["y"] = 6195.73, ["z"] = 31.49-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -338.53, ["y"] = 6115.24, ["z"] = 31.45-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -432.69, ["y"] = 6242.61, ["z"] = 30.89-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -417.20, ["y"] = 6309.51, ["z"] = 28.58-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -365.89, ["y"] = 6324.83, ["z"] = 29.86-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -311.13, ["y"] = 6375.53, ["z"] = 30.55-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -256.79, ["y"] = 6433.23, ["z"] = 30.17-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -201.42, ["y"] = 6541.70, ["z"] = 11.10-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -69.92, ["y"] = 6553.71, ["z"] = 31.49-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -34.71, ["y"] = 6637.11, ["z"] = 30.33-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -84.50, ["y"] = 6680.96, ["z"] = 35.07-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 198.12, ["y"] = 6628.44, ["z"] = 31.55-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   -- Los Santos
   { ["x"] = -292.04, ["y"] = -764.27, ["z"] = 53.25-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -130.15, ["y"] = -838.90, ["z"] = 44.22-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = -55.86, ["y"] = -898.79, ["z"] = 41.55-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 183.16, ["y"] = -1087.76, ["z"] = 29.28-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 256.45, ["y"] = -1156.20, ["z"] = 29.26-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 305.60, ["y"] = -1243.79, ["z"] = 29.49-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 419.51, ["y"] = -1332.68, ["z"] = 46.05-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 463.16, ["y"] = -1322.53, ["z"] = 29.44-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 730.90, ["y"] = -1318.04, ["z"] = 26.32-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
   { ["x"] = 949.91, ["y"] = -1407.12, ["z"] = 31.46-1, ["h"] = 69.0, ["model"] = "prop_veg_crop_03_pump" },
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