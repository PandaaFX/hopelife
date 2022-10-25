ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local cachedBadges = {}

Citizen.CreateThread(function()
    MySQL.Async.fetchAll('SELECT `badge`, `identifier`, `firstname`, `lastname` FROM `users`', {}, function(result)
        if result then
            for _, v in pairs(result) do
                -- print(v.badge, v.identifier)
                cachedBadges[v.identifier] = { badge = v.badge, fullname = v.lastname } --fullname = string.sub(v.firstname, 1, 1) .. ". " .. v.lastname }
            end
        end
    end)

    for k,v in pairs(Config.Settings) do
        ESX.RegisterUsableItem(v.itemName, function(src)
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer.job.name == v.job then
                local data = cachedBadges[xPlayer.identifier]
                if data ~= nil and data.badge and data.fullname then
                    local rank = Config.Ranks[xPlayer.job.name][xPlayer.job.grade]
                    TriggerClientEvent("an_badges:showBadge", src, v.design, data.badge, data.fullname, v.number, rank)
                else
                    TriggerClientEvent("an_badges:notify", src, "You have not yet created your badge, please provide a picture URL to be used in your badge", "error")
                    TriggerClientEvent("an_badges:createBadge", src)
                end
            else
                TriggerClientEvent("an_badges:notify", src, "That is not yours.", "error")
            end
        end)
    end
end)

RegisterNetEvent('an_badges:showSV', function(pid, data)
    TriggerClientEvent("an_badges:showCL", pid, data)
end)

RegisterNetEvent('an_badges:updateBadge', function(url)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.Async.execute('UPDATE users SET badge = ? WHERE identifier = ? ', {url, xPlayer.identifier}, function(affectedRows)
            if affectedRows then
                TriggerClientEvent("an_badges:notify", src, "Your badge avatar was updated successfully.", "success")
                cachedBadges[xPlayer.identifier].badge = url
            else
                TriggerClientEvent("an_badges:notify", src, "There have been an error updating your badge avatar. Please contact the developer: aymaN#5924", "error")
            end
        end)
    end
end)