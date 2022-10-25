ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    PlayerData = ESX.GetPlayerData()
end)

local havemarry = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (GetDistanceBetweenCoords(playerCoords, Config.PedCoords, false) < Config.InteractDistance) then
            ESX.ShowHelpNotification(Config.HelpNotify)
            if IsControlJustPressed(0, 38) then
                openMarry(true)
            end       
        elseif (GetDistanceBetweenCoords(playerCoords, Config.PedCoords2, false) < Config.InteractDistance) then
            ESX.ShowHelpNotification(Config.HelpNotify2)
            if IsControlJustPressed(0, 38) then
                openAdoption(true)
            end
        
        else
            Citizen.Wait(500)
        end
    end
end) 

-- Ped

--[[Citizen.CreateThread(function()
    ped = CreatePed(4, GetHashKey("ig_priest"), Config.PedCoords, 3374176, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end) --]]

-- Blip

Citizen.CreateThread(function()
    marry = AddBlipForCoord(Config.BlipPos)
    SetBlipSprite(marry, Config.BlipSprite)
    SetBlipDisplay(marry, 4)
    SetBlipScale(marry, Config.BlipScale)
    SetBlipColour(marry, Config.BlipColor)
    SetBlipAsShortRange(marry, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(marry)
end)

function openMarry(state)
    SendNUIMessage({
        action="marry",
        status=state
    })
    SetNuiFocus(state, state)
end

function openAdoption(state)
    SendNUIMessage({
        action="adoption",
        status=state
    })
    SetNuiFocus(state, state)
end

RegisterNUICallback("marry-close", function()
    openMarry(false)
end)

RegisterNUICallback("adoption-close", function()
    openAdoption(false)
end)

RegisterNUICallback("marry-yes", function()
    local player = GetPlayerPed(-1)
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    openMarry(false)

    if closestPlayer ~= -1 and closestPlayerDistance <= 3.0 then
        ESX.ShowNotification(Config.SendMarry)
        TriggerServerEvent("sendMarry", GetPlayerServerId(closestPlayer))
    else
        ESX.ShowNotification(Config.NoNearPlayer)
    end
end)

RegisterNUICallback("adoption-yes", function()
    local player = GetPlayerPed(-1)
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    openAdoption(false)

    if closestPlayer ~= -1 and closestPlayerDistance <= 1.5 then
        ESX.ShowNotification(Config.SendAdoption)
        TriggerServerEvent("sendAdoption", GetPlayerServerId(closestPlayer))
    else
        ESX.ShowNotification(Config.NoNearPlayer)
    end
end)

RegisterNetEvent("acceptmarry")
AddEventHandler("acceptmarry", function()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    havemarry = true

    Citizen.CreateThread(function()
        while havemarry do
            Citizen.Wait(1)
            if closestPlayer ~= -1 and closestPlayerDistance <= 3.0 then
                if IsControlJustPressed(0, 246) then
                    havemarry = false
                    ESX.ShowNotification(Config.SendedYes)
                    TriggerServerEvent("accepted", GetPlayerServerId(closestPlayer))
                end
            else
                ESX.ShowNotification(Config.NoNearPlayer)
            end
        end
    end)    
end)

RegisterNetEvent("acceptadoption")
AddEventHandler("acceptadoption", function()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    haveadoption = true

    Citizen.CreateThread(function()
        while haveadoption do
            Citizen.Wait(1)
            if closestPlayer ~= -1 and closestPlayerDistance <= 3.0 then
                if IsControlJustPressed(0, 246) then
                    haveadoption = false
                    ESX.ShowNotification(Config.SendedYes)
                    TriggerServerEvent("accepted2", GetPlayerServerId(closestPlayer))
                end
            else
                ESX.ShowNotification(Config.NoNearPlayer)
            end
        end
    end)    
end)

-- RegisterNetEvent("sendMarryNotify")
-- AddEventHandler("sendMarryNotify", function(text)
--     ESX.ShowNotification(text)
-- end)