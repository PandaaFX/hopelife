ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hopelife:notify')
AddEventHandler('hopelife:notify', function(type, color, title, message, time)
    SendNUIMessage({
        type = type,
        color = color,
		title = title,
        message = message,
        time = time,
    })
    
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)


RegisterCommand('ids', function(source, args)
	local player = GetPlayerPed(-1)
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestPlayerDistance <= 3.0 then
		ESX.ShowNotification("ID: " ..GetPlayerServerId(closestPlayer))
	end
end)