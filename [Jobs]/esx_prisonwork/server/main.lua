ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('shavejailtime', function(source, cb, jail_time_shave)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
		-- EXECUTE SQL STATEM SELECT FROM 'jail'
	MySQL.Async.fetchScalar('SELECT jail_time FROM users WHERE identifier = @identifier', 
		{
			['@identifier'] = xPlayer.identifier,
		}, function(jail_time_remain)
			local new_jail_time = jail_time_remain - jail_time_shave
		
				-- EXECUTE SQL STATEMENT INTO 'jail'
			MySQL.Async.execute('UPDATE users SET jail_time = @new_time WHERE identifier = @identifier',
				{
					['@new_time'] = new_jail_time,
					['@identifier'] = xPlayer.identifier,
				})
				cb(true)
			end)
end)



--notification
function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "lmao",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end