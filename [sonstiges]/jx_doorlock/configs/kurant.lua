

-- kurant tür
table.insert(Config.DoorList, {
	locked = true,
	authorizedJobs = { ['crips']=0 },
	audioRemote = false,
	doors = {
		{objHash = 1770861563, objHeading = 270.00006103516, objCoords = vector3(381.8307, -1077.431, 29.73933)},
		{objHash = 1770861563, objHeading = 90.000122070313, objCoords = vector3(381.8307, -1075.519, 29.73933)}
 },
	lockpick = false,
	slides = false,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})