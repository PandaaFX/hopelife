ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--
-- Diving Gear
--
ESX.RegisterUsableItem('kuz_divinggear', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.showNotification(_U('equip_diving'))
    TriggerClientEvent('kuz_diving:applyGear', source, 0)
end)

ESX.RegisterUsableItem('kuz_divinggeargood', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.showNotification(_U('equip_scuba'))
    TriggerClientEvent('kuz_diving:applyGear', source, 1)
end)

RegisterServerEvent("kuz_diving:buy")
AddEventHandler("kuz_diving:buy", function(itemID)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item = Config.divingStores.items[itemID]

    if xPlayer.getMoney() >= item.price then
        buyItem(_source, item, true)
    else
        if Config.divingStores.payWithBank then
            if xPlayer.getAccount('bank').money >= item.price then
                buyItem(_source, item, false)
            else
                xPlayer.showNotification(_U('buy_cant_afford'))
            end
        end
        if not Config.divingStores.payWithBank then
            xPlayer.showNotification(_U('buy_cant_afford'))
        end
    end
end)



RegisterServerEvent("kuz_diving:sell")
AddEventHandler("kuz_diving:sell", function(sellID, itemID)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item = Config.sellLocations[sellID].items[itemID]

    local itemCount = xPlayer.getInventoryItem(item.item).count
    if itemCount > 0 then
        xPlayer.removeInventoryItem(item.item, itemCount)
        xPlayer.addAccountMoney(Config.sellLocations[sellID].useAccount, item.price * itemCount)
        xPlayer.showNotification(_U('you_have_sold') .. '~g~' .. itemCount .. 'x ' .. item.label .. '\n~w~' .. _U('for') .. ' ~g~' .. _U('currency') .. item.price * itemCount)
    else
        xPlayer.showNotification(_U('no_item'))
    end
end)


function sellItem(source, item, cash)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(item.item, 1) then
        xPlayer.addInventoryItem(item.item, 1)
        if cash then
            xPlayer.removeMoney(item.price)
        else
            xPlayer.removeAccountMoney('bank', item.price)
        end
        TriggerClientEvent('esx:showNotification', source, _U('buy_success') .. '~y~' .. item.label)
    else
        TriggerClientEvent('esx:showNotification', source, _U('no_room_to_buy'))
    end
end

ESX.RegisterServerCallback('kuz_diving:hasItem', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(item).count > 0 then
        cb(true)
    else
        cb(false)
    end
end)

function buyItem(source, item, cash)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(item.item, 1) then
        xPlayer.addInventoryItem(item.item, 1)
        if cash then
            xPlayer.removeMoney(item.price)
        else
            xPlayer.removeAccountMoney('bank', item.price)
        end
        TriggerClientEvent('esx:showNotification', source, _U('buy_success') .. '~y~' .. item.label)
    else
        TriggerClientEvent('esx:showNotification', source, _U('no_room_to_buy'))
    end
end

RegisterServerEvent("kuz_diving:getLoot")
AddEventHandler("kuz_diving:getLoot", function(playerCoords)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local nearestDistance = 9999.0
    local nearestId

    for k in pairs(Config.lootLocations) do
        local lootLoc = Config.lootLocations[k]
        local dist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, lootLoc.x, lootLoc.y, lootLoc.z)
        if dist < nearestDistance or nearestDistance == nil then
            nearestDistance = dist
            nearestId = k
        end
    end
    if nearestDistance > Config.lootLocations[nearestId].radius + 20.0 then
        return
    end

    local lootLoc = Config.lootLocations[nearestId]

    local selectedItem

    local hit = math.random(0, 100)
    local value = 0
    for k in pairs(lootLoc.loot) do
        local item = lootLoc.loot[k]
        value = value + item.chance
        if value >= hit then
            selectedItem = item
            break
        end
    end

    if selectedItem ~= nil then
        local amount = math.random(selectedItem.amount_min, selectedItem.amount_max)
        if xPlayer.canCarryItem(selectedItem.item, amount) then
            xPlayer.addInventoryItem(selectedItem.item, amount)
            sendFoundNotification(_source, xPlayer.getInventoryItem(selectedItem.item).label, amount)
        else
            if amount > 1 then
                if xPlayer.canCarryItem(selectedItem.item, 1) then
                    xPlayer.addInventoryItem(selectedItem.item, 1)
                    sendFoundNotification(_source, xPlayer.getInventoryItem(selectedItem.item).label, 1)
                    return
                end
            end
            xPlayer.showNotification(_U('cant_hold_loot'))
        end
    else
        xPlayer.showNotification(_U('nothing_found'))
    end
end)

--
-- Helpers
--
function sendFoundNotification(source, item, amount)
    if amount > 1 then
        TriggerClientEvent('esx:showNotification', source, _U('you_found') .. ' ~y~x' .. amount .. ' ' .. item)
    else
        TriggerClientEvent('esx:showNotification', source, _U('you_found') .. ' ~y~' .. item)
    end

end

function GetDistanceBetweenCoords(x, y, z, x2, y2, z2)
    return ((x2 - x)^2 + (y2 - y)^2 + (z2 - z)^2)^0.5
end