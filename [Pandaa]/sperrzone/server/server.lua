ESX = nil
local existPD = false
local existSD = false
local existFIB = false

local coordsX_PD = 0
local coordsY_PD = 0
local coordsZ_PD = 0

local coordsX_SD = 0
local coordsY_SD = 0
local coordsZ_SD = 0

local coordsX_FIB = 0
local coordsY_FIB = 0
local coordsZ_FIB= 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Config.CreateZone, function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local name = GetPlayerName(source)

    if xPlayer.job.name == "police" then
        if existPD == false then
            playerCoords = GetEntityCoords(GetPlayerPed(source), true)
            coordsX_PD = playerCoords.x
            coordsY_PD = playerCoords.y
            coordsZ_PD = playerCoords.z

            TriggerClientEvent("adminzone:setblip", -1, coordsX_PD, coordsX_PD, coordsY_PD, coordsZ_PD, xPlayer, Config.BlipSpritePD, "pd")
            existPD = true 
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Sperrzone - LSPD', 'Information', 'Eine Sperrzone wurde bereits ausgerufen.', 'CHAR_CALL911', 1)
        end
    elseif xPlayer.job.name == "lssd" then
        if existSD == false then
            playerCoords = GetEntityCoords(GetPlayerPed(source), true)
            coordsX_SD = playerCoords.x
            coordsY_SD = playerCoords.y
            coordsZ_SD = playerCoords.z

            TriggerClientEvent("adminzone:setblip", -1, coordsX_SD, coordsX_SD, coordsY_SD, coordsZ_SD, xPlayer, Config.BlipSpriteSD, "sd")
            existSD = true 
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Sperrzone - LSSD', 'Information', 'Eine Sperrzone wurde bereits ausgerufen.', 'CHAR_CALL911', 1)
        end
    elseif xPlayer.job.name == "fib" then
        if existFIB == false then
            playerCoords = GetEntityCoords(GetPlayerPed(source), true)
            coordsX_FIB = playerCoords.x
            coordsY_FIB = playerCoords.y
            coordsZ_FIB = playerCoords.z

            TriggerClientEvent("adminzone:setblip", -1, coordsX_FIB, coordsX_FIB, coordsY_FIB, coordsZ_FIB, xPlayer, Config.BlipSpriteFIB, "fib")
            existFIB = true 
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Sperrzone - FIB', 'Information', 'Eine Sperrzone wurde bereits ausgerufen.', 'CHAR_CALL911', 1)
        end  
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Sperrzone', 'Information', 'Dazu bist du nicht berechtigt.', 'CHAR_CALL911', 1)
    end
end)

RegisterServerEvent("adminzone:reconnectzone")
AddEventHandler("adminzone:reconnectzone", function()
    local _source = source
    if existPD then
    TriggerClientEvent("adminzone:reconnectsetblip", _source, coordsX_PD, coordsX_PD, coordsY_PD, coordsZ_PD, Config.BlipSpritePD, "pd")
    end
    if existSD then
    TriggerClientEvent("adminzone:reconnectsetblip", _source, coordsX_SD, coordsX_SD, coordsY_SD, coordsZ_SD, Config.BlipSpriteSD, "sd")
    end
    if existFIB then
    TriggerClientEvent("adminzone:reconnectsetblip", _source, coordsX_FIB, coordsX_FIB, coordsY_FIB, coordsZ_FIB, Config.BlipSpriteFIB, "fib")
    end
end)

RegisterCommand(Config.DeleteZone, function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local name = GetPlayerName(source)

    if xPlayer.job.name == "police" then
        TriggerClientEvent("adminzone:delZone", -1, "pd")
        existPD = false
    elseif xPlayer.job.name == "lssd" then
        TriggerClientEvent("adminzone:delZone", -1, "sd")
        existSD = false
    elseif xPlayer.job.name == "fib" then
        TriggerClientEvent("adminzone:delZone", -1, "fib")
        existFIB = false
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Sperrzone', 'Information', 'Dazu bist du nicht berechtigt.', 'CHAR_CALL911', 1)
    end

end)


RegisterServerEvent("adminzone:sendNotify")
AddEventHandler("adminzone:sendNotify", function(job)
    TriggerClientEvent('esx:showAdvancedNotification', -1, 'Sperrzone - '.. job, 'Information', '~r~Es wurde eine Sperrzone ausgerufen!~s~\nWir bitten alle Bürger das Gebiet zu meiden.\nVielen Dank!', 'CHAR_CALL911', 1)
end)

RegisterServerEvent("adminzone:sendOpen")
AddEventHandler("adminzone:sendOpen", function(job)
    TriggerClientEvent('esx:showAdvancedNotification', -1, 'Sperrzone - '.. job, 'Information', '~g~Die Sperrzone wurde aufgehoben!~s~\nDas Gebiet kann wieder betreten werden.\nVielen Dank für Ihre Geduld!', 'CHAR_CALL911', 1)
end)