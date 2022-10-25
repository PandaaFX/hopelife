CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not cache.loadedFramework do Wait(500) end
    local ESX = cache.ESX

    function OpenBossMenu()
        if not cache.boss then return end

        ESX.UI.Menu.CloseAll()

        TriggerEvent(esx.society_event, "lafam", function(data, menu)
            menu.close()
        end, esx.societyOptions)
    end
end)