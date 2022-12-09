RegisterServerEvent('shoprobbery:server:policeAlert')
AddEventHandler('shoprobbery:server:policeAlert', function(coords)
    if Config['ShopRobbery']['framework']['name'] == 'ESX' then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player['job']['name'] == 'fib' or player['job']['name'] == 'police' or player['job']['name'] == 'lssd' then
                TriggerClientEvent('shoprobbery:client:policeAlert', players[i], coords)
            end
        end
    elseif Config['ShopRobbery']['framework']['name'] == 'QB' then
        local players = QBCore.Functions.GetPlayers()
        for i = 1, #players do
            local player = QBCore.Functions.GetPlayer(players[i])
            if player.PlayerData.job.name == Config['ShopRobbery']['setjobForPolice'] then
                TriggerClientEvent('shoprobbery:client:policeAlert', players[i], coords)
            end
        end
    end
end)

discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/987021808811253850/DbDWMODK3Mgr7yDM0voyR52O1MaMhQjnoh3aGqxjW9fvrXBlM0sw04z-FdOYiq5ktWBp',
    ['name'] = 'rm_shoprobbery',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dff6a13a5361bc520ef126991405caae.png?size=1024'
}

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end
