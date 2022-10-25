

-- Eingang garage
table.insert(Config.DoorList, {
	audioRemote = false,
	locked = true,
	maxDistance = 6.0,
	lockpick = false,
	fixText = false,
	objCoords = vector3(2521.06, 4123.835, 39.22495),
	objHeading = 243.00003051758,
	authorizedJobs = { ['soa']=0 },
	garage = true,
	objHash = 497665568,
	slides = 6.0,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Eingang tür
table.insert(Config.DoorList, {
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	fixText = false,
	objCoords = vector3(2507.756, 4097.621, 38.84628),
	objHeading = 243.99996948242,
	authorizedJobs = { ['soa']=0 },
	garage = false,
	objHash = 782767342,
	slides = false,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})