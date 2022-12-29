ESX = exports["es_extended"]:getSharedObject()

local currentBag, currentBagWeight = nil, nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
    CreateThread(function()
        while not ESX.IsPlayerLoaded() do 
            debug('Player not loaded, wait...')
            Wait(100)
        end
    end)

    Wait(1000) -- Please Do Not Touch!
    
    if ESX.IsPlayerLoaded() then
        debug('Player loaded')
        ESX.TriggerServerCallback('msk_backpack:getPlayerSkin', function(skin)
            for k, v in pairs(Config.Backpacks) do
                if skin.sex == 0 then -- Male
                    if skin.bags_1 == v.skin.male.skin1 then -- Bag Skin
                        debug(skin.bags_1, v.skin.male.skin1, v.weight)
                        currentBag = k
                        currentBagWeight = v.weight

                        if Config.BagInventory:match('expand') then
                            TriggerServerEvent('msk_backpack:setJoinBag', k, v.weight)
                        end
                    end
                else -- Female
                    if skin.bags_1 == v.skin.female.skin1 then -- Bag Skin
                        debug(skin.bags_1, v.skin.female.skin1, v.weight)
                        currentBag = k
                        currentBagWeight = v.weight

                        if Config.BagInventory:match('expand') then
                            TriggerServerEvent('msk_backpack:setJoinBag', k, v.weight)
                        end
                    end
                end
            end
        end, GetPlayerServerId(PlayerId()))
    else
        debug('xPlayer not found on Event: playerLoaded')
    end
end)

RegisterNetEvent('msk_backpack:setBackpack')
AddEventHandler('msk_backpack:setBackpack', function(itemname, item)
    debug('itemname:', itemname)
    local playerPed = PlayerPedId()
    currentBag = itemname
    currentBagWeight = item.weight

    doAnimation(playerPed)

    ESX.TriggerServerCallback('msk_backpack:getPlayerSkin', function(skin)
        if skin.sex == 0 then -- Male
            if Config.FiveMAppearance then
                SetPedComponentVariation(playerPed, 5, item.skin.male.skin1, item.skin.male.skin2)
            else
                TriggerEvent('skinchanger:change', "bags_1", item.skin.male.skin1)
                TriggerEvent('skinchanger:change', "bags_2", item.skin.male.skin2)
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('msk_backpack:save', skin)
                end)
            end
        else -- Female
            if Config.FiveMAppearance then
                SetPedComponentVariation(playerPed, 5, item.skin.female.skin1, item.skin.female.skin2)
            else
                TriggerEvent('skinchanger:change', "bags_1", item.skin.female.skin1)
                TriggerEvent('skinchanger:change', "bags_2", item.skin.female.skin2)
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('msk_backpack:save', skin)
                end)
            end
        end
    end, GetPlayerServerId(PlayerId()))

    ESX.ShowNotification(_U('used_bag'))
end)

RegisterNetEvent('msk_backpack:delBackpack')
AddEventHandler('msk_backpack:delBackpack', function()
    debug('Trigger Event delBackpack')
    local playerPed = PlayerPedId()
    currentBag = nil
    currentBagWeight = nil

    doAnimation(playerPed)

    ESX.TriggerServerCallback('msk_backpack:getPlayerSkin', function(skin)
        if Config.useParachute then
            if skin.bags_1 ~= 63 then -- Parachute Skin - esx_parachute by me :)
                if Config.FiveMAppearance then
                    SetPedComponentVariation(playerPed, 5, 0, 0)
                else
                    TriggerEvent('skinchanger:change', "bags_1", 0)
                    TriggerEvent('skinchanger:change', "bags_2", 0)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerServerEvent('msk_backpack:save', skin)
                    end)
                end
                debug('Set Backpack to 0')
            end
        else
            if Config.FiveMAppearance then
                SetPedComponentVariation(playerPed, 5, 0, 0)
            else
                TriggerEvent('skinchanger:change', "bags_1", 0)
                TriggerEvent('skinchanger:change', "bags_2", 0)
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('msk_backpack:save', skin)
                end)
            end
            debug('Set Backpack to 0')
        end
    end, GetPlayerServerId(PlayerId()))

    ESX.ShowNotification(_U('used_nobag'))
end)

RegisterNetEvent('msk_backpack:delBackpackDeath')
AddEventHandler('msk_backpack:delBackpackDeath', function()
    debug('Trigger Event delBackpack after Death')
    local playerPed = PlayerPedId()
    currentBag = nil
    currentBagWeight = nil

    if Config.FiveMAppearance then
        SetPedComponentVariation(playerPed, 5, 0, 0)
    else
        TriggerEvent('skinchanger:change', "bags_1", 0)
        TriggerEvent('skinchanger:change', "bags_2", 0)
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('msk_backpack:save', skin)
        end)
    end
    debug('Set Backpack to 0')
    TriggerEvent("inventory:refresh")
end)

if Config.BagInventory:match('secondary') then
    RegisterCommand('openbag', function()
        local hasBackpack = false

        ESX.TriggerServerCallback('msk_backpack:getPlayerSkin', function(skin)
            if not IsPlayerDead(PlayerId()) then
                for k, v in pairs(Config.Backpacks) do
                    if skin.sex == 0 then -- Male
                        if skin.bags_1 == v.skin.male.skin1 then -- Bag Skin
                            hasBackpack = true
                        end
                    else -- Female
                        if skin.bags_1 == v.skin.female.skin1 then -- Bag Skin
                            hasBackpack = true
                        end
                    end
                end

                if hasBackpack then
                    ESX.TriggerServerCallback('msk_backpack:getUserData', function(name, identifier)
                        TriggerEvent('inventory:openInventory', {
                            type = currentBag,
                            id = identifier,
                            title = '🎒 '.. name,
                            weight = currentBagWeight,
                            delay = 150,
                            save = true
                        })
                    end)
                else
                    ESX.ShowNotification(_U('noBag'))
                end
            else
                ESX.ShowNotification(_U('youre_dead'))
            end
        end, GetPlayerServerId(PlayerId()))
    end)

    RegisterCommand('stealbag', function()
        local player, playerDistance = ESX.Game.GetClosestPlayer()
    
        if player ~= -1 and playerDistance <= 3.0 then
            local playerPed = GetPlayerPed(player)
            local hasBackpack = false
                    
            if DoesEntityExist(playerPed) then
                ESX.TriggerServerCallback('msk_backpack:getPlayerSkin', function(skin)
                    for k, v in pairs(Config.Backpacks) do
                        if skin.sex == 0 then -- Male
                            if skin.bags_1 == v.skin.male.skin1 then -- Bag Skin
                                hasBackpack = true
                            end
                        else -- Female
                            if skin.bags_1 == v.skin.female.skin1 then -- Bag Skin
                                hasBackpack = true
                            end
                        end
                    end

                    if hasBackpack then
                        ESX.TriggerServerCallback('msk_backpack:getTargetData', function(name, identifier)
                            if IsEntityDead(playerPed) then
                                if Config.StealBagIfDead then
                                    TriggerServerEvent('msk_backpack:updateStealInventoryBag', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                                        
                                    TriggerEvent('inventory:openInventory', {
                                        type = currentBag,
                                        id = identifier,
                                        title = '🎒 '.. name,
                                        weight = currentBagWeight,
                                        delay = 150,
                                    })
            
                                    LoadAnimDict("random@mugging5", function()
                                        TaskPlayAnim(PlayerPedId(), "random@mugging5", "ig_1_guy_handoff", 8.0, 8.0, -1, 50, 0, false, false, false)
                                        Wait(2000)
                                        ClearPedTasks(PlayerPedId())
                                    end) 
                                else
                                    ESX.ShowNotification(_U('entity_dead'))
                                end
                            else 
                                if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_enter", 3) then
                                    TriggerServerEvent('msk_backpack:updateStealInventoryBag', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                                        
                                    TriggerEvent('inventory:openInventory', {
                                        type = currentBag,
                                        id = identifier,
                                        title = '🎒 '.. name,
                                        weight = currentBagWeight,
                                        delay = 150,
                                    })
        
                                    LoadAnimDict("random@mugging5", function()
                                        TaskPlayAnim(PlayerPedId(), "random@mugging5", "ig_1_guy_handoff", 8.0, 8.0, -1, 50, 0, false, false, false)
                                        Wait(2000)
                                        ClearPedTasks(PlayerPedId())
                                    end) 
                                else 
                                    ESX.ShowNotification(_U('not_handsup'))
                                end 
                            end
                        end, GetPlayerServerId(player))
                    else
                        ESX.ShowNotification(_U('player_noBag'))
                    end
                end, GetPlayerServerId(player))
    
                while true do 
                    Wait(1)
                    player, playerDistance = ESX.Game.GetClosestPlayer()
    
                    if playerDistance > 3.0 then 
                        TriggerEvent('inventory:close')
                        break
                    end
                end
            end
        else 
            ESX.ShowNotification(_U('no_player_nearby'))
        end
    end)
end

function doAnimation(playerPed)
    ESX.Streaming.RequestAnimDict(Config.Animations.dict, function()
		TaskPlayAnim(playerPed, Config.Animations.dict, Config.Animations.anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(Config.Animations.dict)
	end)
	Wait(Config.Animations.time * 1000)
	ClearPedTasks(playerPed)
end

function debug(msg, msg2, msg3)
	if Config.Debug then
        if msg3 then
            print(msg, msg2, msg3)
        elseif not msg3 and msg2 then
            print(msg, msg2)
        else
		    print(msg)
        end
	end
end