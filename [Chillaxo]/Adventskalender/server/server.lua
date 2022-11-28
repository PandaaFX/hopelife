ESX = nil
CreateThread(function()
    while true do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)


local function CheckReward(identifier, day)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT * FROM ChillAdvent WHERE identifier = @identifier AND day = @day', {
        ['@identifier'] = identifier,
        ['@day'] = day
    }, function(result)
        if #result >= 1 then
            if Config.debug == true then
                print('CheckReward: true')
            end
            xPlayer.showNotification("Du hast heute schon dein Geschenk abgeholt!")
            --return "true"
        else
            if Config.debug == true then
                print('CheckReward: false')
            end
            TriggerClientEvent('ChillKalender:PlayAnimation', src, day)
            --return "false"
        end
    end)
end

local function addDay(identifier, day)
    MySQL.Async.execute('INSERT INTO ChillAdvent (identifier, day) VALUES (@identifier, @day)',
	{
        ['@identifier']   = identifier,
		['@day']   = day,
    }, function ()
        if Config.debug == true then
            print(identifier.. ' hat geschenkt abgeholt und wurde eingetragen')
        end
	end)
end

RegisterNetEvent('ChillKalender:Check', function(day)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.getIdentifier()
    CheckReward(identifier, tonumber(day))
    --[[if CheckReward(identifier, tonumber(day)) == "true" then
        xPlayer.showNotification("Du hast heute schon dein Geschenk abgeholt!")
    else 
        TriggerClientEvent('ChillKalender:PlayAnimation', src, day)
    end
    ]]
end)

RegisterNetEvent('ChillKalender:GiveItem', function(itemname, amount, isMoney, day)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.getIdentifier()
    local count = tonumber(amount)

        if isMoney then
            xPlayer.addMoney(count)
            xPlayer.showNotification("Du hast ".. count.. "$ als Geschenk erhalten!")
        else
            xPlayer.addInventoryItem(itemname, count)
            xPlayer.showNotification("Du hast ".. ESX.GetItemLabel(itemname) .. " " .. count.. "x als Geschenk erhalten!")
        end
        addDay(identifier, day)
   
        
   
end)