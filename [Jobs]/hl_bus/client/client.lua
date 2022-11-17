local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local HasAlreadyEnteredMarker, LastZone = false, nil

local allPossibleJobStates = {
	[1] = 'spawned_bus',
	[2] = 'entered_bus',
	[3] = 'on_tour',
	[4] = 'did_all_stops',
}


local activeBlip = nil
local currentJobVehicle = nil
local currentJobStatus = nil
local busStationStop = nil
local routePrice = nil
local vehicleMaxHealth = nil

local cautionVehicleInCaseofDrop    = 0
local maxCautionVehicleInCaseofDrop = 0
local vehicleObjInCaseofDrop        = nil
local vehicleInCaseofDrop           = nil
local vehicleHashInCaseofDrop       = nil
local vehicleMaxHealthInCaseofDrop  = nil
local vehicleOldHealthInCaseofDrop  = nil


-- Get ESX & set blip
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
  	end
  
	for k, v in pairs (Config.Blips) do
		local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

		SetBlipSprite(blip, v.type)
		SetBlipScale(blip, v.scale)
		SetBlipColour(blip, v.colour)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.name)
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent('ft_bus:giveBackCautionInCaseOfDrop')
end)

AddEventHandler('ft_bus:hasEnteredMarker', function(zone)
    thisZone = zone
    if zone == 'Startpoint' then
         
        CurrentAction     = 'Startpoint'
        CurrentActionMsg  = _U('open_actions')
        CurrentActionData = {}
    end 
end)


AddEventHandler('ft_bus:hasExitedMarker', function(zone)
    if zone == 'Startpoint' then
		ESX.UI.Menu.CloseAll()
    end
 
    CurrentAction = nil
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		local letSleep    = true

		-- Draw Marker
		for k, v in pairs(Config.Blips) do
			if GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < 100 then
				DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 0.5, 0, 200, 0, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end
		end

		-- Marker Enter/Leave Handler
		for k, v in pairs(Config.Blips) do
			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < 1.5) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('ft_bus:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('ft_bus:hasExitedMarker', LastZone)
		end

	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
         
        if CurrentAction then
            ESX.ShowHelpNotification(CurrentActionMsg)
 
            if IsControlJustReleased(0, Keys['E']) then
 
				if CurrentAction == 'Startpoint' then
					if currentJobStatus == nil then
						OpenAvailableJobsMenu()
					else
						ESX.ShowNotification(_U('only_one_job'))
					end
                end
 
                CurrentAction = nil
            end
        end
         
    end
end)


function OpenAvailableJobsMenu()
	local playerPed = PlayerPedId()
	local elements =  {}

	for k, v in pairs(Config.AvailableRoutes) do
		table.insert(elements, {label = v.name, value = k})
	end

	table.sort(elements, function(a,b) return a.value < b.value end)

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'available_jobs',
		{
			title    = _U('bus_menu'),
			elements = elements
		},
		function(data, menu)

			-- type selected
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'confirm',
				{
					title    = _U('confirm_start'),
					elements = {
						{label = _U('yes'), value = 'yes'},
						{label = _U('no'), value = 'no'}
					}
				},
				function(data2, menu2)
		
					if data2.current.value == 'yes' then

						local job = data.current.value

						menu2.close()

						-- is bus Spawnpoint free
						local nextSpawnpoint = {}
						local thisSpawnpoints = Config.AvailableRoutes[job].BusSpawnPoints

						for i=1, #thisSpawnpoints, 1 do
							if ESX.Game.IsSpawnPointClear(thisSpawnpoints[i].coords, thisSpawnpoints[i].range) then
								table.insert(nextSpawnpoint, i)
							end
						end


						if #nextSpawnpoint > 0 then	
							menu.close()

							local randomBusSpot = nil

							if #nextSpawnpoint > 1 then
								randomBusSpot = math.random(1, #nextSpawnpoint)
							else
								randomBusSpot = 1
							end

							ESX.Game.SpawnVehicle(Config.AvailableRoutes[job].bus, thisSpawnpoints[nextSpawnpoint[randomBusSpot]].coords, thisSpawnpoints[nextSpawnpoint[randomBusSpot]].heading, function(vehicle)
								currentJobVehicle = vehicle

								SetVehicleFuelLevel(vehicle, 100.0)
								DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
								local plate = 'B ' .. math.random(1000, 99999)
								SetVehicleNumberPlateText(vehicle, plate)

								SetVehicleColours(vehicle, Config.AvailableRoutes[job].color, Config.AvailableRoutes[job].color)
								SetVehicleDirtLevel(vehicle, 0)
								
								vehicleInCaseofDrop = vehicle
								vehicleHashInCaseofDrop = GetHashKey(ESX.Game.GetVehicleProperties(vehicle).model)
								vehicleObjInCaseofDrop = vehicle
								vehicleMaxHealthInCaseofDrop = GetEntityMaxHealth(vehicle)
								vehicleOldHealthInCaseofDrop = vehicleMaxHealthInCaseofDrop
							end)

							busStationStop = Config.AvailableRoutes[job].BusStops[1]

							currentJobStatus = allPossibleJobStates[1]
							activeBlip = createBlipAt(thisSpawnpoints[nextSpawnpoint[randomBusSpot]].coords, _U('bus'))
							TriggerServerEvent('ft_bus:setCautionInCaseOfDrop', Config.SafeDeposit)
							cautionVehicleInCaseofDrop = Config.SafeDeposit
							maxCautionVehicleInCaseofDrop = cautionVehicleInCaseofDrop
							TriggerServerEvent('ft_bus:caution', "take", cautionVehicleInCaseofDrop)
							StartDeliveryJob(job)
						else
							ESX.ShowNotification(_U('currently_no_place_free'))
						end


					elseif data2.current.value == 'no' then
						menu2.close()
					end	
				end,
				function(data2, menu2)
					menu2.close()
				end
			)

		end,
		function(data, menu)
			menu.close()
		end
	)
end


function StartDeliveryJob(job)

	local currentSpot = 1

	local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), busStationStop.coords.x, busStationStop.coords.y, busStationStop.coords.z, false)
	routePrice = ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice

	while currentJobStatus ~= nil do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		-- stop job if bus engine down
		if GetVehicleEngineHealth(currentJobVehicle) <= 100 then
			ESX.ShowNotification(_U('engine_down_cancel'))
			finishBusJob(false, false, false, job)
			break
		end

		-- stop job if player down
		if IsPedDeadOrDying(playerPed, true) then
			ESX.ShowNotification(_U('player_down_cancel'))
			finishBusJob(false, false, false, job)
			break
		end

		-- is Player near deleter spot 
		if GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, true) < 100 then
			-- draw marker green if job is finished, draw marker red if not finished
			if currentJobStatus == allPossibleJobStates[4] then
				DrawMarker(1, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 1.0, 0, 255, 0, 100, false, true, 2, nil, nil, true)
			else
				DrawMarker(1, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, true)
			end

			-- show helptext if close enough
			if GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, true) < 2 then
				-- when bus job is finished
				if currentJobStatus == allPossibleJobStates[4] then
					if GetVehiclePedIsIn(playerPed, false) == currentJobVehicle then
						ESX.ShowHelpNotification(_U('finish_job'))

						if IsControlJustReleased(0, Keys['E']) then
							finishBusJob(true, true, true, job)
							break
						end
					end
				-- cancel job
				else
					ESX.ShowHelpNotification(_U('cancel_job'))

					if IsControlJustReleased(0, Keys['E']) then
						finishBusJob(false, true, true, job)
						break
					end
				end
			end
		end

		-- show msg/marker if player leave bus
		if GetVehiclePedIsIn(playerPed, false) ~= currentJobVehicle and GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false) > 2 and currentJobStatus ~= allPossibleJobStates[1] then
			ESX.ShowHelpNotification(_U('get_back_into_your_vehicle'))
			local busCoords = GetEntityCoords(currentJobVehicle)
			DrawMarker(20, busCoords.x, busCoords.y, busCoords.z + 4.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 0, 200, 0, 100, true, true, 2, nil, nil, true)


		-- driving routine
		elseif GetVehiclePedIsIn(playerPed, false) == currentJobVehicle and currentJobStatus == allPossibleJobStates[3] and GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false) > 2 then

			-- is near bus stop, show marker
			if GetDistanceBetweenCoords(coords, busStationStop.coords.x, busStationStop.coords.y, busStationStop.coords.z, true) < 100 then
				DrawMarker(1, busStationStop.coords.x, busStationStop.coords.y, busStationStop.coords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 1.0, 0, 200, 0, 100, false, true, 2, nil, nil, true)

				-- bus is in stop marker
				local busCoords = GetEntityCoords(currentJobVehicle)
				if GetDistanceBetweenCoords(busStationStop.coords.x, busStationStop.coords.y, busStationStop.coords.z, busCoords.x, busCoords.y, busCoords.z, false) < 2 then
					ESX.ShowHelpNotification(_U('press_to_open_doors'))

					if IsControlJustReleased(0, Keys['E']) and GetVehicleDashboardSpeed(currentJobVehicle) <= 2 then

						openDoorRoutine()

						-- if more stops
						if #Config.AvailableRoutes[job].BusStops > currentSpot then

							busStationStop = Config.AvailableRoutes[job].BusStops[currentSpot + 1]
							RemoveBlip(activeBlip)
							activeBlip = nil
							activeBlip = createBlipAt(busStationStop.coords, _U('buspoint_blip_addon') .. busStationStop.name)
							local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), busStationStop.coords.x, busStationStop.coords.y, busStationStop.coords.z, false)
							routePrice = routePrice + (ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice)
							currentSpot = currentSpot + 1
							ESX.ShowNotification(_U('msg_next_stop'))
							
						-- all stops done
						else

							currentJobStatus = allPossibleJobStates[4]
							RemoveBlip(activeBlip)
							activeBlip = nil
							activeBlip = createBlipAt(Config.VehicleDeleter, _U('end_delivery_blip'))	
							local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false)
							routePrice = routePrice + (ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice)
							ESX.ShowNotification(_U('msg_return_bus'))
						end

					-- bus is not standing
					elseif IsControlJustReleased(0, Keys['E']) and GetVehicleDashboardSpeed(currentJobVehicle) >= 2 then
						ESX.ShowNotification(_U('to_fast'))
					end
				end
			end


		elseif GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, true) > 2 then

			-- Job started, get your trailer
			if currentJobStatus == allPossibleJobStates[1] then
				ESX.ShowHelpNotification(_U('get_your_bus'))

				local busCoords = GetEntityCoords(currentJobVehicle)
				DrawMarker(20, busCoords.x, busCoords.y, busCoords.z + 4.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 0, 200, 0, 100, true, true, 2, nil, nil, true)

				-- Ped is in Job Vehicle
				if GetVehiclePedIsIn(playerPed, false) == currentJobVehicle then

					-- set new jobstatus
					currentJobStatus = allPossibleJobStates[2]
				end	

			-- Trailer attached, set route to delivery spot and new status
			elseif currentJobStatus == allPossibleJobStates[2] then
				RemoveBlip(activeBlip)
				activeBlip = nil
				activeBlip = createBlipAt(busStationStop.coords, _U('buspoint_blip_addon') .. busStationStop.name)
				currentJobStatus = allPossibleJobStates[3]

				ESX.ShowNotification(_U('get_to_bus_point'))
			end
		end
	end
end

function createBlipAt(coords, name)

	local currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)

	SetBlipSprite(currentBlip, 8)
	SetBlipColour(currentBlip, 2)
	SetBlipDisplay(currentBlip, 4)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(name)
	EndTextCommandSetBlipName(currentBlip)
	SetBlipAsShortRange(currentBlip, true)

	SetBlipAsMissionCreatorBlip(currentBlip, true)
	SetBlipRoute(currentBlip, true)

	return currentBlip
end

function openDoorRoutine()

	FreezeEntityPosition(currentJobVehicle, true)
	SetVehicleDoorOpen(currentJobVehicle, 0, false)
	SetVehicleDoorOpen(currentJobVehicle, 1, false)
	SetVehicleDoorOpen(currentJobVehicle, 2, false)
	SetVehicleDoorOpen(currentJobVehicle, 3, false)
	Citizen.Wait(Config.BusStopTimer)
	SetVehicleDoorShut(currentJobVehicle, 0, false)
	SetVehicleDoorShut(currentJobVehicle, 1, false)
	SetVehicleDoorShut(currentJobVehicle, 2, false)
	SetVehicleDoorShut(currentJobVehicle, 3, false)
	FreezeEntityPosition(currentJobVehicle, false)

end

function finishBusJob(finished, SafeDepositReturn, deleteVeh, job)

	-- remove bus key
	local currentPlate = ESX.Game.GetVehicleProperties(currentJobVehicle).plate

	-- give back caution
	if SafeDepositReturn then
		TriggerServerEvent('ft_bus:caution', "give_back", cautionVehicleInCaseofDrop)
	end

	-- delelte bus
	if deleteVeh then
		ESX.Game.DeleteVehicle(currentJobVehicle)
	end

	-- remove blip/route and reset variables
	RemoveBlip(activeBlip)
	activeBlip = nil
	currentJobVehicle = nil
	currentJobStatus = nil
	busStationStop = nil

	cautionVehicleInCaseofDrop = 0
	maxCautionVehicleInCaseofDrop = 0
	vehicleInCaseofDrop = nil
	vehicleHashInCaseofDrop = nil
	vehicleMaxHealthInCaseofDrop = nil
	vehicleOldHealthInCaseofDrop = nil
	vehicleObjInCaseofDrop = nil
	TriggerServerEvent('ft_bus:setCautionInCaseOfDrop', 0)

	-- give money if job was finished
	if finished then
		ESX.Scaleform.ShowFreemodeMessage(_U('title_finished_msg'), _U('msg_finished_msg', ESX.Math.GroupDigits(ESX.Math.Round(routePrice, 0))), 2)
		TriggerServerEvent('ft_bus:giveMoney', routePrice)
		routePrice = nil
	else
		routePrice = nil
	end
end

-- Vehicle caution
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if vehicleInCaseofDrop ~= nil then
			if currentJobStatus ~= nil then
				local vehicleHealth = GetEntityHealth(vehicleInCaseofDrop)

				if vehicleOldHealthInCaseofDrop ~= vehicleHealth then
					local cautionValue = 0
					vehicleOldHealthInCaseofDrop = vehicleHealth
					if vehicleHealth == vehicleMaxHealthInCaseofDrop then
						cautionValue = maxCautionVehicleInCaseofDrop
						cautionVehicleInCaseofDrop = cautionValue
					else
						local healthPct = (vehicleHealth * 100) / vehicleMaxHealthInCaseofDrop
						local damagePct = 100 - healthPct
						cautionValue =  math.ceil(cautionVehicleInCaseofDrop - cautionVehicleInCaseofDrop * damagePct * 2.5 / 100)
						if cautionValue < 0 then
							cautionValue = 0
						elseif cautionValue >= cautionVehicleInCaseofDrop then
							cautionValue = cautionVehicleInCaseofDrop
						end
						cautionVehicleInCaseofDrop = cautionValue
					end
					TriggerServerEvent('ft_bus:setCautionInCaseOfDrop', cautionValue)
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)