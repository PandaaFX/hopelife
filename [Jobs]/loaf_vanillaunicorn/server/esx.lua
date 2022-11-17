CreateThread(function()
    if Config.Framework ~= "esx" then return end

    local lib = exports["loaf_lib"]:GetLib()

    TriggerEvent("esx_society:registerSociety", "lafam", "Lafamilia", "society_lafam", "society_lafam", "society_lafam", {type = "private"})

    TriggerEvent(esx.server, function(ESX)
        -- leaning
        lib.RegisterCallback("loaf_vanillaunicorn:throw_money", function(source, cb, tosstype)
            local xPlayer = ESX.GetPlayerFromId(source)
            local price = Config.ThrowMoney[tosstype]
            if xPlayer.getMoney() < price then return cb(false) end
            --local dancerPlayer = ESX.GetPlayerFromId(dancer)
            --if dancerPlayer then 
                xPlayer.removeMoney(price)
                --local dancersCut = math.ceil((Config.ThrowMoney.dancerCut / 100) * price)
                --dancerPlayer.addMoney(dancersCut)
                --TriggerClientEvent("esx:showNotification", dancer, Strings["threw"]:format(dancersCut))

                TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                    account.addMoney(price)
                end)
            --end
            cb(true)
        end)
        -- end of leaning

        -- bar
        lib.RegisterCallback("loaf_vanillaunicorn:get_fridge", function(source, cb)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return cb({}) end
            TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                cb(inventory.items)
            end)
        end)

        lib.RegisterCallback("loaf_vanillaunicorn:get_label", function(source, cb, item)
            cb(ESX.GetItemLabel(item) or item)
        end)

        lib.RegisterCallback("loaf_vanillaunicorn:mix_drink", function(source, cb, drink)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return cb(false) end

            TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                local hasitems = false
                for k, v in pairs(Config.Bar.Recipes[drink].Ingredients) do
                    local itemdata = inventory.getItem(v[1])
                    if itemdata and itemdata.count >= v[2] then
                        hasitems = true
                    end
                end

                if hasitems then
                    for k, v in pairs(Config.Bar.Recipes[drink].Ingredients) do
                        inventory.removeItem(v[1], v[2])
                    end
                    cb(true)
                    Wait(5000)
                    xPlayer.addInventoryItem(Config.Bar.Recipes[drink].Name, 1)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["mixed"]:format(Config.Bar.Recipes[drink].Label))
                else
                    TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["missing_ingredients"])
                    cb(false)
                end
            end)
        end)

        ---Tabak----

        RegisterNetEvent('tabak:Buymontecristo')
        AddEventHandler('tabak:Buymontecristo', function()
            local xPlayer = ESX.GetPlayerFromId(source)
            local price = 20000
            if xPlayer.job.name ~= "lafam" then
	            if(xPlayer.getMoney() >= price) then
		            xPlayer.removeMoney(price)
		            xPlayer.addInventoryItem('montecristo', 1)
		            TriggerClientEvent('esx:showNotification', source, "1x Montecristo Zigarre für " ..price.. " gekauft!")
		            TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
                        TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account1)
    	                    account.addMoney(price/2)
                            account1.addMoney(price/2)
		                end)
                    end)
	            else
		            TriggerClientEvent('esx:showNotification', source, "Nicht genug Geld")
	            end	
            end
            if xPlayer.job.name == "lafam" then
                local _source = source
                local xPlayer = ESX.GetPlayerFromId(source)  
                local price2 = 15000
            
                TriggerEvent("esx_addonaccount:getSharedAccount", "society_ambulance", function(account)
                    TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account1)
                        TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account2)
                            if account2.money >= price2 then
                                TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                                    inventory.addItem('montecristo', 1)
                                    account2.removeMoney(price2)
                                    account.addMoney(price2/2)
                                    account1.addMoney(price2/2)
                                    TriggerClientEvent('esx:showNotification', source, "1x Montecristo Zigarre für " ..price2.. " gekauft!")
                                end)
                            else
                                TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                            end
                        end)
                    end)
                end)
            end
        end)

        RegisterNetEvent('tabak:Buycohiba')
        AddEventHandler('tabak:Buycohiba', function()
            local xPlayer = ESX.GetPlayerFromId(source)
            local price3 = 40000
            if xPlayer.job.name ~= "lafam" then
	            if(xPlayer.getMoney() >= price3) then
		            xPlayer.removeMoney(price3)
		            xPlayer.addInventoryItem('cohiba', 1)
		            TriggerClientEvent('esx:showNotification', source, "1x Cohiba Zigarre für " ..price3.. " gekauft!")
		            TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
                        TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account1)
    	                    account.addMoney(price3/2)
                            account1.addMoney(price3/2)
		                end)
                    end)
	            else
		            TriggerClientEvent('esx:showNotification', source, "Nicht genug Geld")
	            end	
            end
            if xPlayer.job.name == "lafam" then
                local _source = source
                local xPlayer = ESX.GetPlayerFromId(source)  
                local price4 = 25000
            
                TriggerEvent("esx_addonaccount:getSharedAccount", "society_ambulance", function(account)
                    TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account1)
                        TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account2)
                            if account2.money >= price4 then
                                TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                                    inventory.addItem('cohiba', 1)
                                    account2.removeMoney(price4)
                                    account.addMoney(price4/2)
                                    account1.addMoney(price4/2)
                                    TriggerClientEvent('esx:showNotification', source, "1x Cohiba Zigarre für " ..price4.. " gekauft!")
                                end)
                            else
                                TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                            end
                        end)
                    end)
                end)
            end
        end)

        --Shop Unicorn 
        RegisterNetEvent('unicorn:BuyEau')
        AddEventHandler('unicorn:BuyEau', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 70
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('water', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Wasser für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buybeer')
        AddEventHandler('unicorn:Buybeer', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 70
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('beer', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Bier für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buychamp')
        AddEventHandler('unicorn:Buychamp', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 370
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('champagne', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Champagner für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        --[[RegisterNetEvent('unicorn:Buysekt')
        AddEventHandler('unicorn:Buysekt', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 270
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('sekt', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Sekt für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)]]--

        RegisterNetEvent('unicorn:Buyvodka')
        AddEventHandler('unicorn:Buyvodka', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 200
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('wodka', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Wodka für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycointreau')
        AddEventHandler('unicorn:Buycointreau', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 100
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('cointreau', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Cointreau für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycranberry_juice')
        AddEventHandler('unicorn:Buycranberry_juice', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 80
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('cranberry_juice', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Cranberrysaft für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buyfresh_mix')
        AddEventHandler('unicorn:Buyfresh_mix', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 120
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('fresh_mix', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Fertig Mischung für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buymint')
        AddEventHandler('unicorn:Buymint', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 60
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('mint', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Minze für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buylime')
        AddEventHandler('unicorn:Buylime', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 70
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('lime', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Limette für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buysugar')
        AddEventHandler('unicorn:Buysugar', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 100
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('sugar', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Zucker für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buyice')
        AddEventHandler('unicorn:Buyice', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 20
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('ice', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Eis für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buywhite_rum')
        AddEventHandler('unicorn:Buywhite_rum', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 100
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('white_rum', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Weißer Rum für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buyclub_soda')
        AddEventHandler('unicorn:Buyclub_soda', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 150
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('club_soda', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Club Soda für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buylight_rum')
        AddEventHandler('unicorn:Buylight_rum', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 115
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('light_rum', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Leichten Rum für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buydark_rum')
        AddEventHandler('unicorn:Buydark_rum', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 170
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('dark_rum', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Dunklen Rum für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buygold_rum')
        AddEventHandler('unicorn:Buygold_rum', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 200
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('gold_rum', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Goldenen Rum für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycuracao')
        AddEventHandler('unicorn:Buycuracao', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 75
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('curacao', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Curacao für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buysyrup')
        AddEventHandler('unicorn:Buysyrup', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 20
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('syrup', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Sirup für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buybourbon')
        AddEventHandler('unicorn:Buybourbon', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 105
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('bourbon', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Bourbon für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycachaca')
        AddEventHandler('unicorn:Buycachaca', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 120
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('cachaca', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Cachaca für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buylimeade')
        AddEventHandler('unicorn:Buylimeade', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 75
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('limeade', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Limeade für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buytequila')
        AddEventHandler('unicorn:Buytequila', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 155
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('tequila', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Tequila für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buytriple_sec')
        AddEventHandler('unicorn:Buytriple_sec', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 120
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('triple_sec', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Triple Sec für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycoconut_milk')
        AddEventHandler('unicorn:Buycoconut_milk', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 40
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('coconut_milk', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Kokosmilch für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buypineapple_juice')
        AddEventHandler('unicorn:Buypineapple_juice', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 60
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('pineapple_juice', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Ananassaft für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycoca_cola')
        AddEventHandler('unicorn:Buycoca_cola', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 300
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('cola', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Coca Cola für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buyred_bull')
        AddEventHandler('unicorn:Buyred_bull', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 300
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('red_bull', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Red Bull für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)

        RegisterNetEvent('unicorn:Buycoffee')
        AddEventHandler('unicorn:Buycoffee', function()

            local _source = source
            local xPlayer = ESX.GetPlayerFromId(source)  
            local price = 150
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                if account.money >= price then
                    TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                        inventory.addItem('coffee', 10)
                        account.removeMoney(price)
                        TriggerClientEvent('esx:showNotification', source, "10x Kaffee für " ..price.. " gekauft!")
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, "Firma hat nicht genug Geld")
                end
            end)
        end)
        -------------
        RegisterNetEvent("loaf_vanillaunicorn:purchase_bar")
        AddEventHandler("loaf_vanillaunicorn:purchase_bar", function(purchaseType, item, amount)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return end

            local allowedPurchase = false
            for _, grade in pairs(Config.JobGrades.PurchaseIngredients) do 
                if grade == tonumber(xPlayer.job.grade) then
                    allowedPurchase = true
                    break
                end
            end
            if not allowedPurchase then return end
            if amount < 0 then return end

            if purchaseType == "item" then
                local data = Config.Bar.Items[item]
                if not data then return end
                local price = math.floor(data[2] * amount)
                TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                    if account.money >= price then
                        TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                            inventory.addItem(data[1], amount)
                            account.removeMoney(price)
                            TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["you_purchased"]:format(amount, ESX.GetItemLabel(data[1]), price))
                        end)
                    else
                        TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["company_no_money"])
                    end
                end)
            elseif purchaseType == "bundle" then
                local data = Config.Bar.Cocktails[item]
                if not data then return end
                local price = math.floor(data[2] * amount)
                TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                    if account.money >= price then
                        TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                            inventory.addItem(data[1], amount)
                            account.removeMoney(price)
                            TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["you_purchased"]:format(amount, ESX.GetItemLabel(data[1]), price))
                        end)
                    else
                        TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["company_no_money"])
                    end
                end)
            end
        end)
        RegisterNetEvent("loaf_vanillaunicorn:waren_einlagern")
        AddEventHandler("loaf_vanillaunicorn:waren_einlagern", function(purchaseType, item, amount)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return end

            local allowedPurchase = false
            for _, grade in pairs(Config.JobGrades.PurchaseIngredients) do 
                if grade == tonumber(xPlayer.job.grade) then
                    allowedPurchase = true
                    break
                end
            end
            if not allowedPurchase then return end
            if amount < 0 then return end

            if purchaseType == "item" then
                local data = Config.Bar.Items[item]
                if not data then return end
                TriggerEvent("esx_addonaccount:getSharedAccount", "society_lafam", function(account)
                    if amount >= 1 then
                        TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                            inventory.addItem(data[1], amount)
                        end)
                    else
                        TriggerClientEvent("esx:showNotification", xPlayer.source, "Ungültige Menge")
                    end
                end)
            end
        end)
        -- end of bar

        -- storage
        if esx.inventory == "ox_inventory" then
            exports.ox_inventory:RegisterStash("loaf_vanillaunicorn", "Lafamilia", 200, 100000, false, "lafam")
        end

        lib.RegisterCallback("loaf_vanillaunicorn:get_inventory", function(source, cb)
            cb(ESX.GetPlayerFromId(source).getLoadout(), ESX.GetPlayerFromId(source).inventory)
        end)

        lib.RegisterCallback("loaf_vanillaunicorn:get_storage", function(source, cb, invtype)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return cb({}) end

            if invtype == "items" then
                TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                    cb(inventory.items)
                end)
            elseif invtype == "weapons" then
                TriggerEvent("esx_datastore:getSharedDataStore", "society_lafam", function(store)
                    cb(store.get("weapons") or {})
                end)
            end
        end)

        lib.RegisterCallback("loaf_vanillaunicorn:deposit", function(source, cb, item, amount)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return cb(false) end

            if amount then -- it is an item
                local itemdata = xPlayer.getInventoryItem(item)
                if not itemdata then return cb(false) end
                if itemdata.count < amount then
                    TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["invalid_amount"])
                    return cb(false)
                end
                TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                    xPlayer.removeInventoryItem(item, amount)
                    inventory.addItem(item, amount)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["deposited"]:format(amount, itemdata.label))
                    cb(true)
                end)
            else -- it is a weapon
                TriggerEvent("esx_datastore:getSharedDataStore", "society_lafam", function(datastore)
                    local _, weapon = xPlayer.getWeapon(item)
                    if not weapon then return cb(false) end

                    xPlayer.removeWeapon(item)

                    local weapons = datastore.get("weapons") or {}

                    local found = false
                    for k, v in pairs(weapons) do
                        if v.name == item then
                            v.count = v.count + 1
                            found = true
                            break
                        end
                    end

                    if not found then
                        table.insert(weapons, {
                            name = item,
                            label = weapon.label,
                            count = 1
                        })
                    end

                    datastore.set("weapons", weapons)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["deposited"]:format(1, weapon.label))
                    cb(true)
                end)
            end
        end)

        lib.RegisterCallback("loaf_vanillaunicorn:withdraw", function(source, cb, item, amount)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.job.name ~= "lafam" then return cb(false) end

            if amount then -- it is an item
                TriggerEvent("esx_addoninventory:getSharedInventory", "society_lafam", function(inventory)
                    local itemdata = inventory.getItem(item)
                    if itemdata and itemdata.count >= amount and amount > 0 then
                        if xPlayer.canCarryItem(item, amount) then
                            inventory.removeItem(item, amount)
                            xPlayer.addInventoryItem(item, amount)
                            
                            TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["withdrew"]:format(amount, xPlayer.getInventoryItem(item).label))
                            cb(true)
                        else
                            TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["cant_carry"])
                            cb(false)
                        end
                    else
                        cb(false)
                    end
                end)
            else -- it is a weapon
                TriggerEvent("esx_datastore:getSharedDataStore", "society_unicorn", function(datastore)
                    local weapons = datastore.get("weapons") or {}

                    for k, v in pairs(weapons) do
                        if v.name == item and v.count > 0 then
                            v.count = v.count - 1
                            xPlayer.addWeapon(item, 250)
                        end
                    end
                    
                    datastore.set("weapons", weapons)

                    cb(true)
                end)
            end
        end)
        -- end of storage
    end)
end)

