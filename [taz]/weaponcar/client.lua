ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local duffle = true 
local bagErrorText = "Diese Waffe kannst du nur aus einem Auto holen oder aus einer Tasche ziehen."
local carErrorText = "Diese Waffe kannst du nur aus einem Auto holen."
local equippedOnSling = "Du hast dir die Waffe umgehangen."
local storedInBag = "Du hast die Waffe in deiner Tasche verstaut."
rifleOnSling = false
BackEngineVehicles = {
    [`ninef`] = true,
    [`adder`] = true,
    [`vagner`] = true,
    [`t20`] = true,
    [`infernus`] = true,
    [`zentorno`] = true,
    [`reaper`] = true,
    [`comet2`] = true,
    [`comet3`] = true,
    [`jester`] = true,
    [`jester2`] = true,
    [`cheetah`] = true,
    [`cheetah2`] = true,
    [`prototipo`] = true,
    [`turismor`] = true,
    [`pfister811`] = true,
    [`ardent`] = true,
    [`nero`] = true,
    [`nero2`] = true,
    [`tempesta`] = true,
    [`vacca`] = true,
    [`bullet`] = true,
    [`osiris`] = true,
    [`entityxf`] = true,
    [`turismo2`] = true,
    [`fmj`] = true,
    [`re7b`] = true,
    [`tyrus`] = true,
    [`italigtb`] = true,
    [`penetrator`] = true,
    [`monroe`] = true,
    [`ninef2`] = true,
    [`stingergt`] = true,
    [`surfer`] = true,
    [`surfer2`] = true,
    [`gp1`] = true,
    [`autarch`] = true,
    [`tyrant`] = true
}
rifles = {
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_ASSAULTSMG",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_DBSHOTGUN",
	"WEAPON_GUSENBERG",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_MG",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_MUSKET",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_SWEEPERSHOTGUN",
}
local SETTINGS = {
	back_bone = 24816,
	x = 0.25,
	y = -0.17,
	z = -0.02,
	x_rotation = 0.0,
	y_rotation = 180.0,
	z_rotation = 0.0,
	compatible_weapon_hashes = {
	  -- melee:
	  --["prop_golf_iron_01"] = 1141786504, -- positioning still needs work
	  --["w_me_bat"] = -1786099057,
	  --["prop_ld_jerrycan_01"] = 883325847,
	  -- assault rifles:
	  ["w_ar_carbinerifle"] = -2084633992,
	  ["w_ar_carbineriflemk2"] = GetHashKey("WEAPON_CARBINERIFLE_MK2"),
	  ["w_ar_assaultrifle"] = -1074790547,
	  ["w_ar_specialcarbine"] = -1063057011,
	  ["w_ar_bullpuprifle"] = 2132975508,
	  ["w_ar_advancedrifle"] = -1357824103,
	  -- sub machine guns:
	  ["w_sb_microsmg"] = 324215364,
	  ["w_sb_assaultsmg"] = -270015777,
	  ["w_sb_smg"] = 736523883,
	  ["w_sb_smgmk2"] = GetHashKey("WEAPON_SMG_MK2"),
	  ["w_sb_gusenberg"] = 1627465347,
	  -- sniper rifles:
	  ["w_sr_sniperrifle"] = 100416529,
	  -- shotguns:
	  ["w_sg_assaultshotgun"] = -494615257,
	  ["w_sg_bullpupshotgun"] = -1654528753,
	  ["w_sg_pumpshotgun"] = 487013001,
	  ["w_ar_musket"] = -1466123874,
	  ["w_sg_heavyshotgun"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
	  -- ["w_sg_sawnoff"] = 2017895192 don't show, maybe too small?
	  -- launchers:
	  ["w_lr_firework"] = 2138347493
	}
}

currWeapon = GetHashKey("WEAPON_UNARMED")
local attached_weapons = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while true do
		Wait(250)
		local hasBag = GetBagState()
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed, true)
			if currWeapon ~= weapon then
				if isWeaponRifle(weapon) then
					--local vehicle = GetTrunkPosition()
					local vehicle, distance = ESX.Game.GetClosestVehicle()
					distance = GetTrunkPosition(vehicle)
        			if vehicle and distance < 2 then
					--if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
						currWeapon = weapon
						SetVehicleDoorOpen(vehicle, 5, false, false)
						Citizen.Wait(2000)
						SetVehicleDoorShut(vehicle, 5, false)
					else
						if IsPedModel(playerPed,1885233650) and GetVehiclePedIsIn(playerPed, false) == 0 then
							if hasBag then
								currWeapon = weapon
							else
								Citizen.Wait(3000)
								drawNotification(bagErrorText)
								SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								DisablePlayerFiring(PlayerPedId(), false)
							end
						else	
							if IsPedModel(playerPed,-1667301416) and GetVehiclePedIsIn(playerPed, false) == 0 then
								if hasBag then
									currWeapon = weapon
								else									
									Citizen.Wait(3000)
									drawNotification(bagErrorText)
									SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
									SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
									DisablePlayerFiring(PlayerPedId(), false)
								end
							end
						end
					end
				end
			end
		end
	end
end) 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while true do
		Wait(500)
		local hasBag = GetBagState()
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed, true)
			if  currWeapon ~= weapon then
				if not isWeaponRifle(weapon) and rifleOnSling == false then
					--local vehicle = GetTrunkPosition()
					
					--if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
					local vehicle, distance = ESX.Game.GetClosestVehicle()
					distance = GetTrunkPosition(vehicle)
					if vehicle and distance < 2 then
						currWeapon = GetHashKey("WEAPON_UNARMED")
						SetVehicleDoorOpen(vehicle, 5, false, false)
						Citizen.Wait(2000)
						SetVehicleDoorShut(vehicle, 5, false)
					else
						if IsPedModel(playerPed,1885233650) and currWeapon == weapon and GetVehiclePedIsIn(playerPed, false) == 0 then
							if hasBag then
								currWeapon = weapon
							end
						elseif IsPedModel(playerPed,-1667301416) and currWeapon == weapon and GetVehiclePedIsIn(playerPed, false) == 0 then
							if hasBag then
								currWeapon = weapon
							end
							
						--elseif hasBag then
							--Wait(1)
							--drawNotification(storedInBag)
						else
							Wait(1)
							drawNotification(equippedOnSling)
							rifleOnSling = true
							for wep_name, wep_hash in pairs(SETTINGS.compatible_weapon_hashes) do
								if currWeapon == wep_hash then
									if not attached_weapons[wep_name] and GetSelectedPedWeapon(playerPed) ~= wep_hash then
										AttachWeapon(wep_name, wep_hash, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, false)
									end
								end
							end
						end
					end
				end
			--else 
				--for name, attached_object in pairs(attached_weapons) do
					--if GetSelectedPedWeapon(me) ==  attached_object.hash or not HasPedGotWeapon(me, attached_object.hash, false) then 
						--DeleteObject(attached_object.handle)
						--attached_weapons[name] = nil
					--end
				--end
			end
			for name, attached_object in pairs(attached_weapons) do
				if GetSelectedPedWeapon(playerPed) ==  attached_object.hash or not HasPedGotWeapon(playerPed, attached_object.hash, false) then 
					DeleteObject(attached_object.handle)
					attached_weapons[name] = nil
				end
			end
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		playerPed = GetPlayerPed(-1)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed, true)
			if isWeaponRifle(weapon) and rifleOnSling == true and currWeapon == weapon then
					rifleOnSling = false
			end
		end
		Wait(500)
	end
end)

function GetTrunkPosition(vehicle)
	local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -2.5, 0.0)
	if (IsBackEngine(GetEntityModel(vehicle))) then
		entityWorld = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
	end
	return GetDistanceBetweenCoords(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, false)
    --local _, _, _, _, result = GetRaycastResult(CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0))
end

function GetBagState()
	return GetPedDrawableVariation(playerPed,5) == 51 or GetPedDrawableVariation(playerPed,5) == 52 or GetPedDrawableVariation(playerPed,5) == 88 or GetPedDrawableVariation(playerPed,5) == 89
end

function drawNotification(Notification)
	TriggerEvent('hopelife:notify', 1, '#5f0085', 'HopeLife', Notification, 3000)
end

function isWeaponRifle(model)
	for _, rifle in pairs(rifles) do
		if model == GetHashKey(rifle) then
			return true
		end
	end
	return false
end
function getRifleName(model)
	for _, rifle in pairs(rifles) do
		if model == GetHashKey(rifle) then
			return rifle
		end
	end
	return false
end
function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR, isMelee)
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
	  Wait(100)
	end
	
	attached_weapons[attachModel] = {
		hash = modelHash,
		handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
	}
	if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end -- reposition for melee items
	if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end
	AttachEntityToEntity(attached_weapons[attachModel].handle, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

function IsBackEngine(vehModel)
    if BackEngineVehicles[vehModel] then return true end
    return false
end

