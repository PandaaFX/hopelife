ESX = nil
local PersonalMenu = {
	ItemSelected = {},
	ItemIndex = {},
	WeaponData = {},
	WalletIndex = {},
	PersonData = {},
	WalletList = {_U('wallet_option_give'), _U('wallet_option_drop')},
	BillData = {},
	DoorState = {
		FrontLeft = false,
		FrontRight = false,
		BackLeft = false,
		BackRight = false,
		Hood = false,
		Trunk = false
	},
	WindowState = {
		FrontLeft = false,
		FrontRight = false,
		BackLeft = false,
		BackRight = false
	},
	DoorIndex = 1,
	DoorList = {_U('vehicle_door_frontleft'), _U('vehicle_door_frontright'), _U('vehicle_door_backleft'), _U('vehicle_door_backright')},
	WindowIndex = 1,
	WindowList = {_U('vehicle_door_frontleft'), _U('vehicle_door_frontright'), _U('vehicle_door_backleft'), _U('vehicle_door_backright')},
}

Player = {
	isDead = false,
	inAnim = false,
	crouched = false,
	handsup = false,
	pointing = false,
	noclip = false,
	godmode = false,
	invisible = false,
	ghostmode = false,
	showCoords = false,
	showName = false,
	gamerTags = {},
	group = 'user'
}

local societymoney, societymoney2 = nil, nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	if Config.DoubleJob then
		while ESX.GetPlayerData().job2 == nil do
			Citizen.Wait(10)
		end
	end

	ESX.PlayerData = ESX.GetPlayerData()

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) actualSkin = skin end)
		Citizen.Wait(100)
	end

	RefreshMoney()

	if Config.DoubleJob then
		RefreshMoney2()
	end

	PersonalMenu.WeaponData = ESX.GetWeaponList()

	for i = 1, #PersonalMenu.WeaponData, 1 do
		if PersonalMenu.WeaponData[i].name == 'WEAPON_UNARMED' then
			PersonalMenu.WeaponData[i] = nil
		else
			PersonalMenu.WeaponData[i].hash = GetHashKey(PersonalMenu.WeaponData[i].name)
		end
	end

	RMenu.Add('rageui', 'personal', RageUI.CreateMenu(Config.MenuTitle, _U('mainmenu_subtitle'), 0, 0, 'commonmenu', 'interaction_bgd', 255, 255, 255, 255))

	RMenu.Add('personal', 'person', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), 'Personen & Fahrzeug'))
	RMenu.Add('personal', 'wallet', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('wallet_title')))
	--RMenu.Add('personal', 'billing', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('bills_title')))
	RMenu.Add('personal', 'vehicle', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('vehicle_title')), function()
		if IsPedSittingInAnyVehicle(plyPed) then
			if (GetPedInVehicleSeat(GetVehiclePedIsIn(plyPed, false), -1) == plyPed) then
				return true
			end
		end

		return false
	end)

	RMenu.Add('personal', 'boss', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('bossmanagement_title')), function()
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
			return true
		end

		return false
	end)

	if Config.DoubleJob then
		RMenu.Add('personal', 'boss2', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('bossmanagement2_title')), function()
			if Config.DoubleJob then
				if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
					return true
				end
			end

			return false
		end)
	end

	RMenu.Add('personal', 'admin', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('admin_title')), function()
		if Player.group ~= nil and (Player.group == 'guide' or Player.group == 'mod' or Player.group == 'support' or Player.group == 'mod' or Player.group == 'admin' or Player.group == 'superadmin' or Player.group == 'dev') then
			return true
		end

		return false
	end)

	--RMenu.Add('inventory', 'actions', RageUI.CreateSubMenu(RMenu.Get('personal', 'inventory'), _U('inventory_actions_title')))
	--RMenu.Get('inventory', 'actions').Closed = function()
	--	PersonalMenu.ItemSelected = nil
	--end

	--RMenu.Add('loadout', 'actions', RageUI.CreateSubMenu(RMenu.Get('personal', 'loadout'), _U('loadout_actions_title')))
	--RMenu.Get('loadout', 'actions').Closed = function()
	--	PersonalMenu.ItemSelected = nil
	--end

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:onPlayerDeath', function()
	Player.isDead = true
	RageUI.CloseAll()
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('playerSpawned', function()
	Player.isDead = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshMoney()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	RefreshMoney2()
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		societymoney = ESX.Math.GroupDigits(money)
	end

	if ESX.PlayerData.job2 and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		societymoney2 = ESX.Math.GroupDigits(money)
	end
end)

-- Weapon Menu --
RegisterNetEvent('krz_personalmenu:Weapon_addAmmoToPedC')
AddEventHandler('krz_personalmenu:Weapon_addAmmoToPedC', function(value, quantity)
	local weaponHash = GetHashKey(value)

	if HasPedGotWeapon(plyPed, weaponHash, false) and value ~= 'WEAPON_UNARMED' then
		AddAmmoToPed(plyPed, value, quantity)
	end
end)

-- Admin Menu --
RegisterNetEvent('krz_personalmenu:Admin_BringC')
AddEventHandler('krz_personalmenu:Admin_BringC', function(plyCoords)
	SetEntityCoords(plyPed, plyCoords)
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			societymoney = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			societymoney2 = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job2.name)
	end
end

--Message text joueur
function Text(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(0)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.03)
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityPhysicsHeading(plyPed)
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end

function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(anim, function()
		SetPedMotionBlur(plyPed, false)
		SetPedMovementClipset(plyPed, anim, true)
		RemoveAnimSet(anim)
	end)
end


function CheckQuantity(number)
	number = tonumber(number)

	if type(number) == 'number' then
		number = ESX.Math.Round(number)

		if number > 0 then
			return true, number
		end
	end

	return false, number
end

function RenderPersonalMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		for i = 1, #RMenu['personal'], 1 do
			local buttonLabel = RMenu['personal'][i].ButtonLabel or RMenu['personal'][i].Menu.Title

			if type(RMenu['personal'][i].Restriction) == 'function' then
				if RMenu['personal'][i].Restriction() then
					RageUI.Button(buttonLabel, nil, {RightLabel = "→→→"}, true, function() end, RMenu['personal'][i].Menu)
				else
					RageUI.Button(buttonLabel, nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function() end, RMenu['personal'][i].Menu)
				end
			else
				RageUI.Button(buttonLabel, nil, {RightLabel = "→→→"}, true, function() end, RMenu['personal'][i].Menu)
			end
		end
	end)
end

function RenderActionsMenu(type)
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		if type == 'inventory' then
			RageUI.Button(_U('inventory_use_button'), "", {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					if PersonalMenu.ItemSelected.usable then
						TriggerServerEvent('esx:useItem', PersonalMenu.ItemSelected.name)
					else
						ESX.ShowNotification(_U('not_usable', PersonalMenu.ItemSelected.label))
					end
				end
			end)

			RageUI.Button(_U('inventory_give_button'), "", {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 3 then
						local closestPed = GetPlayerPed(closestPlayer)

						if IsPedOnFoot(closestPed) then
							if PersonalMenu.ItemIndex[PersonalMenu.ItemSelected.name] ~= nil and PersonalMenu.ItemSelected.count > 0 then
								TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', PersonalMenu.ItemSelected.name, PersonalMenu.ItemIndex[PersonalMenu.ItemSelected.name])
								RageUI.CloseAll()
							else
								ESX.ShowNotification(_U('amount_invalid'))
							end
						else
							ESX.ShowNotification(_U('in_vehicle_give', PersonalMenu.ItemSelected.label))
						end
					else
						ESX.ShowNotification(_U('players_nearby'))
					end
				end
			end)

			RageUI.Button(_U('inventory_drop_button'), "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
				if (Selected) then
					if PersonalMenu.ItemSelected.canRemove then
						if IsPedOnFoot(plyPed) then
							if PersonalMenu.ItemIndex[PersonalMenu.ItemSelected.name] ~= nil then
								TriggerServerEvent('esx:removeInventoryItem', 'item_standard', PersonalMenu.ItemSelected.name, PersonalMenu.ItemIndex[PersonalMenu.ItemSelected.name])
								RageUI.CloseAll()
							else
								ESX.ShowNotification(_U('amount_invalid'))
							end
						else
							ESX.ShowNotification(_U('in_vehicle_drop', PersonalMenu.ItemSelected.label))
						end
					else
						ESX.ShowNotification(_U('not_droppable', PersonalMenu.ItemSelected.label))
					end
				end
			end)
		elseif type == 'loadout' then
			if HasPedGotWeapon(plyPed, PersonalMenu.ItemSelected.hash, false) then
				RageUI.Button(_U('loadout_give_button'), "", {}, true, function(Hovered, Active, Selected)
					if (Selected) then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

						if closestDistance ~= -1 and closestDistance <= 3 then
							local closestPed = GetPlayerPed(closestPlayer)

							if IsPedOnFoot(closestPed) then
								local ammo = GetAmmoInPedWeapon(plyPed, PersonalMenu.ItemSelected.hash)
								TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_weapon', PersonalMenu.ItemSelected.name, ammo)
								RageUI.CloseAll()
							else
								ESX.ShowNotification(_U('in_vehicle_give', PersonalMenu.ItemSelected.label))
							end
						else
							ESX.ShowNotification(_U('players_nearby'))
						end
					end
				end)

				RageUI.Button(_U('loadout_givemun_button'), "", {RightBadge = RageUI.BadgeStyle.Ammo}, true, function(Hovered, Active, Selected)
					if (Selected) then
						local post, quantity = CheckQuantity(KeyboardInput('KORIOZ_BOX_AMMO_AMOUNT', _U('dialogbox_amount_ammo'), '', 8))

						if post then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestDistance ~= -1 and closestDistance <= 3 then
								local closestPed = GetPlayerPed(closestPlayer)

								if IsPedOnFoot(closestPed) then
									local ammo = GetAmmoInPedWeapon(plyPed, PersonalMenu.ItemSelected.hash)

									if ammo > 0 then
										if quantity <= ammo and quantity >= 0 then
											local finalAmmo = math.floor(ammo - quantity)
											SetPedAmmo(plyPed, PersonalMenu.ItemSelected.name, finalAmmo)

											TriggerServerEvent('krz_personalmenu:Weapon_addAmmoToPedS', GetPlayerServerId(closestPlayer), PersonalMenu.ItemSelected.name, quantity)
											ESX.ShowNotification(_U('gave_ammo', quantity, GetPlayerName(closestPlayer)))
											RageUI.CloseAll()
										else
											ESX.ShowNotification(_U('not_enough_ammo'))
										end
									else
										ESX.ShowNotification(_U('no_ammo'))
									end
								else
									ESX.ShowNotification(_U('in_vehicle_give', PersonalMenu.ItemSelected.label))
								end
							else
								ESX.ShowNotification(_U('players_nearby'))
							end
						else
							ESX.ShowNotification(_U('amount_invalid'))
						end
					end
				end)

				RageUI.Button(_U('loadout_drop_button'), "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
					if (Selected) then
						if IsPedOnFoot(plyPed) then
							TriggerServerEvent('esx:removeInventoryItem', 'item_weapon', PersonalMenu.ItemSelected.name)
							RageUI.CloseAll()
						else
							ESX.ShowNotification(_U('in_vehicle_drop', PersonalMenu.ItemSelected.label))
						end
					end
				end)
			else
				RageUI.GoBack()
			end
		end
	end)
end

function RenderInventoryMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		for i = 1, #ESX.PlayerData.inventory, 1 do
			if ESX.PlayerData.inventory[i].count > 0 then
				local invCount = {}

				for i = 1, ESX.PlayerData.inventory[i].count, 1 do
					table.insert(invCount, i)
				end

				RageUI.List(ESX.PlayerData.inventory[i].label .. ' (' .. ESX.PlayerData.inventory[i].count .. ')', invCount, PersonalMenu.ItemIndex[ESX.PlayerData.inventory[i].name] or 1, nil, {}, true, function(Hovered, Active, Selected, Index)
					if (Selected) then
						PersonalMenu.ItemSelected = ESX.PlayerData.inventory[i]
					end

					PersonalMenu.ItemIndex[ESX.PlayerData.inventory[i].name] = Index
				end, RMenu.Get('inventory', 'actions'))
			end
		end
	end)
end

function RenderWeaponMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		for i = 1, #PersonalMenu.WeaponData, 1 do
			if HasPedGotWeapon(plyPed, PersonalMenu.WeaponData[i].hash, false) then
				local ammo = GetAmmoInPedWeapon(plyPed, PersonalMenu.WeaponData[i].hash)

				RageUI.Button(PersonalMenu.WeaponData[i].label .. ' [' .. ammo .. ']', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						PersonalMenu.ItemSelected = PersonalMenu.WeaponData[i]
					end
				end, RMenu.Get('loadout', 'actions'))
			end
		end
	end)
end

function RenderWalletMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()

		RageUI.Button("Dokumente", nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				ExecuteCommand('documents')
				RageUI.CloseAll()
			end
		end)

		if Config.JSFourIDCard then
			RageUI.Button(_U('wallet_show_idcard_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
					else
						ESX.ShowNotification(_U('players_nearby'))
					end
				end
			end)

			RageUI.Button(_U('wallet_check_idcard_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
				end
			end)

			RageUI.Button(_U('wallet_show_driver_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
					else
						ESX.ShowNotification(_U('players_nearby'))
					end
				end
			end)

			RageUI.Button(_U('wallet_check_driver_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
				end
			end)

			RageUI.Button(_U('wallet_show_firearms_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
					else
						ESX.ShowNotification(_U('players_nearby'))
					end
				end
			end)

			RageUI.Button(_U('wallet_check_firearms_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
				end
			end)
			RageUI.Button(_U('wallet_show_bauamt_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'bauamt')
					else
						ESX.ShowNotification(_U('players_nearby'))
					end
				end
			end)

			RageUI.Button(_U('wallet_check_bauamt_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'bauamt')
				end
			end)
		end
	end)
end


function RenderBillingMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		for i = 1, #PersonalMenu.BillData, 1 do
			RageUI.Button(PersonalMenu.BillData[i].label, nil, {RightLabel = '$' .. ESX.Math.GroupDigits(PersonalMenu.BillData[i].amount)}, true, function(Hovered, Active, Selected)
				if (Selected) then
					
					ESX.TriggerServerCallback('esx_billing:payBill', function()
						ESX.TriggerServerCallback('krz_personalmenu:Bill_getBills', function(bills) PersonalMenu.BillData = bills end)
					end, PersonalMenu.BillData[i].id)
				end
			end)
		end
	end)
end

function RenderPersonMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		RageUI.Button('Geisel nehmen', nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 3.0 then
					ExecuteCommand('th')
				else
					ESX.ShowNotification(_U('players_nearby'))
				end
			end
		end)

		/*RageUI.Button('Bürger Tüte aufsetzen', nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 2.0 then
					TriggerEvent("NajblizszyGracz")
					RageUI.CloseAll()
				else
					ESX.ShowNotification(_U('players_nearby'))
				end
			end
		end)
		RageUI.Button('Bürger Tüte abnehmen', nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 2.0 then
					TriggerServerEvent('esx_worek:zdejmij')
					RageUI.CloseAll()
				else
					ESX.ShowNotification(_U('players_nearby'))
				end
			end
		end)*/
		RageUI.Button('Spieler Carry', nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 2.0 then
					TriggerEvent("rtx_carry:Carry", "1")
					RageUI.CloseAll()
				else
					ESX.ShowNotification(_U('players_nearby'))
				end
			end
		end)
		RageUI.Button('Spieler Carry beenden', nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 2.0 then
					TriggerEvent("rtx_carry:StopCarryViaEvent")
					RageUI.CloseAll()
				else
					ESX.ShowNotification(_U('players_nearby'))
				end
			end
		end)
		RageUI.Button('Fahrzeug Tracken', nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				ExecuteCommand('track')
				RageUI.CloseAll()
			end
		end)
	end)
end





function RenderVehicleMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		RageUI.Button(_U('vehicle_engine_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if IsPedSittingInAnyVehicle(plyPed) then
					local plyVeh = GetVehiclePedIsIn(plyPed, false)

					if GetIsVehicleEngineRunning(plyVeh) then
						SetVehicleEngineOn(plyVeh, false, false, true)
						SetVehicleUndriveable(plyVeh, true)
					elseif not GetIsVehicleEngineRunning(plyVeh) then
						SetVehicleEngineOn(plyVeh, true, false, true)
						SetVehicleUndriveable(plyVeh, false)
					end
				else
					ESX.ShowNotification(_U('no_vehicle'))
				end
			end
		end)

		RageUI.List(_U('vehicle_door_button'), PersonalMenu.DoorList, PersonalMenu.DoorIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
			if (Selected) then
				if IsPedSittingInAnyVehicle(plyPed) then
					local plyVeh = GetVehiclePedIsIn(plyPed, false)

					if Index == 1 then
						if not PersonalMenu.DoorState.FrontLeft then
							PersonalMenu.DoorState.FrontLeft = true
							SetVehicleDoorOpen(plyVeh, 0, false, false)
						elseif PersonalMenu.DoorState.FrontLeft then
							PersonalMenu.DoorState.FrontLeft = false
							SetVehicleDoorShut(plyVeh, 0, false, false)
						end
					elseif Index == 2 then
						if not PersonalMenu.DoorState.FrontRight then
							PersonalMenu.DoorState.FrontRight = true
							SetVehicleDoorOpen(plyVeh, 1, false, false)
						elseif PersonalMenu.DoorState.FrontRight then
							PersonalMenu.DoorState.FrontRight = false
							SetVehicleDoorShut(plyVeh, 1, false, false)
						end
					elseif Index == 3 then
						if not PersonalMenu.DoorState.BackLeft then
							PersonalMenu.DoorState.BackLeft = true
							SetVehicleDoorOpen(plyVeh, 2, false, false)
						elseif PersonalMenu.DoorState.BackLeft then
							PersonalMenu.DoorState.BackLeft = false
							SetVehicleDoorShut(plyVeh, 2, false, false)
						end
					elseif Index == 4 then
						if not PersonalMenu.DoorState.BackRight then
							PersonalMenu.DoorState.BackRight = true
							SetVehicleDoorOpen(plyVeh, 3, false, false)
						elseif PersonalMenu.DoorState.BackRight then
							PersonalMenu.DoorState.BackRight = false
							SetVehicleDoorShut(plyVeh, 3, false, false)
						end
					end
				else
					ESX.ShowNotification(_U('no_vehicle'))
				end
			end

			PersonalMenu.DoorIndex = Index
		end)
		RageUI.List("Fenster", PersonalMenu.WindowList, PersonalMenu.WindowIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
			if (Selected) then
				if IsPedSittingInAnyVehicle(plyPed) then
					local plyVeh = GetVehiclePedIsIn(plyPed, false)

					if Index == 1 then
						if not PersonalMenu.WindowState.FrontLeft then
							PersonalMenu.WindowState.FrontLeft = true
							RollDownWindow(plyVeh, 0)
						elseif PersonalMenu.WindowState.FrontLeft then
							PersonalMenu.WindowState.FrontLeft = false
							RollUpWindow(plyVeh, 0)
						end
					elseif Index == 2 then
						if not PersonalMenu.WindowState.FrontRight then
							PersonalMenu.WindowState.FrontRight = true
							RollDownWindow(plyVeh, 1)
						elseif PersonalMenu.WindowState.FrontRight then
							PersonalMenu.WindowState.FrontRight = false
							RollUpWindow(plyVeh, 1)
						end
					elseif Index == 3 then
						if not PersonalMenu.WindowState.BackLeft then
							PersonalMenu.WindowState.BackLeft = true
							RollDownWindow(plyVeh, 2)
						elseif PersonalMenu.WindowState.BackLeft then
							PersonalMenu.WindowState.BackLeft = false
							RollUpWindow(plyVeh, 2)
						end
					elseif Index == 4 then
						if not PersonalMenu.WindowState.BackRight then
							PersonalMenu.WindowState.BackRight = true
							RollDownWindow(plyVeh, 3)
						elseif PersonalMenu.WindowState.BackRight then
							PersonalMenu.WindowState.BackRight = false
							RollUpWindow(plyVeh, 3)
						end
					end
				else
					ESX.ShowNotification(_U('no_vehicle'))
				end
			end

			PersonalMenu.WindowIndex = Index
		end)

		RageUI.Button(_U('vehicle_hood_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if IsPedSittingInAnyVehicle(plyPed) then
					local plyVeh = GetVehiclePedIsIn(plyPed, false)

					if not PersonalMenu.DoorState.Hood then
						PersonalMenu.DoorState.Hood = true
						SetVehicleDoorOpen(plyVeh, 4, false, false)
					elseif PersonalMenu.DoorState.Hood then
						PersonalMenu.DoorState.Hood = false
						SetVehicleDoorShut(plyVeh, 4, false, false)
					end
				else
					ESX.ShowNotification(_U('no_vehicle'))
				end
			end
		end)

		RageUI.Button(_U('vehicle_trunk_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if IsPedSittingInAnyVehicle(plyPed) then
					local plyVeh = GetVehiclePedIsIn(plyPed, false)

					if not PersonalMenu.DoorState.Trunk then
						PersonalMenu.DoorState.Trunk = true
						SetVehicleDoorOpen(plyVeh, 5, false, false)
					elseif PersonalMenu.DoorState.Trunk then
						PersonalMenu.DoorState.Trunk = false
						SetVehicleDoorShut(plyVeh, 5, false, false)
					end
				else
					ESX.ShowNotification(_U('no_vehicle'))
				end
			end
		end)
	end)
end

function RenderBossMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		if societymoney ~= nil then
			RageUI.Button(_U('bossmanagement_chest_button'), nil, {RightLabel = '$' .. societymoney}, true, function() end)
		end

		RageUI.Button(_U('bossmanagement_hire_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_recruterplayer', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)

		RageUI.Button(_U('bossmanagement_fire_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_virerplayer', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)

		RageUI.Button(_U('bossmanagement_promote_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_promouvoirplayer', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)

		RageUI.Button(_U('bossmanagement_demote_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_destituerplayer', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)
	end)
end

function RenderBoss2Menu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		if societymoney ~= nil then
			RageUI.Button(_U('bossmanagement2_chest_button'), nil, {RightLabel = '$' .. societymoney2}, true, function() end)
		end

		RageUI.Button(_U('bossmanagement2_hire_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job2.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_recruterplayer2', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)

		RageUI.Button(_U('bossmanagement2_fire_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job2.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_virerplayer2', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)

		RageUI.Button(_U('bossmanagement2_promote_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job2.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_promouvoirplayer2', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)

		RageUI.Button(_U('bossmanagement2_demote_button'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
				if ESX.PlayerData.job2.grade_name == 'boss' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('players_nearby'))
					else
						TriggerServerEvent('krz_personalmenu:Boss_destituerplayer2', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('missing_rights'))
				end
			end
		end)
	end)
end

function RenderAdminMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		for i = 1, #Config.Admin, 1 do
			local authorized = false

			for j = 1, #Config.Admin[i].groups, 1 do
				if Config.Admin[i].groups[j] == Player.group then
					authorized = true
				end
			end

			if authorized then
				RageUI.Button(Config.Admin[i].label, nil, {}, true, function(Hovered, Active, Selected)
					if (Selected) then
						Config.Admin[i].command()
					end
				end)
			else
				RageUI.Button(Config.Admin[i].label, nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function() end)
			end
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Config.Controls.OpenMenu.keyboard) and not Player.isDead then
			if not RageUI.Visible() then
				ESX.TriggerServerCallback('krz_personalmenu:Admin_getUsergroup', function(plyGroup)
					Player.group = plyGroup

					ESX.TriggerServerCallback('krz_personalmenu:Bill_getBills', function(bills)
						PersonalMenu.BillData = bills
						ESX.PlayerData = ESX.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)
					end)
				end)
			end
		end

		if RageUI.Visible(RMenu.Get('rageui', 'personal')) then
			RenderPersonalMenu()
		end

		if RageUI.Visible(RMenu.Get('inventory', 'actions')) then
			RenderActionsMenu('inventory')
		elseif RageUI.Visible(RMenu.Get('loadout', 'actions')) then
			RenderActionsMenu('loadout')
		end

		if RageUI.Visible(RMenu.Get('personal', 'inventory')) then
			RenderInventoryMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'loadout')) then
			RenderWeaponMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'wallet')) then
			RenderWalletMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'billing')) then
			--RenderBillingMenu()
			TriggerEvent('myBills:openMenu')
			RageUI.CloseAll()
		end

		if RageUI.Visible(RMenu.Get('personal', 'person')) then
			RenderPersonMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'clothes')) then
			RenderClothesMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'vehicle')) then
			if not RMenu.Settings('personal', 'vehicle', 'Restriction')() then
				RageUI.GoBack()
			end
			RenderVehicleMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'boss')) then
			if not RMenu.Settings('personal', 'boss', 'Restriction')() then
				RageUI.GoBack()
			end
			RenderBossMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'boss2')) then
			if not RMenu.Settings('personal', 'boss2', 'Restriction')() then
				RageUI.GoBack()
			end
			RenderBoss2Menu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'admin')) then
			if not RMenu.Settings('personal', 'admin', 'Restriction')() then
				RageUI.GoBack()
			end
			RenderAdminMenu()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		plyPed = PlayerPedId()

		if IsControlJustReleased(0, Config.Controls.StopTasks.keyboard) and IsInputDisabled(2) and not Player.isDead then
			Player.handsup, Player.pointing = false, false
			ClearPedTasks(plyPed)
		end

		--[[if IsControlPressed(1, Config.Controls.TPMarker.keyboard1) and IsControlJustReleased(1, Config.Controls.TPMarker.keyboard2) and IsInputDisabled(2) and not Player.isDead then
			ESX.TriggerServerCallback('krz_personalmenu:Admin_getUsergroup', function(plyGroup)
				if plyGroup ~= nil and (plyGroup == 'guide' or plyGroup == 'mod' or plyGroup == 'support' or plyGroup == 'admin' or plyGroup == 'superadmin' or plyGroup == 'dev') then
					local waypointHandle = GetFirstBlipInfoId(8)

					if DoesBlipExist(waypointHandle) then
						Citizen.CreateThread(function()
							local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
							local foundGround, zCoords, zPos = false, -500.0, 0.0

							while not foundGround do
								zCoords = zCoords + 10.0
								RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
								Citizen.Wait(0)
								foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

								if not foundGround and zCoords >= 2000.0 then
									foundGround = true
								end
							end

							SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos)
							ESX.ShowNotification(_U('admin_tpmarker'))
						end)
					else
						ESX.ShowNotification(_U('admin_nomarker'))
					end
				end
			end)
		end]]--

		if Player.showCoords then
			local plyCoords = GetEntityCoords(plyPed, false)
			Text('~r~X~s~: ' .. ESX.Math.Round(plyCoords.x, 2) .. '\n~b~Y~s~: ' .. ESX.Math.Round(plyCoords.y, 2) .. '\n~g~Z~s~: ' .. ESX.Math.Round(plyCoords.z, 2) .. '\n~y~Angle~s~: ' .. ESX.Math.Round(GetEntityPhysicsHeading(plyPed), 2))
		end

		if Player.noclip then
			local plyCoords = GetEntityCoords(plyPed, false)
			local camCoords = getCamDirection()
			SetEntityVelocity(plyPed, 0.01, 0.01, 0.01)

			if IsControlPressed(0, 32) then
				plyCoords = plyCoords + (Config.NoclipSpeed * camCoords)
			end

			if IsControlPressed(0, 269) then
				plyCoords = plyCoords - (Config.NoclipSpeed * camCoords)
			end

			SetEntityCoordsNoOffset(plyPed, plyCoords, true, true, true)
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if Player.showName then
			for k, v in ipairs(ESX.Game.GetPlayers()) do
				local otherPed = GetPlayerPed(v)

				if otherPed ~= plyPed then
					if #(GetEntityCoords(plyPed, false) - GetEntityCoords(otherPed, false)) < 5000.0 then
						Player.gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
					else
						RemoveMpGamerTag(Player.gamerTags[v])
						Player.gamerTags[v] = nil
					end
				end
			end
		end

		Citizen.Wait(100)
	end
end)

function setUniform(group)
    local playerPed = PlayerPedId()
    
    TriggerEvent('skinchanger:getSkin', function(skin)
    ESX.TriggerServerCallback("Admin:getRankFromPlayer", function(group)
        if skin.sex == 0 then
            if group == "superadmin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.superadmin.male)
            elseif group == "admin" then
				if GetPlayerName(PlayerId()) == Config.Admin2.Name2 then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.superadmin.male)
				else
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.admin.male)
				end
            elseif group == "mod" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.mod.male)
            elseif group == "support" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.support.male)
			elseif group == "dev" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.dev.male)		
			elseif group == "guide" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.guide.male)				
            end
        else
            if group == "superadmin" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.superadmin.female)
			elseif group == "admin" then
				print(GetPlayerName(PlayerId()))
				if GetPlayerName(PlayerId()) == Config.Admin2.Name1 then
						TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.superadmin.female)
					else
                    	TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.admin.female)
					end
            elseif group == "mod" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.mod.female)
            elseif group == "support" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.support.female)
			elseif group == "dev" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.dev.female)		
			elseif group == "guide" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Admin2.guide.female)				
            end
            end
        end)
    end)
end

RegisterNetEvent("toggleDuty")
AddEventHandler("toggleDuty", function()
    local playerPed = PlayerPedId()
    if duty then
        duty = false
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)		
    else
        duty = true
        setUniform(group)
    end 
end)

RegisterNetEvent('adminhl:c_godmodexyz')
local godmode = false

AddEventHandler('adminhl:c_godmodexyz', function()
	local playerPed = GetPlayerPed(-1)
	exports.logmanager:log{message = "adminhl:c_godmodexyz"}
	if not godmode then
	    godmode = true
	    --ESX.ShowNotification("GodMode ~g~ON")


	elseif godmode then
	    godmode = false
	end
end)

-- Citizen.CreateThread(function() --Godmode
-- 	while true do
-- 		Citizen.Wait(1)

-- 		if godmode then
-- 			SetEntityInvincible(GetPlayerPed(-1), true)
-- 			SetPlayerInvincible(GetPlayerPed(-1), true)
-- 			--SetPedCanRagdoll(GetPlayerPed(-1), false)
-- 			ClearPedBloodDamage(GetPlayerPed(-1))
-- 			ResetPedVisibleDamage(GetPlayerPed(-1))
-- 			ClearPedLastWeaponDamage(GetPlayerPed(-1))
-- 			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
-- 			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
-- 			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
-- 		elseif not godmode then
-- 			SetEntityInvincible(GetPlayerPed(-1), false)
-- 			SetPlayerInvincible(GetPlayerPed(-1), false)
-- 			--SetPedCanRagdoll(GetPlayerPed(-1), true)
-- 			ClearPedLastWeaponDamage(GetPlayerPed(-1))
-- 			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
-- 			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
-- 			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function() --Godmode
	while true do
		Citizen.Wait(1)

		local playerPed = GetPlayerPed(-1)
		
		if godmode then
			SetEntityInvincible(playerPed, true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(playerPed, false)
			ClearPedBloodDamage(playerPed)
			ResetPedVisibleDamage(playerPed)
			ClearPedLastWeaponDamage(playerPed)
			SetEntityProofs(playerPed, true, true, true, true, true, true, true, true)
			SetEntityOnlyDamagedByPlayer(playerPed, false)
			SetEntityCanBeDamaged(playerPed, false)
		else
			SetEntityInvincible(playerPed, false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(playerPed, true)
			ClearPedLastWeaponDamage(playerPed)
			SetEntityProofs(playerPed, false, false, false, false, false, false, false, false)
			SetEntityOnlyDamagedByPlayer(playerPed, false)
			SetEntityCanBeDamaged(playerPed, true)
			Citizen.Wait(300)
		end
	end
end)

