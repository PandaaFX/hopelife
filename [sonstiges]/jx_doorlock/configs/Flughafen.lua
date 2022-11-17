

-- Einreise 
table.insert(Config.DoorList, {
	maxDistance = 2.5,
	doors = {
		{objHash = -545008322, objHeading = 330.00006103516, objCoords = vector3(-1044.839, -2746.593, 20.33327)},
		{objHash = -545008322, objHeading = 149.99998474121, objCoords = vector3(-1042.154, -2748.143, 20.33327)}
 },
	lockpick = false,
	authorizedJobs = { ['admin']=0 },
	locked = true,
	slides = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

--[[
-- flughafen
table.insert(Config.DoorList, {
	objHeading = 149.99998474121,
	fixText = false,
	lockpick = false,
	objHash = -545008322,
	slides = false,
	maxDistance = 2.0,
	objCoords = vector3(-1042.154, -2748.143, 20.33327),
	authorizedJobs = { ['admin']=0 },
	audioRemote = false,
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})
--]]