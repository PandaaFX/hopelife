CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not cache.loadedFramework do Wait(500) end
    local ESX = cache.ESX

    -- mix drink
    function MixMenu(coords)
        local elements = {}
        for k, v in pairs(Config.Bar.Recipes) do
            table.insert(elements, {
                label = v.Label,
                value = k
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "mix_select", {
            title = Strings["select_drink"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)

            local elements = {
                {label = string.format(Strings["make_drink"], data.current.label), value = "make"}
            }
            for k, v in pairs(Config.Bar.Recipes[data.current.value].Ingredients) do
                table.insert(elements, {
                    label = Strings["amount_ingredient"]:format(v[2], lib.TriggerCallbackSync("loaf_vanillaunicorn:get_label", v[1]))
                })
            end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_mix", {
                title = data.current.label,
                align = cache.menuAlign,
                elements = elements
            }, function(data2, menu2)
                if data2.current.value == "make" then
                    local success = lib.TriggerCallbackSync("loaf_vanillaunicorn:mix_drink", data.current.value)
                    if success then
                        ESX.UI.Menu.CloseAll()
                        PlayMixAnimation(coords)
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)

        end, function(data, menu)
            menu.close()
        end)
    end

    -- fridge
    function BrowseFridge()
        local items = lib.TriggerCallbackSync("loaf_vanillaunicorn:get_fridge")
        local elements = {}
        for k, v in pairs(items) do
            if v.count > 0 then 
                table.insert(elements, {
                    label = ("x%i %s"):format(v.count, (v.label or v.name or "unkown")),
                    value = v.name,
                    amount = v.count
                })
            end
        end
        if #elements == 0 then elements = {{label = Strings["no_items"]}} end
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "browse_fridge", {
            title = Strings["browse_items"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)

        end, function(data, menu)
            menu.close()
        end)
    end

    local function GetAmount(label)
        local toReturn
        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "select_amount", {
            title = string.format(Strings["amount_buy"], label)
        }, function(data, menu)
            local amount = tonumber(data.value)
            if amount and amount > 0 then
                toReturn = amount
            else
                toReturn = false
            end
            menu.close()
        end, function(data, menu)
            toReturn = false
            menu.close()
        end)
        while toReturn == nil do Wait(0) end 
        return toReturn
    end

    function PurchaseIndividualItems()
        local elements = {}
        for k, v in pairs(Config.Bar.Items) do
            table.insert(elements, {
                label = Strings["listing_item"]:format(v[3] or v[1], v[2]),
                value = k
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "purchase_item", {
            title = Strings["purchase_items"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            local amount = GetAmount(data.current.label)
            if amount then
                TriggerServerEvent("loaf_vanillaunicorn:purchase_bar", "item", data.current.value, amount)
            end
        end, function(data, menu)
            menu.close()
        end)
    end

    function PurchaseBundles()
        local prices = {}
        for k, v in pairs(Config.Bar.Items) do
            prices[v[1]] = v[2]
        end

        local elements = {}
        for k, v in pairs(Config.Bar.Recipes) do
            local price = 0
            for k, v in pairs(v.Ingredients) do
                price = price + (v[2] * prices[v[1]] or 0)
                if not prices[v[1]] then
                    print("Price for item " .. v[1] .. "doesn't exist.")
                end
            end
            table.insert(elements, {
                label = Strings["purchase_bundle"]:format(v.Label, price),
                value = k
            })
        end
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "purchase_bundle", {
            title = Strings["purchase_bundles"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            local amount = GetAmount(data.current.label)
            if amount then
                TriggerServerEvent("loaf_vanillaunicorn:purchase_bar", "bundle", data.current.value, amount)
            end
        end, function(data, menu)
            menu.close()
        end)
    end

    function AccessFridge()
        ESX.UI.Menu.CloseAll()
        
        if not cache.allowedPurchaseIngredients then return BrowseFridge() end
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_fridge", {
            title = Strings["fridge"],
            align = cache.menuAlign,
            elements = {
                {label = Strings["browse_items"], value = "browse"},
                --{label = Strings["purchase_items"], value = "purchase"},
                {label = Strings["purchase_bundles"], value = "bundles"},
                {label = "Waren Einkaufen", value = "kaufen"},
                {label = "Zigarren Einkaufen", value = "cigkaufen"},
            }
        }, function(data, menu)
            if data.current.value == "browse" then
                BrowseFridge()
            --elseif data.current.value == "purchase" then
              --  PurchaseIndividualItems()
            elseif data.current.value == "bundles" then
                PurchaseBundles()
            elseif data.current.value == "cigkaufen" then
                SetNewWaypoint(5006.347168, -5196.830566, 2.505493)
                ESX.ShowNotification("Fahr zum Tabakhändler und kauf ein. Wegpunkt wurde gesetzt")
            elseif data.current.value == "kaufen" then
                SetNewWaypoint(980.89, -1705.84, 31.12)
                ESX.ShowNotification("Fahr zum Grosshändler und kauf ein. Wegpunkt wurde gesetzt")
            end
        end, function(data, menu)
            menu.close()
        end)
    end
end)

