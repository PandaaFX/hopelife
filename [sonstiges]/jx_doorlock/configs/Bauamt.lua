

-- Garagesecond
table.insert(Config.DoorList, {
	locked = true,
	objHeading = 0.0,
	fixText = false,
	items = { 'ramm' },
	audioRemote = false,
	slides = 6.0,
	lockpick = false,
	objHash = 1827434119,
	objCoords = vector3(-532.6376, -885.9293, 26.27159),
	garage = true,
	authorizedJobs = { ['bauamt']=0 },
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garagehaupt
table.insert(Config.DoorList, {
	locked = true,
	objHeading = 89.999977111816,
	fixText = false,
	items = { 'ramm' },
	audioRemote = false,
	slides = 6.0,
	lockpick = false,
	objHash = -610223133,
	objCoords = vector3(-561.1066, -930.1593, 25.58847),
	garage = true,
	authorizedJobs = { ['bauamt']=0 },
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- hauptür
table.insert(Config.DoorList, {
	locked = true,
	slides = false,
	lockpick = false,
	maxDistance = 2.5,
	doors = {
		{objHash = -930505499, objHeading = 270.00003051758, objCoords = vector3(-598.0059, -931.1721, 24.02803)},
		{objHash = 733700947, objHeading = 270.00003051758, objCoords = vector3(-598.0059, -928.572, 24.02803)}
 },
	audioRemote = false,
	authorizedJobs = { ['bauamt']=0 },
	items = { 'ramm' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})