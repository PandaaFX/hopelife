CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not cache.loadedFramework do Wait(500) end
    local ESX = cache.ESX

    function LockerHandler()
        TriggerEvent("skinchanger:getSkin", function(skin)
            ESX.UI.Menu.CloseAll()

            local clothes = Outfits[cache.gradeName]
            local elements = {{label = Strings["regular"], outfit = "civilian"}}

            local gender = "male"
            if skin.sex == 1 then gender = "female" end
            for k, v in pairs(clothes) do
                if v[gender] then
                    table.insert(elements, {label = v.label, outfit = v[gender]})
                end
            end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_outfit", {
                title = Strings["wardrobe"],
                align = cache.menuAlign,
                elements = elements
            }, function(data, menu)

                local outfit = data.current.outfit
                if outfit == "civilian" then
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
                else
                    TriggerEvent("skinchanger:loadClothes", skin, outfit)
                end

            end, function(data, menu)
                menu.close()
            end)
        end)
    end
end)