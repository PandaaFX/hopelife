CreateThread(function()
    if Config.Framework ~= "esx" then return end

    local ESX = nil
    while ESX == nil do
        Wait(500)
        TriggerEvent(esx.client, function(obj) 
            ESX = obj
        end)
    end

    while ESX.GetPlayerData().job == nil or ESX.GetPlayerData().job.name == nil do
        Wait(500)
    end
    cache.loadedFramework = true
    cache.ESX = ESX
    
    InitMarkers()

    Wait(500)

    local function SetJobCache()
        local job = ESX.GetPlayerData().job
        cache.grade = job.grade
        cache.gradeName = job.grade_name
        cache.hasJob = job.name == "lafam"

        if cache.hasJob then
            cache.boss = cache.grade == Config.JobGrades.Boss
        else
            cache.boss = false
        end

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

    RegisterNetEvent("esx:setJob")
    AddEventHandler("esx:setJob", function(job)
        SetJobCache()
    end)

    function Notify(msg)
        ESX.ShowNotification(msg)
    end
end)