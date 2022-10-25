ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('murtaza:clean')
AddEventHandler('murtaza:clean', function()
	local playerPed = GetPlayerPed(-1)
	local vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 10.0, 0, 71)
	ESX.Progressbar("Fahrzeug sauber machen", 10000,{
        FreezePlayer = false,
		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true),
		Wait(1100) ,
    	onFinish = function()
		ClearPedTasksImmediately(playerPed)
        WashDecalsFromVehicle((vehicle), 1.0)
		SetVehicleDirtLevel(vehicle, 0.0)
		notification("Fahrzeug wieder sauber")
    end})	
end)


function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end