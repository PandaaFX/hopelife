

Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_c_cat_01"))
	
    while not HasModelLoaded(GetHashKey("a_c_cat_01")) do
        Wait(1)
    end

	local ped = CreatePed(4, 0x573201B8, -581.208801, -1055.670288, 22.388306, 0, false, true)
    local ped2 = CreatePed(4, 0x573201B8,-572.848328, -1053.916504, 22.337769, 0, false, true)
    local ped3 = CreatePed(4, 0x573201B8,-577.107666, -1061.947266, 22.337769, 0, false, true)		
	SetBlockingOfNonTemporaryEvents(ped, true)
    SetBlockingOfNonTemporaryEvents(ped2, true)
    SetBlockingOfNonTemporaryEvents(ped3, true)
    -- Make ped wander in spawned area with radius of 100 meters, will wander at least 2 meters and wait for around 10 seconds between patrols
    TaskWanderInArea(ped, -581.208801, -1055.670288, 22.388306, 20.0, 2, 10.0)
    TaskWanderInArea(ped2, -572.848328, -1053.916504, 22.337769, 20.0, 2, 10.0)
    TaskWanderInArea(ped3, -577.107666, -1061.947266, 22.337769, 20.0, 2, 10.0)
end)