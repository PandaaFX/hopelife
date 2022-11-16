

-- haupttür
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	doors = {
		{objHash = 262671971, objHeading = 89.999992370605, objCoords = vector3(1395.874, 1140.705, 114.7902)},
		{objHash = 1504256620, objHeading = 270.0, objCoords = vector3(1395.875, 1142.904, 114.7902)}
 },
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['casino']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})