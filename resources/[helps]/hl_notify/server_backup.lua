ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local adminRanks = { -- change this as your server ranking ( default are : superadmin | admin | moderator )
                'superadmin',
                'admin',
                'dev'
}

function havePermission(xPlayer, exclude)    -- you can exclude rank(s) from having permission to specific commands     [exclude only take tables]
    if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end    -- will prevent from errors if you pass wrong argument

    local playerGroup = xPlayer.getGroup()
    for k,v in pairs(adminRanks) do
        if v == playerGroup then
            if not exclude then
                return true
            else
                for a,b in pairs(exclude) do
                    if b == v then
                        return false
                    end
                end
                return true
            end
        end
    end
    return false
end





RegisterCommand("announce", function(source, args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
        if source ~= 0 then
            local xPlayer = ESX.GetPlayerFromId(source)
            local playerGroup = xPlayer.getGroup()
            if havePermission(xPlayer) then
                TriggerClientEvent('txAdmin:receiveAnnounce', -1, argString, playerGroup)
            end
        end
    end
end, false)
