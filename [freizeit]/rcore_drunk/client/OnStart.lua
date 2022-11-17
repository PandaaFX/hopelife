-------------------------------------------------
-- Variables
-------------------------------------------------
local lastDrunkLevel = -1

-------------------------------------------------
-- Command test
-------------------------------------------------
if Config.Debug then
    RegisterCommand("drunk", function(source, args)
        SetPlayerDrunkPercentage(tonumber(args[1]))
    end)

    RegisterCommand("headache", function(source, args)
        SetPlayerHeadachePercentage(tonumber(args[1]))
    end)

    RegisterCommand("vomit", function(source, args)
        Wait(3500)
        PlayVomitAnimation()
    end)
end

-------------------------------------------------
-- Thread list
-------------------------------------------------
--- Will just make keys in the array to make it more simple in code to check the job.
CreateThread(function()
    for k, v in pairs(Config.WhitelistedJobsToTestBreath) do
        Config.WhitelistedJobsToTestBreath[v] = true
    end

end)

--- preload animations
CreateThread(function()
    for _, dict in pairs(DrunkWalkList) do
        RequestAnimSet(dict)
    end
end)

if Config.Framework == 0 then
    --- Will call on server to fetch drunk level
    CreateThread(function()
        TriggerServerEvent(TriggerName("FetchPlayerDrunkLevel"))
    end)

    --- Reset all effect on start
    CreateThread(function()
        while true do
            Wait(60000)
            if lastDrunkLevel ~= DrunkPercentage then
                TriggerServerEvent(TriggerName("SavePlayerData"), GetPlayerDrunkPercentage(), GetPlayerHeadachePercentage())
                lastDrunkLevel = DrunkPercentage
            end
        end
    end)
end

-- ESX
if Config.Framework == 1 then
    local loaded = false

    GetCoreObject(Config.Framework, Config.ResourceName, function(obj)
        if obj.IsPlayerLoaded() then
            TriggerServerEvent(TriggerName("FetchPlayerDrunkLevel"))
            loaded = true
        end
    end)

    RegisterNetEvent(Config.ExtendedEvents.PlayerLoaded, function()
        --- Will call on server to fetch drunk level
        TriggerServerEvent(TriggerName("FetchPlayerDrunkLevel"))
        loaded = true
    end)

    --- will save player data if loaded
    CreateThread(function()
        while true do
            Wait(60000)
            if loaded then
                if lastDrunkLevel ~= DrunkPercentage then
                    TriggerServerEvent(TriggerName("SavePlayerData"), GetPlayerDrunkPercentage(), GetPlayerHeadachePercentage())
                    lastDrunkLevel = DrunkPercentage
                end
            end
        end
    end)
end

-- QBCore
if Config.Framework == 2 then
    local loaded = false

    GetCoreObject(Config.Framework, Config.ResourceName, function(obj)
        if obj.Functions.GetPlayerData().citizenid then
            TriggerServerEvent(TriggerName("FetchPlayerDrunkLevel"))
            loaded = true
        end
    end)

    RegisterNetEvent(Config.QBCoreEvents.OnPlayerLoaded, function()
        --- Will call on server to fetch drunk level
        TriggerServerEvent(TriggerName("FetchPlayerDrunkLevel"))
        loaded = true
    end)

    --- will save player data if loaded
    CreateThread(function()
        while true do
            Wait(60000)
            if loaded then
                if lastDrunkLevel ~= DrunkPercentage then
                    TriggerServerEvent(TriggerName("SavePlayerData"), GetPlayerDrunkPercentage(), GetPlayerHeadachePercentage())
                    lastDrunkLevel = DrunkPercentage
                end
            end
        end
    end)
end

--- Reset all effect on start
CreateThread(function()
    local ped = PlayerPedId()

    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    ResetPedMovementClipset(ped, 0)
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)

    ResetPedMovementClipset(ped, 0.0)
    SetTimecycleModifier("spectator5")
    SetTimecycleModifierStrength(0.0)
end)

--- player do not wish to pay so we will set nui focus on false
RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent(TriggerName("SetPlayerData"), function(data)
    SetPlayerDrunkPercentage((data.drunk_level))
    SetPlayerHeadachePercentage((data.headache_level))
    SetDrunkerType(data.toughness)

    SendNUIMessage({
        type = "headache",
        value = GetPlayerHeadachePercentage(),
    })

    SendNUIMessage({
        type = "drunk",
        value = GetPlayerDrunkPercentage(),
    })
end)

AddEventHandler("onResourceStop", function(res)
    if (GetCurrentResourceName() ~= res) then
        return
    end

    RemoveNetworkedScenes()
    DeleteEntity(RealBottle)
    DeleteEntity(RealGlass)
    DeleteEntity(BottleObject)

    TriggerServerEvent(TriggerName("SavePlayerData"), GetPlayerDrunkPercentage(), GetPlayerHeadachePercentage())

    for k, v in pairs(Config.DrinkTable) do
        if v.bottle then
            DeleteEntity(v.bottle)
        end

        if v.glass then
            DeleteEntity(v.glass)
        end
    end

    Animation.ResetAll()
end)