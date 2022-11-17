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

ESX						= nil
local CurrentAction		= nil
local isReparing 		= false
local IsMecanoOnline	= false
local PlayerData		= {}
local inVeh = false
local distance = 0
local vehPlate

hasKM = 0
hasCheck = 0
showKM = 0
showCheck = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('jobonline:set')
AddEventHandler('jobonline:set', function(jobs_online)

	jobs = jobs_online
	mechanicjob = Config.MechanicNameJob

	if jobs_online[mechanicjob] > 0 and Config.IfMecaIsOnline then
		IsMecanoOnline = true
	else 
		IsMecanoOnline = false
	end
end)


Citizen.CreateThread(function()
	while true do
		TriggerServerEvent('jobonline:get')

		Wait(10000)
	end
end)

-- RegisterCommand("repair", function(source, args, raw)
-- 	TriggerEvent('esx_repairkit:onUse')
-- end,false)

RegisterNetEvent('esx_repairkit:onUse')
AddEventHandler('esx_repairkit:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	local coordsE = GetWorldPositionOfEntityBone(vehicle, engine)
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	end

	if DoesEntityExist(vehicle) and not IsMecanoOnline then
		exports['progressBars']:startUI(10*1000, "Reifen reparieren")
			TaskStartScenarioInPlace(plyPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
			Citizen.Wait(10000)
			TriggerEvent('kq_wheeldamage:fixWheel', vehicle, 0)
			TriggerEvent('kq_wheeldamage:fixWheel', vehicle, 1)
			TriggerEvent('kq_wheeldamage:fixWheel', vehicle, 2)
			TriggerEvent('kq_wheeldamage:fixWheel', vehicle, 3)
			ClearPedTasksImmediately(plyPed)
	end

	ESX.ShowNotification(_U('finished_repair'))
end)


RegisterNetEvent('esx_intervallcheck:onUse')
AddEventHandler('esx_intervallcheck:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	local coordsE = GetWorldPositionOfEntityBone(vehicle, engine)
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)

		local veh =  GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			inVeh = true
			Citizen.Wait(50)
			vehPlate = GetVehicleNumberPlateText(veh)
			Citizen.Wait(1)
			ESX.TriggerServerCallback('esx_carmileage:getIntervall', function(hasIntervall)
				Citizen.Wait(1000)
				hasIntervall = hasIntervall - hasIntervall
				if hasIntervall <= 0 then
					ESX.ShowNotification("Besser gehts nicht")
				else
					TriggerServerEvent('esx_carmileage:addIntervall', vehPlate, hasIntervall)
					inVeh = false
				end
			end, GetVehicleNumberPlateText(veh))

	exports['progressBars']:startUI(5000, "Hauptuntersuchung")
	TaskStartScenarioInPlace(plyPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
	Citizen.Wait(5000)
	print(hasIntervall)
	ClearPedTasksImmediately(plyPed)
	ESX.ShowNotification("Hauptuntersuchung beendet")
end)





