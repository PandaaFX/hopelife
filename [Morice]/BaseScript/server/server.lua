ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj
end)

-- Items Benutzen Anfang

for k,v in pairs(Config.Drugs) do 
    ESX.RegisterUsableItem(k, function(playerId)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        
        if xPlayer.getInventoryItem(k).count >= 1 then 
            xPlayer.removeInventoryItem(k, 1)
            xPlayer.triggerEvent("morice:drogenbenutzen", v.Animation, v.Time, k)
        end
    end)
end

-- Items Benutzen Ende

-- AntiCheat Clear Cache Anfang

ConsoleInterval_mixas = 1 * 60000
ConsoleCommandsAfterInterval_mixas = {
    "clearcache"
}

Citizen.CreateThread(function()
    while true do 
        Wait(ConsoleInterval_mixas)

        for k,v in pairs(ConsoleCommandsAfterInterval_mixas) do 
            ExecuteCommand(v)
        end
    end
end)

-- AntiCheat Clear Cache Ende

-- WS Loader Stop

Citizen.CreateThread(function()
    Citizen.Wait(10 * 60 * 1000)
    StopResource("ws_loader")
end)

-- WS Loader Stop

-- AntiCheat Allgemeines Anfang

AddEventHandler("giveWeaponEvent", function(sender, data)  
    TriggerEvent('mxs:customban', sender, 'Gibt einem anderem Spieler eine Waffe')
end)

AddEventHandler("removeWeaponEvent", function(sender, data)
    TriggerEvent('mxs:customban', sender, 'Möchte einen Spieler die Waffen wegnehmen')
end)

-- AntiCheat Allgemeines Ende