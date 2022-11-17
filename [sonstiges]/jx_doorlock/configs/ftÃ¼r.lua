--[[

-- eingang
table.insert(Config.DoorList, {
	locked = true,
	slides = false,
	maxDistance = 2.5,
	doors = {
		{objHash = -545008322, objHeading = 149.99998474121, objCoords = vector3(-1042.154, -2748.143, 20.33327)},
		{objHash = -545008322, objHeading = 330.00006103516, objCoords = vector3(-1044.839, -2746.593, 20.33327)}
 },
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['admin']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})
--]]