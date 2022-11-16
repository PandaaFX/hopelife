ESX = nil

TriggerEvent(Config.ESXPrefix..':'..Config.getSharedObject, function(obj) ESX = obj end)

local WebhookLink = 'https://discord.com/api/webhooks/985923937944870912/G6kCmrDqvV_pPvr8fjh4qjKJ7tIkyM0SK3wMu5FfNQFTLyPqtCj2hnMPoFvy9bqsMVZZ' -- PUT YOUR WEBHOOK LINK HERE

function Webhook()
	return WebhookLink
end

function ESXf()
	local ESXf = nil
	TriggerEvent(Config.ESXPrefix..':'..Config.getSharedObject, function(obj) ESXf = obj end)
	return ESXf
end

function MySQLexecute(query, values, func)
	return MySQL.Async.execute(query, values, func)
end

function MySQLfetchAll(query, values, func)
	return MySQL.Async.fetchAll(query, values, func)
end

function MySQLinsert(query, values, func)
	return MySQL.Async.insert(query, values, func)
end

ESX.RegisterServerCallback(Config.EventPrefix..":isAdmin", function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerGroup = xPlayer.getGroup()
	local isAdmin = false

	for k,v in ipairs(Config.AdminGroups) do
		if playerGroup == v then
			isAdmin = true
			break
		end
	end

	cb(isAdmin)
end)

RegisterServerEvent(Config.EventPrefix..':setVehicleOwned')
AddEventHandler(Config.EventPrefix..':setVehicleOwned', function (vehicleProps, model, id, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQLexecute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)',
	{
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@type'] = id
	}, function (rowsChanged)
	end)
end)


ESX.RegisterServerCallback(Config.EventPrefix..":HasLicense", function(source, cb, license)
	local hasLicense = false

	if license == "" then
		hasLicense = true
	elseif license == "boat" then
		-- Add the checks to see if the player has the license
		hasLicense = true
	end

	cb(hasLicense)
end)

ESX.RegisterServerCallback(Config.EventPrefix..":canOpenMenu", function(source, cb, shop_id)
	local canOpenShop = true
	
	-- Here you can make the verifications you want,
	-- For example check if a no VIP person is trying to open a VIP shop, if so change canOpenShop to false

	cb(canOpenShop)
end)