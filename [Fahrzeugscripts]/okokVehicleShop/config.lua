Config = {}

Config.ESX11 = false -- If you are using ESX 1.1 and are having troubles with the hand money

Config.CheckForOfflineOrders = true

Config.MoneyID = "bank" -- For ESX 1.1

Config.SetVisibility = true -- true = player will be invisible when chosing a vehicle

Config.SetInvincibility = true -- true = player will not die while test driving

Config.CheckForOfflineOrdersEvery = 0.5 -- In minutes | it'll check every x minutes for offline players with orders accepted, if someone is offline it'll cancel the order

Config.ShowVehicleShopBlip = true -- Activate/Deactivate Vehicle shop blips

Config.ShowOwnerBlip = false -- Activate/Deactivate owner blips

Config.ShowBuyVehicleShopBlip = false -- Activate/Deactivate buy shop blip

Config.ShowHasOwnerShopBlip = false -- Activate/Deactivate blip of shops with "hasOwner = false"

Config.TestDrive = true -- Activate/Deactivate test drive

Config.DevMode = false -- Allows you to restart the script (IMPORTANT: only set this to true if you are configuring the script)

Config.EventPrefix = "okokVehicleShop" -- this will change the prefix of the events name so if Config.EventPrefix = "example" the events will be "example:event"

Config.ESXPrefix = "esx" -- this will change the prefix of esx events such as esx:onPlayerDeath

Config.onPlayerDeath = "onPlayerDeath"

Config.playerLoaded = "playerLoaded"

Config.getSharedObject = "getSharedObject"

Config.TestDrivePlate = "TEST"

Config.UseOkokTextUI = false -- true = okokTextUI (I recommend you using this since it is way more optimized than the default ShowHelpNotification) | false = ShowHelpNotification

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.UseokokRequests = false -- true = use okokRequests for hiring people | false = don't use okokRequests - https://okok.tebex.io/package/4724985

Config.UseSameImageForVehicles = true -- true = use the same image for all vehicles (vehicle.png) | false = use different images for each vehicle (vehicle_id.png)

Config.HideMinimap = true -- If true it'll hide the minimap when the vehicle shop menu is opened

Config.TimeBetweenTransition = 7000 -- how much time it stays in a camera before changing, in miliseconds

Config.TransitionTime = 4000 -- how much time it takes to go from one camera to another (camera movement), in miliseconds

Config.ShakeAmplitude = 0.2 -- camera shake

Config.UseKMh = true -- true = use KM/h | false = use miles/h

Config.MaxVehiclesSpeed = 450 -- Max speed a vehicle can go at (it is only used for UI purposes, it does NOT change the speed of a vehicle)

Config.TestDriveTime = 40 -- In seconds

Config.StopTestDriveCmd = "cancel" -- command to stop the test drive

Config.PlateLetters  = 3 -- How many letters the plate has

Config.PlateNumbers  = 3 -- How many numbers the plate has

Config.PlateUseSpace = true	-- If the plate uses spaces between letters and numbers

Config.OrderCompletedPercentage = 10 -- When a employee completes the misson he will get this percentage as a reward, 10 = 10%

Config.HireRange = 3 -- How close a player needs to be to be in the hiring range

Config.AdminCommand = "vsadmin" -- command to open the admin menu

Config.OwnerBuyVehiclePercentage = 10 -- How much of a discount the owner has to order a vehicle (bases on the min. price)

Config.SellBusinessReceivePercentage = 50 -- How much a player will receive for selling his business (in percentage, 50 = 50%)

Config.ClearMoneyWhenBusinessIsSold = false -- true = remove the money from the society when sold | false = do not remove the money

Config.MaxDealershipsPerPlayer = 1 -- How many vehicle shops a player can own

Config.MaxEmployeesPerDealership = 10 -- How many employees a vehicle shop can hire

Config.EnableSellVehicle = true -- Allows players to sell their vehicles for a percentage of the vehicle's min price

Config.VehicleShopBuyVehicle = true -- true = when selling a bought vehicle the money will be discounted from the vehicle shop and the vehicle added to the stock | false = vehicle shop will not be charged or receive the vehicle

Config.VehicleSellPercentage = 40 -- 40 = seller will receive 40% of the vehicle min. price

Config.EnableOkokBankingTransactions = true -- true = when you buy a vehicle a transaction is added (okokBanking)

Config.AdminGroups = { -- Admin groups that can access the admin menu
	"superadmin",
	"admin",
	"dev"
}

Config.JobRanks = { -- These are the ranks available on the vehicle shops, you can add or remove as many as you want but leave at least 1
	"Neuling",		-- ID: 1
	"Fahrer",	-- ID: 2
	"Verkäufer",		-- ID: 3
	"Stelv.Besitzer"		-- ID: 4 
}

Config.SubOwnerRank = 4 -- ID of the rank that will work as a secondary owner

Config.MissionForStock = true -- false = when you order a vehicle, the vehicle shop will instantly receive it without doing any order/mission

Config.TruckBlip = {blipId = 67, blipColor = 2, blipScale = 0.9, blipText = "Truck"} -- Blip of the truck when someone accepts an order

Config.TrailerBlip = {blipId = 515, blipColor = 2, blipScale = 0.9, blipText = "Trailer"} -- Blip of the trailer when someone accepts an order (for vehicle shops with big vehicles)

Config.OrderBlip = {blipId = 478, blipColor = 5, blipText = "Order"}  -- Blip of the ordered vehicle when someone accepts an order

Config.TowMarker = {id = 21, size = {x = 0.5, y = 0.5, z = 0.5}, color = {r = 31, g = 94, b = 255, a = 90}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0} -- The marker to tow a vehicle when someone accepts an order

Config.SmallTowTruckID = "flatbed"

Config.BigTowTruckID = "Hauler"

Config.TrailerID = "TRFlat"

Config.Stands = { -- Vehicle shops informations
	{
		name = "Vehicle Shop", -- name of the vehicle shop
		licenseType = "", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		coords = {x = -57.50, y = -1096.73, z = 26.42}, -- Marker/Shop position
		sellVehicleCoords = {x = -44.72, y = -1082.12, z = 25.50},
		sellVehicleMarker = {id = 1, color = {r = 255, g = 0, b = 0, a = 90}, size = {x = 4.0, y = 4.0, z = 1.5}, radius = 2.5, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the sell vehicle marker
		ownerCoords = {x = -31.66, y = -1114.00, z = 26.42}, -- Marker/Shop position for owner/employees
		spawnFlatbedPos = {x = -16.95, y = -1105.34, z = 26.67, h = 160.0}, -- Where the flatbed/truck is spawned for the orders
		towCoords = {bone = 20, xPos = -0.5, yPos = -5.0, zPos = 1.0},
		missionsVehicleSpawn = { -- Locations where someone who accepted an order will have to go (it is random)
			{x = -465.99, y = -618.22, z = 31.17, h = 100.0},
			--{x = 218.46, y = -850.71, z = 30.16, h = 100.0},
		},
		radius = 1, -- Interaction radius for the markers
		price = 10000, -- Price of the vehicle shop
		blip = {blipId = 225, blipColor = 3, blipScale = 0.9, blipText = "Vehicle Shop"}, -- Blip informations for vehicleshop blip
		ownerBlip = {blipId = 225, blipColor = 2, blipScale = 0.9, blipText = "Vehicleshop Panel"}, -- Blip informations for shops you own/work for
		buyBlip = {blipId = 225, blipColor = 1, blipScale = 0.9, blipText = "Vehicleshop to buy"}, -- Blip informations for shop on sale
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the vehicle shop
		ownerMarker = {id = 21, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the owning menu
		bigVehicles = false, -- Set to true if it's airplanes/helicopters/etc... it'll use a truck instead of a flatbed to get the ordered vehicles
		type = "vehicles", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "car", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	--[[{
		name = "Always Shop",
		licenseType = "",
		currency = "money",
		hasOwner = false, -- when this is false you don't need all the config elements but dont forget to add on Config.ShowVehicle and Config.TransitionCamerasOffset
		coords = {x = -74.93, y = -1116.35, z = 25.43},
		sellVehicleCoords = {x = -70.91, y = -1123.73, z = 24.60},
		sellVehicleMarker = {id = 1, color = {r = 255, g = 0, b = 0, a = 90}, size = {x = 4.0, y = 4.0, z = 1.5}, radius = 2.5, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		radius = 1,
		blip = {blipId = 225, blipColor = 3, blipScale = 0.9, blipText = "Vehicleshop"},
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		type = "vehicles",
		id = "alwaysshop1",
	},]]--
	{
		name = "Motorradshop", -- name of the vehicle shop
		licenseType = "", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = true, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		coords = {x =2474.162598,y= 4114.166992,z= 38.058594}, -- Marker/Shop position
		sellVehicleCoords = {x = 2501.353760, y = 4090.430664, z= 38.496704},
		sellVehicleMarker = {id = 1, color = {r = 255, g = 0, b = 0, a = 90}, size = {x = 4.0, y = 4.0, z = 1.5}, radius = 2.5, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the sell vehicle marker
		ownerCoords = {x = 2519.419678,y= 4108.812988,z= 42.793457}, -- Marker/Shop position for owner/employees
		spawnFlatbedPos = {x = 2521.701172,y= 4140.369141,z= 38.614624,h= 331.653534}, -- Where the flatbed/truck is spawned for the orders
		towCoords = {bone = 20, xPos = -0.5, yPos = -5.0, zPos = 1.0},
		missionsVehicleSpawn = { -- Locations where someone who accepted an order will have to go (it is random)
			{x = 1218.013184,y= -2979.257080,z= 5.858643,h= 331.653534},
			--{x = 218.46, y = -850.71, z = 30.16, h = 100.0},
		},
		radius = 1, -- Interaction radius for the markers
		price = 1, -- Price of the vehicle shop
		blip = {blipId = 226, blipColor = 51, blipScale = 0.8, blipText = "Motorradshop"}, -- Blip informations for vehicleshop blip
		ownerBlip = {blipId = 225, blipColor = 2, blipScale = 0.9, blipText = "Vehicleshop Panel"}, -- Blip informations for shops you own/work for
		buyBlip = {blipId = 225, blipColor = 1, blipScale = 0.9, blipText = "Vehicleshop to buy"}, -- Blip informations for shop on sale
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the vehicle shop
		ownerMarker = {id = 21, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the owning menu
		bigVehicles = false, -- Set to true if it's airplanes/helicopters/etc... it'll use a truck instead of a flatbed to get the ordered vehicles
		type = "motos", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "motos", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		name = "Import Shop", -- name of the vehicle shop
		licenseType = "", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		coords = {x =-755.723083,y= -1438.60217,z= 5.066650}, -- Marker/Shop position
		sellVehicleCoords = {x = -767.920898, y = -1463.208740, z= 5.049805},
		sellVehicleMarker = {id = 1, color = {r = 255, g = 0, b = 0, a = 90}, size = {x = 4.0, y = 4.0, z = 1.5}, radius = 2.5, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the sell vehicle marker
		ownerCoords = {x = -773.129639,y= -1442.769287,z= 5.049805}, -- Marker/Shop position for owner/employees
		spawnFlatbedPos = {x = -745.529663,y= -1469.103271,z= 4.999268,h= 325.984253}, -- Where the flatbed/truck is spawned for the orders
		towCoords = {bone = 20, xPos = -0.5, yPos = -5.0, zPos = 1.0},
		missionsVehicleSpawn = { -- Locations where someone who accepted an order will have to go (it is random)
			{x = 1218.013184,y= -2979.257080,z= 5.858643,h= 331.653534},
			--{x = 218.46, y = -850.71, z = 30.16, h = 100.0},
		},
		radius = 1, -- Interaction radius for the markers
		price = 1, -- Price of the vehicle shop
		blip = {blipId = 326, blipColor = 51, blipScale = 0.8, blipText = "Importshop"}, -- Blip informations for vehicleshop blip
		ownerBlip = {blipId = 225, blipColor = 2, blipScale = 0.9, blipText = "Vehicleshop Panel"}, -- Blip informations for shops you own/work for
		buyBlip = {blipId = 225, blipColor = 1, blipScale = 0.9, blipText = "Vehicleshop to buy"}, -- Blip informations for shop on sale
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the vehicle shop
		ownerMarker = {id = 21, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0}, -- Marker informations for the owning menu
		bigVehicles = false, -- Set to true if it's airplanes/helicopters/etc... it'll use a truck instead of a flatbed to get the ordered vehicles
		type = "vehicles2", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "car2", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		name = "Air Shop",
		licenseType = "",
		currency = "bank",
		hasOwner = false,
		coords = {x = -949.5, y = -2946.55, z = 13.95},
		sellVehicleCoords = {x = -959.5, y = -2946.55, z = 12.76},
		sellVehicleMarker = {id = 1, color = {r = 255, g = 0, b = 0, a = 90}, size = {x = 4.0, y = 4.0, z = 1.5}, radius = 2.5, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		ownerCoords = {x = -941.51, y = -2955.03, z = 13.95},
		spawnFlatbedPos = {x = -947.62, y = -2976.86, z = 13.95, h = 270.0},
		towCoords = {bone = 0, xPos = 0.0, yPos = -2.0, zPos = 1.3},
		missionsVehicleSpawn = {
			{x = -1835.77, y = 2979.52, z = 32.81, h = 100.0},
		},
		radius = 1,
		price = 12000,
		blip = {blipId = 64, blipColor = 3, blipScale = 0.9, blipText = "Flugzeughaendler"},
		ownerBlip = {blipId = 64, blipColor = 2, blipScale = 0.9, blipText = "Air shop Panel"},
		buyBlip = {blipId = 64, blipColor = 1, blipScale = 0.9, blipText = "Fluzeughaendler"},
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		ownerMarker = {id = 21, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		bigVehicles = true,
		type = "air",
		id = "aircraft",
	}, 
	    {
		name = "Water Shop",
		licenseType = "",
		currency = "bank",
		hasOwner = false,
		coords = {x = -720.77, y = -1324.92, z = 1.6},
		sellVehicleCoords = {x = -721.56, y = -1306.7, z = 3.82},
		sellVehicleMarker = {id = 1, color = {r = 255, g = 0, b = 0, a = 90}, size = {x = 4.0, y = 4.0, z = 1.5}, radius = 2.5, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		ownerCoords = {x = -712.16, y = -1298.88, z = 5.1},
		spawnFlatbedPos = {x = -719.77, y = -1286.15, z = 5.0, h = 120.0},
		towCoords = {bone = 0, xPos = 0.0, yPos = -2.0, zPos = 0.9},
		missionsVehicleSpawn = {
			{x = -758.15, y = -1488.26, z = 5.0, h = 280.0},
		},
		radius = 1,
		price = 14000,
		blip = {blipId = 427, blipColor = 3, blipScale = 0.9, blipText = "Bootshändler"},
		ownerBlip = {blipId = 427, blipColor = 2, blipScale = 0.9, blipText = "Water shop Panel"},
		buyBlip = {blipId = 427, blipColor = 1, blipScale = 0.9, blipText = "Bootshändler"},
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		ownerMarker = {id = 21, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0},
		bigVehicles = true,
		type = "water",
		id = "boat",
	   },  
}

Config.ShowVehicle = { -- Display vehicle
	["car"] = { -- ID of the vehicle shop
		position = {x = -44.21, y = -1097.06, z = 26.42, h = 160.0}, -- Where to spawn the display vehicles
		playerOffsetVehiclePreview = {x = 0.0, y = 0.0, z = -1.0}, -- Coordinations offset of where the player will be set when opening the shop
		noVehicleCam = {x = -44.21-1.49, y = -1097.06-7.65, z = 26.42+1.15}, -- Camera position when there is no vehicle to be displayed
		testDrive = {x = -1733.25, y = -2901.43, z = 13.94, h = 330.0}, -- Where to start the test drive
		vehicleSpawn = { -- Where the vehicle spawns when bought
			{x = -27.65, y = -1082.03, z = 26.64, h = 70.0},
			{x = -13.61, y = -1092.4, z = 26.67, h = 340.0},
			{x = -12.16, y = -1082.49, z = 26.68, h = 84.0},
		},
	},
	["aircraft"] = {
		position = {x = -1652.0, y = -3142.69, z = 13.99, h = 70.0},
		playerOffsetVehiclePreview = {x = 0.0, y = 0.0, z = 0.0},
		noVehicleCam = {x = -1652.0-12.49, y = -3142.69-0.65, z = 13.99+2.15},
		testDrive = {x = -1733.25, y = -2901.43, z = 13.94, h = 330.0},
		vehicleSpawn = {
			{x = -1023.91, y = -3060.6, z = 13.94, h = 70.0},
		},
	},
	["boat"] = {
		position = {x = -828.54, y = -1448.08, z = -0.5, h = 70.0},
		playerOffsetVehiclePreview = {x = 0.0, y = 0.0, z = 0.0},
		noVehicleCam = {x = -828.54-12.49, y = -1448.08-0.65, z = -0.5+3.15},
		testDrive = {x = -878.02, y = -1360.32, z = 2.0, h = 330.0},
		vehicleSpawn = {
			{x = -706.78, y = -1333.57, z = 2.0, h = 70.0},
		},
	},
	["motos"] = { -- ID of the vehicle shop
		position = {x = 2489.037354,y= 4118.439453,z = 38.075439,h = 277.795288}, -- Where to spawn the display vehicles
		playerOffsetVehiclePreview = {x = 0.0, y = 0.0, z = -1.0}, -- Coordinations offset of where the player will be set when opening the shop
		noVehicleCam = {x = 2489.037354-1.49, y = 4118.439453-7.65, z = 38.075439+1.15}, -- Camera position when there is no vehicle to be displayed
		testDrive = {x = -1733.25, y = -2901.43, z = 13.94, h = 330.0}, -- Where to start the test drive
		vehicleSpawn = { -- Where the vehicle spawns when bought
			{x = 2492.004395,y= 4131.270508,z= 38.345093,h= 45.354328}
		},
	},
	["car2"] = { -- ID of the vehicle shop
	position = {x = -761.775818,y= -1455.784668,z = 5.083496,h = 45.354328}, -- Where to spawn the display vehicles
	playerOffsetVehiclePreview = {x = 0.0, y = 0.0, z = -1.0}, -- Coordinations offset of where the player will be set when opening the shop
	noVehicleCam = {x = -761.775818-1.49, y = -1455.784668-7.65, z = 5.083496+1.15}, -- Camera position when there is no vehicle to be displayed
	testDrive = {x = -1733.25, y = -2901.43, z = 13.94, h = 330.0}, -- Where to start the test drive
	vehicleSpawn = { -- Where the vehicle spawns when bought
		{x = -745.450562,y= -1468.800049,z= 4.999268,h= 311.811035}
	},
}, 
}

Config.TransitionCamerasOffset = { -- Cameras positions, you can add as many as you wish
	["car"] = { -- ID of the vehicle shop
		{x = 1.49, y = 7.65, z = 1.15}, 
		{x = 14.0, y = 5.0, z = 0.6},
		{x = 7.0, y = -5.0, z = 1.5},
		{x = -15.0, y = -3.0, z = 1.6},
	},
	["motos"] = { -- ID of the vehicle shop
		{x = 1.49, y = 7.65, z = 1.15}, 
		{x = 14.0, y = 5.0, z = 0.6},
		{x = 7.0, y = -5.0, z = 1.5},
		{x = -15.0, y = -3.0, z = 1.6},
	},
	["aircraft"] = {
		{x = 12.49, y = 0.65, z = 2.15}, 
		{x = 9.0, y = 20.0, z = 1.6},
		{x = -13.5, y = 8.0, z = 2.5},
		{x = -4.0, y = -13.0, z = 2.6},
	},
	["boat"] = {
		{x = 12.49, y = 0.65, z = 3.15}, 
		{x = 9.0, y = 20.0, z = 2.6},
		{x = -13.5, y = 8.0, z = 3.5},
		{x = -4.0, y = -13.0, z = 3.6},
	},
		["car2"] = {
		{x = 12.49, y = 0.65, z = 3.15}, 
		{x = 9.0, y = 20.0, z = 2.6},
		{x = -13.5, y = 8.0, z = 3.5},
		{x = -4.0, y = -13.0, z = 3.6},
	},
}

Config.VehicleshopsCategories = { -- Categories shown on the vehicle shops, this is used to set the vehicles category
	["vehicles"] = { -- TYPE of the vehicle shop
		{display = "Standard", id = "commercials"},
		{display = "Supersportwagen", id = "supercars"},
		{display = "Kompaktwagen", id = "compacts"},
		{display = "Coupes", id = "coupes"},
		{display = "Fahrräder", id = "motorcycles"},
		{display = "MuscleCars", id = "muscle"},
		{display = "Off-Roads", id = "offroad"},
		{display = "Sedans", id = "sedans"},
		{display = "Sportwagen", id = "sports"},
		{display = "Suvs", id = "suvs"},
		{display = "Vans", id = "vans"},
	},
	["air"] = {
		{display = "Groß", id = "groß"},
		{display = "Mittel", id = "mittel"},
		{display = "Klein", id = "klein"},
	},
	["water"] = {
		{display = "Boote", id = "boats"},
		{display = "Uboote", id = "submarine"},
	},
	["motos"] = {
		{display = "Motorräder", id = "motorcycles"},
	},
	["vehicles2"] = {
		{display = "Importwagen", id = "car2"},
	},
}

Config.UseColorID = false -- Will set the vehicle color based on the color ID: https://wiki.rage.mp/index.php?title=Vehicle_Colors

Config.colors = { -- The vehicle colors, this will update the UI as well (it needs to be 10 colors, do NOT remove, add or change the color names)
	color1 = {255, 255, 255, id = 134}, -- The 4th number is the color id for the car if Config.UseColorID = true
	color2 = {0, 0, 0, id = 0},
	color3 = {150, 150, 150, id = 4},
	color4 = {255, 0, 0, id = 27},
	color5 = {255, 150, 0, id = 41},
	color6 = {255, 230, 0, id = 89},
	color7 = {0, 255, 0, id = 55},
	color8 = {0, 0, 255, id = 79},
	color9 = {76, 0, 255, id = 145},
	color10 = {255, 0, 255, id = 137},
}

Config.TextUI = { -- Text UI texts
	['open_shop'] = { 			text = '[E] um zuzugreifen ${shop_name}', 										color = 'darkblue', side = 'right'},
	['buy_business'] = { 		text = '[E] Kaufe ${name} für ${price}$', 								color = 'darkblue', side = 'right'},
	['access_business'] = { 	text = '[E] zugriff ${name}', 										color = 'darkblue', side = 'right'},
	['tow'] = { 				text = '[E] Abschleppen', 													color = 'darkblue', side = 'right'},
	['sell_vehicle'] = { 		text = '[E] Verkaufe Fahrzeug', 											color = 'darkblue', side = 'right'},
}

Config.HelpNotification = { -- Used when Config.UseTextUI = false
	['open_shop'] = { 			text = '~INPUT_CONTEXT~ zum Öffnen ${shop_name}'},
	['buy_business'] = { 		text = '~INPUT_CONTEXT~ kaufen ${name} für ${price}$'},
	['access_business'] = { 	text = '~INPUT_CONTEXT~ Zugriff ${name}'},
	['tow'] = { 				text = '~INPUT_CONTEXT~ Abschleppen'},
	['sell_vehicle'] = { 		text = '~INPUT_CONTEXT~ To sell vehicle'},
}

Config.NotificationsText = { -- Notifications texts
	['success_cancel'] = {		title = "Vehicle Shop", 		text = "Die Bestellung wurde erfolgreich storniert",								time = 5000, type = "success"},
	['fail_cancel'] = {			title = "Vehicle Shop", 		text = "Die Bestellung konnte nicht storniert werden",								time = 5000, type = "error"},
	['cant_access'] = {			title = "Vehicle Shop", 		text = "Du hast keine Berechtigung, auf diesen Shop zuzugreifen",					time = 5000, type = "error"},
	['no_license'] = {			title = "Vehicle Shop", 		text = "Du besitzt keinen Führerschein, um dieses Fahrzeug zu kaufen",				time = 5000, type = "error"},
	['all_occupied'] = {		title = "Vehicle Shop", 		text = "Alle Fahrzeugeingänge sind besetzt",										time = 5000, type = "error"},
	['failed_to_load'] = {		title = "Vehicle Shop", 		text = "Das Fahrzeug konnte nicht geladen werden", 									time = 5000, type = "error"},
	['bus_no_money'] = {		title = "Vehicle Shop", 		text = "Dieses Unternehmen hat nicht genug Geld", 									time = 5000, type = "error"},
	['success_sell'] = {		title = "Vehicle Shop", 		text = "Du hast ${vehicle_name} für ${price}$ erfolgreich verkauft", 				time = 5000, type = "success"},
	['not_in_correct_v'] = {	title = "Vehicle Shop", 		text = "Du bist nicht im richtigen Fahrzeug", 										time = 5000, type = "error"},
	['dont_sell'] = {			title = "Vehicle Shop", 		text = "Der Fahrzeug Shop kauft nicht dieses Fahrzeug", 							time = 5000, type = "error"},
	['not_your_vehicle'] = {	title = "Vehicle Shop", 		text = "Du bist nicht der Eigentümer dieses Fahrzeugs", 							time = 5000, type = "error"},
	['not_in_vehicle'] = {		title = "Vehicle Shop", 		text = "Du musst in einem Fahrzeug sein", 											time = 5000, type = "error"},
	['not_admin'] = {			title = "Vehicle Shop", 		text = "Du hast keine Berechtigung für den Zugriff auf das Admin-Menü", 			time = 5000, type = "error"},
	['inside_vehicle'] = {		title = "Vehicle Shop", 		text = "Du kannst nicht auf den Fahrzeugshop im Fahrzeug zugreifen", 				time = 5000, type = "error"},
	['load_vehicle'] = {		title = "Vehicle Shop", 		text = "Fahrzeug wird geladen, bitte warten", 										time = 3000, type = "info"},
	['stop_testdrive'] = {		title = "Vehicle Shop", 		text = "Beenden der Testfahrt", 													time = 5000, type = "success"},
	['not_testdriving'] = {		title = "Vehicle Shop", 		text = "Du bist nicht auf einer Testfahrt", 										time = 5000, type = "error"},
	['fill_fields'] = {			title = "Vehicle Shop", 		text = "Bitte fülle das Eingabefeld aus", 											time = 5000, type = "error"},
	['already_accepted'] = {	title = "Vehicle Shop", 		text = "Du hast bereits einen Auftrag angenommen, schließe ihn ab, bevor du einen weiteren annimmst",		time = 5000, type = "error"},
	['not_selected_hire'] = {	title = "Vehicle Shop", 		text = "Keiner wurde ausgewählt", 													time = 5000, type = "error"},
	['ordered_success'] = {		title = "Vehicle Shop", 		text = "Sie haben x${amount} ${vehicle_name} erfolgreich bestellt!", 				time = 5000, type = "success"},
	['some_wrong'] = {			title = "Vehicle Shop", 		text = "Etwas ist schief gelaufen!", 												time = 5000, type = "error"},
	['not_enough_money'] = {	title = "Vehicle Shop", 		text = "Du hast nicht genug Geld", 													time = 5000, type = "error"},
	['not_enough_money_s'] = {	title = "Vehicle Shop", 		text = "Deine Fraktion hat nicht genügend Geld", 									time = 5000, type = "error"},
	['accepted_order'] = {		title = "Vehicle Shop", 		text = "Du hast einen Auftrag erfolgreich angenommen", 								time = 5000, type = "success"},
	['someone_accepted'] = {	title = "Vehicle Shop", 		text = "Jemand hat diesen Auftrag bereits angenommen", 								time = 5000, type = "error"},
	['finished_order'] = {		title = "Vehicle Shop", 		text = "Du hast die Bestellung erfolgreich abgeschlossen und ${reward}$ erhalten",  time = 5000, type = "success"},
	['no_ads_cancel'] = {		title = "Vehicle Shop", 		text = "Du hast keine Anzeigen zu stornieren", 											time = 5000, type = "error"},
	['veh_not_available'] = {	title = "Vehicle Shop", 		text = "Dieses Fahrzeug ist nicht verfügbar", 												time = 5000, type = "error"},
	['price_not_valid'] = {		title = "Vehicle Shop", 		text = "Dies ist kein gültiger Preis", 												time = 5000, type = "error"},
	['employee_not_exist'] = {	title = "Vehicle Shop", 		text = "Dieser Mitarbeiter existiert nicht", 												time = 5000, type = "error"},
	['not_enough_to_sell'] = {	title = "Vehicle Shop", 		text = "Du hast nicht genug Fahrzeuge zum Verkaufen", 									time = 5000, type = "error"},
	['got_hired'] = {			title = "Vehicle Shop", 		text = "Du wurdest von ${shop_name} eingestellt", 											time = 5000, type = "info"},
	['got_fired'] = {			title = "Vehicle Shop", 		text = "Du wurdest von ${shop_name} gefeuert", 											time = 5000, type = "info"},
	['success_hired'] = {		title = "Vehicle Shop", 		text = "Du hast ${hired_name} erfolgreich angestellt", 										time = 5000, type = "success"},
	['success_fired'] = {		title = "Vehicle Shop", 		text = "Du hast ${hired_name} erfolgreich gefeuert", 										time = 5000, type = "success"},
	['success_added_ad'] = {	title = "Vehicle Shop", 		text = "Es wurden x${amount} ${vehicle_name} hinzugefügt", 										time = 5000, type = "success"},
	['deposited'] = {			title = "Vehicle Shop", 		text = "Einzahlung von ${amount}$ erfolgreich durchgeführt", 										time = 5000, type = "success"},
	['withdrawn'] = {			title = "Vehicle Shop", 		text = "Auszahlung von ${amount}$ erfolgreich durchgeführt", 										time = 5000, type = "success"},
	['bought_veh'] = {			title = "Vehicle Shop", 		text = "Gekauft ${vehicle_name} für ${vehiclePrice}$", 								time = 5000, type = "success"},
	['change_money'] = {		title = "Vehicle Shop", 		text = "Das Geld von ${shop_name} wurde erfolgreich in ${money} geändert", 					time = 5000, type = "success"},
	['change_info'] = {			title = "Vehicle Shop", 		text = "Die Informationen zu ${vehicle_name} wurden erfolgreich geändert", 					time = 5000, type = "success"},
	['remove_veh'] = {			title = "Vehicle Shop", 		text = "Das Fahrzeug ${vehicle_name} wurde erfolgreich entfernt", 									time = 5000, type = "success"},
	['created_veh'] = {			title = "Vehicle Shop", 		text = "Ein ${Fahrzeugname} wurde erfolgreich hinzugefügt", 									time = 5000, type = "success"},
	['cancel_ads'] = {			title = "Vehicle Shop", 		text = "Es wurden x${amount} ${vehicle_name} entfernt", 									time = 5000, type = "success"},
	['updated_price'] = {		title = "Vehicle Shop", 		text = "Preis von ${vehicle_name} auf ${amount}$ aktualisiert", 							time = 5000, type = "success"},
	['change_rank'] = {			title = "Vehicle Shop", 		text = "${name} ist jetzt ein ${job}", 													time = 5000, type = "success"},
	['already_rank'] = {		title = "Vehicle Shop", 		text = "${name} ist bereits ein ${job}", 												time = 5000, type = "error"},
	['already_employee'] = {	title = "Vehicle Shop", 		text = "${Name} ist bereits dein Mitarbeiter", 											time = 5000, type = "error"},
	['max_shops'] = {			title = "Vehicle Shop", 		text = "Man kann nicht mehr Autohäuser kaufen",											time = 5000, type = "error"},
	['got_to_truck'] = {		title = "Vehicle Shop", 		text = "Lasse dir den Auftrag auf deiner Minimap markieren", 									time = 5000, type = "info"},
	['not_towing'] = {			title = "Vehicle Shop", 		text = "Du musst näher am bestellten Fahrzeug sein", 								time = 5000, type = "error"},
	['towed'] = {				title = "Vehicle Shop",			text = "Du hast das bestellte Fahrzeug erfolgreich abgeschleppt", 								time = 5000, type = "success"},
	['sold_business'] = {		title = "Vehicle Shop", 		text = "Du hast erfolgreich ${shop} für ${amount}$ verkauft", 								time = 5000, type = "success"},
	['leave_business'] = {		title = "Vehicle Shop", 		text = "Du hast ${shop} erfolgreich verlassen", 												time = 5000, type = "success"},
	['min_max_price'] = {		title = "Vehicle Shop", 		text = "Der Mindestpreis muss niedriger sein als der Höchstpreis", 				time = 5000, type = "error"},
	['owner_changed'] = {		title = "Vehicle Shop", 		text = "${owner} ist jetzt der Eigentümer von ${shop}", 										time = 5000, type = "success"},
	['max_employees'] = {		title = "Vehicle Shop", 		text = "Du kannst nur ${employees} Mitarbeiter einstellen", 									time = 5000, type = "error"},
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to webhook.lua, line 1

Config.BotName = 'ServerName' -- Write the desired bot name

Config.ServerName = 'ServerName' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.BuyBusinessWebhook = true
Config.BuyBusinessWebhookColor = '65280'

Config.SellBusinessWebhook = true
Config.SellBusinessWebhookColor = '16711680'

Config.DepositWebhook = true
Config.DepositWebhookColor = '16776960'

Config.WithdrawWebhook = true
Config.WithdrawWebhookColor = '16776960'

Config.StartOrderWebhook = true
Config.StartOrderWebhookColor = '16742656'

Config.EndOrderWebhook = true
Config.EndOrderWebhookColor = '16742656'

Config.HireWebhook = true
Config.HireWebhookColor = '4223487'

Config.FireWebhook = true
Config.FireWebhookColor = '4223487'

Config.BuyVehicleWebhook = true
Config.BuyVehicleWebhookColor = '65535'

Config.ADStockWebhook = true
Config.ADStockWebhookColor = '7209071'

Config.CancelStockWebhook = true
Config.CancelStockWebhookColor = '7209071'

Config.BuyStockWebhook = true
Config.BuyStockWebhookColor = '7209071'

Config.EditEmployeeRankWebhook = true
Config.EditEmployeeRankWebhookColor = '4223487'

Config.QuitJobWebhook = true
Config.QuitJobWebhookColor = '16711680'