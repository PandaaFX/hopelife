ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("sendMarry")
AddEventHandler("sendMarry", function(closestplayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local closestxPlayer = ESX.GetPlayerFromId(closestplayer)

    closestxPlayer.showNotification("Willst du "..xPlayer.getName().." Heiraten? Wenn ja Drücke 'Z'")
    TriggerClientEvent("acceptmarry", closestxPlayer.source)
end)

RegisterNetEvent("sendAdoption")
AddEventHandler("sendAdoption", function(closestplayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local closestxPlayer = ESX.GetPlayerFromId(closestplayer)

    closestxPlayer.showNotification("Willst du "..xPlayer.getName().." Adoptieren? Wenn ja Drücke 'Z'")
    TriggerClientEvent("acceptadoption", closestxPlayer.source)
end)


RegisterNetEvent("accepted")
AddEventHandler("accepted", function(closestplayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local closestxPlayer = ESX.GetPlayerFromId(closestplayer)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["@identifier"] = closestxPlayer.identifier}, function(result)
        MySQL.Async.fetchAll("UPDATE users SET lastname = @lastname WHERE identifier = @identifier", {["@lastname"] = result[1].lastname, ["@identifier"] = xPlayer.identifier}, function(test)
        end)
    end)

    if(closestxPlayer.getAccount('bank').money < 149999) then
        closestxPlayer.showNotification('Du hast nicht genügend Geld auf der Bank!')
    else
        TriggerClientEvent('hopelife:notify', -1, 1, '#5f0085', 'INFORMATION', closestxPlayer.getName()..' und '..xPlayer.getName().. ' haben geheiratet!', 7500)
        closestxPlayer.removeAccountMoney('bank', 150000)
    end

end)

RegisterNetEvent("accepted2")
AddEventHandler("accepted2", function(closestplayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local closestxPlayer = ESX.GetPlayerFromId(closestplayer)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["@identifier"] = closestxPlayer.identifier}, function(result)
        MySQL.Async.fetchAll("UPDATE users SET lastname = @lastname WHERE identifier = @identifier", {["@lastname"] = result[1].lastname, ["@identifier"] = xPlayer.identifier}, function(test)
        end)
    end)

    if(closestxPlayer.getAccount('bank').money < 149999) then
        closestxPlayer.showNotification('Du hast nicht genügend Geld auf der Bank!')
    else
        TriggerClientEvent('hopelife:notify', -1, 1, '#5f0085', 'INFORMATION', closestxPlayer.getName()..' hat '..xPlayer.getName().. ' soeben Adoptiert!', 7500)
        closestxPlayer.removeAccountMoney('bank', 150000)
    end
end)
