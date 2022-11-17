ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('promeniga1')
AddEventHandler('promeniga1', function(igrac, firstname)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getAccount('bank').money >= 200000) then
		xPlayer.removeAccountMoney('bank', 200000)
		
        MySQL.Async.execute('UPDATE users SET firstname = @firstname WHERE identifier = @identifier', {
            ['@firstname'] = firstname,
            ['@identifier'] = xPlayer.identifier
        })
        notification("~y~Geändert zu: ".. firstname)
	else
		notification("Nicht genug Geld ~r~money")
end
end)

RegisterServerEvent('promeniga2')
AddEventHandler('promeniga2', function(igrac, lastname)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if(xPlayer.getAccount('bank').money >= 200000) then
		xPlayer.removeAccountMoney('bank',200000)
	    MySQL.Async.execute('UPDATE users SET lastname = @lastname WHERE identifier = @identifier', {
		    ['@lastname'] = lastname,
		    ['@identifier'] = xPlayer.identifier
        })
        notification("~y~Geändert zu: ".. lastname)
	else
		notification("Nicht genug Geld ~r~money")
    end
end)

function notification(text)
    TriggerClientEvent('esx:showNotification', source, text)
end
