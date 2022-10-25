ESX 					= nil
TriggerEvent(Config.ESX.ESXSHAREDOBJECT, function(obj) ESX = obj end)

function beforeBuyMarket(source,key,xPlayer)
    -- Here you can do any verification when a player is buying a gas station, like if player has the permission to that or anything else you want to check before buy the gas station. return true or false
    return true
end

function MySQL_Sync_execute(sql,params)
    MySQL.Sync.execute(sql, params)
end

function MySQL_Sync_fetchAll(sql,params)
    return MySQL.Sync.fetchAll(sql, params)
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