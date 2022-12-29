ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = 'https://discord.com/api/webhooks/1054427406561194124/UBxfzH98R1EQVNP21egfImFXuvDOLGgg_ov1jkzHUqz3vmlV0a-qPBu4mAClOBEIDOGc'
local sellingVehicles = {}
RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	if sellingVehicles["veh_".._source] == nil then return end

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result[1] ~= nil  then
			if bankMoney >= vehicle_price then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then	
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price)
						sellingVehicles["veh_".._source] = nil

						if Config.UseOkokBankingTransactions then
							TriggerEvent('okokBanking:AddNewTransaction', source_name, xPlayer.identifier, target_name, tPlayer.identifier, vehicle_price, 'Vehicle Sale')
						end

						TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Du hast das Fahrzeug erfolgreich verkauft <b>"..model.."</b> mit der Nummerntafel <b>"..plate.."</b>", 10000, 'success')
						TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "Du hast das Fahrzeug erfolgreich gekauft <b>"..model.."</b> mit der Nummerntafel <b>"..plate.."</b>", 10000, 'success')

						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", target_name.."nicht genug Geld hat, um Ihr Fahrzeug zu kaufen ", 10000, 'error')
				TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "Du hast nicht genug Geld zum Kaufen "..source_name.."'s vehicle", 10000, 'error')
			end
		else
			TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Das Fahrzeug mit dem Kennzeichen<b>"..plate.."</b> ist nicht deins", 10000, 'error')
			TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", source_name.." versucht, Ihnen ein Fahrzeug zu verkaufen, das ihm nicht gehört", 10000, 'error')
		end
	else
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
				['@owner'] = xPlayer.identifier,
				['@target'] = tPlayer.identifier,
				['@plate'] = plate
			}, function (result2)
				if result2 ~= 0 then
					sellingVehicles["veh_".._source] = nil
					TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Du hast das Fahrzeug erfolgreich verkauft <b>"..model.."</b> mit der Nummerntafel <b>"..plate.."</b>", 10000, 'success')
					TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", " Du hast das Fahrzeug erfolgreich gekauft <b>"..model.."</b> mit der Nummerntafel <b>"..plate.."</b>", 10000, 'success')

					if Webhook ~= '' then
						sellVehicleWebhook(webhookData)
					end
				end
			end)
		else
			TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Das Fahrzeug mit dem Kennzeichen<b>"..plate.."</b> ist nicht deins", 10000, 'error')
			TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", source_name.." versucht, Ihnen ein Fahrzeug zu verkaufen, das ihm nicht gehört", 10000, 'error')
		end
	end
end)

ESX.RegisterServerCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = getName(target.identifier)

	cb(targetname)
end)

ESX.RegisterServerCallback('okokContract:checkIfOwnsVehicle', function(source, cb, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('okokContract:Checker')
AddEventHandler('okokContract:Checker', function(plate)
	local _source = source

	sellingVehicles["veh_".._source] = {
		plate = plate
	}
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, getName(xPlayer.identifier), os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if sellingVehicles["veh_".._source] ~= nil then
		TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
		TriggerClientEvent('okokContract:startContractAnimation', data.targetID)
	end

	if Config.RemoveContractAfterUse then
		xPlayer.removeInventoryItem('contract', 1)
	end
end)

ESX.RegisterUsableItem('contract', function(source)
	local _source = source

	if Config.UseOkokRequests then
		TriggerClientEvent('okokContract:doRequest', _source)
	else
		TriggerClientEvent("okokContract:OpenContractInfo", _source)
	end

	TriggerClientEvent('okokContract:startContractAnimation', _source)
end)

function getName(identifier)
	local name = nil
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(db_name)
		if db_name[1] ~= nil then
			name = db_name[1].firstname.." "..db_name[1].lastname
		else
			name = ""
		end
	end)
	while name == nil do
		Citizen.Wait(2)
	end
	return name
end

-------------------------- SELL VEHICLE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'Fahrzeug Vertrag',
			["description"] = '**Fahrzeug: **'..data.model..'**\nNummerntafel: **'..data.plate..'**\nKäufer Name: **'..data.target_name..'**\nVerkäufer Name: **'..data.source_name..'**\nPreis: **'..data.vehicle_price..'$',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end







RegisterServerEvent('okokContract:deleteProp', function(netId)
    TriggerClientEvent("okokContract:deleteProp", -1, netId)
end)