--[[


    Do NOT CHANGE any of the code in this file,
    
    if you do so, do it on your own risk and no support will be given


]]

ESX = nil

CreateThread(function()
    while (ESX == nil) do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end

    ESX.RegisterServerCallback('lls-mechanic:getCurrentMoney', function(source, cb, isWhitelistJob, customConfigPosIndex)
        local esxPlayer = ESX.GetPlayerFromId(source)
        if (esxPlayer) then
            if (isWhitelistJob == true and Config.Positions[customConfigPosIndex].societyName) then
                TriggerEvent('esx_addonaccount:getSharedAccount', Config.Positions[customConfigPosIndex].societyName, function(account)
                    if (account) then
                        cb(account.money)
                    else
                        cb(0)
                    end
                end)
            else
                cb(esxPlayer.getMoney())
            end
        else
            cb(0)
        end
    end)
end)

RegisterServerEvent('lls-mechanic:removeMoney')
AddEventHandler('lls-mechanic:removeMoney', function(amount, isWhitelistJob, customConfigPosIndex, vehicleProps)
    local src = source

    if (amount > 0) then
        if (isWhitelistJob == true and Config.Positions[customConfigPosIndex].societyName) then
            removeSocietyMoney(src, amount, customConfigPosIndex)
        else
            removePlayerCashMoney(src, amount)
        end
    end

    if (Config.AutoSaveVehiclePropertiesOnApply == true) then
        saveVehicleProperties(vehicleProps)
    end
end)
