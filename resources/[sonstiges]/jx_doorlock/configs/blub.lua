

-- lager büro
table.insert(Config.DoorList, {
	locked = true,
	slides = true,
	lockpick = false,
	maxDistance = 6.0,
	doors = {
		{objHash = -513161094, objHeading = 335.0, objCoords = vector3(-185.0549, -337.8533, 57.80722)},
		{objHash = -513161094, objHeading = 154.99998474121, objCoords = vector3(-186.9003, -337.0003, 57.80373)}
 },
	audioRemote = false,
	authorizedJobs = { ['club']=0 },		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})