ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(1)
		if IsControlJustReleased(1, Config.OpenMenuKey) then
			TriggerEvent(Config.EventPrefix..":OpenSelectionMenu")
		end
	end
end)

RegisterCommand(Config.OpenMenuCommand, function(source, args, rawCommand)
	TriggerEvent(Config.EventPrefix..":OpenSelectionMenu")
end)

RegisterNetEvent(Config.EventPrefix..":notification")
AddEventHandler(Config.EventPrefix..":notification", function(title, text, time, type)
	exports['okokNotify']:Alert(title, text, time, type)
end)

function onMenuClose()
	-- Code to execute when the menu is closed
end

function playerjob()
	return ESX.GetPlayerData().job
end

function playerjoblabel()
	return ESX.GetPlayerData().job.label
end

function playerIdentifier()
	return ESX.GetPlayerData().identifier
end