

-- Büro
table.insert(Config.DoorList, {
	locked = true,
	objHeading = 357.11740112305,
	objHash = 634417522,
	maxDistance = 2.0,
	objCoords = vector3(-444.3599, -29.66731, 41.01976),
	authorizedJobs = { ['hookahlounge']=0, ['bauamt']=0, ['crips']=0 },
	lockpick = false,
	audioRemote = false,
	fixText = false,
	garage = false,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Büro
table.insert(Config.DoorList, {
	authorizedJobs = { ['hookahlounge']=0, ['bauamt']=0, ['crips']=0 },
	locked = true,
	lockpick = false,
	doors = {
		{objHash = -1119680854, objHeading = 267.04254150391, objCoords = vector3(-446.0028, -43.16361, 46.36139)},
		{objHash = -1119680854, objHeading = 87.042518615723, objCoords = vector3(-446.1368, -45.75671, 46.36139)}
 },
	audioRemote = false,
	slides = false,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- eingangstür
table.insert(Config.DoorList, {
	authorizedJobs = { ['hookahlounge']=0, ['bauamt']=0, ['crips']=0 },
	locked = true,
	lockpick = false,
	doors = {
		{objHash = -1119680854, objHeading = 267.04254150391, objCoords = vector3(-431.575, -22.80877, 46.39152)},
		{objHash = -1119680854, objHeading = 87.042518615723, objCoords = vector3(-431.705, -25.40208, 46.39152)}
 },
	audioRemote = false,
	slides = false,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})