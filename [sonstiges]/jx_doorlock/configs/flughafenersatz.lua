

-- 1
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	authorizedJobs = { ['admin']=0 },
	locked = true,
	audioRemote = false,
	doors = {
		{objHash = -545008322, objHeading = 330.00006103516, objCoords = vector3(-1044.839, -2746.593, 20.33327)},
		{objHash = -545008322, objHeading = 149.99998474121, objCoords = vector3(-1042.154, -2748.143, 20.33327)}
 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})