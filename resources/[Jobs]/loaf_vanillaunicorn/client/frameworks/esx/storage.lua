CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not cache.loadedFramework do Wait(500) end
    local ESX = cache.ESX

    local function GetAmountDepositWithdraw()
        local toReturn
        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "select_amount_", {
            title = Strings["quantity"]
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

    function DepositItems(itemtype)
        local weapons, items = lib.TriggerCallbackSync("loaf_vanillaunicorn:get_inventory")
        local elements = {}
        if itemtype == "items" then
            for _, v in pairs(items) do
                if v.count > 0 then 
                    table.insert(elements, {
                        label = ("x%i %s"):format(v.count, v.label or v.name),
                        value = v.name,
                        data = v
                    })
                end
            end
        elseif itemtype == "weapons" then
            for _, v in pairs(weapons) do
                table.insert(elements, {
                    label = ("%s"):format(v.label or v.name),
                    value = v.name
                })
            end
        end

        if #elements == 0 then
            table.insert(elements, {label=Strings["no_"..itemtype]})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_item_deposit", {
            title = Strings[itemtype],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if not data.current.value then return menu.close() end
            
            local amount
            if itemtype == "items" then
                amount = GetAmountDepositWithdraw()
                if not amount then return end
                if data.current.data.count < amount then 
                    ESX.ShowNotification(Strings["invalid_amount"])
                    return 
                end
            end

            lib.TriggerCallback("loaf_vanillaunicorn:deposit", function(success)
                if success then
                    DepositItems(itemtype)
                end
            end, data.current.value, amount)

        end, function(data, menu)
            menu.close()
        end)
    end

    function WithdrawItems(itemtype)
        local items = lib.TriggerCallbackSync("loaf_vanillaunicorn:get_storage", itemtype)
        local elements = {}
        for k, v in pairs(items) do
            if v.count > 0 then 
                table.insert(elements, {
                    label = ("x%i %s"):format(v.count, v.label or v.name),
                    value = v.name,
                    data = v
                })
            end
        end

        if #elements == 0 then
            table.insert(elements, {label=Strings["no_"..itemtype]})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_item_withdraw", {
            title = Strings[itemtype],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if not data.current.value then return menu.close() end
            
            local amount
            if itemtype == "items" then
                amount = GetAmountDepositWithdraw()
                if not amount then return end
                if data.current.data.count < amount then 
                    ESX.ShowNotification(Strings["invalid_amount"])
                    return 
                end
            end

            lib.TriggerCallback("loaf_vanillaunicorn:withdraw", function(success)
                if success then
                    WithdrawItems(itemtype)
                end
            end, data.current.value, amount)

        end, function(data, menu)
            menu.close()
        end)
    end

    function DepositOrWithdraw(itemtype)
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "deposit_withdraw", {
            title = Strings[itemtype],
            align = cache.menuAlign,
            elements = {
                {label = Strings["put_"..itemtype], value = "put"},
                {label = Strings["get_"..itemtype], value = "get"},
            }
        }, function(data, menu)
            if data.current.value == "put" then
                DepositItems(itemtype)
            elseif data.current.value == "get" then
                WithdrawItems(itemtype)
            end
        end, function(data, menu)
            menu.close()
        end)
    end

    function OpenStorage()
        ESX.UI.Menu.CloseAll()
        if esx.inventory == "ox_inventory" then
            exports.ox_inventory:openInventory("stash", "loaf_vanillaunicorn")
            return
        end

        if Config.Items and Config.Weapons then
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_storage", {
                title = Strings["storage"],
                align = cache.menuAlign,
                elements = {
                    {label = Strings["items"], value = "items"},
                    {label = Strings["weapons"], value = "weapons"},
                }
            }, function(data, menu)
                DepositOrWithdraw(data.current.value)
            end, function(data, menu)
                menu.close()
            end)
        elseif Config.Items then
            DepositOrWithdraw("items")
        elseif Config.Weapons then
            DepositOrWithdraw("weapons")
        end
    end
end)