ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.set('caution', 0)
end)

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local caution = xPlayer.get('caution')
	TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
		account.addMoney(caution)
	end)
end)

RegisterServerEvent('ft_bus:setCautionInCaseOfDrop')
AddEventHandler('ft_bus:setCautionInCaseOfDrop', function(caution)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.set('caution', caution)
end)

RegisterServerEvent('ft_bus:giveBackCautionInCaseOfDrop')
AddEventHandler('ft_bus:giveBackCautionInCaseOfDrop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
		local caution = account.money
		account.removeMoney(caution)
		if caution > 0 then
			xPlayer.addAccountMoney('bank', caution)
			TriggerClientEvent('esx:showNotification', _source, _U('bank_deposit_returned', caution))
		end
	end)
end)


RegisterServerEvent('ft_bus:caution')
AddEventHandler('ft_bus:caution', function(cautionType, cautionAmount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cautionType == "take" then
		xPlayer.removeAccountMoney('bank', cautionAmount)
		xPlayer.set('caution', cautionAmount)
		TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_taken', cautionAmount))

	elseif cautionType == "give_back" then
		xPlayer.addAccountMoney('bank', cautionAmount)
		xPlayer.set('caution', 0)
		TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', cautionAmount))
	end
end)


RegisterServerEvent('ft_bus:giveMoney')
AddEventHandler('ft_bus:giveMoney', function(money)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addAccountMoney('bank', money)
end)