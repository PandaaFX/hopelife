ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('um-bm:server:item')
AddEventHandler('um-bm:server:item', function(item)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addInventoryItem(item, 1)
end)



RegisterServerEvent('um-bm:server:paid')
AddEventHandler('um-bm:server:paid', function(price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeMoney(price)
    TriggerClientEvent('hopelife:notify', src, 1, '#4E3524', 'Coffee Shop', 'Du hast erfolgreich <strong style="color:#008000;">$'..price..'</strong> bezahlt!', 5500)
end)



ESX.RegisterServerCallback('um-bm:server:money', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()
        cb(money)
end)