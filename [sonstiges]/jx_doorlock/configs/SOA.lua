

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

-- Bar Hintereingang
table.insert(Config.DoorList, {
	lockpick = false,
	slides = false,
	locked = true,
	items = { 'ram' },
	objHeading = 175.00003051758,
	authorizedJobs = { ['soa']=0 },
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-561.2866, 293.5044, 87.77851),
	garage = false,
	objHash = 993120320,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Bar Haupteingang
table.insert(Config.DoorList, {
	lockpick = false,
	slides = false,
	locked = true,
	items = { 'ram' },
	objHeading = 355.00003051758,
	authorizedJobs = { ['soa']=0 },
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-565.1712, 276.6259, 83.28626),
	garage = false,
	objHash = 993120320,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Bar runter
table.insert(Config.DoorList, {
	lockpick = false,
	slides = false,
	locked = true,
	items = { 'ram' },
	objHeading = 265.00006103516,
	authorizedJobs = { ['soa']=0 },
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-560.2373, 293.0106, 82.32609),
	garage = false,
	objHash = -626684119,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})