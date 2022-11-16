

-- dopple tür eingang
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['saints']=0 },
	audioRemote = false,
	slides = false,
	doors = {
		{objHash = 574422567, objHeading = 27.817852020264, objCoords = vector3(-1731.623, 379.1135, 89.85722)},
		{objHash = 574422567, objHeading = 208.46897888184, objCoords = vector3(-1733.915, 377.8857, 89.85722)}
 },
	maxDistance = 2.5,
	locked = true,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 305.07562255859,
	locked = true,
	objHash = -728539053,
	slides = 6.0,
	authorizedJobs = { ['saints']=0 },
	fixText = false,
	objCoords = vector3(-1745, 368.5997, 90.37098),
	garage = true,
	maxDistance = 6.0,
	audioRemote = false,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tür neben Garage
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 303.7395324707,
	locked = true,
	objHash = 520341586,
	slides = false,
	authorizedJobs = { ['saints']=0 },
	fixText = false,
	objCoords = vector3(-1741.024, 364.9353, 88.89058),
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tür terrase 1
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 43.099910736084,
	locked = true,
	objHash = 1647181300,
	slides = false,
	authorizedJobs = { ['saints']=0 },
	fixText = false,
	objCoords = vector3(-1724.133, 352.2008, 89.62007),
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tür terrase 2
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 43.099910736084,
	locked = true,
	objHash = 1647181300,
	slides = false,
	authorizedJobs = { ['saints']=0 },
	fixText = false,
	objCoords = vector3(-1727.062, 370.4783, 90.02195),
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tür terrase 3
table.insert(Config.DoorList, {
	lockpick = false,
	objHeading = 300.06256103516,
	locked = true,
	objHash = 1647181300,
	slides = false,
	authorizedJobs = { ['saints']=0 },
	fixText = false,
	objCoords = vector3(-1715.522, 387.4262, 90.02003),
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tor
table.insert(Config.DoorList, {
	objHeading = 208.63679504395,
	garage = false,
	objCoords = vector3(-1760.434, 373.1052, 87.58844),
	locked = true,
	objHash = -1153093533,
	maxDistance = 2.0,
	fixText = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['saints']=0 },		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tor
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	lockpick = false,
	audioRemote = false,
	doors = {
		{objHash = -1153093533, objHeading = 208.63679504395, objCoords = vector3(-1760.434, 373.1052, 87.58844)},
		{objHash = -1153093533, objHeading = 29.030048370361, objCoords = vector3(-1770.633, 367.4903, 87.58844)}
 },
	locked = true,
	authorizedJobs = { ['saints']=0 },
	slides = true,		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- tor
table.insert(Config.DoorList, {
	objHeading = 29.348436355591,
	garage = false,
	objCoords = vector3(-1739.634, 384.8374, 87.52946),
	locked = true,
	objHash = -1153093533,
	maxDistance = 6.0,
	fixText = false,
	lockpick = false,
	audioRemote = false,
	slides = true,
	authorizedJobs = { ['saints']=0 },		
	items = { 'ram' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})