local IsDead = false
local IsAnimated = false

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)


RegisterNetEvent('hl:healPlayer')
AddEventHandler('hl:healPlayer', function()
	exports.logmanager:log{message = "hl:healPlayer"}
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
		status.remove(125)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
		status.remove(100)
	end)

end)

AddEventHandler('esx_status:onTick', function(data)
	local playerPed  = PlayerPedId()
	local prevHealth = GetEntityHealth(playerPed)
	local health     = prevHealth
	
	for k, v in pairs(data) do
		if v.name == 'hunger' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'thirst' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		end
	end
	
	if health ~= prevHealth then SetEntityHealth(playerPed, health) end
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

				Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			CreateThread(function()
				Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification("Fahrzeug gefixt")
			end)
		end
	end
end)
