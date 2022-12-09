ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    Citizen.Wait(500)

    ESX.PlayerData = ESX.GetPlayerData()
end)

function Notify(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNUICallback('close', function(data, cb)
    if data.message ~= nil then
        SetNuiFocus(false, false)
        notify(data.message)
    else
        SetNuiFocus(false, false)
    end
end)

RegisterNUICallback('claim', function(data, cb)
    TriggerServerEvent('hope_advent:claim')
end)

local pedCoords = {
    {Config.CollectPositions.x, Config.CollectPositions.y, Config.CollectPositions.z, nil, Config.CollectPositions.w, nil, -100858228}
}


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        local coords = GetEntityCoords(PlayerPedId())
        local canSleep = true
        for k,v in pairs(Config.CollectPositions) do
            local dist = #(coords - vector3(v.x, v.y, v.z))
            if dist <= 9.0 then
                canSleep = false
                ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um deine Belohnung abzuholen.")
                if IsControlJustPressed(0, 38) then
                    ESX.TriggerServerCallback('hope_advent:reward', function(access)
                        if access then
                            SendNUIMessage({type = "showUI", access = access})
                            SetNuiFocus(true, true)
                        else
                            Config.Notify(Config.Locales["notReady"])
                        end
                    end)
                end
            end
        end
        if canSleep then
            Wait(1000)
        end
    end
end)

RegisterNetEvent("hope_advent:notify", function(msg)
    Config.Notify(msg)
end)