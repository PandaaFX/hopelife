ESX 					= nil
TriggerEvent(Config.ESX.ESXSHAREDOBJECT, function(obj) ESX = obj end)

function stores_addInventoryItem(source,item,amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local arr_item = stringsplit(item, "_")
    if arr_item[1] and (arr_item[1] == "WEAPON" or arr_item[1] == "GADGET") then
        local ammo = 0
        xPlayer.addWeapon(item, ammo)
    else
        xPlayer.addInventoryItem(item, amount)
    end
end

function stores_customCheckWeight(source,item,amount)
    -- Here you can check if player has enought space in inventory if you are using a custom inventory (set the esx version on config to custom). return true or false
    return true
end

function beforeBuyItem(source,market_id,xPlayer,item_id,amount,total_price)
    -- Here you can do any verification when a player is buying an item in a market, like if player has gun license or anything else you want to check before buy the item. return true or false
    return true
end

function afterBuyItem(source,market_id,xPlayer,item_id,amount,total_price,account)
    -- Here you can run any code just after the player purchased any item, like government taxes or anything else
end

function beforeBuyMarket(source,key,xPlayer)
    -- Here you can do any verification when a player is buying a market, like if player has the permission to that or anything else you want to check before buy the market. return true or false
    return true
end

function MySQL_Sync_execute(sql,params)
    MySQL.Sync.execute(sql, params)
end

function MySQL_Sync_fetchAll(sql,params)
    return MySQL.Sync.fetchAll(sql, params)
end

function getOnlinePlayers()
    local online_players = {}
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        table.insert(online_players, {
            source     = xPlayer.source,
            identifier = xPlayer.identifier,
            name       = xPlayer.name
        })
    end
    return online_players
end

function getPlayerName(user_id)
	local xPlayer = ESX.GetPlayerFromIdentifier(user_id)
	if xPlayer then
		return xPlayer.name
	end
	return false
end

-- Player ID that will appear on the logs
function GetPlayerIdLog(source)
	local user_id = ESX.GetPlayerFromId(source).identifier
	return user_id
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end