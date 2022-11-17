

-- garage
table.insert(Config.DoorList, {
	authorizedJobs = { ['club']=0 },
	objCoords = vector3(-218.7182, -273.3588, 50.02312),
	objHeading = 251.0,
	maxDistance = 6.0,
	locked = true,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	slides = 6.0,
	objHash = -1353128142,
	garage = true,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- garage kleidung
table.insert(Config.DoorList, {
	authorizedJobs = { ['club']=0 },
	objCoords = vector3(-183.659, -313.4135, 55.3124),
	objHeading = 339.00009155273,
	maxDistance = 2.0,
	locked = true,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	slides = false,
	objHash = -1989765534,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- garage eingangs tür
table.insert(Config.DoorList, {
	maxDistance = 2.5,
	locked = true,
	slides = false,
	doors = {
		{objHash = 942404643, objHeading = 69.999992370605, objCoords = vector3(-173.49, -310.562, 55.1996)},
		{objHash = 942404643, objHeading = 250.00003051758, objCoords = vector3(-174.4733, -313.2596, 55.20012)}
 },
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['club']=0 },		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Lager tür bar
table.insert(Config.DoorList, {
	authorizedJobs = { ['club']=0 },
	objCoords = vector3(-185.3025, -344.4835, 58.96827),
	objHeading = 65.0,
	maxDistance = 2.0,
	locked = true,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	slides = false,
	objHash = -1989765534,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Lager tür links
table.insert(Config.DoorList, {
	authorizedJobs = { ['club']=0 },
	objCoords = vector3(-190.1672, -346.701, 58.96188),
	objHeading = 336.00006103516,
	maxDistance = 2.0,
	locked = true,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	slides = false,
	objHash = -1989765534,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})





-- büro erste tür
table.insert(Config.DoorList, {
	authorizedJobs = { ['club']=0 },
	objCoords = vector3(-210.0421, -364.5209, 58.95134),
	objHeading = 265.0,
	maxDistance = 2.0,
	locked = true,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	slides = false,
	objHash = 736699661,
	garage = false,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})



-- büro double sliding
table.insert(Config.DoorList, {
	authorizedJobs = { ['club']=0 },
	lockpick = false,
	locked = true,
	doors = {
		{objHash = -513161094, objHeading = 354.99987792969, objCoords = vector3(-214.19, -369.8767, 57.80485)},
		{objHash = -513161094, objHeading = 174.99998474121, objCoords = vector3(-216.2212, -369.7051, 57.80405)}
 },
	audioRemote = false,
	maxDistance = 6.0,
	slides = true,		
	items = { 'ram' },		
	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})