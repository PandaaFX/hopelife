Config = Config or {}

-- Enables the version checher on resource start (if enabled and the resource is out of date it will print in server console)
Config.EnableVersionChecker = true

-- The derailCard position on the top of the screen (0 = right, 1 = left)
Config.detailCardMenuPosition = 1

-- The cash amount position on the top of the screen (0 = right, 1 = left)
Config.cashPosition = 1

-- If this turned off every mechanic position will be able to to cosmetics and upgrades otherwise only whitelist job can do upgrades 
Config.IsUpgradesOnlyForWhitelistJobPoints = false

-- The key to access the mechanic menu, the key code and the name can be found here: https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    action = {key = 38, label = 'E', name = '~INPUT_PICKUP~'}
}

-- Enable this to save the vehicle properties (on apply) in database in the table `owned_vehicles` in field `vehicle`
-- by default you will need `mysql-async` (https://github.com/brouznouf/fivem-mysql-async) for the database connection (uncomment the '@mysql-async/lib/MySQL.lua' in file `fxmanifest.lua`)
-- if you want to use another library for your database connection you should modify the function `saveVehicleProperties` in file `config/server_functions.lua`
Config.AutoSaveVehiclePropertiesOnApply = false

-- The default values access disrance from position if "Config.Positions" misses the value actionDistance
Config.DefaultActionDistance = 8.0

-- The default values for the blip if "Config.Positions" misses the value "blip = {}"
Config.DefaultBlip = {
    enable = true,
    type = 72,
    color = 0,
    title = 'Mechanic',
    scale = 0.5
}

-- The default values for the marker if "Config.Positions" misses the value "marker = {}"
-- The marker will only display while you are insade a vehicle and inside the `drawDistance` of each position
--      drawDistance: the dinstance from the player that the marker will draw
--      enable: if marker will draw at all or not
--      type: the type of the marker (https://docs.fivem.net/docs/game-references/markers/)
--      positionOffset: offset from the position pos
--      direction: component of the direction vector for the marker
--      rotation: rotation for the marker. Only used if the direction vector is 0.0
--      scale: the scale for the marker
--      color: marker color r: red, g: green, b: blue, a: alpha (opacity)
--      bobUpAndDownAlways: whether or not the marker should slowly animate up/down always
--      bobUpAndDownOnAccess: whether or not the marker should slowly animate up/down only if you are in range for action
--      faceCamera: if should constantly face the camera
--      rotating: if should constantly rotating
Config.DefaultMarker = {
    drawDistance = 20.0,
    enable = false,
    type = 36,
    positionOffset = {x = 0.0, y = 0.0, z = 1.0},
    direction = {x = 0.0, y = 0.0, z = 0.0},
    rotation = {x = 0.0, y = 0.0, z = 0.0},
    scale = {x = 2.0, y = 3.0, z = 2.0},
    color = {r = 255, g = 255, b = 255, a = 100},
    bobUpAndDownAlways = false,
    bobUpAndDownOnAccess = true,
    faceCamera = false,
    rotating = true
}

-- Add or remove position for mechanic access points
-- if any position miss the property "whitelistJobName" will be open for anyone and the price will have the multiple of "Config.PriceMultiplierWithoutTheJob" in "config/prices.lua"
-- if any position miss the property "societyName" will use player cash, otherwise will use society account money (this only can be used if this point has the property "whitelistJobName") (https://github.com/esx-framework/esx_society)
-- if any position miss the property "blip = {}" will be the default as seen above "Config.DefaultBlip"
-- if any position miss the property "actionDistance" will be the default as seen above "Config.DefaultActionDistance"
Config.Positions = {
    { -- bennys
    pos = {x = -223.1, y = -1327.24, z = 30.69},
    whitelistJobName = 'mechanic',
    societyName = 'society_mechanic', -- uncomment this to enable society account for this point (only for whitelist points)
    blip = {
        enable = true,
        type = 446,
        color = 44,
        title = 'Bennys',
        scale = 0.8
    },
    marker = {
        enable = true,
        type = 30,
        positionOffset = {x = 0.0, y = 0.0, z = 0.3},
        scale = {x = 1.0, y = 1.0, z = 1.0},
        color = {r = 0, g = 0, b = 0, a = 150},
    },
    actionDistance = 25.0
},
{ -- bennys outdoor
    pos = {x = -163.67, y = -1301.82, z = 31.34},
    whitelistJobName = 'mechanic',
    societyName = 'society_mechanic', -- uncomment this to enable society account for this point (only for whitelist points)
    blip = {
        enable = false,
        type = 72,
        color = 0,
        title = 'Bennys',
        scale = 0.8
    },
    marker = {
        enable = true,
        type = 30,
        positionOffset = {x = 0.0, y = 0.0, z = 0.3},
        scale = {x = 1.0, y = 1.0, z = 1.0},
        color = {r = 0, g = 0, b = 0, a = 150},
    },
    actionDistance = 10.0
},
{ -- soa 
pos = {x = 352.826385, y = 3403.239502, z = 36.457886},
whitelistJobName = 'soa',
societyName = 'society_soa', -- uncomment this to enable society account for this point (only for whitelist points)
blip = {
    enable = true,
    type = 446,
    color = 44,
    title = 'SOA',
    scale = 0.8
},
marker = {
    enable = true,
    type = 30,
    positionOffset = {x = 0.0, y = 0.0, z = 0.3},
    scale = {x = 1.0, y = 1.0, z = 1.0},
    color = {r = 0, g = 0, b = 0, a = 150},
},
actionDistance = 25.0
},
{ -- outlaws
pos = {x = 140.20, y = -3030.32, z = 7.04},
whitelistJobName = 'outlaws',
-- societyName = 'society_mechanic', -- uncomment this to enable society account for this point (only for whitelist points)
blip = {
enable = false,
    type = 446,
    color = 44,
    title = 'outlaws',
    scale = 0.8
},
marker = {
    enable = false,
    type = 30,
    positionOffset = {x = 0.0, y = 0.0, z = 0.3},
    scale = {x = 1.0, y = 1.0, z = 1.0},
    color = {r = 0, g = 0, b = 0, a = 150},
},
actionDistance = 10.0
},
{ -- outlaws boote
pos = {x = 93.151657, y = -2988.633057, z = 1.578735},
whitelistJobName = 'outlaws',
-- societyName = 'society_mechanic', -- uncomment this to enable society account for this point (only for whitelist points)
blip = {
enable = false,
    type = 446,
    color = 44,
    title = 'outlaws',
    scale = 0.8
},
marker = {
    enable = false,
    type = 30,
    positionOffset = {x = 0.0, y = 0.0, z = 0.3},
    scale = {x = 1.0, y = 1.0, z = 1.0},
    color = {r = 0, g = 0, b = 0, a = 150},
},
actionDistance = 10.0
},
{ -- outlaws heli
pos = {x = 167.090103, y = -3047.907715, z = 5.858643},
whitelistJobName = 'outlaws',
-- societyName = 'society_mechanic', -- uncomment this to enable society account for this point (only for whitelist points)
blip = {
enable = false,
    type = 446,
    color = 44,
    title = 'outlaws',
    scale = 0.8
},
marker = {
    enable = false,
    type = 30,
    positionOffset = {x = 0.0, y = 0.0, z = 0.3},
    scale = {x = 1.0, y = 1.0, z = 1.0},
    color = {r = 0, g = 0, b = 0, a = 150},
},
actionDistance = 10.0
},
--{ -- ls customs
--    pos = {x = -338.93, y = -135.96, z = 38.33},
--    whitelistJobName = 'ls_customs',
--   marker = {
--        enable = true
--    },
--},
{ -- paleto
    pos = {x = 110.89, y = 6626.35, z = 31.10},
    blip = {
        enable = true,
        type = 72,
        color = 0,
        title = 'Tuning',
        scale = 0.8
    },
    marker = {
        enable = true,
        type = 30,
        positionOffset = {x = 0.0, y = 0.0, z = 0.3},
        scale = {x = 1.0, y = 1.0, z = 1.0},
        color = {r = 0, g = 0, b = 0, a = 150},
    },
    actionDistance = 7.0
},
{ -- LSIA
    pos = {x = -1154.03, y = -2005.59, z = 13.18},
    blip = {
        enable = true,
        type = 72,
        color = 0,
        title = 'Tuning',
        scale = 0.8
    },
    marker = {
        enable = true,
        type = 30,
        positionOffset = {x = 0.0, y = 0.0, z = 0.3},
        scale = {x = 1.0, y = 1.0, z = 1.0},
        color = {r = 0, g = 0, b = 0, a = 150},
    },
    actionDistance = 7.0
},
{ -- LS Custom
    pos = {x = -339.05, y = -136.34, z = 39.01},
    blip = {
        enable = true,
        type = 72,
        color = 0,
        title = 'Tuning',
        scale = 0.8
    },
    marker = {
        enable = true,
        type = 30,
        positionOffset = {x = 0.0, y = 0.0, z = 0.3},
        scale = {x = 1.0, y = 1.0, z = 1.0},
        color = {r = 0, g = 0, b = 0, a = 150},
    },
    actionDistance = 7.0
},
--{ -- root 68
--    pos = {x = 1174.93, y = 2639.62, z = 37.07}
--}
}
