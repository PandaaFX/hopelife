ESX = nil

local helper = false
local timerLocator = false
local time = 0
local helperWaitTime = false
local vehicles = {
	"banshee",
	"retinue",
	"issi7",
	"ninef",
	"ninef2",
	"comet3",
	"feltzer2",
	"jester",
	"jester3",
	"surano",
	"adder",
	"nero2",
	"osiris",
	"voltic",
	"cheetah",
	"zentorno",
	"vacca",
	"mesar",
	"brawler",
	"bullet",
	"infernus",
	"neo"
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('mas_carthief:Helper')
AddEventHandler('mas_carthief:Helper', function ()
	if not helperWaitTime then
		helper = true
		Notification(1, Lang['helper_drive'])
	else
		Notification(2, Lang['helper_timer'])
	end
end)

------------Helper---------
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1)

		if helper then
			local curVeh = GetVehiclePedIsIn(PlayerPedId())
			if curVeh ~= 0 and isRightVehicle(curVeh) then
				DrawScreenText(Lang['destroy_locator'], 0.4, 0.43)
				if IsControlJustPressed(0, 38) then
					Timer()
				end
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

isRightVehicle = function (vehicle)
	for _, veh in pairs(vehicles) do
		if GetEntityModel(vehicle) == GetHashKey(veh) then
			return true
		end
	end
	return false
end


Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1)

		if timerLocator then
			DrawScreenText(Lang['remaining_time'] ..time.. Lang['%'], 0.4, 0.43)
		else
			Citizen.Wait(500)
		end
	end
end)

Timer = function ()
    timerLocator = true
	for i = 1, 100 do
		time = i
		Citizen.Wait(config.TimerSec * 1000)
	end
	time = 0
    timerLocator = false
    helper = false
	TriggerServerEvent('mas_carthief:respondDriver')
	helperWaitTime = true
	if helperWaitTime then
		Citizen.Wait(config.HelperSecBetweenNextDrive * 1000)
		helperWaitTime = false
	end
end