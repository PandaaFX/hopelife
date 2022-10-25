Config = {}
Translation = {}

Config.useESX = true
Config.useNewESX = false
Config.Locale = 'de'

Translation = {
	['de'] = {
		['blip_title'] = 'Gärtnerei',
		['message_title'] = 'Gärtnerei',
		['message_subtitle'] = 'Nebenjob angenommen',
		['start_route'] = 'Vielen Dank, dass du uns aushilfst! Gerade ist hier wirklich viel zu tun...',
		['next_stop'] = 'Weiter gehts! Es gibt noch genug zu tun.',
		['return'] = 'Gehe zurück zum Parkplatz und lass dir neue Arbeit geben.',
		['openMenu'] = 'Drücke ~INPUT_CONTEXT~ um als ~y~Gärtner~w~ zu arbeiten',
		['neededLevel'] = 'Benötigtes Level: ',
		['earned_money'] = 'Du hast ~g~$',
		['earned_money2'] = '~w~ verdient',
		['wrong_vehicle'] = '~r~Du nutzt nicht dein Jobfahrzeug!',
	},
	['en'] = {
		['blip_title'] = 'GolfClub',
		['message_title'] = 'GolfClub',
		['message_subtitle'] = 'Part-time job started',
		['start_route'] = 'Thank you for helping us out! There is really a lot to do here right now...',
		['next_stop'] = 'Go on! There is still enough to be done.',
		['return'] = 'Go back to the parking lot and get some new work.',
		['openMenu'] = 'Press ~INPUT_CONTEXT~ to work as a ~y~gardener',
		['neededLevel'] = 'Required level: ',
		['earned_money'] = 'You earned ~g~$',
		['earned_money2'] = '~w~',
		['wrong_vehicle'] = '~r~You are not using the correct vehicle!',
	}
}


Config.JobName		= 'gardenerjob'
Config.menuTitle    = 'Gardener'
Config.menuSubtitle = '~b~Joblevel: '


Config.Marker = {
    id          = 27,
    colour      = {r = 0, g = 255, b = 0, a = 50},
    isRotating  = false,
    radius      = 1.0,
}


Config.Location = {
    {x = -1345.25, y = 139.12, z = 56.25, rot = 273.0, name = ""}, 
}


Config.Jobs = {
	{name = "Finish job", id = 0, minimumLevel = 0, payment = 0},
    {name = "Pick weeds", id = 1, minimumLevel = 0, payment = 750, gardenerStops = 4},
    {name = "Mow the lawn", id = 2, minimumLevel = 0, payment = 600, gardenerStops = 9},
}

Config.VehicleSpawnLocation = {x = -1339.03, y = 140.25119018555, z = 57.017066955566, rot = 287.521}



Config.JobLocations = {
	{  
		{x = -1350.0574951172, y = 157.18472290039, z = 57.408851623535, rot = 7.1473460197449, name = "x"}, 
		{x = -1342.4736328125, y = 162.55577087402, z = 57.793537139893, rot = 288.16485595703, name = "x"}, 
		{x = -1348.5112304688, y = 164.29322814941, z = 57.840927124023, rot = 316.12197875977, name = "x"}, 
		{x = -1289.8786621094, y = 138.16203308105, z = 58.056015014648, rot = 115.49999237061, name = "x"}, 
		{x = -1281.6397705078, y = 131.93446350098, z = 57.772617340088, rot = 276.39031982422, name = "x"}, 
		{x = -1265.6104736328, y = 121.65460205078, z = 57.373146057129, rot = 259.85928344727, name = "x"}, 
		{x = -1233.5766601563, y = 131.48941040039, z = 58.199283599854, rot = 268.83712768555, name = "x"}, 
		{x = -1223.3160400391, y = 126.55902862549, z = 58.269721984863, rot = 247.94927978516, name = "x"}, 
		{x = -1205.9001464844, y = 125.16874694824, z = 59.839576721191, rot = 287.91744995117, name = "x"}, 
		{x = -1189.9516601563, y = 126.15509033203, z = 60.762706756592, rot = 282.32052612305, name = "x"}, 
		{x = -1124.1635742188, y = 99.43236541748, z = 58.05347442627, rot = 230.7967376709, name = "x"}, 
		{x = -1120.4516601563, y = 100.27311706543, z = 58.990829467773, rot = 125.74353027344, name = "x"}, 
		{x = -1102.0961914063, y = 68.255989074707, z = 54.128963470459, rot = 331.10284423828, name = "x"}, 
		{x = -1087.84375, y = 26.011264801025, z = 50.67845916748, rot = 221.70802307129, name = "x"}, 
		{x = -1157.5017089844, y = -48.764232635498, z = 44.701068878174, rot = 115.15013885498, name = "x"}, 
		{x = -1164.6228027344, y = -58.004348754883, z = 44.983001708984, rot = 146.13584899902, name = "x"}, 
		{x = -1190.9348144531, y = 7.9154276847839, z = 48.435813903809, rot = 31.819654464722, name = "x"}, 
		{x = -1277.4371337891, y = 35.842277526855, z = 49.902980804443, rot = 216.56146240234, name = "x"}, 
		{x = -1274.84765625, y = 32.587303161621, z = 49.396827697754, rot = 201.60494995117, name = "x"}, 
		{x = -1272.0307617188, y = 42.85657119751, z = 49.980178833008, rot = 343.8229675293, name = "x"},
	},
	{
		{x = -1325.0584716797, y = 159.21499633789, z = 57.80493927002, rot = 335.69256591797, name = "y"}, 
		{x = -1266.9307861328, y = 180.71305847168, z = 60.832927703857, rot = 286.32266235352, name = "y"}, 
		{x = -1220.0676269531, y = 188.2154083252, z = 64.343475341797, rot = 83.491333007813, name = "y"},  
		{x = -1168.8360595703, y = 175.04190063477, z = 63.435264587402, rot = 253.90112304688, name = "y"}, 
		{x = -1164.1932373047, y = 144.36402893066, z = 61.800395965576, rot = 101.93257904053, name = "y"}, 
		{x = -1208.5369873047, y = 99.820297241211, z = 57.325798034668, rot = 88.069671630859, name = "y"}, 
		{x = -1253.8795166016, y = 107.4348449707, z = 55.988121032715, rot = 74.660690307617, name = "y"}, 
		{x = -1306.2762451172, y = 104.18573760986, z = 55.529678344727, rot = 105.04067230225, name = "y"}, 
		{x = -1332.3277587891, y = 127.52643585205, z = 56.484283447266, rot = 30.898332595825, name = "y"}, 
		{x = -1297.4968261719, y = 142.2622833252, z = 57.967662811279, rot = 286.60089111328, name = "y"}, 
		{x = -1252.5207519531, y = 143.52235412598, z = 58.176872253418, rot = 243.04898071289, name = "y"}, 
		{x = -1204.9602050781, y = 90.976928710938, z = 56.771842956543, rot = 251.38958740234, name = "y"}, 
		{x = -1142.7723388672, y = 96.005027770996, z = 57.484157562256, rot = 251.34027099609, name = "y"}, 
	},
}


