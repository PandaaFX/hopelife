ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



local mechanicjob = Config.MechanicNameJob


-- Make the kit usable!
ESX.RegisterUsableItem('repairkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_repairkit:onUse', _source)
		xPlayer.removeInventoryItem('repairkit', 1)
	else
		if xPlayer.job.name ~= mechanicjob then
			TriggerClientEvent('esx_repairkit:onUse', _source)
			xPlayer.removeInventoryItem('repairkit', 1)
		end
	end
end)

ESX.RegisterUsableItem('untersuchungskit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_intervallcheck:onUse', _source)
end)





