

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
	for k, v in pairs(Config["5mscriptscom"]) do
		ESX.RegisterUsableItem(k, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(k, 1)
			TriggerClientEvent('mkbuss:open5mscriptscom', source,k)
		end)
	end
end)


RegisterServerEvent('mkbuss:giveReward')
AddEventHandler('mkbuss:giveReward', function (t, data, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if t == "item" then
		xPlayer.addInventoryItem(data, amount)
	elseif t == "weapon" then
		xPlayer.addWeapon(data, 1)
	elseif t == "money" then
		xPlayer.addMoney(data)
	elseif t == "black_money" then
		xPlayer.addAccountMoney('black_money', data)
	end
	
end)


RegisterServerEvent("mkbuss:boradcast")
AddEventHandler("mkbuss:boradcast", function(tier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if Config["broadcast"] then
        tier = tonumber(tier)
        if Config["broadcast_tier"][tier] == true then
            TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2Gachapon: ' .. GetPlayerName(source) .. ' Got '..Config["chance"][tier].name) 
        end
    end
end)

ESX.RegisterServerCallback('esx_vehicleshop:buyVehicle2', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {xPlayer.identifier, plate, json.encode({model = joaat(model), plate = plate})
	}, function(rowsChanged)
		xPlayer.showNotification(_U('vehicle_belongs', plate))
		cb(true)
	end)
end)

