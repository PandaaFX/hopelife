
Config = {}

-- set this to false if you do not want entities render as scorched when they are completely broken
Config.renderScorched = false

-- this controls when a vehicle will be removed from the database table when calling the cleanup 
-- function (in hours; so 24 * 7 = one week)
Config.cleanUpThresholdTime = 24 * 7

-- set this to true if you also want the cleanup running at a certain time of day
Config.useCleanUpTask = false
-- only used when useCleanUpTask is set to true (you can define more by copy pasting one entry)
Config.cleanUpTimes = {
	{ hour = 0, minute = 0 },
	{ hour = 3, minute = 0 },
	{ hour = 6, minute = 0 },
	{ hour = 12, minute = 0 },
	{ hour = 15, minute = 0 },
	{ hour = 18, minute = 0 },
}

-- Delete exploded vehicles upon cleanup
Config.cleanUpExplodedVehicles = true



-- only save vehicles that are owned (only works with ESX or QB by default)
Config.saveOnlyOwnedVehicles = true

-- set this to true to automatically store vehicles in the garage upon cleanup (only works with ESX 
-- or QB by default)
Config.storeOwnedVehiclesInGarage = true



-- comma separated list of vehicle classes that you do not want to save
-- ids can be found here: https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.classesBlacklist = {
	21 --[[Trains]],
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
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
}

-- other vehicles that you do not want to save can be inserted here (use `MODELNAME` when you put 
-- them in there)
Config.vehiclesBlacklist = {
	--`blista`,
	--`firetruk`,
	--`adder`,

}

-- any plates from vehicles you do not want to save, go here (not case sensitive and can use 
-- partial strings)
Config.platesBlacklist = {
	--"XYZ 404 ",
	--"xyz 404",
	--"mech",
}



-- Control if vehicles should be deleted automatically every X minutes (this can be useful for 
-- large servers with a lot of players and especially with a lot of (unoptimized) modded vehicles)
Config.autoDelete = {
	-- in minutes; 0 if you do not want to use it
	timer = 60,

	-- only vehicles that are more than X meters away from a player
	distance = 50.0,

	-- when the notifications should be shown before the despawning
	-- needs to be in descending order in minutes and lower than Config.deleteTimer
	notificationTimes = { 5, 3, 2, 1 },

	-- notification to show players before deleting vehicles
	-- (use %s as placeholder for time left in minutes)
	timeLeftNotification = "Fahrzeuge werden in %s Minuten abgeschleppt.",

	-- notification to show players when deleting vehicles
	deleteNotification = "Abschleppen beginnt..."
}
