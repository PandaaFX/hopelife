

-- haupteingang
table.insert(Config.DoorList, {
	slides = false,
	locked = true,
	authorizedJobs = { ['hookahlounge']=0 },
	maxDistance = 2.5,
	doors = {
		{objHash = -1119680854, objHeading = 267.04254150391, objCoords = vector3(-431.575, -22.80877, 46.39152)},
		{objHash = -1119680854, objHeading = 87.042518615723, objCoords = vector3(-431.705, -25.40208, 46.39152)}
 },
	audioRemote = false,
	lockpick = false,	
	items = { 'ram' },		

	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- eingangdrinnen
table.insert(Config.DoorList, {
	slides = false,
	locked = true,
	authorizedJobs = { ['hookahlounge']=0 },
	maxDistance = 2.5,
	doors = {
		{objHash = -1119680854, objHeading = 267.04254150391, objCoords = vector3(-446.0028, -43.16361, 46.36139)},
		{objHash = -1119680854, objHeading = 87.042518615723, objCoords = vector3(-446.1368, -45.75671, 46.36139)}
 },
	audioRemote = false,
	lockpick = false,	
	items = { 'ram' },		

	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- eingangbüro
table.insert(Config.DoorList, {
	slides = false,
	objHash = 634417522,
	locked = true,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	authorizedJobs = { ['hookahlounge']=0 },
	maxDistance = 2.0,
	objCoords = vector3(-444.3599, -29.66731, 41.01976),
	garage = false,
	objHeading = 357.11740112305,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})