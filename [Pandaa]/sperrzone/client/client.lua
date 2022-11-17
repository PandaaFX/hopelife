ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local zonePD, zoneSD, zoneFIB, blipPD, blipSD, blipFIB = nil, nil, nil, nil, nil, nil


AddEventHandler('playerSpawned', function(spawn)
    Citizen.Wait(2*1000)
    TriggerServerEvent("adminzone:reconnectzone") 
end)

RegisterNetEvent('adminzone:reconnectsetblip')
AddEventHandler('adminzone:reconnectsetblip', function(source, coordsX, coordsY, coordsZ, blipSprite, typee)
    local job = nil
    if typee == "pd" then
        job = "LSPD"
        blipPD = AddBlipForCoord(coordsX, coordsY, coordsZ)
        zonePD = AddBlipForRadius(coordsX, coordsY, coordsZ, Config.ZoneRadius)
        
        SetBlipSprite(zonePD, 1)
        SetBlipColour(zonePD, Config.ZoneColorPD)
        SetBlipAlpha(zonePD, 100)
        
        SetBlipAsShortRange(blipPD, true)
        SetBlipSprite(blipPD, blipSprite)
        SetBlipColour(blipPD, Config.BlipColorPD)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipNamePD)
        EndTextCommandSetBlipName(blipPD)
    elseif typee == "sd" then
        job = "LSSD"
        blipSD = AddBlipForCoord(coordsX, coordsY, coordsZ)
        zoneSD = AddBlipForRadius(coordsX, coordsY, coordsZ, Config.ZoneRadius)
        
        SetBlipSprite(zoneSD, 1)
        SetBlipColour(zoneSD, Config.ZoneColorSD)
        SetBlipAlpha(zoneSD, 100)
        
        SetBlipAsShortRange(blipSD, true)
        SetBlipSprite(blipSD, blipSprite)
        SetBlipColour(blipSD, Config.BlipColorSD)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipNameSD)
        EndTextCommandSetBlipName(blipSD)
    elseif typee == "fib" then
        job = "FIB"
        blipFIB = AddBlipForCoord(coordsX, coordsY, coordsZ)
        zoneFIB = AddBlipForRadius(coordsX, coordsY, coordsZ, Config.ZoneRadius)
        
        SetBlipSprite(zoneFIB, 1)
        SetBlipColour(zoneFIB, Config.ZoneColorFIB)
        SetBlipAlpha(zoneFIB, 100)
        
        SetBlipAsShortRange(blipFIB, true)
        SetBlipSprite(blipFIB, blipSprite)
        SetBlipColour(blipFIB, Config.BlipColorFIB)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipNameFIB)
        EndTextCommandSetBlipName(blipFIB)
    end
    TriggerEvent('esx:showAdvancedNotification', 'Sperrzone - '.. job, 'Information', '~r~Es wurde eine Sperrzone ausgerufen!~s~\nWir bitten alle Bürger das Gebiet zu meiden.\nVielen Dank!', 'CHAR_CALL911', 1)
    exist = true
end)


RegisterNetEvent('adminzone:setblip')
AddEventHandler('adminzone:setblip', function(source, coordsX, coordsY, coordsZ, xPlayer, blipSprite, typee)
    local job = nil
    if typee == "pd" then
        job = "LSPD"
        blipPD = AddBlipForCoord(coordsX, coordsY, coordsZ)
        zonePD = AddBlipForRadius(coordsX, coordsY, coordsZ, Config.ZoneRadius)
        
        SetBlipSprite(zonePD, 1)
        SetBlipColour(zonePD, Config.ZoneColorPD)
        SetBlipAlpha(zonePD, 100)
        
        SetBlipAsShortRange(blipPD, true)
        SetBlipSprite(blipPD, blipSprite)
        SetBlipColour(blipPD, Config.BlipColorPD)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipNamePD)
        EndTextCommandSetBlipName(blipPD)
    elseif typee == "sd" then
        job = "LSSD"
        blipSD = AddBlipForCoord(coordsX, coordsY, coordsZ)
        zoneSD = AddBlipForRadius(coordsX, coordsY, coordsZ, Config.ZoneRadius)
        
        SetBlipSprite(zoneSD, 1)
        SetBlipColour(zoneSD, Config.ZoneColorSD)
        SetBlipAlpha(zoneSD, 100)
        
        SetBlipAsShortRange(blipSD, true)
        SetBlipSprite(blipSD, blipSprite)
        SetBlipColour(blipSD, Config.BlipColorSD)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipNameSD)
        EndTextCommandSetBlipName(blipSD)
    elseif typee == "fib" then
        job = "FIB"
        blipFIB = AddBlipForCoord(coordsX, coordsY, coordsZ)
        zoneFIB = AddBlipForRadius(coordsX, coordsY, coordsZ, Config.ZoneRadius)
        
        SetBlipSprite(zoneFIB, 1)
        SetBlipColour(zoneFIB, Config.ZoneColorFIB)
        SetBlipAlpha(zoneFIB, 100)
        
        SetBlipAsShortRange(blipFIB, true)
        SetBlipSprite(blipFIB, blipSprite)
        SetBlipColour(blipFIB, Config.BlipColorFIB)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipNameFIB)
        EndTextCommandSetBlipName(blipFIB)
    end
    TriggerServerEvent("adminzone:sendNotify", job)   
    exist = true
end)

function delBlip(typee, job)
    if typee == "pd" then
        if blipPD and zonePD then
            RemoveBlip(blipPD)
            RemoveBlip(zonePD)
            
            blipPD = nil
            zonePD = nil
            TriggerServerEvent("adminzone:sendOpen", job)
        end
    elseif typee == "sd" then
        if blipSD and zoneSD then
            RemoveBlip(blipSD)
            RemoveBlip(zoneSD)
            
            blipSD = nil
            zoneSD = nil
            TriggerServerEvent("adminzone:sendOpen", job)
        end
    elseif typee == "fib" then
        if blipFIB and zoneFIB then
            RemoveBlip(blipFIB)
            RemoveBlip(zoneFIB)
            
            blipFIB = nil
            zoneFIB = nil
            TriggerServerEvent("adminzone:sendOpen", job)
        end
    end
end

RegisterNetEvent("adminzone:delZone")
AddEventHandler("adminzone:delZone", function(typee, job)
    local job = nil
    if typee == "pd" then
        job = "LSPD"
    elseif typee == "sd" then
        job = "LSSD"
    elseif typee == "fib" then
        job = "FIB"
    end
    delBlip(typee, job)
end)