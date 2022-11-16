ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    if Config.Debug then 
        ESX.TriggerServerCallback('mapbuilder:getGroup', function(group_res)
            group = group_res
            print(group)
        end)
    end

end)

local spawnedObjects = {}
local mySteamID = nil
_menuPool = NativeUI.CreatePool()

local group
RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

Citizen.CreateThread(function()

    if Config.Debug then
        TriggerServerEvent('mapbuilder:getObjects')
    end

    while true do
        Wait(1)
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()
        end
    end
end)


if Config.KeyUsage then
    Citizen.CreateThread(function()

        while true do
            
            if IsControlJustReleased(0, Config.Key) then
                openMapMaker()
            end

            Citizen.Wait(1)

        end

    end)
end


RegisterCommand(Config.Command, function(source, args, rawCommand)
    if Config.OnlyForAdmin and group == Config.AdminGroup then
        openMapMaker()
    elseif not Config.OnlyForAdmin then
        openMapMaker()
    end
    
end, false)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('mapbuilder:getObjects')
    ESX.TriggerServerCallback('mapbuilder:getGroup', function(group_res)
        group = group_res
        print(group)
    end)
end)

RegisterNetEvent('mapbuilder:receiveObjects')
AddEventHandler('mapbuilder:receiveObjects', function(result, steamID)
    mySteamID = steamID
    for k, v in pairs(result) do
       
        local sObject = CreateObject(GetHashKey(v.objectHash), v.locX, v.locY, v.locZ, false, true, true)
		Citizen.Wait(25)
		SetEntityCoords(sObject, v.locX, v.locY, v.locZ)
		
        SetEntityHeading(sObject, v.heading)
        --PlaceObjectOnGroundProperly(sObject)
       

        if tonumber(v.freeze) == 1 then
            FreezeEntityPosition(sObject, true)
        else
            FreezeEntityPosition(sObject, false)
        end
        table.insert(spawnedObjects, result[k])
        spawnedObjects[#spawnedObjects].entity = sObject
    end
end)


local object = nil
local selectedObject = nil
local selectedObjectHash = nil
local objectHash = nil -- final object hash
local selectedPrice

local isFrozen = true

local mapmakerMenu
local spawnObject_sub
local enterObject 

function openMapMaker()
    _menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    collectgarbage()

    local prefix = ''
    if object == nil then
        prefix = '~c~'
    else
        prefix = ''
    end

    mapmakerMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_title'])
    _menuPool:Add(mapmakerMenu)


    local objectsInDistance = _menuPool:AddSubMenu(mapmakerMenu, Translation[Config.Locale]['get_object_distance'], '~b~')
    mapmakerMenu.Items[1]:RightLabel('~o~→→→')

        if #spawnedObjects > 0 then
            for k, v in pairs(spawnedObjects) do
                if v.createdBy == mySteamID or (group ~= nil and group == Config.AdminGroup) then
                    local roundX = math.round(v.locX)
                    local roundY = math.round(v.locY)
                    local roundZ = math.round(v.locZ)
                    local roundHeading = math.round(v.heading)

                    local obj_sub
                    if Config.useNativeUIReloaded then
                        obj_sub = _menuPool:AddSubMenu(objectsInDistance.SubMenu, '~b~' .. v.comment .. ' ~s~| ' .. v.objectHash, '(~b~X ~s~= ' .. roundX .. ', ~b~Y ~s~= ' .. roundY .. ', ~b~Z~s~ = ' .. roundZ)
                    else
                        obj_sub = _menuPool:AddSubMenu(objectsInDistance, '~b~' .. v.comment .. ' ~s~| ' .. v.objectHash, '(~b~X ~s~= ' .. roundX .. ', ~b~Y ~s~= ' .. roundY .. ', ~b~Z~s~ = ' .. roundZ)
                    end
                    if group == Config.AdminGroup then
                        local teleport = NativeUI.CreateItem(Translation[Config.Locale]['obj_tp'], Translation[Config.Locale]['obj_tp_desc'])
                        if Config.useNativeUIReloaded then
                            obj_sub.SubMenu:AddItem(teleport)
                        else
                            obj_sub:AddItem(teleport)
                        end
                        

                        teleport.Activated = function(sender, index)
                            SetEntityCoords(PlayerPedId(), v.locX, v.locY, v.locZ)
                        end
                    end

                    local hide = NativeUI.CreateItem(Translation[Config.Locale]['obj_hide'], Translation[Config.Locale]['obj_hide_desc'])
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(hide)
                    else
                        obj_sub:AddItem(hide)
                    end

                    hide.Activated = function(sender, index)
                        if v.entity ~= nil then
                            DeleteObject(v.entity)
                            v.entity = nil
                        else
                            ShowNotification(Translation[Config.Locale]['invalid_object'])
                        end
                    end

                    local replace = NativeUI.CreateItem(Translation[Config.Locale]['obj_replace'], Translation[Config.Locale]['obj_replace_desc'])
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(replace)
                    else
                        obj_sub:AddItem(replace)
                    end

                    replace.Activated = function(sender, index)
                        if v.entity == nil then
                            newObj = spawnObject(v.objectHash, v.locX, v.locY, v.locZ, v.heading, v.freeze)
                            v.entity = newObj
                        else
                            ShowNotification(Translation[Config.Locale]['obj_already_exists'])
                        end
                    end

                    local turn = NativeUI.CreateItem(Translation[Config.Locale]['turn_object'], '~b~')
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(turn)
                    else
                        obj_sub:AddItem(turn)
                    end

                    turn.Activated = function(sender, index)
                        if v.entity ~= nil then
                            if Config.useNativeUIReloaded then
                                turnObject(v.entity, obj_sub.SubMenu)
                            else
                                turnObject(v.entity, obj_sub)
                            end
                        else
                            ShowNotification(Translation[Config.Locale]['invalid_object'])
                        end
                    end

                    local move = NativeUI.CreateItem(Translation[Config.Locale]['move_object'], '~b~')
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(move)
                    else
                        obj_sub:AddItem(move)
                    end

                    move.Activated = function(sender, index)
                        if v.entity ~= nil then
                            if Config.useNativeUIReloaded then
                                moveObject(v.entity, obj_sub.SubMenu)
                            else
                                moveObject(v.entity, obj_sub)
                            end
                        else
                            ShowNotification(Translation[Config.Locale]['invalid_object'])
                        end
                    end

                    local moveUpandDown = NativeUI.CreateItem(Translation[Config.Locale]['moveupdown_object'], '~b~')
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(moveUpandDown)
                    else
                        obj_sub:AddItem(moveUpandDown)
                    end

                    moveUpandDown.Activated = function(sender, index)
                        if v.entity ~= nil then
                            if Config.useNativeUIReloaded then
                                moveUpDown(v.entity, obj_sub.SubMenu)
                            else
                                moveUpDown(v.entity, obj_sub)
                            end
                        else
                            ShowNotification(Translation[Config.Locale]['invalid_object'])
                        end
                    end

                    local editMoveable = NativeUI.CreateCheckboxItem(Translation[Config.Locale]['set_moveable'], v.freeze, Translation[Config.Locale]['set_moveable_desc'])
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(editMoveable)
                
                        obj_sub.SubMenu.OnCheckboxChange = function(sender, item, checked)
                            if item == editMoveable then
                                if v.entity ~= nil then
                                    isFrozen = checked
                                    ShowNotification(Translation[Config.Locale]['moveable_state_changed'] .. tostring(checked))
                                    FreezeEntityPosition(v.entity, isFrozen)
                                else
                                    isFrozen = checked
                                    --ShowNotification(Translation[Config.Locale]['invalid_object'])
                                end
                            end
                        end
                    else
                        obj_sub:AddItem(editMoveable)
                
                        obj_sub.OnCheckboxChange = function(sender, item, checked)
                            if item == editMoveable then
                                if object ~= nil then
                                    isFrozen = checked
                                    ShowNotification(Translation[Config.Locale]['moveable_state_changed'] .. tostring(checked))
                                    FreezeEntityPosition(object, isFrozen)
                                else
                                    isFrozen = checked
                                    --ShowNotification(Translation[Config.Locale]['invalid_object'])
                                end
                            end
                        end
                    end

                    local permDelete = NativeUI.CreateItem(Translation[Config.Locale]['delete_object'], Translation[Config.Locale]['obj_permdelete_desc'])
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(permDelete)
                    else
                        obj_sub:AddItem(permDelete)
                    end

                    permDelete.Activated = function(sender, index)
                        if v.id ~= nil then
                            TriggerServerEvent('mapbuilder:removeFromDatabase', v.id, v.objectHash)
                            TriggerServerEvent('mapbuilder:syncObjectRemove', v.id, v.objectHash)
                            ShowNotification(Translation[Config.Locale]['obj_removed'])
                        else
                            ShowNotification(Translation[Config.Locale]['cant_save'])
                        end
                    end

                    local save = NativeUI.CreateItem(Translation[Config.Locale]['obj_savechanges'], Translation[Config.Locale]['obj_savechanges_desc'])
                    if Config.useNativeUIReloaded then
                        obj_sub.SubMenu:AddItem(save)
                    else
                        obj_sub:AddItem(save)
                    end

                    save.Activated = function(sender, index)
                        if v.id ~= nil then
                            local coords = GetEntityCoords(v.entity)
                            local heading = GetEntityHeading(v.entity)
                            
                            TriggerServerEvent('mapbuilder:updateObject', v.id, coords, heading, isFrozen)
                            ShowNotification(Translation[Config.Locale]['obj_saved'])
                            --TriggerServerEvent('mapbuilder:saveToDatabase', selectedObject, coords, heading, isMoveable, desc)
                            --DeleteObject(object)
                        else
                            ShowNotification(Translation[Config.Locale]['cant_save'])
                        end
                    end
                end

            end
        end

    spawnObject_sub = _menuPool:AddSubMenu(mapmakerMenu, Translation[Config.Locale]['spawn_object'], '~b~Select an object!')
    mapmakerMenu.Items[2]:RightLabel('~b~→→→')
    enterObject = NativeUI.CreateItem(Translation[Config.Locale]['enter_objectname'], Translation[Config.Locale]['enter_objectname_desc'])
    enterObject:RightLabel('~b~' .. Config.defaultObject)
    selectedObject = Config.defaultObject
    selectedObjectHash = GetHashKey(Config.defaultObject)
    if Config.useNativeUIReloaded then
        spawnObject_sub.SubMenu:AddItem(enterObject)
    else
        spawnObject_sub:AddItem(enterObject)
    end

    enterObject.Activated = function(sender, index)
        if group == Config.AdminGroup then
            if Config.useNativeUIReloaded then
                spawnObject_sub.SubMenu:Visible(false)
            else
                spawnObject_sub:Visible(false)
            end
            --local objectInput = KeyboardInput(Translation[Config.Locale]['insert_here'], Translation[Config.Locale]['insert_placeholder'], 100)
            ShowNotification(Translation[Config.Locale]['selectObject_help'])
        else
            ShowNotification(Translation[Config.Locale]['only_for_admins'])
        end

    end

    
    local recommendObjects
    if Config.useNativeUIReloaded then
        recommendObjects = _menuPool:AddSubMenu(spawnObject_sub.SubMenu, Translation[Config.Locale]['recommend_objects'], Translation[Config.Locale]['recommend_objects_desc'])
        spawnObject_sub.SubMenu.Items[2]:RightLabel('~o~→→→')
    else
        recommendObjects = _menuPool:AddSubMenu(spawnObject_sub, Translation[Config.Locale]['recommend_objects'], Translation[Config.Locale]['recommend_objects_desc'])
        spawnObject_sub.Items[2]:RightLabel('~o~→→→')
    end
    
    

    for k, v in pairs(Config.recommendObjects) do
        local recObjectItem = NativeUI.CreateItem(v.label, Translation[Config.Locale]['select_object_desc'] .. v.object)
        recObjectItem:RightLabel('~b~' .. v.price .. '$')
        if Config.useNativeUIReloaded then
            recommendObjects.SubMenu:AddItem(recObjectItem)

            recObjectItem.Activated = function(sender, index)
                recommendObjects.SubMenu:Visible(false)
                enterObject:RightLabel('~g~' .. v.object)
                selectedObjectHash = GetHashKey(v.object)
                selectedObject = v.object
                selectedPrice = v.price
                spawnObject_sub.SubMenu:Visible(true)
            end
        else
            recommendObjects:AddItem(recObjectItem)

            recObjectItem.Activated = function(sender, index)
                recommendObjects:Visible(false)
                enterObject:RightLabel('~g~' .. v.object)
                selectedObjectHash = GetHashKey(v.object)
                selectedObject = v.object
                selectedPrice = v.price
                spawnObject_sub:Visible(true)
            end
        end
    end

    local spawnObjectFinal = NativeUI.CreateItem(Translation[Config.Locale]['spawn_object_final'], Translation[Config.Locale]['spawn_object_final_desc'])
    if Config.useNativeUIReloaded then
        spawnObject_sub.SubMenu:AddItem(spawnObjectFinal)
    else
        spawnObject_sub:AddItem(spawnObjectFinal)
    end

    local moveObjectItem = NativeUI.CreateItem(Translation[Config.Locale]['move_object'], '~b~')
    moveObjectItem:RightLabel(Translation[Config.Locale]['no_object'])
    mapmakerMenu:AddItem(moveObjectItem)

    moveObjectItem.Activated = function()
        if object ~= nil then
            moveObject(object, mapmakerMenu)
        else
            ShowNotification(Translation[Config.Locale]['invalid_object'])
        end
        
    end

    local turnObjectItem = NativeUI.CreateItem(Translation[Config.Locale]['turn_object'], '~b~')
    turnObjectItem:RightLabel(Translation[Config.Locale]['no_object'])
    mapmakerMenu:AddItem(turnObjectItem)

    turnObjectItem.Activated = function(sender, index)
        if object ~= nil then
            turnObject(object, mapmakerMenu)
        else
            ShowNotification(Translation[Config.Locale]['invalid_object'])
        end
    end

    local moveUpandDownItem = NativeUI.CreateItem(Translation[Config.Locale]['moveupdown_object'], '~b~')
    moveUpandDownItem:RightLabel(Translation[Config.Locale]['no_object'])
    mapmakerMenu:AddItem(moveUpandDownItem)

    moveUpandDownItem.Activated = function(sender, index)
        if object ~= nil then
            moveUpDown(object, mapmakerMenu)
        else
            ShowNotification(Translation[Config.Locale]['invalid_object'])
        end
    end

    local setMoveableItem = NativeUI.CreateCheckboxItem(Translation[Config.Locale]['set_moveable'], isFrozen, Translation[Config.Locale]['set_moveable_desc'])
    mapmakerMenu:AddItem(setMoveableItem)

    mapmakerMenu.OnCheckboxChange = function(sender, item, checked)
        if item == setMoveableItem then
            if object ~= nil then
                isFrozen = checked
                ShowNotification(Translation[Config.Locale]['moveable_state_changed'] .. tostring(checked))
                FreezeEntityPosition(object, isFrozen)
            else
                isFrozen = checked
                --ShowNotification(Translation[Config.Locale]['invalid_object'])
            end
        end
    end

    local desc = '-'
    local commentItem = NativeUI.CreateItem(Translation[Config.Locale]['set_description'], Translation[Config.Locale]['set_description_desc'])
    commentItem:RightLabel('~b~' .. desc)
    mapmakerMenu:AddItem(commentItem)

    commentItem.Activated = function(sender, index)
        local descStr = KeyboardInput(Translation[Config.Locale]['set_description'], desc, 20)
        if descStr ~= nil then
            desc = descStr
            commentItem:RightLabel('~b~' .. desc)
        end
    end

    local deleteObjectItem = NativeUI.CreateItem(Translation[Config.Locale]['delete_object'], Translation[Config.Locale]['delete_object_desc'])
    mapmakerMenu:AddItem(deleteObjectItem)

    deleteObjectItem.Activated = function(sender, index)
        if object ~= nil then
            DeleteObject(object)
            object = nil
            turnObjectItem:RightLabel(Translation[Config.Locale]['no_object'])
            moveObjectItem:RightLabel(Translation[Config.Locale]['no_object'])
            moveUpandDownItem:RightLabel(Translation[Config.Locale]['no_object'])
        else
            ShowNotification(Translation[Config.Locale]['invalid_object'])
        end
    end

    local saveObject = NativeUI.CreateItem(Translation[Config.Locale]['save_object'], Translation[Config.Locale]['save_object_desc'])
    mapmakerMenu:AddItem(saveObject)

    saveObject.Activated = function(sender, index)
        if object ~= nil then
            local hashKey = GetHashKey(object)
            local coords = GetEntityCoords(object)
            local heading = GetEntityHeading(object)
            if selectedObject ~= Config.defaultObject then
                ESX.TriggerServerCallback('mapbuilder:getMoney', function(money)
                    if selectedPrice == nil or money >= selectedPrice then
                        TriggerServerEvent('mapbuilder:removeMoney', selectedPrice)
                        TriggerServerEvent('mapbuilder:syncObject', selectedObject, coords, heading, isFrozen, mySteamID, desc)
                        TriggerServerEvent('mapbuilder:saveToDatabase', selectedObject, coords, heading, isFrozen, desc)
                        DeleteObject(object)
                        object = nil
                    else
                        ShowNotification(Translation[Config.Locale]['not_enough_money'])
                        DeleteObject(object)
                    end
                end)
            else
                ShowNotification(Translation[Config.Locale]['invalid_object'])
            end
        else
            ShowNotification(Translation[Config.Locale]['invalid_object'])
        end

    end

    spawnObjectFinal.Activated = function(sender, index)
        if Config.useNativeUIReloaded then
            spawnObject_sub.SubMenu:Visible(false)
        else
            spawnObject_sub:Visible(false)
        end

        playerCoords = GetEntityCoords(PlayerPedId())
        playerHeading = GetEntityHeading(PlayerPedId())

        if object ~= nil then
            DeleteObject(object)
        end
        objectHash = selectedObjectHash
        object = CreateObject(selectedObjectHash, playerCoords.x, playerCoords.y, playerCoords.z-1, false, true, true)
        SetEntityHeading(object, playerHeading+180)
        PlaceObjectOnGroundProperly(object)
        FreezeEntityPosition(object, isFrozen)

        -- turn mode
        AddTextEntry('text', 
        Translation[Config.Locale]['controls'] ..'~n~~' .. Config.Controls.turnright.name .. '~' .. Translation[Config.Locale]['turn_right'] .. '~n~~' 
        .. Config.Controls.turnleft.name .. '~' .. Translation[Config.Locale]['turn_left'] .. '~n~~' 
        .. Config.Controls.fast.name .. '~' .. Translation[Config.Locale]['turn_fast'] .. '~n~~' 
        .. Config.Controls.slow.name .. '~' .. Translation[Config.Locale]['turn_slow'] .. '~n~~' 
        .. Config.Controls.finish.name .. '~' .. Translation[Config.Locale]['back_to_menu'] .. '~n~~' 
        )
        while true do
            Wait(0)
            BeginTextCommandDisplayHelp('text')
            EndTextCommandDisplayHelp(false, false, false, -1)
            

            if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.turnright.key) then
                SetEntityHeading(object, GetEntityHeading(object)+0.1)
            elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.turnright.key) then
                SetEntityHeading(object, GetEntityHeading(object)+10)
            elseif IsControlJustPressed(0, Config.Controls.turnright.key) then
                SetEntityHeading(object, GetEntityHeading(object)+1)
            end

            if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.turnleft.key) then
                SetEntityHeading(object, GetEntityHeading(object)-0.1)
            elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.turnleft.key) then
                SetEntityHeading(object, GetEntityHeading(object)-10)
            elseif IsControlJustPressed(0, Config.Controls.turnleft.key) then
                SetEntityHeading(object, GetEntityHeading(object)-1)
            end

            if IsControlJustPressed(0, Config.Controls.finish.key) then
                turnObjectItem:RightLabel('~g~')
                moveObjectItem:RightLabel('~g~')
                moveUpandDownItem:RightLabel('~g~')
                mapmakerMenu:Visible(true)
                break
            end
        end
    end

    mapmakerMenu:Visible(not mapmakerMenu:Visible())

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end


RegisterCommand("selectObject", function(source, args, rawCommand)
    if GetHashKey(args[1]) ~= nil then
        enterObject:RightLabel('~g~' .. args[1])
        selectedObjectHash = GetHashKey(args[1])
        selectedObject = args[1]
        if Config.useNativeUIReloaded then
            spawnObject_sub.SubMenu:Visible(true)
        else
            spawnObject_sub:Visible(true)
        end
    else
        ShowNotification(Translation[Config.Locale]['invalid_object'])
        if Config.useNativeUIReloaded then
            spawnObject_sub.SubMenu:Visible(true)
        else
            spawnObject_sub:Visible(true)
        end
    end
end, false)


RegisterNetEvent('mapbuilder:spawnObject')
AddEventHandler('mapbuilder:spawnObject', function(hash, loc, headingres, freezeres, owner, desc)
    local lastObj = CreateObject(GetHashKey(hash), loc.x, loc.y, loc.z, false, true, true)
	Citizen.Wait(25)
	SetEntityCoords(lastObj, loc.x, loc.y, loc.z)
	
    FreezeEntityPosition(lastObj, freezeres)
    SetEntityHeading(lastObj, headingres)
    --PlaceObjectOnGroundProperly(lastObj)

    table.insert(spawnedObjects, {
        objectHash = hash,
        locX = loc.x,
        locY = loc.y,
        locZ = loc.z,
        heading = headingres,
        freeze = freezeres,
        createdBy = owner,
        comment = desc,
        entity = lastObj}
    )


end)

RegisterNetEvent('mapbuilder:updateObject')
AddEventHandler('mapbuilder:updateObject', function(objectID, loc, heading, freeze)
    for k, v in pairs(spawnedObjects) do
        if v.id == objectID then
            DeleteObject(v.entity)
            local lastObj = CreateObject(GetHashKey(v.objectHash), loc.x, loc.y, loc.z, false, true, true)
			Citizen.Wait(25)
			SetEntityCoords(lastObj, loc.x, loc.y, loc.z)
            FreezeEntityPosition(lastObj, freeze)
            SetEntityHeading(lastObj, heading)
            --PlaceObjectOnGroundProperly(lastObj)

            v.entity = lastObj
            v.locX = loc.x
            v.locY = loc.y
            v.locZ = loc.z
            v.heading = heading
            v.freeze = freeze

            break
        end
    end
    
end)

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

function spawnObject(objectHash, locX, locY, locZ, heading, freeze)
    local sObject = CreateObject(GetHashKey(objectHash), locX, locY, locZ, false, true, true)
	Citizen.Wait(25)
	SetEntityCoords(sObject, locX, locY, locZ)
    SetEntityHeading(sObject, heading)
    --PlaceObjectOnGroundProperly(sObject)
    FreezeEntityPosition(sObject, freeze)
    return sObject
end


RegisterNetEvent('mapbuilder:deleteObject')
AddEventHandler('mapbuilder:deleteObject', function(objectID, hash)
    for k, v in pairs(spawnedObjects) do
        if v.id == objectID then
            if v.objectHash == hash then
                DeleteObject(v.entity)
                table.remove(spawnedObjects, k)
            end
        end
    end
end)

function turnObject(objectRes, menu)
    menu:Visible(false)

    AddTextEntry('text', 
    Translation[Config.Locale]['controls'] ..'~n~~' .. Config.Controls.turnright.name .. '~' .. Translation[Config.Locale]['turn_right'] .. '~n~~' 
        .. Config.Controls.turnleft.name .. '~' .. Translation[Config.Locale]['turn_left'] .. '~n~~' 
        .. Config.Controls.fast.name .. '~' .. Translation[Config.Locale]['turn_fast'] .. '~n~~' 
        .. Config.Controls.slow.name .. '~' .. Translation[Config.Locale]['turn_slow'] .. '~n~~' 
        .. Config.Controls.finish.name .. '~' .. Translation[Config.Locale]['back_to_menu'] .. '~n~~' 
    )
    while true do
        Wait(0)
        BeginTextCommandDisplayHelp('text')
        EndTextCommandDisplayHelp(false, false, false, -1)
        

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.turnright.key) then
            SetEntityHeading(objectRes, GetEntityHeading(objectRes)+0.1)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.turnright.key) then
            SetEntityHeading(objectRes, GetEntityHeading(objectRes)+10)
        elseif IsControlJustPressed(0, Config.Controls.turnright.key) then
            SetEntityHeading(objectRes, GetEntityHeading(objectRes)+1)
        end

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.turnleft.key) then
            SetEntityHeading(objectRes, GetEntityHeading(objectRes)-0.1)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.turnleft.key) then
            SetEntityHeading(objectRes, GetEntityHeading(objectRes)-10)
        elseif IsControlJustPressed(0, Config.Controls.turnleft.key) then
            SetEntityHeading(objectRes, GetEntityHeading(objectRes)-1)
        end

        if IsControlJustPressed(0, Config.Controls.finish.key) then
            menu:Visible(true)
            break
        end
    end
end

function moveObject(objectRes, menu)

    menu:Visible(false)
    AddTextEntry('text', 
    Translation[Config.Locale]['controls'] ..'~n~~' .. Config.Controls.moveright.name .. '~' .. Translation[Config.Locale]['move_right'] .. '~n~~' 
        .. Config.Controls.moveleft.name .. '~' .. Translation[Config.Locale]['move_left'] .. '~n~~' 
        .. Config.Controls.moveup.name .. '~' .. Translation[Config.Locale]['move_forward'] .. '~n~~' 
        .. Config.Controls.movedown.name .. '~' .. Translation[Config.Locale]['move_backwards'] .. '~n~~' 
        .. Config.Controls.fast.name .. '~' .. Translation[Config.Locale]['move_fast'] .. '~n~~' 
        .. Config.Controls.slow.name .. '~' .. Translation[Config.Locale]['move_slow'] .. '~n~~' 
        .. Config.Controls.finish.name .. '~' .. Translation[Config.Locale]['back_to_menu'] .. '~n~~' 
    )
    while true do
        Wait(0)
        BeginTextCommandDisplayHelp('text')
        EndTextCommandDisplayHelp(false, false, false, -1)
        

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.moveright.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x+0.1, coords.y, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.moveright.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x+1, coords.y, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlJustPressed(0, Config.Controls.moveright.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x+.05, coords.y, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        end

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.moveleft.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x-0.1, coords.y, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.moveleft.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x-1, coords.y, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlJustPressed(0, Config.Controls.moveleft.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x-0.5, coords.y, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        end

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.moveup.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y+0.1, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.moveup.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y+1, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlJustPressed(0, Config.Controls.moveup.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y+0.5, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        end

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.movedown.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y-0.1, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.movedown.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y-1, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlJustPressed(0, Config.Controls.movedown.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y-0.5, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        end

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.movedown.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y-0.1, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.movedown.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y-1, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        elseif IsControlJustPressed(0, Config.Controls.movedown.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y-0.5, coords.z)
            PlaceObjectOnGroundProperly(objectRes)
        end

        if IsControlJustPressed(0, Config.Controls.finish.key) then
            menu:Visible(true)
            break
        end
    end

end

function moveUpDown(objectRes, menu)
    menu:Visible(false)
    AddTextEntry('text', 
    Translation[Config.Locale]['controls'] ..'~n~~' .. Config.Controls.movehigher.name .. '~' .. Translation[Config.Locale]['move_higher'] .. '~n~~' 
        .. Config.Controls.movelower.name .. '~' .. Translation[Config.Locale]['move_lower'] .. '~n~~' 
        .. Config.Controls.fast.name .. '~' .. Translation[Config.Locale]['move_fast'] .. '~n~~' 
        .. Config.Controls.slow.name .. '~' .. Translation[Config.Locale]['move_slow'] .. '~n~~' 
        .. Config.Controls.finish.name .. '~' .. Translation[Config.Locale]['back_to_menu'] .. '~n~~' 
    )
    while true do
        Wait(0)
        BeginTextCommandDisplayHelp('text')
        EndTextCommandDisplayHelp(false, false, false, -1)

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.movehigher.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y, coords.z+0.025)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.movehigher.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y, coords.z+0.25)
        elseif IsControlJustPressed(0, Config.Controls.movehigher.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y, coords.z+0.125)
        end

        if IsControlPressed(0, Config.Controls.slow.key) and IsControlJustPressed(0, Config.Controls.movelower.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y, coords.z-0.025)
        elseif IsControlPressed(0, Config.Controls.fast.key) and IsControlJustPressed(0, Config.Controls.movelower.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y, coords.z-0.25)
        elseif IsControlJustPressed(0, Config.Controls.movelower.key) then
            local coords = GetEntityCoords(objectRes)
            SetEntityCoords(objectRes, coords.x, coords.y, coords.z-0.125)
        end

        if IsControlJustPressed(0, Config.Controls.finish.key) then
            menu:Visible(true)
            break
        end
    end

end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false 
		return result 
	else
		Citizen.Wait(500) 
		blockinput = false
		return nil
	end
end