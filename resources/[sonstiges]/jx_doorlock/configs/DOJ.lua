

-- DOJ Haupteingang
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -1094765077, objHeading = 209.99301147461, objCoords = vector3(-546.5197, -203.9119, 38.42064)},
		{objHash = 660342567, objHeading = 29.993005752563, objCoords = vector3(-544.5583, -202.7798, 38.42064)}
 },
	slides = false,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Lobby zu Gerichtssaal
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -1940023190, objHeading = 299.99304199219, objCoords = vector3(-556.5889, -199.3688, 38.43664)},
		{objHash = -1940023190, objHeading = 119.99295806885, objCoords = vector3(-557.2386, -198.2432, 38.43664)}
 },
	slides = false,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Warteflur zu Gerichtssaal
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -1940023190, objHeading = 299.99304199219, objCoords = vector3(-562.1283, -202.5661, 38.43664)},
		{objHash = -1940023190, objHeading = 119.9930267334, objCoords = vector3(-562.778, -201.4405, 38.43664)}
 },
	slides = false,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Jury Room
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 299.99304199219,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-577.2459, -216.6084, 38.32499),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Judge Room
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 119.9930267334,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-582.5042, -207.4983, 38.32499),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Treppenhaus zu Zellen
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99301147461,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-574.5858, -216.934, 38.32499),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Zellenraum
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 119.99295806885,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-562.6888, -231.6888, 34.37224),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Zelle links
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99299621582,
	garage = false,
	objHash = 918828907,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-557.9441, -233.1107, 34.4771),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Zelle rechts
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99299621582,
	garage = false,
	objHash = 918828907,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-560.5424, -234.6103, 34.4771),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Ostausgang
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = 297112647, objHeading = 299.99304199219, objCoords = vector3(-567.4882, -236.2653, 34.3575)},
		{objHash = 830788581, objHeading = 119.99298858643, objCoords = vector3(-568.5511, -234.4239, 34.3575)}
 },
	slides = false,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Lobby zu Büroräume
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -1940023190, objHeading = 119.99295806885, objCoords = vector3(-544.1382, -190.6818, 38.43664)},
		{objHash = -1940023190, objHeading = 299.99304199219, objCoords = vector3(-543.4885, -191.8074, 38.43664)}
 },
	slides = false,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Office I
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99301147461,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-541.0229, -192.2024, 38.334),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Office II
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99301147461,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-536.2, -189.4187, 38.334),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Office III
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99301147461,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-531.3376, -186.6122, 38.334),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Wahlraum links
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99299621582,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-538.4105, -185.5889, 38.334),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Wahlraum rechts
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 29.993005752563,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-532.4227, -182.1329, 38.334),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Office IV
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99301147461,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-541.0101, -192.198, 43.46984),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Mayor Office
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99301147461,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-536.1873, -189.4142, 43.46984),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Meeting Room
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 209.99299621582,
	garage = false,
	objHash = 1762042010,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-538.3984, -185.5834, 43.46984),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOJ Zuschauertribüne
table.insert(Config.DoorList, {
	lockpick = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -1940023190, objHeading = 299.99304199219, objCoords = vector3(-562.1256, -202.5645, 43.5755)},
		{objHash = -1940023190, objHeading = 119.9930267334, objCoords = vector3(-562.7753, -201.4389, 43.5755)}
 },
	slides = false,
	authorizedJobs = { ['doj']=0, ['police']=0, ['fib']=0, ['lssd']=0 },
	locked = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})