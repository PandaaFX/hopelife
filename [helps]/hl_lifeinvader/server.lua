local lastAdvertisement = nil

RegisterNetEvent('lifeinvader:sendMessage', function(message)
    local xPlayer = ESX.GetPlayerFromId(source)

    local license  = false

    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end    
    end

    if xPlayer.getMoney() >= Config.cost then
        if lastAdvertisement ~= nil then

            local minutes = os.difftime(tonumber(os.time()), lastAdvertisement) / 60
            if minutes >= Config.cooldown then
                lastAdvertisement = tonumber(os.time())
                sendAdvertisement(xPlayer, message, license)
                xPlayer.removeMoney(Config.cost)
            else
                xPlayer.showNotification(string.format(Config.locale.CurrentlyOnCooldown, ESX.Math.Round(Config.cooldown - minutes, 2)))
            end
        else
            lastAdvertisement = tonumber(os.time())
            sendAdvertisement(xPlayer, message, license)
        end
    else
        xPlayer.showNotification("Nicht genug Geld dafür")
    end
end)

function sendAdvertisement(xPlayer, message, license)
    xPlayer.removeMoney(Config.cost)
    TriggerClientEvent('lifeinvader:sendNotification', -1, message)
    local embed = {
        {
            ["color"] = 15158332,
            ["title"] = string.format(Config.locale.PostedAdvertisementLog, xPlayer.getName()),
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%c")
            }
        }
    }
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.name, avatar_url= "https://wiki.rage.mp/images/5/5e/Char_lifeinvader.jpg" ,embeds = embed}), { ['Content-Type']= 'application/json' })
    MySQL.query('INSERT INTO lifeinvader (license, name, message) VALUES (?, ?, ?)', {license, xPlayer.getName(), message}, function(result) end)
end