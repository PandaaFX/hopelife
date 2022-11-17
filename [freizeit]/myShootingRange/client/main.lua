ESX             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

local currentMessage = {
	["scoreboard"] = nil
	,["shooting_range"] = nil
}

local isInSpot = {
	["scoreboard"] = false
	,["shooting_range"] = false
}
local currentSpot = {
	["scoreboard"] = nil
	,["shooting_range"] = nil
}

local hideMarker = false

local isInMenu = false
local inShooting = false
local denyMessage = false


local _menuPool  = NativeUI.CreatePool()

local shootingrangeMenu
local WeaponIsRented = false
local objectsAppered = 0

local target = nil
local targetCoords = {}
local currentPoints = 0
local shootingrangeConfig = {}



Citizen.CreateThread(function()
    while true do

        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()
        end

        if isInMenu then
			if IsControlJustReleased(1, Config.HotKeyClose) then
				shootingrangeMenu:Visible(false)
				isInMenu = false
			end
        end
        Citizen.Wait(1)
    end
end)





RegisterNetEvent("myShootingRange:notify")
AddEventHandler("myShootingRange:notify", function(notificationtext)
	if Config.notifications.BtwLouis then
		TriggerEvent('notifications', '#07b95e', '', notificationtext)
	elseif Config.notifications.DefaultFiveM then
		SetNotificationTextEntry('STRING')
		AddTextComponentString(notificationtext)
		DrawNotification(false, false)
  elseif Config.notifications.Custom then
    --here your custom code...
  end
end)


RegisterNetEvent("myShootingRange:notifyOthers")
AddEventHandler("myShootingRange:notifyOthers", function(playerID, notificationtext, coords)
	local myId = PlayerId()
    local otherID = GetPlayerFromServerId(playerID) 
	local playerCoords = GetEntityCoords(PlayerPedId())
	local distance = Vdist(playerCoords, coords.x, coords.y, coords.z)

	if distance <= Config.NotifyOthersDistance and otherID ~= myId then 
		TriggerEvent("myShootingRange:notify", notificationtext)
	end 
end)

RegisterNetEvent("myShootingRange:helperText")
AddEventHandler("myShootingRange:helperText", function(notificationtext)
	if Config.notifications.BtwLouis then
		TriggerEvent('notifications', '#07b95e', '', notificationtext)
	elseif Config.notifications.DefaultFiveM then
		showInfobar(notificationtext)
  elseif Config.notifications.Custom then
    --here your custom code...
  end
end)



-- draw markers
Citizen.CreateThread(function()
	while true do		
		if isInMenu == false and inShooting == false and hideMarker == false then
			Citizen.Wait(1)

			local playerCoords = GetEntityCoords(PlayerPedId())
			local executeSleep = true
			local ped = PlayerPedId()
			local playerCoords = GetEntityCoords(ped)

			for key, values in pairs(Config.ShootingRanges) do

				for key2, values2 in pairs(values.pos) do
					local distance = Vdist(playerCoords, values2.x, values2.y, values2.z)
					if distance < Config.MarkerDrawDistance then
						DoDrawMarker(values2)
						executeSleep = false
					end
				end 

				
				local distance2 = Vdist(playerCoords, values.bestlistPos.x, values.bestlistPos.y, values.bestlistPos.z)
				
				if distance2 < Config.MarkerDrawDistance then
					DoDrawMarker(values.bestlistPos)
					executeSleep = false
				end
			end

			if executeSleep then
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(250)
		end
	end
end)


-- show notification
Citizen.CreateThread(function()  
	while true do
		Citizen.Wait(350)
		isInSpot["shooting_range"] = false
  
		if isInMenu == false or inShooting == false then

			local ped = PlayerPedId()
			local playerCoords = GetEntityCoords(ped)


			if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
				if DoesEntityExist(ped)then
					if IsPedDeadOrDying(ped) == false then
						for key, values in pairs(Config.ShootingRanges) do

							for key2, values2 in pairs(values.pos) do
								local distance = Vdist(playerCoords, values2.x, values2.y, values2.z)
								if distance < Config.NotificationDistance then
									isInSpot["shooting_range"] = true
									currentSpot["shooting_range"] = values
									currentMessage["shooting_range"] = Translations[Config.Locale].notification_openmenu
								end
							end 

							local distance = Vdist(playerCoords, values.pos.x, values.pos.y, values.pos.z)
						end
					end
				end
			end
		end 
		if not isInSpot["shooting_range"] then
			currentSpot["shooting_range"] = nil
			currentMessage["shooting_range"] = nil
		end
	  end 
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if (currentMessage["scoreboard"] ~= nil or currentMessage["shooting_range"] ~= nil) and hideMarker == false and inShooting == false then
			local curmessage = currentMessage["scoreboard"]
			if curmessage == nil then 
				curmessage = currentMessage["shooting_range"]
			end 
			ESX.ShowHelpNotification(curmessage)
		else 
			Citizen.Wait(1)
		end 
	end
end)

Citizen.CreateThread(function()  
	while true do
		Citizen.Wait(350)
		isInSpot["scoreboard"] = false
  
		
		local ped = PlayerPedId()
		local playerCoords = GetEntityCoords(ped)


		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			if DoesEntityExist(ped)then
				if IsPedDeadOrDying(ped) == false then
					for key, values in pairs(Config.ShootingRanges) do
						local distance = Vdist(playerCoords, values.bestlistPos.x, values.bestlistPos.y, values.bestlistPos.z)
			
						if distance <=  Config.NotificationScoreListDistance then
							isInSpot["scoreboard"] = true
							currentSpot["scoreboard"] = values
							currentMessage["scoreboard"] = Translations[Config.Locale].notification_openmenu_bestlist						
						end 
					end
				end
			end
		end
		
		if not isInSpot["scoreboard"] then
			currentSpot["scoreboard"] = nil
			currentMessage["scoreboard"] = nil
		end
	end 
end)






  
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if currentSpot["scoreboard"] then
			local player = PlayerPedId()
			if not IsPedInAnyVehicle(player) then
				if IsControlJustPressed(0, Keys[Config.HotKeyOpen]) then
					openScoreBoard(currentSpot["scoreboard"].id)
				end 
			end
		end
	end
end)



RegisterNUICallback("close", function(data)
	closeScoreBoard()
end)


  
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if isInMenu == false and inShooting == false then
			if currentSpot["shooting_range"] and hideMarker == false then
				local player = PlayerPedId()
				if not IsPedInAnyVehicle(player) then
					if IsControlJustPressed(0, Keys[Config.HotKeyOpen]) then
						showMenu()				
					end 
				end
			end
		elseif isInMenu == true and currentSpot["shooting_range"] == nil then 
			shootingrangeMenu:Visible(false)
			isInMenu = false
		elseif inShooting == true and currentSpot["shooting_range"] == nil then 
			TriggerEvent("myShootingRange:notify", Translations[Config.Locale].left_zone)
			TriggerServerEvent("myShootingRange:notifyOthers", GetEntityCoords(PlayerPedId()), Translations[Config.Locale].left_zone_others, true)

			endShootingPractice(true)
		else
			Citizen.Wait(250)
		end 
	end
end)






-- handle objects to show
Citizen.CreateThread(function()  
	while true do
		Citizen.Wait(1)

		if inShooting then 
			objectsAppered = objectsAppered + 1

			if currentSpot["shooting_range"] ~= nil and currentSpot["shooting_range"].targets ~= nil then 

				local number = math.random(1, #currentSpot["shooting_range"].targets)
				targetCoords = currentSpot["shooting_range"].targets[number]
	
				RequestModel('prop_range_target_01')
				while not HasModelLoaded('prop_range_target_01') do
					Citizen.Wait(0)
				end
	
				target = CreateObject('prop_range_target_01',targetCoords.x,targetCoords.y,targetCoords.z, false, true, true)
	
				SetEntityHeading(target, targetCoords.heading)
				Citizen.Wait(shootingrangeConfig.difficulty.time)
	
	
				DeleteObject(target)
	
				if objectsAppered == shootingrangeConfig.targetcount then
					endShootingPractice(false)
				end
			else
				endShootingPractice(false)
			end 



			
		else
			Citizen.Wait(250)
		end 
	end 
end)




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if inShooting then
			if target ~= nil then
				if HasEntityBeenDamagedByAnyPed(target) then

					local pointsToAdd = 0

					if HasBulletImpactedInBox(targetCoords.x + 0.06 ,targetCoords.y + 0.06 , targetCoords.z + 0.6,  targetCoords.x-0.06,targetCoords.y - 0.06 ,targetCoords.z + 0.45,true,true) then
						pointsToAdd = Config.Points["perfect"]
					elseif HasBulletImpactedInBox(targetCoords.x + 0.12,targetCoords.y + 0.12,targetCoords.z+0.41,  targetCoords.x-0.12 , targetCoords.y -0.12 , targetCoords.z + 0.69,true,true) then
						pointsToAdd = Config.Points["very_good"]
						
					elseif HasBulletImpactedInBox(targetCoords.x + 0.16 , targetCoords.y + 0.16 , targetCoords.z + 0.33,  targetCoords.x-0.16 , targetCoords.y - 0.16,targetCoords.z+0.76,true,true) then
						pointsToAdd = Config.Points["good"]
					
					elseif HasBulletImpactedInBox(targetCoords.x + 0.21,targetCoords.y+0.21,targetCoords.z+0.25,  targetCoords.x - 0.21,targetCoords.y - 0.21 , targetCoords.z - 0.85,true,true) then
						pointsToAdd = Config.Points["ok"]
					else
						pointsToAdd = Config.Points["notgood"]
					
					end

					pointsToAdd = pointsToAdd
					DrawTargetText(pointsToAdd)

					currentPoints = currentPoints + pointsToAdd
					DeleteObject(target)

					target = nil
					targetCoords = {}
				end
			end
		end
	end
end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	if inShooting then 
		endShootingPractice(true)
	end

	print('The resource ' .. resourceName .. ' was stopped.')
end)



-- functions
function DrawTargetText(text)

	local coords = vector3(targetCoords.x,targetCoords.y, targetCoords.z + 2)

	local displaying = true
    Citizen.CreateThread(function()
        Wait(1000)
        displaying = false
    end)

	Citizen.CreateThread(function()
        while displaying do
            Wait(1)
            ESX.Game.Utils.DrawText3D(coords, "~r~+" .. text , 5)
        end
    end)
end

-- functions


function closeScoreBoard()
	SetNuiFocus(false, false)
end 

function openScoreBoard(shootingrange_id)
	ESX.TriggerServerCallback('myShootingRange:loadScores', function(data, mydata)
		--show tablet 
		SendNUIMessage({
			action = "show"
			,tabledata = data
			,owndata = mydata
			,locale = Config.Locale
		})

		SetNuiFocus(true, true)
	
	end, shootingrange_id)
end 


function resetShooringrangeSelections()
	shootingrangeConfig = {}
	shootingrangeConfig.difficulty = Config.Difficulties[1]
	shootingrangeConfig.targetcount = Config.TargetCounts[1]
	shootingrangeConfig.weaponSelected = Config.AllowedWeapons[1]
end

function showMenu()
	isInMenu = true
	resetShooringrangeSelections()

	if shootingrangeMenu ~= nil and shootingrangeMenu:Visible() then
		shootingrangeMenu:Visible(false)
	end

	shootingrangeMenu = NativeUI.CreateMenu(Translations[Config.Locale].shooting_range)
    _menuPool:Add(shootingrangeMenu)
	shootingrangeMenu.Controls.Back.Enabled = false

	local compValues = {}

	for key, values in pairs(Config.Difficulties) do 
		table.insert(compValues, Translations[Config.Locale][values.Translation])
	end

	local difficultyList = NativeUI.CreateListItem(Translations[Config.Locale].difficulty, compValues, 1)
    shootingrangeMenu:AddItem(difficultyList)

	compValues = {}
	for key, values in pairs(Config.TargetCounts) do 
		table.insert(compValues, values)
	end

	local targetcountList = NativeUI.CreateListItem(Translations[Config.Locale].targetcount, compValues, 1)
    shootingrangeMenu:AddItem(targetcountList)

	compValues = {}
	for key, values in pairs(Config.AllowedWeapons) do 

		local hasWeapon = checkIfPlayerHasWeapon(values.name)

		if Config.AllowRentWeapon then 
			local text = ESX.GetWeaponLabel(values.name)
		
			if hasWeapon == false then 
				text  = text .. " (+" .. values.rentPrice .. "$)"
			end
	
			table.insert(compValues, text)
		end
	end

	local weaponList = NativeUI.CreateListItem(Translations[Config.Locale].weaponlist, compValues, 1)
    shootingrangeMenu:AddItem(weaponList)

	local startItem = NativeUI.CreateItem(Translations[Config.Locale].start, currentSpot["shooting_range"].price .. '$')
	shootingrangeMenu:AddItem(startItem)

	


	startItem.Activated = function(sender, item, index)
		shootingrangeMenu:Visible(false)
		isInMenu = false

		startShootingPractice()
	end

	shootingrangeMenu.OnListChange = function(sender, item, index)

		if item == difficultyList then 
			shootingrangeConfig.difficulty = Config.Difficulties[index]
		elseif item == targetcountList then 
			shootingrangeConfig.targetcount = Config.TargetCounts[index]
		elseif item == weaponList then 
			shootingrangeConfig.weaponSelected = Config.AllowedWeapons[index]
		end 
	end




	shootingrangeMenu:Visible(true)
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled(false)
end

function DoDrawMarker(spot)
	DrawMarker(
	  30
	  , spot.x
	  , spot.y
	  , spot.z
	  , 0.0
	  , 0.0
	  , 0.0
	  , 2.0
	  , 2.0
	  , 0.5
	  , 0.6
	  , 0.6
	  , 0.6
	  , 255 -- red of marker
	  , 0-- green of marker
	  , 0-- blue of marker
	  , 255 -- alpha
	  , false
	  , true
	  , 2
	  , true
	  , nil
	  , nil
	  , false
	)
end

function checkIfPlayerHasWeapon(weaponname)
	local retval =  HasPedGotWeapon(PlayerPedId(), GetHashKey(weaponname), false)
	return retval
end

function startShootingPractice()

	currentPoints = 0
	objectsAppered = 0

	WeaponIsRented = checkIfPlayerHasWeapon(shootingrangeConfig.weaponSelected.name) == false

	local price = currentSpot["shooting_range"].price
	local rentPrice = 0

	if WeaponIsRented then 
		rentPrice = shootingrangeConfig.weaponSelected.rentPrice
	end

	ESX.TriggerServerCallback('myShootingRange:pay', function(result)
		if result then 

			
			hideMarker = true


			local targetCount = shootingrangeConfig.targetcount
			local waitTime = shootingrangeConfig.difficulty.time
		
		
			if WeaponIsRented then 
				GiveWeaponToPed(PlayerPedId(), GetHashKey(shootingrangeConfig.weaponSelected.name), 512, false, true)
			else
				SetCurrentPedWeapon(PlayerPedId(), GetHashKey(shootingrangeConfig.weaponSelected.name), true)
			end 
		
		
		
		
			local WaitSecs = Config.CountDownTimeSek
		
			while WaitSecs >= 0 do
				if WaitSecs == 0 then 
					TriggerEvent("myShootingRange:notify", Translations[Config.Locale].runrangestart)
				else
					TriggerEvent("myShootingRange:notify", tostring(WaitSecs) .. " ...")
				end 
				WaitSecs = WaitSecs - 1
				Citizen.Wait(1000)
			end 
		
			
			inShooting = true
			hideMarker = false
		else
			TriggerEvent("myShootingRange:notify", Translations[Config.Locale].cannot_pay)
		end 
	end, price, rentPrice)
end 


function endShootingPractice(dueToCancel)
	inShooting = false
	if target ~= nil then 
		DeleteObject(target)
	end 
	if WeaponIsRented then 
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey(shootingrangeConfig.weaponSelected.name))
		WeaponIsRented = false
	end 
	if dueToCancel == false then 
		TriggerServerEvent("myShootingRange:saveScore", shootingrangeConfig.targetcount, currentPoints, shootingrangeConfig.difficulty, shootingrangeConfig.weaponSelected.name, currentSpot["shooting_range"].id , GetEntityCoords(PlayerPedId()))
	end 
end 



function showInfobar(msg)
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

