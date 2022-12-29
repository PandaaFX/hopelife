local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

RegisterNetEvent('StummCmd', function()
	local player, distance = ESX.Game.GetClosestPlayer()
	if distance ~= -1 and distance <= 3 then
		TriggerServerEvent('StummCMDServer', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'stumm')
	else
		ESX.ShowNotification('No players nearby')
	end
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)
