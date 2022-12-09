ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local t = os.date("*t", os.time()) 
        if t.hour == Config.Reset.hour and t.min == Config.Reset.min then
            MySQL.Sync.execute("UPDATE users SET dailyreward = 1")
            Wait(60 * 10 * 10)
        end
    end
end)

ESX.RegisterServerCallback("hope_advent:reward", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchScalar("SELECT dailyreward FROM users WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
        if result == 1 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('hope_advent:claim')
AddEventHandler('hope_advent:claim', function(data, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchScalar("SELECT dailyreward FROM users WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
        if result == 1 then
            local rR = Config.DailyRewards[math.random(1, #Config.DailyRewards)]
			if rR.type == "account" then
				xPlayer.addAccountMoney(rR.account, rR.amount)
				TriggerClientEvent("hope_advent:notify", xPlayer.source, Config.Locales["gotMoney"]:format(rR.amount, xPlayer.getAccount(rR.account).label))
			elseif rR.type == "item" then
				xPlayer.addInventoryItem(rR.item, rR.amount)
				TriggerClientEvent("hope_advent:notify", xPlayer.source, Config.Locales["gotItem"]:format(rR.amount, xPlayer.getInventoryItem(rR.item).label))
			elseif rR.type == "weapon" then
				xPlayer.addWeapon(rR.weapon, rR.ammo)
				TriggerClientEvent("hope_advent:notify", xPlayer.source, Config.Locales["gotWeapon"]:format(ESX.GetWeaponLabel(rR.weapon), rR.ammo))
			end
            MySQL.Async.execute("UPDATE users SET dailyreward = 0 WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier})
        else
            TriggerClientEvent("hope_advent:notify", Config.Locales["notReady"])
        end
    end)
end) 