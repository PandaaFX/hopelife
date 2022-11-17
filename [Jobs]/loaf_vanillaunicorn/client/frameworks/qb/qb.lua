CreateThread(function()
    if Config.Framework ~= "qb" then return end
    Outfits = {} -- unfortunately outfits do not currently work with qbcore. i will look into this

    local QBCore = nil
    while not QBCore do
        Wait(500)
        QBCore = exports["qb-core"]:GetCoreObject()
    end
    while not QBCore.Functions.GetPlayerData() or not QBCore.Functions.GetPlayerData().job or not QBCore.Functions.GetPlayerData().job.name do
        Wait(500)
    end

    InitMarkers()

    cache.loadedFramework = true
    cache.QBCore = QBCore
    
    function OpenStorage()
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "unicornstash", {
            maxweight = 4000000,
            slots = 300,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "unicornstash")
    end

    Wait(500)

    function MixMenu(coords)
        PlayMixAnimation(coords)
    end

    local function SetJobCache()
        local job = QBCore.Functions.GetPlayerData().job

        cache.grade = job.grade.level
        cache.gradeName = job.grade.name
        cache.hasJob = job.name == "unicorn"

        local allowed = {}
        for action, grades in pairs(Config.JobGrades) do
            if type(grades) == "table" then
                allowed[action] = false
                if cache.hasJob then
                    for _, grade in pairs(grades) do
                        if cache.grade == grade then
                            allowed[action] = true
                        end
                    end
                end
            end
        end

        for action, allowed in pairs(allowed) do
            cache["allowed"..action] = allowed
        end

        ReloadMarkers()
    end

    SetJobCache()

    RegisterNetEvent("QBCore:Client:OnJobUpdate")
    AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
        SetJobCache()
    end)

    function Notify(msg)
        QBCore.Functions.Notify(msg)
    end
end)