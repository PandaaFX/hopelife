RegisterNetEvent('msk_weaponammo:openAttachmentMenu')
AddEventHandler('msk_weaponammo:openAttachmentMenu', function()
    if Config.Menu:match('ESX') then
        OpenAttachmentMenuESX() -- ESX Menu
    elseif Config.Menu:match('NativeUI') then
        OpenAttachmentMenuNativeUI() -- NativeUI
    end
end)

function OpenAttachmentMenuESX()
    local playerPed = PlayerPedId()
	local hash = GetSelectedPedWeapon(playerPed)
    local weapon = ESX.GetWeaponFromHash(hash)

    local elements = {
		{label = _U('weapon_components'), value = 'components'},
	}
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'components', {
		title    = _U('weapon_components'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'components' then
            local elements = {
                {label = _U('scope'), value = 'scope'},
                {label = _U('grip'), value = 'grip'},
                {label = _U('flashlight'), value = 'flashlight'},
                {label = _U('clip_extended'), value = 'clip_extended'},
                {label = _U('suppressor'), value = 'suppressor'},
                {label = _U('luxary_finish'), value = 'luxary_finish'},
                {label = _U('tint'), value = 'tint'},
            }
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weapon_attachments', {
                title    = _U('weapon_components'),
                align    = 'top-left',
                elements = elements
            }, function(data2, menu2)
                local action = data2.current.value

                if action == 'tint' then
                    TriggerServerEvent('msk_weaponammo:removeWeaponTint', weapon.name)
                else
                    TriggerServerEvent('msk_weaponammo:removeWeaponComponent', weapon.name, action)
                    Config.Notification(source, 'client', nil, _U('used_attachment_remover', data2.current.label))
                end
            end, function(data2, menu2)
                menu2.close()
            end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

---- NativeUI ----

if Config.Menu:match('NativeUI') then
    _menuPool = NativeUI.CreatePool()
    local mainMenu

    Citizen.CreateThread(function()
        while true do
            if _menuPool:IsAnyMenuOpen() then 
                _menuPool:ProcessMenus()
            end
            Citizen.Wait(1)
        end
    end)

    local Items = {
        {name = _U('scope'), desc = _U('remove_scope'), comtype = 'scope', type = 'component'},
        {name = _U('grip'), desc = _U('remove_grip'), comtype = 'grip', type = 'component'},
        {name = _U('flashlight'), desc = _U('remove_flashlight'), comtype = 'flashlight', type = 'component'},
        {name = _U('clip_extended'), desc = _U('remove_clip_extended'), comtype = 'clip_extended', type = 'component'},
        {name = _U('suppressor'), desc = _U('remove_suppressor'), comtype = 'suppressor', type = 'component'},
        {name = _U('luxary_finish'), desc = _U('remove_luxary_finish'), comtype = 'luxary_finish', type = 'component'},
        {name = _U('tint'), desc = _U('remove_tint'), type = 'tint'},
    }

    function OpenAttachmentMenuNativeUI()
        local playerPed = PlayerPedId()
        local hash = GetSelectedPedWeapon(playerPed)
        local weapon = ESX.GetWeaponFromHash(hash)

        mainMenu = NativeUI.CreateMenu(_U('weapon_components'), '~b~'.. _U('remove_components'))
        _menuPool:Add(mainMenu)

        local Components = _menuPool:AddSubMenu(mainMenu, _U('components'))

        for k,v in pairs(Items) do
            local ComponentList = NativeUI.CreateItem(v.name, '~b~'.. v.desc)

            Components:AddItem(ComponentList)
            ComponentList.Activated = function(sender, index)
                if v.type == 'component' then
                    TriggerServerEvent('msk_weaponammo:removeWeaponComponent', weapon.name, v.comtype)
                    Config.Notification(source, 'client', nil, _U('used_attachment_remover', v.name))
                elseif v.type == 'tint' then
                    TriggerServerEvent('msk_weaponammo:removeWeaponTint', weapon.name)
                end
            end
        end

        mainMenu:Visible(true)
        _menuPool:RefreshIndex()
        _menuPool:MouseControlsEnabled(false)
        _menuPool:MouseEdgeEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
    end
end