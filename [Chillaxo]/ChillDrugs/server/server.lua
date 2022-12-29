ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj
end)

ESX.RegisterUsableItem('weedjoint', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('weedjoint', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'weed')
	xPlayer.showNotification('Du rauchst ein Joint')
end)

ESX.RegisterUsableItem('drug_lsd', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drug_lsd', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'lsd')
	xPlayer.showNotification('Du nimmst LSD')
end)

ESX.RegisterUsableItem('drug_meth', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drug_meth', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'meth')
	xPlayer.showNotification('Du nimmst Meth')
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke_pooch', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'koks')
	xPlayer.showNotification('Du nimmst Koks')
end)

ESX.RegisterUsableItem('heroin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('heroin', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'hero')
	xPlayer.showNotification('Du nimmst Heroin')
end)

ESX.RegisterUsableItem('drug_lean', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drug_lean', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'lean')
	xPlayer.showNotification('Du nimmst Lean')
end)

ESX.RegisterUsableItem('psilocybin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('psilocybin', 1)

	TriggerClientEvent('ChillDrugs:UseDrug', source, 'psilocybin')
	xPlayer.showNotification('Du nimmst Psilocybin')
end)