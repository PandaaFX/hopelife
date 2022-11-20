local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Events

RegisterServerEvent("decrypto:server:removeitem")
AddEventHandler("decrypto:server:removeitem", function(data)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local item = data
	xPlayer.removeInventoryItem(item, 1)
	--xPlayer.triggerEvent('esx_status:add','stress',( Config.AddStress * 1000))
	--xPlayer.showNotification("You are feeling more stressed!")
end)

RegisterNetEvent('decrypto:server:givecash')
AddEventHandler('decrypto:server:givecash', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local randomMoney = math.random(Config.MinWithdrawl ,Config.MaxWithdrawal)
	xPlayer.showNotification("ATM cash received: $" .. randomMoney)
	xPlayer.addAccountMoney(Config.Account, randomMoney)
end)

ESX.RegisterServerCallback('decrypto:server:hasitem', function(source, cb, item1, item2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasItems = false
    local hasItem1 = false
    local hasItem2 = false
    if xPlayer.getInventoryItem(item1).count > 0 then
        hasItem1 = true
    end
    if hasItem1 and hasItem2 then
        hasItems = true
    end
    cb(hasItems)
end)


RegisterNetEvent('robatm:giveItem')
AddEventHandler('robatm:giveItem', function()

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= 20000 then
        xPlayer.removeMoney(20000)
        xPlayer.addInventoryItem('hackcard', 1)
        xPlayer.addInventoryItem('decryptor', 1)
        TriggerClientEvent('robatm:showNotify', xPlayer.source, '~g~You succesfully bought a key!') -- Notification als Event von der Client senden
    else
        print('Player cant afford')
        TriggerClientEvent('robatm:showNotify', xPlayer.source, '~r~You can\'t afford that!')  -- Notification als Event von der Client senden

    end
end)

RegisterServerEvent('robatm:notifyPolice')
AddEventHandler('robatm:notifyPolice', function(coords)

	local xPlayers = ESX.GetPlayers()
	

	for i=1, #xPlayers, 1 do
		
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		--print(xPlayer.name)
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fib' or xPlayer.job.name == 'lssd' then
			TriggerClientEvent('robatm:callPolice', xPlayer.source, coords)
	   end
   end
	
end)


RegisterServerEvent('robatm:notifyRobAbort')
AddEventHandler('robatm:notifyRobAbort', function(coords)
	
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fib' or  xPlayer.job.name == 'lssd'  then
			TriggerClientEvent('robatm:notifyPoliceAbort', xPlayer.source, coords)
	   end
   end

end)
