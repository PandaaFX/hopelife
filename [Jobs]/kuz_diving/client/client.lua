local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
    createBlips()
end)

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local blips = {}
local nearAny = false
local nearAnyStore = false
local nearAnySell = false

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    if job.name ~= 'diver' and Config.diverJobOnly then
        for k, blip in pairs(blips) do
            RemoveBlip(blip)
        end
        blips = {}
    else
        createBlips()
    end
end)

--
-- Debug
--
if Config.Debug then
    ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 400.0, 0)
end

function createBlips()
    Citizen.CreateThread(function()
        if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'diver') or not Config.diverJobOnly then
            for k, loc in pairs(Config.lootLocations) do
                if loc.showOnMap then
                    local blip = AddBlipForCoord(loc.x, loc.y, loc.z)
                    table.insert(blips, blip)
                    SetBlipSprite(blip, 366)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, 0.8)
                    SetBlipColour(blip, 54)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString('[' .. _U('diving') .. '] ' .. loc.name)
                    EndTextCommandSetBlipName(blip)
                end
            end
        end

        if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'diver') or not Config.diverJobOnly then
            if Config.useDivingStores then
                for k, store in pairs(Config.divingStores.locations) do
                    local blip = AddBlipForCoord(store.x, store.y, store.z)
                    table.insert(blips, blip)
                    SetBlipSprite(blip, 366)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, 0.8)
                    SetBlipColour(blip, 29)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(_U('diving_supplies'))
                    EndTextCommandSetBlipName(blip)
                end
            end

            if Config.useSellLocations then
                for k, sell in pairs(Config.sellLocations) do
                    if sell.showOnMap then
                        for m, loc in pairs(sell.locations) do
                            local blip = AddBlipForCoord(loc.x, loc.y, loc.z)
                            table.insert(blips, blip)
                            SetBlipSprite(blip, sell.blipIcon)
                            SetBlipDisplay(blip, 4)
                            SetBlipScale(blip, sell.blipScale)
                            SetBlipColour(blip, sell.blipColor)
                            SetBlipAsShortRange(blip, true)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(sell.name)
                            EndTextCommandSetBlipName(blip)
                        end
                    end
                end
            end
        end
    end)
end
--
-- Diving Stores
--

function openDivingStore()
    ESX.UI.Menu.CloseAll()

    local elements = {}

    for k, v in ipairs(Config.divingStores.items) do
        table.insert(elements, {
            label = (v.label .. ' <span style="color:green;">$' .. v.price .. '</span>'),
            index = k
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'divingStore', {
        title = _U('diving_supplies'),
        align = 'right',
        elements = elements
    }, function(data, menu)
        menu.close()
        TriggerServerEvent('kuz_diving:buy', data.current.index)
    end, function(data, menu)
        menu.close()
    end)
end

function openSell(id)
    ESX.UI.Menu.CloseAll()

    local elements = {}

    for k, v in ipairs(Config.sellLocations[id].items) do
        table.insert(elements, {
            label = (v.label .. ' <span style="color:green;">$' .. v.price .. '</span>'),
            index = k
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'divingStore', {
        title = _U('sell_items') .. Config.sellLocations[id].name,
        align = 'right',
        elements = elements
    }, function(data, menu)
        menu.close()
        TriggerServerEvent('kuz_diving:sell', id, data.current.index)
    end, function(data, menu)
        menu.close()
    end)
end

--
-- Diving Gear
--
local gearApplied = false
local gearQuality
local doingSomething = false
RegisterNetEvent('kuz_diving:applyGear')
AddEventHandler('kuz_diving:applyGear', function(quality)
    gearQuality = quality
    if not doingSomething then
        gearApplied = not gearApplied
        doingSomething = true
        if gearApplied then
            local playerPed = PlayerPedId()
            SetEnableScuba(PlayerPedId(), true)
            if quality == 0 then
                ESX.ShowNotification(_U('equip_diving'))
                SetPedMaxTimeUnderwater(PlayerPedId(), 300.00)
            else
                ESX.ShowNotification(_U('equip_scuba'))
                SetPedMaxTimeUnderwater(PlayerPedId(), 600.00)
            end
            if Config.divingClothing then
                playAnim("mp_safehouseshower@male@", "male_shower_towel_dry_to_get_dressed")
                Citizen.Wait(2400)
                ClearPedTasks(PlayerPedId())
                if quality == 0 then
                    applyDivingClothing()
                else
                    applyScubaClothing()
                end
                doingSomething = false
            end
        else
            takeOffGear()
        end
    end
end)

function takeOffGear()
    ESX.ShowNotification(_U('dequip_gear'))
    playAnim("mp_safehouseshower@male@", "male_shower_towel_dry_to_get_dressed")
    Citizen.Wait(2000)
    doingSomething = false
    ClearPedTasks(PlayerPedId())

    local playerPed = PlayerPedId()
    gearApplied = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    SetEnableScuba(playerPed, false)
    SetPedMaxTimeUnderwater(playerPed, 12.00)
    SetPedWetnessHeight(playerPed, 0.0)
end

function applyDivingClothing()
    local seed = GetPedHairColor(PlayerPedId())
    math.randomseed(seed)

    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            local maleSkin = {
                ['tshirt_1'] = 134, ['tshirt_2'] = 0,
                ['ears_1'] = -1, ['ears_2'] = 0,
                ['torso_1'] = 375, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['arms'] = 7,
                ['pants_1'] = 145, ['pants_2'] = 0,
                ['shoes_1'] = 104, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['glasses_1'] = 32, ['glasses_2'] = 0,
                ['bproof_1'] = 0, ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
        else
            local femaleSkin = {
                ['tshirt_1'] = 265, ['tshirt_2'] = 0,
                ['ears_1'] = -1, ['ears_2'] = 0,
                ['torso_1'] = 313, ['torso_2'] = 10,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['mask_1'] = 187, ['mask_2'] = 0,
                ['arms'] = 10,
                ['pants_1'] = 148, ['pants_2'] = 0,
                ['shoes_1'] = 16, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['glasses_1'] = 32, ['glasses_2'] = 0,
                ['bproof_1'] = 0, ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, femaleSkin)
        end
    end)
end

function applyScubaClothing()
    local seed = GetPedHairColor(PlayerPedId())
    math.randomseed(seed)

    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            local maleSkin = {
                ['tshirt_1'] = 134, ['tshirt_2'] = 0,
                ['ears_1'] = -1, ['ears_2'] = 0,
                ['torso_1'] = 375, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['arms'] = 7,
                ['pants_1'] = 145, ['pants_2'] = 0,
                ['shoes_1'] = 104, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['glasses_1'] = 32, ['glasses_2'] = 0,
                ['bproof_1'] = 0, ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
        else
            local femaleSkin = {
                ['tshirt_1'] = 265, ['tshirt_2'] = 0,
                ['ears_1'] = -1, ['ears_2'] = 0,
                ['torso_1'] = 313, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['arms'] = 10,
                ['pants_1'] = 148, ['pants_2'] = 0,
                ['shoes_1'] = 16, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['glasses_1'] = 32, ['glasses_2'] = 0,
                ['bproof_1'] = 0, ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, femaleSkin)
        end
    end)
end


--
-- Looting
--
local currentSpot
local pickupPoints = {}
local pickupDistances = {}
local pickupCoordsArray = {}
local pickingUp = false

local nearestId
local nearestDistance = 9999.0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (ESX and ESX.PlayerData.job and ESX.PlayerData.job.name == 'diver') or not Config.diverJobOnly then
            _spawnAndPickup()
            _renderStores()
        end
    end
end)

function _renderStores()
    if Config.useDivingStores and nearAnyStore then
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, store in pairs(Config.divingStores.locations) do
            local distance = GetDistanceBetweenCoords(store.x, store.y, store.z, playerCoords)
            if distance < 150 then
                DrawMarker(1, store.x, store.y, store.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.3, 2.3, 0.7, 0, 40, 180, 90, 0, 1, 0, 0)
                if distance < 3 then
                    Draw3DText(store.x, store.y, store.z, _U('open_store'), 4, 0.1, 0.075)
                    if IsControlJustReleased(0, Keys['E']) then
                        openDivingStore()
                    end
                end
            end
        end
    end
    if Config.useSellLocations and nearAnySell then
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, sell in pairs(Config.sellLocations) do
            for m, loc in pairs(sell.locations) do
                local distance = GetDistanceBetweenCoords(loc.x, loc.y, loc.z, playerCoords)
                if distance < 150 then
                    DrawMarker(1, loc.x, loc.y, loc.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.8, 1.8, 0.7, 220, 160, 20, 90, 0, 1, 0, 0)
                    if distance < 3 then
                        Draw3DText(loc.x, loc.y, loc.z, _U('open_sell') .. sell.name, 4, 0.1, 0.075)
                        if IsControlJustReleased(0, Keys['E']) then
                            openSell(k)
                        end
                    end
                end
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        local playerCoords = GetEntityCoords(playerPed)
        nearAny = false
        for k in pairs(Config.lootLocations) do
            local lootLoc = Config.lootLocations[k]
            if GetDistanceBetweenCoords(playerCoords, lootLoc.x, lootLoc.y, lootLoc.z, true) < 200.0 then
                nearAny = true
            end
        end

        nearAnyStore = false
        if Config.useDivingStores then
            for k, loc in pairs(Config.divingStores.locations) do
                local distance = GetDistanceBetweenCoords(loc.x, loc.y, loc.z, playerCoords)
                if distance < 150 then
                    nearAnyStore = true
                end
            end
        end

        nearAnySell = false
        if Config.useSellLocations then
            for k, sell in pairs(Config.sellLocations) do
                for m, loc in pairs(sell.locations) do
                    local distance = GetDistanceBetweenCoords(loc.x, loc.y, loc.z, playerCoords)
                    if distance < 150 then
                        nearAnySell = true
                    end
                end
            end
        end

        if not pickingUp and currentSpot ~= nil and #pickupPoints > 0 and ((ESX and ESX.PlayerData.job and ESX.PlayerData.job.name == 'diver') or not Config.diverJobOnly) then

            nearestDistance = 999.9
            for m, pickup in pairs(pickupPoints) do
                local pickupCoords = GetEntityCoords(pickup)
                local pickupDistance = GetDistanceBetweenCoords(playerCoords, pickupCoords, true)
                pickupCoordsArray[m] = pickupCoords
                pickupDistances[m] = pickupDistance

                if pickupDistance < nearestDistance then
                    nearestDistance = pickupDistance
                    nearestId = m
                end
            end
        end
        Citizen.Wait(500)
    end
end)

local creating = false
function _spawnAndPickup()
    if nearAny then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for k in pairs(Config.lootLocations) do
            local lootLoc = Config.lootLocations[k]
            if GetDistanceBetweenCoords(playerCoords, lootLoc.x, lootLoc.y, lootLoc.z, true) < 200.0 then
                local oldSpot = currentSpot
                currentSpot = k
                if #pickupPoints <= 0 or oldSpot ~= k then
                    if #pickupPoints <= 0 then
                        for m in pairs(pickupPoints) do
                            DeleteObject(pickupPoints[m])
                        end
                        pickupPoints = {}
                    end
                    if not creating then
                        Citizen.CreateThread(function()
                            creating = true
                            Citizen.Wait(1)
                            for i = 1, lootLoc.spotsCount do
                                createLoot(lootLoc, x, y, z)
                            end
                            creating = false
                        end)
                    end
                else
                    if #pickupDistances > 0 then
                        for m, pickup in pairs(pickupPoints) do
                            local pickupDistance = pickupDistances[m]
                            local pickupCoords = pickupCoordsArray[m]
                            if pickupDistance == nil then
                                pickupDistance = 999.9
                            end

                            if pickupDistance < 4.0 and nearestId == m then
                                if not pickingUp then
                                    Draw3DText(pickupCoords.x, pickupCoords.y, pickupCoords.z + 0.2, _U('press_e_loot'), 4, 0.1, 0.075)
                                else
                                    pickupCoords = GetEntityCoords(pickupPoints[m])
                                    Draw3DText(pickupCoords.x, pickupCoords.y, pickupCoords.z + 0.2, _U('collect_progress'), 4, 0.1, 0.075)
                                end
                                if IsControlJustReleased(0, Keys['E']) and not pickingUp then
                                    if lootLoc.requireItem == nil then
                                        startPickup(m)
                                    else
                                        ESX.TriggerServerCallback('kuz_diving:hasItem', function(has)
                                            if has then
                                                startPickup(m)
                                            else
                                                ESX.ShowNotification(_U('cant_open'))
                                            end
                                        end, lootLoc.requireItem)
                                    end
                                end
                            else
                                if pickingUp and nearestId == m then
                                    pickingUp = false
                                end
                            end
                        end
                    end
                end
            else
                if currentSpot == k then
                    if currentSpot ~= nil then
                        currentSpot = nil
                    end
                    if pickingUp then
                        pickingUp = false
                    end
                end
                if #pickupPoints > 0 and currentSpot == k then
                    for m in pairs(pickupPoints) do
                        DeleteObject(pickupPoints[m])
                    end
                    pickupPoints = {}
                end
            end
        end
    end
end

function startPickup(m)
    Citizen.CreateThread(function()
        if not DoesEntityExist(pickupPoints[m]) then
            return
        end
        local playerPed = PlayerPedId()
        pickingUp = true
        pickingUpId = m
        local lootLoc = Config.lootLocations[currentSpot]
        if lootLoc.animation ~= nil and lootLoc.animationDict ~= nil then
            if lootLoc.animationDict == 'Scenario' then
                TaskStartScenarioInPlace(playerPed, lootLoc.animation, 0, true)
            else
                playAnim(lootLoc.animationDict, lootLoc.animation)
            end
        else
            playAnim("mp_take_money_mg", "put_cash_into_bag_loop")
        end
        FreezeEntityPosition(PlayerPedId(), true)
        Citizen.Wait(math.random(4000, 7000))
        pickingUp = false
        nearestId = nil
        nearestDistance = 9999.0
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        pickupPickup(m)
    end)
end

function createLoot(lootLoc, x_, y_, z_)
    if #pickupPoints < lootLoc.spotsCount then
        local x, y, z
        if x_ ~= nil then
            x = x_
            y = y_
            z = z_
        else
            x = math.random(-lootLoc.radius, lootLoc.radius) + lootLoc.x
            y = math.random(-lootLoc.radius, lootLoc.radius) + lootLoc.y
            waste, z = GetGroundZFor_3dCoord(x, y, 999.0, false)
        end

        if z >= -0.5 and not Config.Debug then
            Citizen.CreateThread(function()
                Citizen.Wait(5000)
                createLoot(lootLoc)
            end)
            return
        end

        local random = math.random(1, #lootLoc.models)
        local hash = GetHashKey(lootLoc.models[random])
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end

        local object = CreateObject(hash, x, y, z + 0.5, false, false, true)
        ApplyForceToEntityCenterOfMass(object, 0, 1.0, 1.0, 1.0, true, true, false)
        SetObjectPhysicsParams(object, 100.0, 2.0, 2.0, 0.0, 0.0)
        table.insert(pickupPoints, object)
    end
end

function createNewLoot()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local lootLoc = Config.lootLocations[currentSpot]
        local x = math.random(-lootLoc.radius, lootLoc.radius) + lootLoc.x
        local y = math.random(-lootLoc.radius, lootLoc.radius) + lootLoc.y
        local waste, z = GetGroundZFor_3dCoord(x, y, 999.0, false)

        if GetDistanceBetweenCoords(playerCoords, x, y, z, true) < lootLoc.radius / 3 then
            createNewLoot()
        else
            createLoot(lootLoc, x, y, z)
        end
    end)
end

function pickupPickup(m)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        FreezeEntityPosition(playerPed, false)
        local playerCoords = GetEntityCoords(playerPed)
        local pickupCoords = GetEntityCoords(pickupPoints[m])
        local pickupDistance = GetDistanceBetweenCoords(playerCoords, pickupCoords, true)
        if pickupDistance < 4.0 then
            DeleteObject(pickupPoints[m])
            table.remove(pickupPoints, m)
            Citizen.Wait(10)
            createNewLoot()
            TriggerServerEvent('kuz_diving:getLoot', playerCoords)
        end
        pickingUp = false
    end)
end


--
-- Helpers
--
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function playAnim(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, 5.0, 17, 0, true, true, false)
    RemoveAnimDict(dict)
end

Citizen.CreateThread(function()
    while true do
        local sleep = 6000
        local playedPed = PlayerPedId()
        if gearApplied and IsPedSwimmingUnderWater(playedPed) then
            local time = math.floor(GetPlayerUnderwaterTimeRemaining(PlayerId()))
            if time < 600 then
                if time < 0 then
                    time = 0
                end
				
                sleep = 0
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.3)
                if time > 30 then
                    SetTextColour(220, 160, 5, 140)
                else
                    SetTextColour(220, 0, 5, 140)
                end
                SetTextCentre(true)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(('Sauerstoff') .. ' ' .. math.floor(time/6) .. ' ' .. ('%'))
                DrawText(0.5, 0.007)
            end
        end

        Citizen.Wait(sleep)
    end
end)