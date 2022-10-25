

-- Md Doppeltür eingang
table.insert(Config.DoorList, {
	doors = {
		{objHash = -770740285, objHeading = 174.99998474121, objCoords = vector3(-672.3508, 329.7774, 83.11162)},
		{objHash = -770740285, objHeading = 354.99987792969, objCoords = vector3(-670.0551, 329.5765, 83.11162)}
 },
	slides = false,
	authorizedJobs = { ['ambulance']=0,['offambulance']=0, ['police']=0, ['fib']=0 },
	audioRemote = false,
	locked = true,
	maxDistance = 2.5,
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})