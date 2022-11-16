ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('myShops:buyItem')
AddEventHandler('myShops:buyItem', function(index, amount, list)

    local xPlayer = ESX.GetPlayerFromId(source)
    local finalPrice = amount * list[index].price
    local label = list[index].label 


    if xPlayer.getMoney() >= finalPrice then
	--if xPlayer.getAccountMoney('bank') >= finalPrice then
        if Config.useWeightSystem then
            if xPlayer.canCarryItem(list[index].name, amount) then
                xPlayer.removeMoney(finalPrice)
				--xPlayer.removeAccountMoney('bank', finalPrice)
                xPlayer.addInventoryItem(list[index].name, amount)
                TriggerClientEvent('myShops:picturemsg', source, Config.NotificationPicture, Translation[Config.Locale]['purchased'] .. amount .. Translation[Config.Locale]['purchased2'] .. label .. Translation[Config.Locale]['purchased3'] .. finalPrice .. Translation[Config.Locale]['purchased4'], Translation[Config.Locale]['shop'], Translation[Config.Locale]['purchased_title'])
            else
                TriggerClientEvent('myShops:receiveNotification', source, Translation[Config.Locale]['can_not_carry'])
            end
        else
            local sourceItem = xPlayer.getInventoryItem(list[index].name)
            local count = sourceItem.count
            
            if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
                TriggerClientEvent('myShops:receiveNotification', source, Translation[Config.Locale]['can_not_carry'])
            else
                xPlayer.removeMoney(finalPrice)
				--xPlayer.removeAccountMoney('bank', finalPrice)
                xPlayer.addInventoryItem(list[index].name, amount)
                TriggerClientEvent('myShops:picturemsg', source, Config.NotificationPicture, Translation[Config.Locale]['purchased'] .. amount .. Translation[Config.Locale]['purchased2'] .. label .. Translation[Config.Locale]['purchased3'] .. finalPrice .. Translation[Config.Locale]['purchased4'], Translation[Config.Locale]['shop'], Translation[Config.Locale]['purchased_title'])
            
            end
        end
        


    else

        TriggerClientEvent('myShops:receiveNotification', source, Translation[Config.Locale]['not_enough_money'])

    end


end)

RegisterServerEvent('myShops:buyWeapon')
AddEventHandler('myShops:buyWeapon', function(name, price, label)

	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.hasWeapon(name) then
        TriggerClientEvent('myShops:picturemsg', source, Config.NotificationPicture, "Du hast diese Waffe bereits!")
	else   
        if xPlayer.getMoney() >= price then
		    xPlayer.removeMoney(price)
            xPlayer.addWeapon(name, 255)
		    TriggerClientEvent('myShops:picturemsg', source, Config.NotificationPicture, Translation[Config.Locale]['purchased'] .. 1 .. Translation[Config.Locale]['purchased2'] .. label .. Translation[Config.Locale]['purchased3'] .. price .. Translation[Config.Locale]['purchased4'], Translation[Config.Locale]['shop'], Translation[Config.Locale]['purchased_title'])
	    end
    end

end)

RegisterServerEvent('myShops:sellItem')
AddEventHandler('myShops:sellItem', function(index, amount, list)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem(list[index].name).count >= amount and amount > 0 then
        xPlayer.removeInventoryItem(list[index].name, amount)
        xPlayer.addMoney(math.floor((list[index].price / Config.PriceBuyDivide) * amount))
        TriggerClientEvent('myShops:picturemsg', source, Config.NotificationPicture, Translation[Config.Locale]['sold'] .. amount .. Translation[Config.Locale]['sold2'] .. list[index].label .. Translation[Config.Locale]['sold3'] .. math.floor((list[index].price / Config.PriceBuyDivide) * amount) .. Translation[Config.Locale]['sold4'], Translation[Config.Locale]['shop'], Translation[Config.Locale]['sold_title'])
            
    else
        TriggerClientEvent('myShops:receiveNotification', source, Translation[Config.Locale]['not_enough_items'])
    end

end)

RegisterServerEvent('myShops:sellWeapon')
AddEventHandler('myShops:sellWeapon', function(name, price, label)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.hasWeapon(name) then
        xPlayer.removeWeapon(name)
        xPlayer.addMoney(price / Config.PriceBuyDivide)
        TriggerClientEvent('myShops:picturemsg', source, Config.NotificationPicture, Translation[Config.Locale]['sold'] .. 1 .. Translation[Config.Locale]['sold2'] .. label .. Translation[Config.Locale]['sold3'] .. price .. Translation[Config.Locale]['sold4'], Translation[Config.Locale]['shop'], Translation[Config.Locale]['sold_title'])
            
    else
        TriggerClientEvent('myShops:receiveNotification', source, Translation[Config.Locale]['not_enough_items'])
    end

end)