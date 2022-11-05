Config = {
    Locale = 'de',
    useImages = true, -- you can add images in folder "view/items". The images names must be the same as in your items sql table. e.g. "drill.png"
    handleWeaponsLikeItems = true,
    esx_getSharedObject = 'esx:getSharedObject', -- for security reasons you can customise the esx:getSharedObject event name. Attention if you change it, be sure you have als change it in es_extended
    ignoreMoney = false,
    ignoreBlackMoney = false,
    StoragePositions = {
        {
            name = "lafam", -- job name, must be the same as in your jobs table
            coords = vector3( -3194.650, 833.60, 7.92), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "lafam", -- job name, must be the same as in your jobs table
            coords = vector3(-3197.248291, 836.070313, 8.925293), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "che", -- job name, must be the same as in your jobs table
            coords = vector3(-3031.740723, 87.665939, 12.345825), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "soa", -- job name, must be the same as in your jobs table
            coords = vector3(-562.18, 288.94, 82.18),--adjust angle 259.15? -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "che", -- job name, must be the same as in your jobs table
            coords = vector3(-3031.674805, 89.789017, 12.345825), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "mg13", -- job name, must be the same as in your jobs table
            coords = vector3(1245.956055, -1574.492310, 58.413208), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "saints", -- job name, must be the same as in your jobs table
            coords = vector3(-1739.221924, 373.793396, 89.720093), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "saints", -- job name, must be the same as in your jobs table
            coords = vector3(-1737.758301, 371.142853, 89.720093), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "lcn", -- job name, must be the same as in your jobs table
            coords = vector3(-1537.028564, 96.501099, 56.761963), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "lcn", -- job name, must be the same as in your jobs table
            coords = vector3(-1535.485718, 98.558243, 56.761963), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "outlaws", -- job name, must be the same as in your jobs table
            coords = vector3(128.663742, -3009.454834, 7.038086), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "outlaws", -- job name, must be the same as in your jobs table
            coords = vector3(128.465942, -3013.265869, 7.038086), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "wein", -- job name, must be the same as in your jobs table
            coords = vector3(-1882.681274, 2070.712158, 140.994141), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "police", -- job name, must be the same as in your jobs table
            coords = vector3(620.096680, -11.090107, 76.627808), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "police", -- job name, must be the same as in your jobs table
            coords = vector3(619.635193, -13.727470, 76.627808), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Waffenkammer", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "fib", -- job name, must be the same as in your jobs table
            coords = vector3(2518.720947, -323.103302, 101.885742), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "fib", -- job name, must be the same as in your jobs table
            coords = vector3(2520.857178, -326.096710, 101.885742), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "soa", -- job name, must be the same as in your jobs table
            coords = vector3(2509.094482, 4098.342773, 41.411743), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "soa", -- job name, must be the same as in your jobs table
            coords = vector3(2509.951660, 4096.443848, 41.411743), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "18th", -- job name, must be the same as in your jobs table
            coords = vector3(-17.076920, -1430.400024, 31.099609), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "18th", -- job name, must be the same as in your jobs table
            coords = vector3(-18.421974, -1438.747192, 31.099609), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "tribunal", -- job name, must be the same as in your jobs table
            coords = vector3(-106.41,999.59,235.76), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = 54.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "tribunal", -- job name, must be the same as in your jobs table
            coords = vector3(-100.65,1001.86,235.76), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "mechanic", -- job name, must be the same as in your jobs table
            coords = vector3(-198.250549, -1315.437378, 31.082764), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "mechanic", -- job name, must be the same as in your jobs table
            coords = vector3(-197.340652, -1320.316528, 31.082764), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "club", -- job name, must be the same as in your jobs table
            coords = vector3(-193.12, -343.12, 58.800781), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "kurant", -- job name, must be the same as in your jobs table
            coords = vector3(374.73, -1079.02, 29.48), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        
        {
            name = "hookahlounge", -- job name, must be the same as in your jobs table
            coords = vector3(-444.079102, -35.063736, 46.180176), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "hookahlounge", -- job name, must be the same as in your jobs table
            coords = vector3(-436.457153, -35.828568, 40.872559), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "lssd", -- job name, must be the same as in your jobs table
            coords = vector3(-446.927460, 6016.338379, 36.98022), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "saints", -- job name, must be the same as in your jobs table
            coords = vector3(-1842.685669, -1184.940674, 14.300415), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "LagerKüche", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "sinaloa", -- job name, must be the same as in your jobs table
            coords = vector3(-2600.887939, 1916.782471, 167.296753), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "sinaloa", -- job name, must be the same as in your jobs table
            coords = vector3(-2590.958252, 1917.837402, 167.296753), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "oblocks", -- job name, must be the same as in your jobs table
            coords = vector3(332.334,-2018.4132,22.337769), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Lager", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        {
            name = "oblocks", -- job name, must be the same as in your jobs table
            coords = vector3(336.158234, -2021.670288, 22.337769), -- position of the location
            enableBlip = false, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            blipLabel = "Tresor", -- -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = true, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = -154.002, -- z position of the subMarker
            },
            enablePed = false, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 65.981, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 50000, price = 20000 },
                { maxStorage = 100000, price = 40000 },
                { maxStorage = 150000, price = 60000 },
                { maxStorage = 250000, price = 100000 },
                { maxStorage = 500000, price = 500000 },
                { maxStorage = 800000, price = 800000 },
                { maxStorage = 1000000, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "1",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        },
        --[[{
            name = "aemechanic", -- job name, must be the same as in your jobs table
            coords = vector3(147.45576477051,-1045.0551757812,28.368034362793), -- position of the location
            enableBlip = true, -- enable Blip on map, if true, display, sprite, scale, color and name are required
            name = "ADAC Storage", -- Name of the Blip
            display = 4, -- see displayId on https://docs.fivem.net/natives/?_0x9029B2F3DA924928
            sprite = 440, -- blip symbol on map, see: https://docs.fivem.net/docs/game-references/blips/
            scale = 1.2, -- scale of blip
            color = 24, -- color of blip, see https://docs.fivem.net/docs/game-references/blips/
            radius = 2.0, -- Radius of the action to open the menu
            viewZone = false, -- view register register zone in game, if true marker, rgba and subMarker is needed
            marker = 27, -- marker type see https://docs.fivem.net/docs/game-references/checkpoints/
            rgba = { 120, 255, 120, 155 }, -- color of marker
            subMarker = {
                marker = 20, -- marker type see https://docs.fivem.net/docs/game-references/markers/
                posZ = 29.002, -- z position of the subMarker
            },
            enablePed = true, -- Enable the ped. pedModel and pedOrientation is needed if you enable this options
            pedModel = "s_m_y_airworker", -- ped model, see https://docs.fivem.net/docs/game-references/ped-models/
            pedOrientation = 59.575, -- orientation of the ped
            level = { -- player can extend the storage. Define here the capacity and the price for the different levels.
                { maxStorage = 500, price = 200000 },
                { maxStorage = 1000, price = 400000 },
                { maxStorage = 1500, price = 600000 },
                { maxStorage = 2500, price = 1000000 },
            },
            useBlackMoneyForUpgrade = false, -- use black money instead of money to upgrade the store
            policeJobNameInYourDatabase =  "police", -- config here the job name of your police job.
            policeRolesThatCanAccess = { -- set here the police grade names
                "captain",
                "boss"
            },
            policeCanOpenStorage = false, -- enable or disable the access for cops. If enabled only configured grades can access
        }]]--
    }
}
