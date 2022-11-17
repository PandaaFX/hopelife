ESX = nil

local Webhook = 'https://discord.com/api/webhooks/1008471804219768832/3qkM-YrvKR7dyPTCnRkqVHTA_tJl1h1dBLHaWy2ChbbRemvErLInB8K7766oDt0ZOLr7'
local sessions = {}
local levels = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  if levels[1] == nil then
  	local xp = Config.StartEXP
  	local nextLevel = xp
  	for i=1, Config.MaxLevel, 1 do
		table.insert(levels, math.floor(nextLevel+0.5))
		xp = xp*Config.LevelMultiplier
		nextLevel = nextLevel+xp
	end
  end
end)

ESX.RegisterServerCallback("okokCrafting:getLevel", function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(users) 
		local xp = tonumber(users[1].xp)
		local maxLevel = Config.MaxLevel
		for k,v in ipairs(levels) do
			if v > xp then
				local percentage = 0
				if levels[k-1] ~= nil then
					percentage = ((xp - levels[k-1]) * 100) / (levels[k] - levels[k-1])
				else
					percentage = ((xp - 0) * 100) / (levels[k] - 0)
				end
				cb(k-1, math.floor(percentage+0.5))
				break
			elseif k == maxLevel then
				cb(k, 100)
			end
		end
	end)
end)

RegisterServerEvent('okokCrafting:craftStartItem')
AddEventHandler('okokCrafting:craftStartItem',function()
	sessions[source] = {
		stoppedCraft = false,
		isCrafting = true,
		last = GetGameTimer(),
	}
end)

RegisterServerEvent('okokCrafting:craftStopItem')
AddEventHandler('okokCrafting:craftStopItem',function()
	sessions[source] = {
		stoppedCraft = true,
		isCrafting = false,
	}
end)

RegisterServerEvent('okokCrafting:failedCraft')
AddEventHandler('okokCrafting:failedCraft',function(item, xp)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.GiveXPOnCraftFailed and Config.UseXP then
		MySQL.Async.execute('UPDATE users SET xp = xp+@xp WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@xp'] = xp,
		}, function (result)
		end)
		TriggerClientEvent('okokCrafting:updateXP', xPlayer.source)
	end

	if Webhook ~= '' then
		local identifierlist = ExtractIdentifiers(xPlayer.source)
		local data = {
			playerid = xPlayer.source,
			identifier = identifierlist.license:gsub("license2:", ""),
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
			type = "failed",
			item = item,
		}
		noSession(data)
	end
end)

RegisterServerEvent('okokCrafting:craftItemDeath')
AddEventHandler('okokCrafting:craftItemDeath',function(queueClient)
	local xPlayer = ESX.GetPlayerFromId(source)
	local queue = queueClient

	if sessions[source] then
		if sessions[source].stoppedCraft then
			for k,v in ipairs(queue) do
				for k2,v2 in ipairs(v.recipe) do
					if v2[3] then
						xPlayer.addInventoryItem(v2[1], v2[2])
					end
				end
			end
			TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", "Du bist gestorben, alle Gegenstände wurden zurückgegeben", 5000, 'info')
			sessions[xPlayer.source] = nil
		end
	else
		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(xPlayer.source)
			local data = {
				playerid = xPlayer.source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = "Death",
			}
			noSession(data)
		end
		TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", "Keine Session!", 5000, 'error')
	end
			
end)

RegisterServerEvent('okokCrafting:craftItemFinished')
AddEventHandler('okokCrafting:craftItemFinished', function(item, crafts, itemName, isItem, xp)
	local xPlayer = ESX.GetPlayerFromId(source)
	local timeToCraft = 600000
	local amount = 0

	if sessions[source] then
		for k,v in ipairs(crafts) do
			if v.item == item then
				amount = v.amount
				timeToCraft = v.time * 1000
			end
		end
		sessions[source].last = GetGameTimer() - sessions[source].last

		if sessions[source].last+500 >= timeToCraft then
			if isItem then
				xPlayer.addInventoryItem(item, amount)
			else
				xPlayer.addWeapon(item, 1)
			end

			if Config.UseXP then
				MySQL.Async.execute('UPDATE users SET xp = xp+@xp WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@xp'] = xp,
				}, function (result)
				end)
				TriggerClientEvent('okokCrafting:updateXP', xPlayer.source)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.source)
				local data = {
					playerid = xPlayer.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "conclude-crafting",
					itemName = itemName,
					time = sessions[xPlayer.source].last,
				}
				noSession(data)
			end
			sessions[xPlayer.source] = nil
		else
			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.source)
				local data = {
					playerid = xPlayer.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "crafted-soon",
					time_taken = sessions[source].last,
					time_needed = timeToCraft,
					itemName = itemName,
				}
				noSession(data)
			end
			TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", "Anti-cheat protection!", 5000, 'error')
		end
	else
		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(xPlayer.source)
			local data = {
				playerid = xPlayer.source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = "conclude",
			}
			noSession(data)
		end
		TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", "Keine Session!", 5000, 'error')
	end
			
end)

ESX.RegisterServerCallback("okokCrafting:inv2", function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(item)

	cb(item)
end)

ESX.RegisterServerCallback("okokCrafting:itemNames", function(source, cb)
	cb(Config.itemNames)
end)

ESX.RegisterServerCallback("okokCrafting:CanCraftItem", function(source, cb, itemID, recipe, itemName, amount, isItem)
	local xPlayer = ESX.GetPlayerFromId(source)
	local canCraft = true

	for k,v in pairs(recipe) do
		local item = xPlayer.getInventoryItem(v[1])

		if item.count < v[2] then
			canCraft = false
		end
	end
	if canCraft then
		if isItem then
			if xPlayer.canCarryItem(itemID, amount) then
				for k,v in pairs(recipe) do
					if v[3] == "true" then
						xPlayer.removeInventoryItem(v[1], v[2])
					end
				end
				cb(true)
				TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", itemName[itemID].." wurde zur Warteschlange hinzugefügt", 5000, 'success')
				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.source)
					local data = {
						playerid = xPlayer.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = "crafting",
						itemName = itemName[itemID],
					}
					noSession(data)
				end
			else
				cb(false)
				TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", "Du kannst nicht "..itemName[itemID].. " tragen", 5000, 'error')
			end
		else
			for k,v in pairs(recipe) do
				if v[3] == "true" then
					xPlayer.removeInventoryItem(v[1], v[2])
				end
			end
			cb(true)
			TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", itemName[itemID].." wurde zur Warteschlange hinzugefügt", 5000, 'success')
			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.source)
				local data = {
					playerid = xPlayer.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "crafting",
					itemName = itemName[itemID],
				}
				noSession(data)
			end
		end
	else
		cb(false)
		TriggerClientEvent('okokNotify:Alert', source, "HERSTELLUNG", "Du kannst nicht "..itemName[itemID].. " herstellen", 5000, 'error')
	end
end)

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end

-------------------------- NO SESSION WEBHOOK

function noSession(data)
	local color = '65352'
	local category = 'test'

	if data.type == 'Death' then
		color = Config.AnticheatProtectionWebhookColor
		category = 'Tried to receive the crafting items without starting a crafting, he might be cheating'
	elseif data.type == 'conclude' then
		color = Config.AnticheatProtectionWebhookColor
		category = 'Tried to conclude a crafting without starting it first, he might be cheating'
	elseif data.type == 'crafted-soon' then
		color = Config.AnticheatProtectionWebhookColor
		category = 'Concluded the crafting of '..data.itemName..' after '..data.time_taken..'ms while it takes '..data.time_needed..'ms to craft, he might be cheating'
	elseif data.type == 'crafting' then
		color = Config.StartCraftWebhookColor
		category = 'Added '..data.itemName..' to queue'
	elseif data.type == 'conclude-crafting' then
		color = Config.ConcludeCraftWebhookColor
		category = 'Crafted a '..data.itemName..' after '..data.time..'ms'
	elseif data.type == 'failed' then
		color = Config.FailWebhookColor
		category = 'Failed to craft a '..data.item
	end
	
	local information = {
		{
			["color"] = color,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'CRAFTING',
			["description"] = '**Action:** '..category..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..data.identifier..'\n**Discord:** '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}

	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end