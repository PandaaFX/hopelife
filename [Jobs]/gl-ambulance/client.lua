ESX                             = nil
local medBag
local droppedBag = false
local isShot = false
local isMeleed = false
local isBurned = false
local isDead = false
local curWound = nil
local stretcher
local vehicle
local emsCount = 0
local npc
local npc2
local pedSpawned = false
local pedSpawned2 = false
local grandmaSpawned = false
local grandma





Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if ESX ~= nil then
            PlayerData = ESX.GetPlayerData()
            if PlayerData.job ~= nil then
                PlayerJob = PlayerData.job.name
            end

        else
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end

    end
end)



_menuPool = NativeUI.CreatePool()
medbagMenu = NativeUI.CreateMenu("Medbag", "Medbag Menu")
stretchMenu = NativeUI.CreateMenu("Stretch", "Stretch Menu")
nancyMenu = NativeUI.CreateMenu("Nancy", "Nancy Menu")
_menuPool:Add(medbagMenu)
_menuPool:Add(stretchMenu)
_menuPool:Add(nancyMenu)

function medbagMenuF(menu)
    local click = NativeUI.CreateItem("Aufnehmen", "Tasche aufnehmen")
    menu:AddItem(click)
    local click2 = NativeUI.CreateItem("Tasche benutzen", "Tasche verwenden")
    menu:AddItem(click2)
    local exit = NativeUI.CreateItem('Verlassen', 'Das Menü verlassen')
    menu:AddItem(exit)
    menu.OnItemSelect = function(sender, item, index)
      if item == click then
        TriggerEvent('gl-ambulance:exitMenu:medbagMenu')
        TriggerEvent('gl-ambulance:pickUpBag')
      end
      if item == click2 then
        TriggerEvent('gl-ambulance:exitMenu:medbagMenu')
        TriggerEvent('gl-ambulance:interactBag')
      end
      if item == exit then
        TriggerEvent('gl-ambulance:exitMenu:medbagMenu')
      end
    end
end

function stretchMenuF(menu)
    local click = NativeUI.CreateItem("Hinlegen", "Auf die Trage legen")
    menu:AddItem(click)
    local click2 = NativeUI.CreateItem("Aufstehen", "Von der Trage aufstehen")
    menu:AddItem(click2)
    local click3 = NativeUI.CreateItem("Trage schieben", "Trage schieben")
    menu:AddItem(click3)
    local click4 = NativeUI.CreateItem("Trage entfernen", "Trage entfernen")
    menu:AddItem(click4)
    local click5 = NativeUI.CreateItem("Patient von Trage entfernen", "Patient von Trage entfernen")
    menu:AddItem(click5)
    local exit = NativeUI.CreateItem('Exit', 'Exit the menu')
    menu:AddItem(exit)
    menu.OnItemSelect = function(sender, item, index)
        if item == click then
            TriggerEvent('gl-ambulance:exitMenu:stretchMenu')
            TriggerEvent('gl-ambulance:laydown')
        end
        if item == click2 then
            TriggerEvent('gl-ambulance:exitMenu:stretchMenu')
            TriggerEvent('gl-ambulance:getup')
        end
        if item == click3 then
            TriggerEvent('gl-ambulance:exitMenu:stretchMenu')
            TriggerEvent('gl-ambulance:push')
        end
        if item == click4 then
            TriggerEvent('gl-ambulance:exitMenu:stretchMenu')
            TriggerEvent('gl-ambulance:delStretcherC')
        end
        if item == click5 then
            TriggerEvent('gl-ambulance:exitMenu:stretchMenu')
            TriggerEvent('gl-ambulance:getupCKICK')
        end
        if item == exit then
            TriggerEvent('gl-ambulance:exitMenu:stretchMenu')
        end
    end
end

function nancyMenuF(menu)
    local click = NativeUI.CreateItem("Patienten einchekcen", "Im Krankenhaus einchecken")
    menu:AddItem(click)
    local exit = NativeUI.CreateItem('Exit', 'aus dem Menü')
    menu:AddItem(exit)
    menu.OnItemSelect = function(sender, item, index)
        if item == click then
            TriggerEvent('gl-ambulance:exitMenu:nancyMenu')
            TriggerEvent('gl-ambulance:checkInNancyC')
        end
        if item == exit then
            TriggerEvent('gl-ambulance:exitMenu:nancyMenu')
        end
    end
end

medbagMenuF(medbagMenu)
stretchMenuF(stretchMenu)
nancyMenuF(nancyMenu)
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled(false)
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)







Citizen.CreateThread(function()
    while true do
    local sleep = 1000
    local PlayerPed = PlayerPedId()
    local PlayerPos = GetEntityCoords(PlayerPed)
    --   local npcdist = #(PlayerPos - 
    --   vector3(Config.umBM["loc"].x,Config.umBM["loc"].y,Config.umBM["loc"].z))
    -- local hit, coords, entity = RayCastGamePlayCamera(20.0)

    local getclosestobj = GetClosestObjectOfType(PlayerPos, 1.5, GetHashKey("xm_prop_x17_bag_med_01a"), false, false, false)
    local getclosestobj2 = GetClosestObjectOfType(PlayerPos, 1.0, GetHashKey("prop_ld_binbag_01"), false, false, false)
    -- local getclosestobj3 = GetClosestObjectOfType(PlayerPos, 2, npc, false, false, false)
    -- print(getclosestobj3, npc)


        -- NANCY
    local NPCspawnCoords = Config.NancyPos
    local NancyPosdst = #(NPCspawnCoords - PlayerPos)
    local NPCspawnCoords2 = Config.NancyPos2
    local NancyPosdst2 = #(NPCspawnCoords2 - PlayerPos)
        -- NANCY


    -- print(getclosestobj, GetEntityModel(getclosestobj))
    -- print(GetEntityType(getclosestobj2), getclosestobj2, GetEntityModel(getclosestobj2), GetHashKey("prop_ld_binbag_01"))

    -- print(#(PlayerPos - coords), GetEntityType(entity))
    -- print(GetEntityCoords(entity))

    if ESX ~= nil then
        if getclosestobj ~= 0 then
            sleep = 1000
            if GetEntityType(getclosestobj) ~= 0 and not isDead then
                if GetEntityModel(getclosestobj) == GetHashKey("xm_prop_x17_bag_med_01a") and droppedBag == true  then
                    ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ das Menü zu öffnen')
                    sleep = 1
                        if IsControlJustPressed(0, 38) then
                        -- TriggerEvent('um-bm:client:menu')
                            DisableControlAction(0, 194, true)
                            DisableControlAction(0, 199, true)
                            DisableControlAction(0, 322, true)
                            medbagMenu:Visible(not medbagMenu:Visible())
                        end
                end




            end
        elseif getclosestobj2 ~= 0 then
            if GetEntityType(getclosestobj2) ~= 0 and not isDead then
                if GetEntityModel(getclosestobj2) == GetHashKey("prop_ld_binbag_01") then
                    ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ das Menü zu öffnen')
                    sleep = 1
                        if IsControlJustPressed(0, 38) then
                            DisableControlAction(0, 194, true)
                            DisableControlAction(0, 199, true)
                            DisableControlAction(0, 322, true)
                            stretchMenu:Visible(not stretchMenu:Visible())
                        end
                end
            end
        elseif (NancyPosdst <= 2.0 or NancyPosdst2 <= 2.0) and (PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd') and not isDead then
            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ das Menü zu öffnen')
            sleep = 1
                if IsControlJustPressed(0, 38) then
                    DisableControlAction(0, 194, true)
                    DisableControlAction(0, 199, true)
                    DisableControlAction(0, 322, true)
                    nancyMenu:Visible(not nancyMenu:Visible())
                end
        else
            medbagMenu:Visible(false)
            stretchMenu:Visible(false)
            nancyMenu:Visible(false)
        end
    end
    Citizen.Wait(sleep)
    _menuPool:ProcessMenus()
    end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('gl-ambulance:exitMenu:stretchMenu')
AddEventHandler('gl-ambulance:exitMenu:stretchMenu', function()
    stretchMenu:Visible(not stretchMenu:Visible())
    EnableControlAction(0, 194, true)
    EnableControlAction(0, 199, true)
    EnableControlAction(0, 322, true)
end)

RegisterNetEvent('gl-ambulance:exitMenu:medbagMenu')
AddEventHandler('gl-ambulance:exitMenu:medbagMenu', function()
    medbagMenu:Visible(not medbagMenu:Visible())
    EnableControlAction(0, 194, true)
    EnableControlAction(0, 199, true)
    EnableControlAction(0, 322, true)
end)

RegisterNetEvent('gl-ambulance:exitMenu:nancyMenu')
AddEventHandler('gl-ambulance:exitMenu:nancyMenu', function()
    nancyMenu:Visible(not nancyMenu:Visible())
    EnableControlAction(0, 194, true)
    EnableControlAction(0, 199, true)
    EnableControlAction(0, 322, true)
end)

CreateThread(function()
    local hospitalBlip = AddBlipForCoord(Config.HospitalBlipCoords)

    SetBlipSprite(hospitalBlip, 61)
    SetBlipScale(hospitalBlip, 1.0)
    SetBlipColour(hospitalBlip, 1)
    SetBlipAsShortRange(hospitalBlip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('LSMD')
    EndTextCommandSetBlipName(hospitalBlip)

    -- local medical = {`xm_prop_x17_bag_med_01a`}

        -- exports['bt-target']:AddTargetModel(medical, {
        --     options = {
        --         {
        --             event = "gl-ambulance:pickUpBag",
        --             icon = "fas fa-hand-paper",
        --             label = 'Pick Up',
        --         },
        --         {
        --             event = "gl-ambulance:interactBag",
        --             icon = "fas fa-hand-paper",
        --             label = 'Interact',
        --         },
    
        --     },
        --     job = {"all"},
        --     distance = 1.5
        -- })

-- local stretch = { `prop_ld_binbag_01`}

--         exports['bt-target']:AddTargetModel(stretch, {
--             options = {
--                 {
--                     event = "gl-ambulance:LayDown",
--                     icon = "fas fa-bed",
--                     label = 'Lay Down',
--                 },
    
--             },
--             job = {"all"},
--             distance = 1.5
--         })
end)

RegisterNetEvent('gl-ambulance:restockEMS',function()
    local restockEMS = {}
        for k, v in pairs(Config.Restock) do
            table.insert(restockEMS, 
            {
                id = k,
                header = 'Restock Equipment',
                txt = '1x ' .. v.label,
                params = {
                    event = 'gl-ambulance:getItem',
                    args = {
                        item = v.item,
                    }                
                }
            })
        end
        TriggerEvent('nh-context:sendMenu', restockEMS)
end)

RegisterNetEvent('gl-ambulance:openBossMenu',function()
    TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
        menu.close()
    end)

end)

RegisterNetEvent('gl-ambulance:interactBag',function()
    if PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd' then
        TriggerEvent('nh-context:sendMenu', {
            {
                id = 1,
                header = "Mediziner Tasche",
                txt = "Eingelagerte Items:"
            },
            {
                id = 2,
                header = "Zange",
                txt = "Um Kugeln zu entfernen",
                params = {
                    event = "gl-ambulance:getItem",
                    args = {
                        item = 'tweezers'
    
                    }    
                }
            },
            {
                id = 3,
                header = "Nähset" ,
                txt = "Wunden nähen",
                params = {
                    event = "gl-ambulance:getItem",
                    args = {
                        item = 'suturekit'
                    }
                }
            },
    
            {
                id = 4,
                header = "Verbrennungscreme",
                txt = "Für intime Anwendungen",
                params = {
                    event = "gl-ambulance:getItem",
                    args = {
                        item = 'burncream'
    
                    }
                }
            },
    
            {
                id = 5,
                header = "Defibrillator",
                txt = "Um den Herzschlag wiederherzustellen",
                params = {
                    event = "gl-ambulance:getItem",
                    args = {
                        item = 'defib'
    
                    }
                }
            },
            {
                id = 6,
                header = "Sedativum",
                txt = "Örtliche Betäubung",
                params = {
                    event = "gl-ambulance:getItem",
                    args = {
                        item = 'sedative'
    
                    }
                }
            },
            {
                id = 7,
                header = "Medizinische Trage",
                txt = "Trage",
                params = {
                    event = "gl-ambulance:getItem",
                    args = {
                        item = 'stretcher'
    
                    }
                }
            },
        
        })
    end
end)

RegisterNetEvent('gl-ambulance:getItem',function(data)
    TriggerServerEvent('gl-ambulance:getItemForEMS',data.item)    
end)

RegisterNetEvent('gl-ambulance:pickUpBag',function()
    -- Do Animation Later Dummy
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("xm_prop_x17_bag_med_01a"), false)
    local objCoords = GetEntityCoords(closestObject)
    DeleteEntity(closestObject)
    TriggerServerEvent('gl-ambulance:getItemForEMS','medbag')
    -- if PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd' then
    --     TriggerServerEvent('gl-ambulance:getItemForEMS','medbag')
    -- else
    --     TriggerServerEvent('gl-ambulance:getItemForEMS','bandage')
    -- end
    droppedBag = false
    TriggerServerEvent("gl-ambulance:deleteBag", ObjToNet(closestObject))
end)

RegisterNetEvent('gl-ambulance:deleteBag', function(netId)
    if DoesEntityExist(NetToObj(netId)) then
        DeleteObject(NetToObj(netId))
    end   
end)

RegisterNetEvent('gl-ambulance:tryTreatingPlayer',function(wound)
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        playerID = GetPlayerServerId(player)
        TriggerServerEvent('gl-ambulance:checkPlayerWounds',playerID,wound)
    end
end)

RegisterNetEvent('gl-ambulance:checkPlayerWounds',function(player,wound)
    -- print(curWound, wound)
    if curWound == wound then
        TriggerServerEvent('gl-ambulance:treatPlayerWounds',player,curWound)
    end
end)

RegisterNetEvent('gl-ambulance:useStretcher',function()
local hash = GetHashKey('prop_ld_binbag_01')
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,3.0,0.5))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    stretcher = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    LoadAnimDict("anim@heists@box_carry@")

    AttachEntityToEntity(stretcher, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.9, -0.52, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

    while IsEntityAttachedToEntity(stretcher, PlayerPedId()) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(stretcher, true, true)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(stretcher, true, true)
            FreezeEntityPosition(stretcher,true)
            ClearPedTasksImmediately(ped)
        end
    end
end)

RegisterNetEvent('gl-ambulance:delStretcherC',function()
    -- print('delStretcher')
    if PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd' then
        local pedCoords = GetEntityCoords(PlayerPedId())
        local closestObject = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            TriggerServerEvent('gl-ambulance:delStretcher',ObjToNet(closestObject))
        end
    end
end)

RegisterNetEvent('gl-ambulance:delStretcher',function(netId)
    if DoesEntityExist(NetToObj(netId)) then
        DeleteObject(NetToObj(netId))
    end  
end)

RegisterCommand('takeout',function()
    local hash = GetHashKey('prop_ld_binbag_01')
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,3.0,0.5))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    stretcher = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    LoadAnimDict("anim@heists@box_carry@")

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

        local player, distance = ESX.Game.GetClosestPlayer()
        if distance ~= -1 and distance <= 5.0 then
            TriggerServerEvent('gl-ambulance:getOutVehicle', GetPlayerServerId(player))
        end


    AttachEntityToEntity(stretcher, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.9, -0.52, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

    while IsEntityAttachedToEntity(stretcher, PlayerPedId()) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(stretcher, true, true)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(stretcher, true, true)
            FreezeEntityPosition(stretcher,true)
        end
    end

end)

RegisterNetEvent('gl-ambulance:getOutVehicle',function()

    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
        return
    end
    local vehicle = GetVehiclePedIsIn(ped, false)
    TaskLeaveVehicle(ped, vehicle, 16)
    Wait(500)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey("prop_ld_binbag_01"), false)
    local objCoords = GetEntityCoords(closestObject)
    LoadAnimDict("anim@gangops@morgue@table@")
    TaskPlayAnim(PlayerPedId(), "anim@gangops@morgue@table@", "body_search", 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    AttachEntityToEntity(PlayerPedId(), closestObject, 0, 0, 0.0, 1.0, 195.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
end)


RegisterNetEvent('gl-ambulance:push',function()
    if PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd' then

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(PlayerPedId())
        local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_ld_binbag_01"), false)
        local objCoords = GetEntityCoords(closestObject)
        LoadAnimDict("anim@heists@box_carry@")

        AttachEntityToEntity(closestObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.9, -0.52, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

        while IsEntityAttachedToEntity(closestObject, PlayerPedId()) do
            Citizen.Wait(5)

            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
            end

            if IsPedDeadOrDying(PlayerPedId()) then
                DetachEntity(closestObject, true, true)
            end

            if IsControlJustPressed(0, 73) then
                DetachEntity(closestObject, true, true)
                FreezeEntityPosition(closestObject,true)
                ClearPedTasksImmediately(ped)
            end
        end

    end

end)

-- RegisterCommand('emsveh',function()
--     local ped = PlayerPedId()
--     local pCoords = GetEntityCoords(ped)
--     local dst = #(pCoords - Config.HospitalCoords)
--     if dst < 100 or IsEntityInWater(ped) then
--     local vehicleCat = {}
--         for k, v in pairs(Config.EMSVehicles) do
--             table.insert(vehicleCat, 
--             {
--                 id = k,
--                 header = 'Pull Out Vehicle',
--                 txt = 'Vehicle: ' .. v.label,
--                 params = {
--                     event = 'gl-ambulance:spawnVehicle',
--                     args = {
--                         spawnName = v.spawnName,
--                         spawnLoc = v.spawnLoc
--                     }                
--                 }
--             })
--         end
--         TriggerEvent('nh-context:sendMenu', vehicleCat)
--     end
-- end)

RegisterNetEvent('gl-ambulance:spawnVehicle',function(data)
    local coords = data.spawnLoc

    local ModelHash = data.spawnName -- Use Compile-time hashes to get the hash of this model
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) -- Request the model
    while not HasModelLoaded(ModelHash) do -- Waits for the model to load with a check so it does not get stuck in an infinite loop
      Citizen.Wait(10)
    end
    if coords == 'atPlayer' then
        x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,4.0,0.5))
        local emsCar = CreateVehicle(ModelHash, x,y,z,0, true, false) -- Spawns a networked vehicle on your current coords
    else
        local emsCar = CreateVehicle(ModelHash, coords.x,coords.y,coords.z,coords.w, true, false) -- Spawns a networked vehicle on your current coords
    end
    SetModelAsNoLongerNeeded(ModelHash) -- removes model from game memory as we no longer need it

end)


RegisterCommand('putonstretcher',function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('gl-ambulance:putOnStretcher', GetPlayerServerId(player))
    end
end)

RegisterNetEvent('gl-ambulance:getup',function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_ld_binbag_01"), false)
    local objCoords = GetEntityCoords(closestObject)
    local dst = #(pedCoords - objCoords)
    DetachEntity(PlayerPedId())
    ClearPedTasksImmediately(ped)
    -- if dst < 1 then
    -- end
end)

RegisterNetEvent('gl-ambulance:getupCKICK', function()
    if PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd' then
        local player, distance = ESX.Game.GetClosestPlayer()
        if distance ~= -1 and distance <= 2.0 then
            TriggerServerEvent('gl-ambulance:getupKICK', GetPlayerServerId(player))
        end
    end
end)

RegisterNetEvent('gl-ambulance:getupKICK', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_ld_binbag_01"), false)
    local objCoords = GetEntityCoords(closestObject)
    local dst = #(pedCoords - objCoords)
    DetachEntity(PlayerPedId())
    ClearPedTasksImmediately(ped)
end)

RegisterNetEvent('gl-ambulance:putOnStretcher',function()
    if isDead then
        local pedCoords = GetEntityCoords(PlayerPedId())
        local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_ld_binbag_01"), false)
        local objCoords = GetEntityCoords(closestObject)
        LoadAnimDict("anim@gangops@morgue@table@")
        TaskPlayAnim(PlayerPedId(), "anim@gangops@morgue@table@", "body_search", 8.0, 8.0, -1, 33, 0, 0, 0, 0)
        AttachEntityToEntity(PlayerPedId(), closestObject, 0, 0, 0.0, 1.0, 195.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
    end
end)


RegisterNetEvent('gl-ambulance:laydown',function()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_ld_binbag_01"), false)
    local objCoords = GetEntityCoords(closestObject)
    LoadAnimDict("anim@gangops@morgue@table@")
    TaskPlayAnim(PlayerPedId(), "anim@gangops@morgue@table@", "body_search", 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    AttachEntityToEntity(PlayerPedId(), closestObject, 0, 0, 0.0, 1.0, 195.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
    --Wait(15000)
    --DetachEntity(PlayerPedId())

end)


RegisterNetEvent('gl-ambulance:useMedBag',function()
    local hash = GetHashKey('xm_prop_x17_bag_med_01a')
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,3.0,0.5))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    medBag = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(medBag, ped, GetPedBoneIndex(ped, 57005), 0.42, 0, -0.05, 0.10, 270.0, 60.0, true, true, false, true, 1, true)
    iHasDaBag()
end)

RegisterNetEvent('gl-ambulance:treatAnimations',function(wound)

    -- Change Animations later
    if wound == 'bullet' then
        LoadAnimDict("mini@repair") 
        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
        Wait(3000)
        ClearPedTasks(PlayerPedId())
    elseif wound == 'stitch' then
        LoadAnimDict("mini@repair") 
        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
        Wait(3000)
        ClearPedTasks(PlayerPedId())
    elseif wound == 'burn' then
        LoadAnimDict("mini@repair") 
        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
        Wait(3000)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent('gl-ambulance:treatTargetWound',function(wound)
    -- Find better way to do this later
    if wound == 'bullet' then
        TriggerEvent('gl-ambulance:treatBulletWound')
    elseif wound == 'stitch' then
        TriggerEvent('gl-ambulance:treatDeepWound')
    elseif wound == 'burn' then
        TriggerEvent('gl-ambulance:treatBurnWound')
    end
end)


RegisterNetEvent('gl-ambulance:treatBulletWound',function()
    if isShot then
        -- Add Animation Stuff
        isShot = false
        curWound = nil
    end
end)

RegisterNetEvent('gl-ambulance:treatDeepWound',function()
    if isMeleed then
        -- Add Animation Stuff
        isMeleed = false
        curWound = nil
    end
end)

RegisterNetEvent('gl-ambulance:treatBurnWound',function()
    if isBurned then
        -- Add Animation Stuff
        isBurned = false
        curWound = nil
    end
end)


RegisterNetEvent('gl-ambulance:tryRevivePlayer',function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        if PlayerJob == 'ambulance' or PlayerJob == 'police' or PlayerJob == 'fib' or PlayerJob == 'lssd' then
            playerID = GetPlayerServerId(player)
            -- LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
            -- TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
            ExecuteCommand("e cpr")
            Wait(5000)
            ExecuteCommand("e c")
            TriggerServerEvent('gl-ambulance:revivePlayer',playerID)
        else
            local doMath = math.random(1,100)
            if doMath <= 20 then
                playerID = GetPlayerServerId(player)
                -- LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
                -- TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
            ExecuteCommand("e cpr")
                
                Wait(5000)
            ExecuteCommand("e c")
            TriggerServerEvent('gl-ambulance:revivePlayer',playerID)
            else
                TriggerEvent('hopelife:notify', 1, 'red', 'Error', "You failed to work the defibrillator and broke it.", 15000)
                
            end
            TriggerServerEvent('gl-ambulance:removeDefib')
        end

    end

end)

AddEventHandler('gl-ambulance:revivePlayer')
RegisterNetEvent('gl-ambulance:revivePlayer',function()
    if isDead then
        local ped = PlayerPedId()
        local maxHealth = GetPedMaxHealth(ped)
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        NetworkResurrectLocalPlayer(coords, heading, true, false)
        ClearPedBloodDamage(ped)
        SetEntityInvincible(ped,false)
        Wait(100)
        if isShot then
            SetEntityHealth(ped,125) -- 25Health
        elseif isMeleed then
            SetEntityHealth(ped,135) -- 35 Health
        elseif isBurned then
            SetEntityHealth(ped,150) -- 50 Health
        else
            SetEntityHealth(ped,200) -- Full health
        end
        TriggerEvent('esx:onPlayerSpawn')
    
        isDead = false
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
        ClearPedTasks(ped)
        FreezeEntityPosition(ped,false)
        DetachEntity(stretcher, true, true)
    end
    
end)

RegisterNetEvent('gl-ambulance:healPlayer',function()
    local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
    SetEntityHealth(ped,200) -- Full health
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')

end)

RegisterNetEvent('gl-ambulance:tryTreatWound',function(wound)

    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then

        TriggerServerEvent('gl-ambulance:treatPlayerWounds',GetPlayerServerId(PlayerId()),GetPlayerServerId(player))
        
    else

    end
end)

RegisterNetEvent('gl-ambulance:useSedative',function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then

        TriggerServerEvent('gl-ambulance:goNightNight',GetPlayerServerId(player))
        
    else


    end

end)

RegisterNetEvent('gl-ambulance:goNightNight',function()
    local ped = PlayerPedId()
    LoadAnimDict('mini@cpr@char_b@cpr_def')
    TaskPlayAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    FreezeEntityPosition(ped,true)
    Wait(20000)
    FreezeEntityPosition(ped,false)
end)

RegisterCommand('putiv',function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if IsAnyVehicleNearPoint(coords, 5.0) then
        local coordA = GetEntityCoords(ped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
        vehicle = getVehicleInDirection(coordA, coordB)
        local player, distance = ESX.Game.GetClosestPlayer()
        if distance ~= -1 and distance <= 3.0 then
            local a = NetworkGetNetworkIdFromEntity(vehicle)
            TriggerServerEvent('gl-ambulance:putInVehicle', GetPlayerServerId(player),NetworkGetNetworkIdFromEntity(vehicle))
            DeleteEntity(stretcher)
        end
    end
end)

RegisterNetEvent('gl-ambulance:tryPutInVehicle',function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if IsAnyVehicleNearPoint(coords, 5.0) then
        local coordA = GetEntityCoords(ped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
        vehicle = getVehicleInDirection(coordA, coordB)
        local player, distance = ESX.Game.GetClosestPlayer()
        if distance ~= -1 and distance <= 3.0 then
            local a = NetworkGetNetworkIdFromEntity(vehicle)
            TriggerServerEvent('gl-ambulance:putInVehicle', GetPlayerServerId(player),NetworkGetNetworkIdFromEntity(vehicle))
            DeleteEntity(stretcher)
        end
    end
end)

RegisterNetEvent('gl-ambulance:putInVehicle',function(veh)
    local vehicleA = NetworkGetEntityFromNetworkId(veh)
    local ped = PlayerPedId()
    DetachEntity(ped)
        local coords = GetEntityCoords(ped)
            if IsAnyVehicleNearPoint(coords, 5.0) then
            if DoesEntityExist(vehicleA) then
                if IsVehicleSeatFree(vehicleA, 1) then
                    TaskWarpPedIntoVehicle(ped, vehicleA, 1)
                else
                    TaskWarpPedIntoVehicle(ped, vehicleA, 2)
                end
            end
        end
end)
SetEntityVisible(PlayerPedId(), true, true)
RegisterNetEvent('gl-ambulance:bodyBag',function()

    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local hash = GetHashKey('xm_prop_body_bag')
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    SetEntityVisible(ped, false, false)
    bodyBag = CreateObject(hash, playerCoords, true, true, true)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(bodyBag, ped, 0, -0.2, 0.75, -0.2, 0.0, 0.0, 0.0, false, false, false, false, 20, false)
    LoadAnimDict('mini@cpr@char_b@cpr_def')
    TaskPlayAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    disableControls()
end)

-- RegisterCommand('bodybag',function()
--     local player, distance = ESX.Game.GetClosestPlayer()
--     if distance ~= -1 and distance <= 3.0 then
--         TriggerServerEvent('gl-ambulance:bodyBag',GetPlayerServerId(player))
--     end
-- end)

local wheelchair
RegisterNetEvent('gl-ambulance:useWheelChair',function()
    print('test')
    if DoesEntityExist(wheelchair) then
        DeleteEntity(wheelchair)
    else
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local hash = 'iak_wheelchair'
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        wheelchair = CreateVehicle(hash,pedCoords,0,true,false)
        Wait(100)
        TaskWarpPedIntoVehicle(ped, wheelchair,-1)
    end
end)

-- Pulse
RegisterCommand('checkpulse',function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        playerID = GetPlayerServerId(player)
        TriggerServerEvent('gl-ambulance:checkPulse',playerID,wound)
    end

end)

RegisterNetEvent('gl-ambulance:getPulse',function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        playerID = GetPlayerServerId(player)
        TriggerServerEvent('gl-ambulance:checkPulse',playerID)
    end
end)

RegisterNetEvent('gl-ambulance:sendPulseBack',function(target)
    local sendToWhom = target
    local minPulse = 60
    local maxPulse = 80
    local status = 'Alles OK'
    if isShot then
        minPulse = 120
        maxPulse = 200
        status = 'Blutet von Schusswunden'
    end
    if isMeleed then
        minPulse = 90
        maxPulse = 115
        status = 'Hat tiefe Wunden/Blutergüsse'
    end
    
    if isBurned then
        minPulse = 20
        maxPulse = 50
        status = 'Hat Verbrennungen am ganzen Körper'
    end
    local pulse = math.random(minPulse,maxPulse)
    TriggerServerEvent('gl-ambulance:reportPulseBack',sendToWhom,pulse, status)
end)


-- RegisterNetEvent('gl-ambulance:receive911',function(message,coords)
--     if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
--         TriggerEvent("swt_notifications:caption",'911 Call',message,'top',15000,'blue-10','grey-1',true)
--         handleDaBlips(coords)
--     end

-- end)


-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            local NPCspawnCoords = Config.NancyPos
            local NPCspawnHeading = Config.NancyPosHeading
            local NPCspawnCoords2 = Config.NancyPos2
            local NPCspawnHeading2 = Config.NancyPosHeading2
            local dst = #(NPCspawnCoords - pedCoords)
            local dst2 = #(NPCspawnCoords2 - pedCoords)
            
            if dst < 100 and pedSpawned == false then
                TriggerEvent('gl-ambulance:spawnPed',NPCspawnCoords,NPCspawnHeading, '1')
                pedSpawned = true
            end
            if dst >= 101  then
                pedSpawned = false
                DeleteEntity(npc)
            end       

            if dst2 < 100 and pedSpawned2 == false then
                TriggerEvent('gl-ambulance:spawnPed',NPCspawnCoords2,NPCspawnHeading2, '2')
                pedSpawned2 = true
            end
            if dst2 >= 101  then
                pedSpawned2 = false
                DeleteEntity(npc2)
            end

        if Config.Grandmas then
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            local grandmasCoords = Config.GrandmaCoords
            local dst = #(grandmasCoords - pedCoords)
            
            if dst < 100 and grandmaSpawned == false then
                TriggerEvent('gl-ambulance:spawnGrandmaPed',grandmasCoords,134.07)
                grandmaSpawned = true
            end
            if dst >= 101  then
                grandmaSpawned = false
                DeleteEntity(grandma)
            end

        end


    end
end)

-- Spawn NPC
RegisterNetEvent('gl-ambulance:spawnPed')
AddEventHandler('gl-ambulance:spawnPed',function(coords,heading,num)
    local hash = GetHashKey('s_f_y_scrubs_01')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do 
        Wait(10)
    end

    if num == '2' then

        npc2 = CreatePed(5, hash, coords, heading, false, false)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetModelAsNoLongerNeeded(hash)
    else 

        npc = CreatePed(5, hash, coords, heading, false, false)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetModelAsNoLongerNeeded(hash)
    end


    -- exports['bt-target']:AddEntityZone('nancy', npc, {
    --         name="nancy",
    --         debugPoly=true,
    --         useZ = true
    --             }, {
    --             options = {
    --                 {
    --                 event = "gl-ambulance:checkInNancy",
    --                 icon = "far fa-comment",
    --                 label = "Check In",
    --                 },                                                                    
    --             },
    --                 job = {"all"},
    --                 distance = 2.5
    --             })  
end)

RegisterNetEvent('gl-ambulance:spawnGrandmaPed')
AddEventHandler('gl-ambulance:spawnGrandmaPed',function(coords,heading)
    local hash = GetHashKey('ig_mrs_thornhill')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do 
        Wait(10)
    end

    grandma = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(grandma, true)
    SetEntityInvincible(grandma, true)
    SetBlockingOfNonTemporaryEvents(grandma, true)
    SetModelAsNoLongerNeeded(hash)
    exports['bt-target']:AddEntityZone('grandma', grandma, {
            name="grandma",
            debugPoly=false,
            useZ = true
                }, {
                options = {
                    {
                    event = "gl-ambulance:useGrandmas",
                    icon = "far fa-comment",
                    label = "Revive",
                    },                                                                    
                },
                    job = {"all"},
                    distance = 2.5
                })  
end)

RegisterNetEvent('gl-ambulance:checkInNancyC', function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 2.0 then
        playerID = GetPlayerServerId(player)
        TriggerServerEvent('gl-ambulance:checkInNancy',playerID)
    end
end)


RegisterNetEvent('gl-ambulance:checkInNancy',function()
    local bed = Config.BedLocs[math.random(#Config.BedLocs)]
    TriggerEvent("swt_notifications:caption",'Being Treated','You have been moved to a bed for Treatment.','top',20000,'green-6','grey-1',true)
    TriggerEvent('hopelife:notify', 1, '#5f0085', 'Being Treated', "You have been moved to a bed for Treatment.", 20000)

    SetEntityCoords(PlayerPedId(), bed.x,bed.y,bed.z)
    LoadAnimDict('anim@gangops@morgue@table@')
    TaskPlayAnim(PlayerPedId(), 'anim@gangops@morgue@table@' , 'body_search' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), bed.w)
    -- Set these to whatever wound system you use
    Wait(20000)
    -- TriggerEvent('mythic_hospital:client:RemoveBleed')
    -- TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('gl-ambulance:revivePlayer')
    SetEntityHealth(PlayerPedId(),200)
    ClearPedTasks(PlayerPedId())
    -- TriggerEvent("swt_notifications:caption",'Treated','You are good now, stop getting in trouble.','top',6000,'green-6','grey-1',true)
    TriggerEvent('hopelife:notify', 1, '#5f0085', 'Treated', "You are good now, stop getting in trouble.", 5000)

end)

RegisterNetEvent('gl-ambulance:useGrandmas',function()
    TriggerEvent("swt_notifications:caption",'Grandma',"I'll take care of you sonny",'top',5000,'green-6','grey-1',true)
    Wait(5000)
    TriggerEvent('gl-ambulance:revivePlayer')
end)

RegisterNetEvent('gl-ambulance:adminHeal',function()
    local ped = PlayerPedId()
    local maxHealth = GetPedMaxHealth(ped)
    SetEntityHealth(ped,maxHealth)
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
end)

-- Handlers Below
AddEventHandler('esx:onPlayerDeath', function(data)
    isShot = false
    isMeleed = false
    isBurned = false
    if not isDead then
        ESX.TriggerServerCallback("gl-ambulance:getEMSCount", function(cb)
            emsCount = cb
        end)
        StartDistressSignal()
        StartDeathTimer()
        isDead = true
        for k, v in pairs (Config.Guns) do
            if data.deathCause == v then
                isShot = true
                curWound = 'bullet'
            end
        end
        for k, v in pairs (Config.Melee) do 
            if data.deathCause == v then
                isMeleed = true
                curWound = 'stitch'
            end
        end

        for k, v in pairs(Config.Explosions) do
            if data.deathCause == v then
                isMeleed = true
                curWound = 'burn'
            end
        end

        disableControls()
        -- playDead()
    end
end)

AddEventHandler('esx:onPlayerSpawn', function()
    local ped = PlayerPedId()
    if isDead then
        LoadAnimDict('get_up@directional@movement@from_knees@action')
        TaskPlayAnim(ped, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
        isDead = false
    end
end)


-- // End Handlers //

-- Commands



-- Functions Below

function handleDaBlips(coords)
    local time = Config.BlipTimer * 20000
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 126)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 26)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("911 Alert")
    EndTextCommandSetBlipName(blip) 
    CreateThread(function()  
        while time > 0 do
            Wait(1000)
            time = time - 1000
            if time <= 0 then
                RemoveBlip(blip)
                break
            end
        end
    end)
end


function playDead()
    local ped = PlayerPedId()
    local maxHealth = GetPedMaxHealth(ped)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    NetworkResurrectLocalPlayer(coords, heading, true, false)
    Wait(100)
    SetEntityHealth(ped,maxHealth)
    SetEntityInvincible(ped,true)
    LoadAnimDict('mini@cpr@char_b@cpr_def')
    LoadAnimDict("veh@bus@passenger@common@idle_duck")
    TaskPlayAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    CreateThread(function()
        while isDead do
            if IsPedInAnyVehicle(ped,false) then
                if not IsEntityPlayingAnim(ped, "veh@bus@passenger@common@idle_duck", "sit", 3) then
                    ClearPedTasks(ped)
                    TaskPlayAnim(ped, "veh@bus@passenger@common@idle_duck", "sit", 8.0, -8, -1, 2, 0, 0, 0, 0)
                end
            else
                if not IsEntityPlayingAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 3) then
                    ClearPedTasks(ped)
                    TaskPlayAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
                end
                Wait(30000)
                if isDead then
                    ClearPedTasks(ped)
                    TaskPlayAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
                end
            end
            Wait(1000)
        end
    end)
end

-- Fix when sober you dumb fuck
function disableControls()
    CreateThread(function()
        while isDead do
            Wait(1)
            DisableAllControlActions(0)
            EnableControlAction(0, 1)
            EnableControlAction(0, 2)
            EnableControlAction(0, 26, true)
            EnableControlAction(0, 47, true)
            EnableControlAction(0, 74, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 249, true)
            EnableControlAction(0, 0, true)
            EnableControlAction(0, 20, true)
            EnableControlAction(0, 178, true)
            EnableControlAction(0, 167, true)
        end
    end)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function iHasDaBag()
    local hasBag = true
    CreateThread(function()
        while hasBag do
            Wait(0)
            -- If they press E drop the fucking bag
            if IsControlJustReleased(0,38) then
                hasBag = false
                dropDaBag()
                Citizen.Wait(1000)
            end
        end
    end)
end

function dropDaBag()
    DetachEntity(medBag)
    PlaceObjectOnGroundProperly(medBag)
    droppedBag = true
end

function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end



function respawnCountdownText()
    local dispatchgesendet = false
    CreateThread(function()
        while isDead do
            Wait(0)
            local text = _U('respawn',emsCount)
            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.0, 0.3)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextCentre(true)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(text)
            EndTextCommandDisplayText(0.5, 0.8)
            if IsControlPressed(0, 38) and not dispatchgesendet then
 --[[             if emsCount > 0 and Config.RemoveItemsOnDeath then
                    -- Lose Items
                    TriggerServerEvent('gl-ambulance:removeDeathItems')
                end
                    SetEntityCoords(PlayerPedId(),Config.RespawnCoords)
                    TriggerEvent('gl-ambulance:revivePlayer')
                break
 ]]--  


            local anonym = false
            local coords = GetEntityCoords(PlayerPedId())
            local position = {x = coords.x, y = coords.y, z = coords.z - 1}
            local jobreceived = "ambulance"
            local message = "Dispatch angekommen! Sofort anfahren!"
            
            TriggerServerEvent('roadphone:sendDispatch', GetPlayerServerId(PlayerId()), message, jobreceived, position, anonym)

             dispatchgesendet = true       

            end

            
      
        end
    end)
end

function StartDistressSignal()
	CreateThread(function()
		local timer = Config.BleedoutTimer
		local anonym = false
		local coords = GetEntityCoords(PlayerPedId())
		local position = {x = coords.x, y = coords.y, z = coords.z - 1}
		local jobreceived = "ambulance"
		local message = "Eine Person benötigt Hilfe!"
		while timer > 0 and isDead do
			Wait(0)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlJustReleased(0, 47) then
				-- print("kek")
				SendDistressSignal()
				break
			end
		end
	end)
end

function StartNotSignal()
	CreateThread(function()
		local timer = Config.BleedoutTimer
		while timer > 0 and isDead do
			Wait(0)
			timer = timer - 30
			if IsControlJustReleased(0, 47) then
				ExecuteCommand("help")
				break
			end
		end
	end)
end

function SendDistressSignal()
	local anonym = false
 local coords = GetEntityCoords(PlayerPedId())
 local position = {x = coords.x, y = coords.y, z = coords.z - 1}
 local jobreceived = "ambulance"
 local message = "Dispatch angekommen! Sofort anfahren!"
 
 TriggerServerEvent('roadphone:sendDispatch', GetPlayerServerId(PlayerId()), message, jobreceived, position, anonym)
end


function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end



function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format('%02.f', math.floor(seconds / 3600))
		local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	CreateThread(function()
		local text
		local timeHeld=0
		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(text)
			EndTextCommandDisplayText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

				text = text .. _U('respawn_bleedout_prompt')

                -- print(timeHeld)
				if IsControlPressed(0, 38) and timeHeld > 60 then
					-- TriggerServerEvent('gl-ambulance:removeDeathItems')
                    RemoveItemsAfterRPDeath()
					break
				end

			if IsControlPressed(0, 38) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(text)
			EndTextCommandDisplayText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and isDead then
			TriggerServerEvent('gl-ambulance:removeDeathItems')
		end
	end)
end

function RespawnPed(ped, coords, heading, isDied)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
	if isDied then
		TriggerServerEvent('msk_backpack:setDeathStatus', true)
	end
end


function RemoveItemsAfterRPDeath()
	CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Wait(0)
		end

		ESX.TriggerServerCallback('gl-ambulance:removeItemsAfterRPDeath', function()

			ESX.SetPlayerData('loadout', {})
			RespawnPed(PlayerPedId(), Config.RespawnCoords, Config.RespawnHeading, true)

			AnimpostfxStop('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end






RegisterNetEvent('gl-ambulance:useItem')
AddEventHandler('gl-ambulance:useItem', function(itemName)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		ESX.UI.Menu.CloseAll()

		if itemName == 'medikit' then
			local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
			local playerPed = PlayerPedId()

			ESX.Streaming.RequestAnimDict(lib, function()
				TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

				Wait(500)
				while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
					Wait(0)
					DisableAllControlActions(0)
				end

				TriggerEvent('gl-ambulance:itemHeal', 'big', true)
				ESX.ShowNotification("Du hast ein Medikit verwendet")
			end)

		elseif itemName == 'bandage' then
			local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
			local playerPed = PlayerPedId()
			local health = GetEntityHealth(playerPed)
			local maxHealth = GetEntityMaxHealth(playerPed)
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
			if skin.sex == 0 then
				if health <= 150 then
					SetEntityHealth(playerPed, newHealth)
					ESX.ShowNotification("Du hast dich verbunden")
				else
					ESX.ShowNotification("Mit Verbänden kannst du dich nicht höher heilen")
					return
				end
				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

					Wait(500)
					while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
						Wait(0)
						DisableAllControlActions(0)
					end

					TriggerEvent('gl-ambulance:itemHeal', 'small', true)
					ESX.ShowNotification("Du hast eine Bandage verwendet")
				end)
			else
				if health <= 135 then
					SetEntityHealth(playerPed, newHealth)
					ESX.ShowNotification("Du hast dich verbunden")
				else
					ESX.ShowNotification("Mit Verbänden kannst du dich nicht höher heilen")
					return
				end
				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

					Wait(500)
					while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
						Wait(0)
						DisableAllControlActions(0)
					end

					TriggerEvent('gl-ambulance:itemHeal', 'small', true)
					ESX.ShowNotification("Du hast eine Bandage verwendet")
				end)
			end
		end
	end)
end)




RegisterNetEvent('gl-ambulance:itemHeal')
AddEventHandler('gl-ambulance:itemHeal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification("Du wurdest behandelt")
	end
end)