IsPlayerBusyDrinking = {}

OnObjectLoaded(function()
    if Config.ox_inv then
        FrameworkObject.RegisterUsableItem = function(itemName, cb)
            exports(itemName, function(event, item, inventory, slot, data)
                cb(inventory.id)
            end)
        end
    end

    FrameworkObject.RegisterUsableItem("supervodka", function(source)
        TriggerClientEvent(TriggerName("ShowSelector"), source)
    end)

    FrameworkObject.RegisterUsableItem("breath_alcohol_tester", function(source)
        TriggerClientEvent(TriggerName("TakeSelfTest"), source)
        FrameworkObject.GetPlayerFromId(source).removeInventoryItem("breath_alcohol_tester", 1)
    end)

    if Config.Framework == 0 then
        for k, v in pairs(Config.DrunkList) do
            RegisterCommand(v.name, function(source)
                if not IsPlayerBusyDrinking[source] then
                    IsPlayerBusyDrinking[source] = true
                    FrameworkObject.GetPlayerFromId(source).removeInventoryItem(v.name, 1)
                    TriggerClientEvent(TriggerName("EquipPlayerDrink"), source, v)
                end
            end, false)
        end
    else
        for k, v in pairs(Config.DrunkList) do
            FrameworkObject.RegisterUsableItem(v.name, function(source)
                if not IsPlayerBusyDrinking[source] then
                    IsPlayerBusyDrinking[source] = true
                    FrameworkObject.GetPlayerFromId(source).removeInventoryItem(v.name, 1)
                    TriggerClientEvent(TriggerName("EquipPlayerDrink"), source, v)
                end
            end)
        end
    end
end)

RegisterNetEvent(TriggerName("SetPlayerBusyDrinkStatus"), function(status)
    IsPlayerBusyDrinking[source] = status
end)