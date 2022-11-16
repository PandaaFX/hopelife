

-- Maindoor
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = 21324050, objHeading = 238.00001525879, objCoords = vector3(927.7739, 49.59499, 81.53419)},
		{objHash = 21324050, objHeading = 57.999977111816, objCoords = vector3(926.4382, 47.46822, 81.53419)}
 },
	maxDistance = 2.5,
	authorizedJobs = { ['casino']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Maindoor mitte
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = 21324050, objHeading = 238.00001525879, objCoords = vector3(926.2712, 47.2067, 81.53419)},
		{objHash = 21324050, objHeading = 57.999977111816, objCoords = vector3(924.9374, 45.08024, 81.53419)}
 },
	maxDistance = 2.5,
	authorizedJobs = { ['casino']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Maindoor rechts
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = 21324050, objHeading = 238.00001525879, objCoords = vector3(924.7853, 44.82212, 81.53419)},
		{objHash = 21324050, objHeading = 57.999977111816, objCoords = vector3(923.4505, 42.69615, 81.53419)}
 },
	maxDistance = 2.5,
	authorizedJobs = { ['casino']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	authorizedJobs = { ['casino']=0 },
	objHeading = 328.00003051758,
	slides = 6.0,
	fixText = false,
	audioRemote = false,
	garage = true,
	objHash = -1957832210,
	lockpick = false,
	objCoords = vector3(936.9142, 2.19565, 77.77524),
	locked = true,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Seitentuere neben Cashier
table.insert(Config.DoorList, {
	objHeading = 238.00001525879,
	fixText = false,
	lockpick = false,
	objHash = 1266543998,
	slides = false,
	maxDistance = 2.0,
	objCoords = vector3(951.0956, 27.26886, 71.98338),
	authorizedJobs = { ['casino']=0 },
	audioRemote = false,
	locked = true,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Seitentuere neben Cashier
table.insert(Config.DoorList, {
	audioRemote = false,
	locked = true,
	lockpick = false,
	doors = {
		{objHash = 680601509, objHeading = 238.00001525879, objCoords = vector3(978.1794, 69.32097, 70.38277)},
		{objHash = 680601509, objHeading = 57.999977111816, objCoords = vector3(977.1198, 67.6251, 70.38277)}
 },
	authorizedJobs = { ['casino']=0 },
	slides = false,
	maxDistance = 2.5,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Dachterasse
table.insert(Config.DoorList, {
	objHeading = 58.000003814697,
	fixText = false,
	lockpick = false,
	objHash = -1691719897,
	slides = false,
	maxDistance = 2.0,
	objCoords = vector3(968.3635, 63.24729, 112.6529),
	authorizedJobs = { ['casino']=0 },
	audioRemote = false,
	locked = true,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LObby rechts zu garage
table.insert(Config.DoorList, {
	objHeading = 147.99998474121,
	fixText = false,
	lockpick = false,
	objHash = 901693952,
	slides = false,
	maxDistance = 2.0,
	objCoords = vector3(930.4228, 33.2631, 81.24268),
	authorizedJobs = { ['casino']=0 },
	audioRemote = false,
	locked = true,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Securitybereich
table.insert(Config.DoorList, {
	audioRemote = false,
	locked = true,
	lockpick = false,
	doors = {
		{objHash = 680601509, objHeading = 328.0, objCoords = vector3(984.4885, 35.62531, 70.39265)},
		{objHash = 680601509, objHeading = 147.99998474121, objCoords = vector3(986.1843, 34.56562, 70.39265)}
 },
	authorizedJobs = { ['casino']=0 },
	slides = false,
	maxDistance = 2.5,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Toiletten
table.insert(Config.DoorList, {
	objHeading = 238.00001525879,
	fixText = false,
	lockpick = false,
	objHash = 901693952,
	slides = false,
	maxDistance = 2.0,
	objCoords = vector3(998.5775, 38.474, 70.38277),
	authorizedJobs = { ['casino']=0 },
	audioRemote = false,
	locked = true,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Toiletten
table.insert(Config.DoorList, {
	objHeading = 147.99998474121,
	fixText = false,
	lockpick = false,
	objHash = 901693952,
	slides = false,
	maxDistance = 2.0,
	objCoords = vector3(991.0112, 71.25034, 70.38277),
	authorizedJobs = { ['casino']=0 },
	audioRemote = false,
	locked = true,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- thomas stinkt
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 58.000038146973,
	slides = false,
	locked = true,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = false,
	authorizedJobs = { ['casino']=0 },
	objCoords = vector3(930.0135, 29.9094, 81.32159),
	garage = false,
	objHash = 901693952,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})