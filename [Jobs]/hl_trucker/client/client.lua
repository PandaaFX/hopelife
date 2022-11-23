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
	[1] = 'spawned_Truck_and_Trailer',
	[2] = 'attached_Trailer',
	[3] = 'on_tour',
	[4] = 'delivered_goods',
}


local activeBlip = nil
local currentJobVehicle = nil
local currentJobTrailer = nil
local currentJobStatus = nil
local deliverySpot = nil
local deliveryPrice = nil
local deliveryCounter = nil
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
	TriggerServerEvent('ft_trucker:giveBackCautionInCaseOfDrop')
end)

AddEventHandler('ft_trucker:hasEnteredMarker', function(zone)
    thisZone = zone
    if zone == 'Startpoint' then
         
        CurrentAction     = 'Startpoint'
        CurrentActionMsg  = _U('open_actions')
        CurrentActionData = {}
    end 
end)


AddEventHandler('ft_trucker:hasExitedMarker', function(zone)
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
				DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 0.5, 0, 0, 200, 100, false, true, 2, false, nil, nil, false)
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
			TriggerEvent('ft_trucker:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('ft_trucker:hasExitedMarker', LastZone)
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

	for k, v in pairs(Config.AvailableJobs) do
		table.insert(elements, {label = v.name, value = k})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'available_jobs',
		{
			title    = _U('spedition_menu'),
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

						-- is Trailer Spawnpoint free
						local nextSpawnpointT = {}
						local thisSpawnpointsT = Config.AvailableJobs[job].TrailerSpawnPoints

						for i=1, #thisSpawnpointsT, 1 do
							if ESX.Game.IsSpawnPointClear(thisSpawnpointsT[i].coords, thisSpawnpointsT[i].range) then
								table.insert(nextSpawnpointT, i)
							end
						end

						-- is Truck Spawnpoint free
						local nextSpawnpoint = {}
						local thisSpawnpoints = Config.AvailableJobs[job].TruckSpawnPoints

						for i=1, #thisSpawnpoints, 1 do
							if ESX.Game.IsSpawnPointClear(thisSpawnpoints[i].coords, thisSpawnpoints[i].range) then
								table.insert(nextSpawnpoint, i)
							end
						end


						if #nextSpawnpointT > 0 and #nextSpawnpoint > 0 then	
							menu.close()

							local randomTruckSpot = nil
							local randomTrailerSpot = nil

							if #nextSpawnpoint > 1 then
								randomTruckSpot = math.random(1, #nextSpawnpoint)
							else
								randomTruckSpot = 1
							end

							if #nextSpawnpointT > 1 then
								randomTrailerSpot = math.random(1, #nextSpawnpointT)
							else
								randomTrailerSpot = 1
							end

							ESX.Game.SpawnVehicle(Config.AvailableJobs[job].truck, thisSpawnpoints[nextSpawnpoint[randomTruckSpot]].coords, thisSpawnpoints[nextSpawnpoint[randomTruckSpot]].heading, function(vehicle)
								currentJobVehicle = vehicle

								SetVehicleFuelLevel(vehicle, 100.0)
								DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))

								local plate = 'TR ' .. math.random(1000, 99999)
								SetVehicleNumberPlateText(vehicle, plate)

								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								
								vehicleInCaseofDrop = vehicle
								vehicleHashInCaseofDrop = GetHashKey(ESX.Game.GetVehicleProperties(vehicle).model)
								vehicleObjInCaseofDrop = vehicle
								vehicleMaxHealthInCaseofDrop = GetEntityMaxHealth(vehicle)
								vehicleOldHealthInCaseofDrop = vehicleMaxHealthInCaseofDrop
							end)

							ESX.Game.SpawnVehicle(Config.AvailableJobs[job].trailer, thisSpawnpointsT[nextSpawnpointT[randomTrailerSpot]].coords, thisSpawnpointsT[nextSpawnpointT[randomTrailerSpot]].heading, function(trailer)
								currentJobTrailer = trailer
							end)

							local randomSpot = math.random(1, #Config.AvailableJobs[job].DeliverySpots)
							Config.AvailableJobs[job].DeliverySpots[randomSpot].complete = true
							deliverySpot = Config.AvailableJobs[job].DeliverySpots[randomSpot]

							currentJobStatus = allPossibleJobStates[1]
							activeBlip = createBlipAt(thisSpawnpointsT[nextSpawnpointT[randomTrailerSpot]].coords, _U('trailer'))
							TriggerServerEvent('ft_trucker:setCautionInCaseOfDrop', Config.SafeDeposit)
							cautionVehicleInCaseofDrop = Config.SafeDeposit
							maxCautionVehicleInCaseofDrop = cautionVehicleInCaseofDrop
							TriggerServerEvent('ft_trucker:caution', "take", cautionVehicleInCaseofDrop)
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

	local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), deliverySpot.coords.x, deliverySpot.coords.y, deliverySpot.coords.z, false)
	deliveryPrice = ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice

	while currentJobStatus ~= nil do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		-- stop job if truck engine down
		if GetVehicleEngineHealth(currentJobVehicle) <= 100 then
			ESX.ShowNotification(_U('engine_down_cancel'))
			finishDelivery(false, false, false, true, job)
			break
		end

		-- stop job if trailer down
		if GetVehicleBodyHealth(currentJobTrailer) <= 0 then
			ESX.ShowNotification(_U('trailer_down_cancel'))
			finishDelivery(false, false, false, false, job)
			break
		end

		-- stop job if player down
		if IsPedDeadOrDying(playerPed, true) then
			ESX.ShowNotification(_U('player_down_cancel'))
			finishDelivery(false, false, false, false, job)
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
				-- when delivery job is finished
				if currentJobStatus == allPossibleJobStates[4] then
					if GetVehiclePedIsIn(playerPed, false) == currentJobVehicle then
						ESX.ShowHelpNotification(_U('finish_job'))

						if IsControlJustReleased(0, Keys['E']) then
							finishDelivery(true, true, true, true, job)
							break
						end
					end
				-- cancel job
				else
					ESX.ShowHelpNotification(_U('cancel_job'))

					if IsControlJustReleased(0, Keys['E']) then
						finishDelivery(false, true, true, true, job)
						break
					end
				end
			end
		end

		-- show msg/marker if player leave truck
		if GetVehiclePedIsIn(playerPed, false) ~= currentJobVehicle and GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false) > 2 then
			ESX.ShowHelpNotification(_U('get_back_into_your_vehicle'))
			local truckCoords = GetEntityCoords(currentJobVehicle)
			DrawMarker(20, truckCoords.x, truckCoords.y, truckCoords.z + 4.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 200, 100, true, true, 2, nil, nil, true)


		-- show msg/marker if player remove/change trailer after getting jobtrailer
		elseif GetVehiclePedIsIn(playerPed, false) == currentJobVehicle and currentJobStatus == allPossibleJobStates[3] and GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false) > 2 then
			local hasTrailer, trailer = GetVehicleTrailerVehicle(GetVehiclePedIsIn(playerPed, false))
			if not hasTrailer then
				ESX.ShowHelpNotification(_U('get_back_your_trailer'))
				local trailerCoords = GetEntityCoords(currentJobTrailer)
				DrawMarker(20, trailerCoords.x, trailerCoords.y, trailerCoords.z + 4.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 200, 100, true, true, 2, nil, nil, true)

			-- has trailer and is driving with it
			else 
				-- is near delivery point, show marker
				if GetDistanceBetweenCoords(coords, deliverySpot.coords.x, deliverySpot.coords.y, deliverySpot.coords.z, true) < 100 then
					DrawMarker(1, deliverySpot.coords.x, deliverySpot.coords.y, deliverySpot.coords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 1.0, 0, 0, 200, 100, false, true, 2, nil, nil, true)

					-- trailer is in deliver marker
					local trailerCoords = GetEntityCoords(currentJobTrailer)
					if GetDistanceBetweenCoords(deliverySpot.coords.x, deliverySpot.coords.y, deliverySpot.coords.z, trailerCoords.x, trailerCoords.y, trailerCoords.z, false) < 2 then
						ESX.ShowHelpNotification(_U('press_deliver_goods'))

						if IsControlJustReleased(0, Keys['E']) then


							-- if more deliverys
							if Config.AvailableJobs[job].deliver_counter > 1 then

								-- first delivery but not single, init counter
								if deliveryCounter == nil then
									ESX.Scaleform.ShowFreemodeMessage(_U('title_delivered_msg'), _U('msg_delivered_msg_next'), 2)

									deliveryCounter = Config.AvailableJobs[job].deliver_counter - 1
									deliverySpot = nil

									while deliverySpot == nil do
										local randomSpot = math.random(1, #Config.AvailableJobs[job].DeliverySpots)
										if not Config.AvailableJobs[job].DeliverySpots[randomSpot].complete then
											Config.AvailableJobs[job].DeliverySpots[randomSpot].complete = true
											deliverySpot = Config.AvailableJobs[job].DeliverySpots[randomSpot]
											RemoveBlip(activeBlip)
											activeBlip = nil
											activeBlip = createBlipAt(deliverySpot.coords, _U('deliverpoint_blip_addon') .. deliverySpot.name)
											local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), deliverySpot.coords.x, deliverySpot.coords.y, deliverySpot.coords.z, false)
											deliveryPrice = deliveryPrice + (ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice)
										end
									end

								-- not first delivery 
								else
									deliveryCounter = deliveryCounter - 1

									-- no more delivers open
									if deliveryCounter <= 0 then
										ESX.Scaleform.ShowFreemodeMessage(_U('title_delivered_msg'), _U('msg_delivered_msg'), 2)
										currentJobStatus = allPossibleJobStates[4]
										RemoveBlip(activeBlip)
										activeBlip = nil
										activeBlip = createBlipAt(Config.VehicleDeleter, _U('end_delivery_blip'))	
										local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false)
										deliveryPrice = deliveryPrice + (ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice)

									-- more deliverys open
									else
										ESX.Scaleform.ShowFreemodeMessage(_U('title_delivered_msg'), _U('msg_delivered_msg_next'), 2)
										deliverySpot = nil

										while deliverySpot == nil do
											local randomSpot = math.random(1, #Config.AvailableJobs[job].DeliverySpots)
											if not Config.AvailableJobs[job].DeliverySpots[randomSpot].complete then
												Config.AvailableJobs[job].DeliverySpots[randomSpot].complete = true
												deliverySpot = Config.AvailableJobs[job].DeliverySpots[randomSpot]
												RemoveBlip(activeBlip)
												activeBlip = nil
												activeBlip = createBlipAt(deliverySpot.coords, _U('deliverpoint_blip_addon') .. deliverySpot.name)
												local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), deliverySpot.coords.x, deliverySpot.coords.y, deliverySpot.coords.z, false)
												deliveryPrice = deliveryPrice + (ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice)
											end
										end
									end
								end

							-- if single delivery
							else
								ESX.Scaleform.ShowFreemodeMessage(_U('title_delivered_msg'), _U('msg_delivered_msg'), 2)
								currentJobStatus = allPossibleJobStates[4]
								RemoveBlip(activeBlip)
								activeBlip = nil
								activeBlip = createBlipAt(Config.VehicleDeleter, _U('end_delivery_blip'))
								local deliveryDistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, false)
								deliveryPrice = deliveryPrice + (ESX.Math.Round(deliveryDistance, 0) * Config.DistancePrice)
							end
						end
					end
				end
			end
		elseif GetDistanceBetweenCoords(coords, Config.VehicleDeleter.x, Config.VehicleDeleter.y, Config.VehicleDeleter.z, true) > 2 then

			-- Job started, get your trailer
			if currentJobStatus == allPossibleJobStates[1] then
				ESX.ShowHelpNotification(_U('get_your_trailer'))

				local trailerCoords = GetEntityCoords(currentJobTrailer)
				DrawMarker(20, trailerCoords.x, trailerCoords.y, trailerCoords.z + 4.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 200, 100, true, true, 2, nil, nil, true)

				-- Ped is in Job Vehicle
				if GetVehiclePedIsIn(playerPed, false) == currentJobVehicle then
					-- Get has attached trailer / get trailer of jobvehicle (ped is in)
					local hasTrailer, trailer = GetVehicleTrailerVehicle(GetVehiclePedIsIn(playerPed, false))
					-- if has trailer
					if hasTrailer then
						-- is trailer = jobtrailer
						if currentJobTrailer == trailer then
							-- set new jobstatus
							currentJobStatus = allPossibleJobStates[2]
						end
					end	
				end	

			-- Trailer attached, set route to delivery spot and new status
			elseif currentJobStatus == allPossibleJobStates[2] then
				RemoveBlip(activeBlip)
				activeBlip = nil
				activeBlip = createBlipAt(deliverySpot.coords, _U('deliverpoint_blip_addon') .. deliverySpot.name)
				currentJobStatus = allPossibleJobStates[3]

				ESX.ShowNotification(_U('get_to_delivery_point'))
			end
		end
	end
end

function createBlipAt(coords, name)

	local currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)

	SetBlipSprite(currentBlip, 8)
	SetBlipColour(currentBlip, 29)
	SetBlipDisplay(currentBlip, 4)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(name)
	EndTextCommandSetBlipName(currentBlip)
	SetBlipAsShortRange(currentBlip, true)

	SetBlipAsMissionCreatorBlip(currentBlip, true)
	SetBlipRoute(currentBlip, true)

	return currentBlip
end

function finishDelivery(finished, SafeDepositReturn, deleteVeh, deleteT, job)

	-- remove truck key
	local currentPlate = ESX.Game.GetVehicleProperties(currentJobVehicle).plate

	-- give back caution
	if SafeDepositReturn then
		TriggerServerEvent('ft_trucker:caution', "give_back", cautionVehicleInCaseofDrop)
	end

	-- delelte trailer&truck
	if deleteVeh then
		ESX.Game.DeleteVehicle(currentJobVehicle)
	end

	if deleteT then
		ESX.Game.DeleteVehicle(currentJobTrailer)
	end

	-- remove blip/route and reset variables
	RemoveBlip(activeBlip)
	activeBlip = nil
	currentJobVehicle = nil
	currentJobTrailer = nil
	currentJobStatus = nil
	deliverySpot = nil
	deliveryCounter = nil
	cautionVehicleInCaseofDrop = 0
	maxCautionVehicleInCaseofDrop = 0
	vehicleInCaseofDrop = nil
	vehicleHashInCaseofDrop = nil
	vehicleMaxHealthInCaseofDrop = nil
	vehicleOldHealthInCaseofDrop = nil
	vehicleObjInCaseofDrop = nil
	TriggerServerEvent('ft_trucker:setCautionInCaseOfDrop', 0)

	-- give money if job was finished
	if finished then
		TriggerServerEvent('ft_trucker:giveMoney', deliveryPrice)
		deliveryPrice = nil
	else
		deliveryPrice = nil
	end

	-- make all delivery spots of last job available again
	for i=1, #Config.AvailableJobs[job].DeliverySpots, 1 do
		Config.AvailableJobs[job].DeliverySpots[i].complete = false
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
					TriggerServerEvent('ft_trucker:setCautionInCaseOfDrop', cautionValue)
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)