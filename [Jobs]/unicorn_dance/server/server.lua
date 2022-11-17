ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('myShops:buyItemZigaretten')
AddEventHandler('myShops:buyItemZigaretten', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 50

    if xPlayer.getMoney() >= price then
        if xPlayer.canCarryItem("cigarett", 1) then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem("cigarett", 1)
            TriggerClientEvent('esx:showNotification', source, "Zigaretten gekauft")
        else
            TriggerClientEvent('esx:showNotification', source, "Kannst du nicht tragen")
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Nicht genug Geld")
    end
end)

ESX.RegisterUsableItem('cigarett', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local smoke = xPlayer.getInventoryItem('cigarett')

    xPlayer.removeInventoryItem('cigarett', 1)
    TriggerClientEvent('cigarett:startSmoke', source)
end)

ESX.RegisterUsableItem('cohiba', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local smoke = xPlayer.getInventoryItem('cohiba')

    xPlayer.removeInventoryItem('cohiba', 1)
    TriggerClientEvent('cohiba:startSmoke', source)
end)

ESX.RegisterUsableItem('montecristo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local smoke = xPlayer.getInventoryItem('montecristo')

    xPlayer.removeInventoryItem('montecristo', 1)
    TriggerClientEvent('cohiba:startSmoke', source)
end)
local ring = false

ESX.RegisterUsableItem('ehering', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local rings = xPlayer.getInventoryItem('ehering')
    TriggerClientEvent('ring:anziehen', source)
end)