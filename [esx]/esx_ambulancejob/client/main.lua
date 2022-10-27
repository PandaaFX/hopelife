local firstSpawn = true
local pvp = false
isDead, isSearched, medic = false, false, 0
local purge = false 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	firstSpawn = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false

	if firstSpawn then
		firstSpawn = false

		if Config.SaveDeathStatus then
			while not ESX.PlayerLoaded do
				Wait(1000)
			end

			ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
				if shouldDie then
					Wait(1000)
					SetEntityHealth(PlayerPedId(), 0)
				end
			end)
		end
	end
end)

-- Create blips
CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_hospital'))
		EndTextCommandSetBlipName(blip)
	end

	while true do 
		local Sleep = 1500
		
		if isDead then
			Sleep = 0
			DisableAllControlActions(0)
			EnableControlAction(0, 47, true)
			EnableControlAction(0, 245, true)
			EnableControlAction(0, 38, true)

			if isSearched then
				local playerPed = PlayerPedId()
				local ped = GetPlayerPed(GetPlayerFromServerId(medic))
				isSearched = false
	
				AttachEntityToEntity(playerPed, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				Wait(1000)
				DetachEntity(playerPed, true, false)
				ClearPedTasksImmediately(playerPed)
			end
		end

		Wait(Sleep)
	end
end)

RegisterNetEvent('esx_ambulancejob:clsearch')
AddEventHandler('esx_ambulancejob:clsearch', function(medicId)
	local playerPed = PlayerPedId()

	if isDead then
		local coords = GetEntityCoords(playerPed)
		local playersInArea = ESX.Game.GetPlayersInArea(coords, 50.0)

		for i=1, #playersInArea, 1 do
			local player = playersInArea[i]
			if player == GetPlayerFromServerId(medicId) then
				medic = tonumber(medicId)
				isSearched = true
				break
			end
		end
	end
end)

--Purge Event

local function purgemsg(purge)
	if purge == true then
		ESX.ShowNotification("Purge wurde ~g~gestartet", "success", 3000)
	else
		ESX.ShowNotification("Purge wurde ~r~gestoppt", "success", 3000)
	end

end

RegisterNetEvent('hopelife:purgecmd')
AddEventHandler('hopelife:purgecmd', function ()
	if purge == true then
		purge = false
		ESX.ShowNotification("Purge wurde ~r~gestoppt", "success", 3000)
	else
		TriggerServerEvent("Server:SoundToAll", "ChillPurge.mp3", 1.0);
		purge = true
		ESX.ShowNotification("Purge wurde ~g~gestartet", "success", 3000)
	end
	--[[for _, playerId in ipairs(GetPlayers()) do
		--purgemsg(purge)
	end
]]
end)



function OnPlayerDeath()
	if purge == false then
		isDead = true
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
	
		StartDeathTimer()
		StartDistressSignal()
		StartNotSignal()
	
		AnimpostfxPlay('DeathFailOut', 0, false)
		ClearPedTasksImmediately(GetPlayerPed(-1))
	elseif purge == true then

		local respawn = math.random(0, 3)
		local heading = math.random(0, 360)
		local respawnpos;
		if respawn == 0 then
			respawnpos = vector3(1900.312134, 2605.265869, 48.724487);
			RespawnPed(PlayerPedId(), respawnpos, heading)
		elseif respawn == 1 then
			respawnpos = vector3(-2531.828613, 2324.703369, 33.054199);
			RespawnPed(PlayerPedId(), respawnpos, heading)
		elseif respawn == 2 then
			respawnpos = vector3(-987.323059, -2706.224121, 13.828613);
			RespawnPed(PlayerPedId(), respawnpos, heading)
		elseif respawn == 3 then
			respawnpos = vector3(892.021973, -57.270325, 78.750977);
			RespawnPed(PlayerPedId(), respawnpos, heading)
		end



	end

end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		ESX.UI.Menu.CloseAll()

		if itemName == 'medikit' then
			local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
			local playerPed = PlayerPedId()

			ESX.Streaming.RequestAnimDict(lib, function()
				TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

				Wait(500)
				while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
					Wait(0)
					DisableAllControlActions(0)
				end

				TriggerEvent('hl:heal', 'big', true)
				ESX.ShowNotification(_U('used_medikit'))
			end)

		elseif itemName == 'bandage' then
			local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
			local playerPed = PlayerPedId()
			local health = GetEntityHealth(playerPed)
			local maxHealth = GetEntityMaxHealth(playerPed)
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
			if skin.sex == 0 then
				if health <= 150 then
					SetEntityHealth(playerPed, newHealth)
					ESX.ShowNotification("Du hast dich verbunden")
				else
					ESX.ShowNotification("Mit Verbänden kannst du dich nicht höher heilen")
					return
				end
				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

					Wait(500)
					while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
						Wait(0)
						DisableAllControlActions(0)
					end

					TriggerEvent('hl:heal', 'small', true)
					ESX.ShowNotification(_U('used_bandage'))
				end)
			else
				if health <= 135 then
					SetEntityHealth(playerPed, newHealth)
					ESX.ShowNotification("Du hast dich verbunden")
				else
					ESX.ShowNotification("Mit Verbänden kannst du dich nicht höher heilen")
					return
				end
				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

					Wait(500)
					while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
						Wait(0)
						DisableAllControlActions(0)
					end

					TriggerEvent('hl:heal', 'small', true)
					ESX.ShowNotification(_U('used_bandage'))
				end)
			end
		end
	end)
end)

function StartDistressSignal()
	CreateThread(function()
		local timer = Config.BleedoutTimer
		local anonym = false
		local coords = GetEntityCoords(PlayerPedId())
		local position = {x = coords.x, y = coords.y, z = coords.z - 1}
		local jobreceived = "ambulance"
		local message = "Eine Person benötigt Hilfe!"
		while timer > 0 and isDead do
			Wait(0)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlJustReleased(0, 47) then
				print("kek")
				SendDistressSignal()
				break
			end
		end
	end)
end

function StartNotSignal()
	CreateThread(function()
		local timer = Config.BleedoutTimer
		while timer > 0 and isDead do
			Wait(0)
			timer = timer - 30
			if IsControlJustReleased(0, 47) then
				ExecuteCommand("help")
				break
			end
		end
	end)
end

function SendDistressSignal()
	print("kek2")
	TriggerEvent("d-phone:client:message:senddispatch", "Bewusstlose Person", "ambulance")
	TriggerEvent("d-notification", "Dispatch gesendet!", 5000,  "success")
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format('%02.f', math.floor(seconds / 3600))
		local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(text)
			EndTextCommandDisplayText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, 38) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, 38) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, 38) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(text)
			EndTextCommandDisplayText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and isDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function GetClosestRespawnPoint()
	local PlyCoords = GetEntityCoords(PlayerPedId())
	local ClosestDist,ClosestHosptial, ClostestCoord = 10000, {}, nil

	for k,v in pairs(Config.RespawnPoints) do
		local Distance = #(PlyCoords - vector3(v.coords.x, v.coords.y, v.coords.z))
		if Distance <= ClosestDist then
			ClosestDist = Distance
			ClosestHosptial = v
			ClostestCoord = vector3(v.coords.x, v.coords.y, v.coords.z)
		end
	end

	return ClostestCoord, ClosestHosptial
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Wait(0)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local RepspawnCoords, ClosestHosptial = GetClosestRespawnPoint()

			ESX.SetPlayerData('loadout', {})
			RespawnPed(PlayerPedId(), RepspawnCoords, ClosestHosptial.heading, true)

			AnimpostfxStop('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

function RespawnPed(ped, coords, heading, isDied)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
	if isDied then
		TriggerServerEvent('msk_backpack:setDeathStatus', true)
	end
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    --if not exports["ws_ffa"]:isInZone() then
		OnPlayerDeath()
    --end
	-- print("ws_ffa")
end)

RegisterNetEvent('hl:revive')
AddEventHandler('hl:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)
	exports.logmanager:log{message = "hl:revive"}
	AnimpostfxStop('DeathFailOut')
	DoScreenFadeIn(800)
end)


RegisterNetEvent('esx_ambulancejob_Revive_gangwar')
AddEventHandler('esx_ambulancejob_Revive_gangwar', function(x,y,z)
        local playerPed = PlayerPedId();
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
        TriggerServerEvent("esx_ambulancejob:setstabile",false)
        local formattedCoordss = {x = x, y = y, z = z }
        RespawnPed(playerPed, formattedCoordss, 120.0)
        StopScreenEffect('DeathFailOut')
        Wait(3000)
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	RequestIpl('Coroner_Int_on') -- Morgue
end
