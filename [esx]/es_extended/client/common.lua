AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

exports('getSharedObject', function()
	return ESX
end)

--exports('getCoreObject', function() return Core end)

if GetResourceState('ox_inventory') ~= 'missing' then
	Config.OxInventory = true
end
