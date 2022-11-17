ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local PlayerIsDriver = false
local PlayerInVehicle = false
local CurrentVehicle = nil
local hasBeenCaught = false
local mobileRadars = {}
local propsCreated = {}

local mainMenu
_menuPool = NativeUI.CreatePool()
local currentSpeedcamLocation
local currentRadius = Config.Ranges[1]
local currentMaxSpeed = 50

local currentSpeedcam

local isNearSpeedcam = false
local isAtSpeedcam = false

local background = Sprite.New('custombanner', 'speedcambanner', 0, 0, 1024, 256)


Citizen.CreateThread(function()
    while true do
        Wait(1)
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()

			if mainMenu ~= nil and mainMenu:Visible() and currentSpeedcamLocation ~= nil then
				DrawMarker(27, currentSpeedcamLocation.x, currentSpeedcamLocation.y, GetEntityCoords(PlayerPedId())[3] - 0.94, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, currentRadius, currentRadius, 1.0, 0, 0, 136, 75, false, false, 2, false, false, false, false)
			end
        end

		if isNearSpeedcam and not _menuPool:IsAnyMenuOpen() then
			if currentSpeedcam.pos ~= nil then
				DrawMarker(27, currentSpeedcam.pos.x, currentSpeedcam.pos.y, currentSpeedcam.pos.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 0, 136, 175, false, false, 2, false, false, false, false)
			end
		end

		if isAtSpeedcam then
			showInfobar(Translations[Config.Locale]['infobar_text'])

			if IsControlJustPressed(0, 38) then
				generateCreateMenu(currentSpeedcam, false)
			end
		end
    end
end)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(250)

		if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == Config.policeJob or ESX.PlayerData.job.name == Config.policeJob2 then
			
			isNearSpeedcam = false
			isAtSpeedcam = false
			
			for k, v in pairs(Config.RadarControls) do
				if v.isMobile ~= nil and v.isMobile then

					local playerCoords = GetEntityCoords(PlayerPedId())
					local distance = Vdist(playerCoords, v.pos.x, v.pos.y, v.pos.z)

					if distance < 2.0 then
						isNearSpeedcam = true
						isAtSpeedcam = true
						currentSpeedcam = v
						
					elseif distance < 6.0 then
						isNearSpeedcam = true
						currentSpeedcam = v
						
					end

				end
			end
		else
			isNearSpeedcam = false
			isAtSpeedcam = false
		end


		if PlayerIsDriver == false and isInVehicle(PlayerPedId()) then -- beim einsteigen

			CurrentVehicle = getVehicle(PlayerPedId())
			PlayerIsDriver = GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId()

		elseif PlayerIsDriver == true and not isInVehicle(PlayerPedId()) then --beim aussteigen
			PlayerIsDriver = false
			CurrentVehicle = nil 
		end 
	end
end)


function refreshRadars()
	if propsCreated ~= nil then
		for key, value in pairs(propsCreated) do
			DeleteObject(value)
		end 
	end

	Citizen.Wait(100)

	-- spawn all speedcams
	for key, values in pairs(Config.RadarControls) do

		if values.propPos ~= nil then 
			for propkey, propvalues in pairs(values.propPos) do 
				if values.isMobile ~= nil and values.isMobile then
					values.object = createProp(propvalues, 6.9, false)
				else
					values.object = createProp(propvalues, nil, true)
				end
				
				
			end 
		end 

	end

end

Citizen.CreateThread(function()

	-- get mobile speedcams from the database
	ESX.TriggerServerCallback('myRadarcontrol:getMobileRadars', function(mobileradars)

		for k, v in pairs(mobileradars) do
			local radarPos = {
				x = v.positionX,
				y = v.positionY,
				z = v.positionZ,
				heading = v.heading
			}
	
			table.insert(Config.RadarControls, {
				name = v.label
				, society = v.society
				, maxSpeed = v.maxSpeed
				, pos = radarPos
				, propPos = {radarPos}
				, flashDistance = v.flashRange
				, isMobile = true
				, mobileID = v.id
			})
		end
		
		Citizen.Wait(100)

		-- spawn all speedcams
		for key, values in pairs(Config.RadarControls) do

			if values.propPos ~= nil then 
				for propkey, propvalues in pairs(values.propPos) do 
					if values.isMobile ~= nil and values.isMobile then
						values.object = createProp(propvalues, 6.9, false)
					else
						values.object = createProp(propvalues, nil, true)
					end
					
					
				end 
			end 

	
		end
	
	
		while true do
			Citizen.Wait(10)
			for key, values in pairs(Config.RadarControls) do
				local playerCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, values.pos.x, values.pos.y, values.pos.z)
	
				if distance <= values.flashDistance and CurrentVehicle ~= nil then 
					local maxSpeed = values.maxSpeed
					local currentSpeed = getSpeed()
					
					local job_blacklisted = checkIfJobBlacklisted()
	
					local tolerance = maxSpeed * Config.toleranceRate
					if currentSpeed > (maxSpeed + tolerance) and hasBeenCaught == false and GetVehicleCurrentGear(CurrentVehicle) ~= 0 then 
	
						--if checkIfJobBlacklisted() == false then 
							
							local fine = checkFine(maxSpeed, currentSpeed)
	
							if fine > 0 then 
	
								if Config.UseFlashingScreen == true then
									TriggerEvent('myRadarcontrol:startFlash')
									Citizen.Wait(200)
									TriggerEvent('myRadarcontrol:endFlash')
								end
	
								local milesTxt = "mp/h"
	
								if Config.UseKMH then 
									milesTxt = "km/h"
								end 
								
								if PlayerIsDriver and job_blacklisted == false then
									
									showPictureNotification("CHAR_BLANK_ENTRY", Translations[Config.Locale].caught01 .. '\n' .. Translations[Config.Locale].caught02 .. currentSpeed .. milesTxt .. '\n' .. Translations[Config.Locale].caught03 .. maxSpeed .. milesTxt, Translations[Config.Locale].caught_title, Translations[Config.Locale].caught_subtitle)
									sendInvoice(fine, values.name,  currentSpeed, maxSpeed + tolerance, values.society)
									if values.isMobile ~= nil and values.isMobile then
										TriggerServerEvent('myRadarcontrol:addProfit', 'mobile', values.mobileID, values.name, fine)
										
									else

										TriggerServerEvent('myRadarcontrol:addProfit', 'static', key, values.name, fine)
									end
									
								
								end 
	
								hasBeenCaught = true
								Citizen.Wait(5000) -- prevent from flash spam
							end 					
						--end 
					end 
				else
					hasBeenCaught = false
				end 
			end
		end

	end)

end)

function showProfitMenu()

	local profitMenu = NativeUI.CreateMenu(Translations[Config.Locale]['profit_title'], nil)
	_menuPool:Add(profitMenu)

	profitMenu:SetBannerSprite(background, true)

	if profitMenu ~= nil and profitMenu:Visible() then
		profitMenu:Visible(false)
	end

	local allRadarsSub = _menuPool:AddSubMenu(profitMenu, Translations[Config.Locale]['all_radars'], '~b~')
	profitMenu.Items[1]:RightLabel('~b~→→→')
	allRadarsSub:SetBannerSprite(background, true)
	for k, v in pairs(Config.RadarControls) do
		local radarSub = _menuPool:AddSubMenu(allRadarsSub, v.name)
		radarSub:SetBannerSprite(background, true)
		local milesTxt = "mp/h"

		if Config.UseKMH then 
			milesTxt = "km/h"
		end
		allRadarsSub.Items[k]:RightLabel('~o~' .. v.maxSpeed .. milesTxt)

		local societyItem = NativeUI.CreateItem(Translations[Config.Locale]['owner'], '~b~')
		societyItem:RightLabel(v.society or Config.defaultSociety)
		radarSub:AddItem(societyItem)

		local maxSpeedItem = NativeUI.CreateItem(Translations[Config.Locale]['max_speed'], '~b~')
		maxSpeedItem:RightLabel(v.maxSpeed .. milesTxt)
		radarSub:AddItem(maxSpeedItem)

		local rangeItem = NativeUI.CreateItem(Translations[Config.Locale]['flash_range'], '~b~')
		rangeItem:RightLabel('~b~' .. v.flashDistance)
		radarSub:AddItem(rangeItem)

		local streetlabel = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, v.pos.x, v.pos.y, v.pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street = GetStreetNameFromHashKey(streetlabel)
		local locItem = NativeUI.CreateItem(Translations[Config.Locale]['location'], Translations[Config.Locale]['location_desc'])
		locItem:RightLabel('~y~' .. street)
		radarSub:AddItem(locItem)

		locItem.Activated = function(sender, index)
			-- set waypoint
			SetNewWaypoint(v.pos.x, v.pos.y)
		end
	end

	local profitSub = _menuPool:AddSubMenu(profitMenu, Translations[Config.Locale]['analyse_title'], '~b~')
	profitMenu.Items[2]:RightLabel('~b~→→→')
	profitSub:SetBannerSprite(background, true)
	ESX.TriggerServerCallback('myRadarcontrol:getRadarProfits', function(radarProfits)
		
		for k, v in pairs(radarProfits) do
			local radarSub = _menuPool:AddSubMenu(profitSub, v.label, Translations[Config.Locale]['last'] .. v.lastUser .. Translations[Config.Locale]['at'] .. v.lastTime .. ' (~y~' .. v.lastProfit .. '$~s~)')
			profitSub.Items[k]:RightLabel('~g~' .. v.totalProfit .. '$')
			radarSub:SetBannerSprite(background, true)

			local labelItem = NativeUI.CreateItem(Translations[Config.Locale]['name'] , '~b~')
			labelItem:RightLabel('~s~' .. v.label)
			radarSub:AddItem(labelItem)

			local typeItem = NativeUI.CreateItem(Translations[Config.Locale]['type'] , '~b~')
			if v.type == 'static' then
				typeItem:RightLabel(Translations[Config.Locale]['type_static'] .. ' (#' .. v.radarID .. ')')
			else
				if v.radarID ~= nil then
					typeItem:RightLabel(Translations[Config.Locale]['type_mobile'] .. ' (#' .. v.radarID .. ')')
				else
					typeItem:RightLabel(Translations[Config.Locale]['type_mobile'])
				end
			end
			radarSub:AddItem(typeItem)

			local totalProfitItem = NativeUI.CreateItem(Translations[Config.Locale]['total_profit'], '~b~')
			totalProfitItem:RightLabel('~g~' .. v.totalProfit .. '$')
			radarSub:AddItem(totalProfitItem)

			local spacerItem = NativeUI.CreateItem('~b~')
			radarSub:AddItem(spacerItem)

			local lastFlashItem = NativeUI.CreateItem(Translations[Config.Locale]['last_flashed'] , '~b~')
			lastFlashItem:RightLabel('~b~' .. v.lastTime)
			radarSub:AddItem(lastFlashItem)

			local lastProfitItem = NativeUI.CreateItem(Translations[Config.Locale]['last_identity'] , '~b~')
			lastProfitItem:RightLabel(v.lastUser)
			radarSub:AddItem(lastProfitItem)

			local lastProfitItem = NativeUI.CreateItem(Translations[Config.Locale]['last_fine'] , '~b~')
			lastProfitItem:RightLabel('~o~' .. v.lastProfit .. '$')
			radarSub:AddItem(lastProfitItem)


			_menuPool:MouseEdgeEnabled(false)
			_menuPool:RefreshIndex()
		end
	
	end)

	profitMenu:Visible(true)

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

function generateCreateMenu(speedCamData, creatingNew)

	-- create object
	local mobileRadarObj
	if creatingNew then
		mobileRadarObj= createProp(speedCamData.pos, 6.9, true)
		while mobileRadarObj == nil do
			Wait(1)
		end

		SetEntityCoords(PlayerPedId(), speedCamData.pos.x + 1.0, speedCamData.pos.y, speedCamData.pos.z)
		table.insert(propsCreated, mobileRadarObj)
	end
	--

	currentSpeedcamLocation = speedCamData.pos
	local currentLabel = speedCamData.name or Translations[Config.Locale]['mobile_speedcam']
	local currentSociety = speedCamData.society or Config.defaultSociety

	if mainMenu ~= nil and mainMenu:Visible() then
		mainMenu:Visible(false)
	end

	mainMenu = NativeUI.CreateMenu(Translations[Config.Locale]['setup_title'], speedCamData.label)
	_menuPool:Add(mainMenu)
	mainMenu:SetBannerSprite(background, true)

	mainMenu.Controls.Back.Enabled = false

	local changeRange = NativeUI.CreateListItem(Translations[Config.Locale]['radius'], Config.Ranges)
	mainMenu:AddItem(changeRange)

	mainMenu.OnListChange = function(sender, item, index)
		if item == changeRange then
			currentRadius = Config.Ranges[index]
		end
	end

	local setupSpeedlimit = NativeUI.CreateItem(Translations[Config.Locale]['max_speed'], '~b~')

	local milesTxt = "mp/h"

	if Config.UseKMH then 
		milesTxt = "km/h"
	end

	currentMaxSpeed = speedCamData.maxSpeed or 50
	setupSpeedlimit:RightLabel(currentMaxSpeed .. milesTxt)
	mainMenu:AddItem(setupSpeedlimit)

	setupSpeedlimit.Activated = function(sender, index)
		local insertedSpeed = CreateDialog(Translations[Config.Locale]['max_speed'])
		if tonumber(insertedSpeed) then
			currentMaxSpeed = insertedSpeed
			setupSpeedlimit:RightLabel(currentMaxSpeed .. milesTxt)
		end
	end

	local labelSpeedcam = NativeUI.CreateItem(Translations[Config.Locale]['name'], '~b~')
	labelSpeedcam:RightLabel('~b~' .. currentLabel)
	mainMenu:AddItem(labelSpeedcam)

	labelSpeedcam.Activated = function(sender, index)
		local insertedName = CreateDialog(Translations[Config.Locale]['name'])
		if tostring(insertedName) then
			currentLabel = insertedName
			labelSpeedcam:RightLabel(currentLabel)
		end
	end

	--print(speedCamData.society)

	local societyItem = NativeUI.CreateItem(Translations[Config.Locale]['society'], '~b~')
	societyItem:RightLabel('~b~' .. currentSociety)
	mainMenu:AddItem(societyItem)

	societyItem.Activated = function(sender, index)
		local insertedSociety = CreateDialog(Translations[Config.Locale]['society'])
		if tostring(insertedSociety) then
			currentSociety = insertedSociety
			societyItem:RightLabel(currentSociety)
		end
	end

	local turnSpeedcam = NativeUI.CreateItem(Translations[Config.Locale]['turn'], '~b~')
	mainMenu:AddItem(turnSpeedcam)

	turnSpeedcam.Activated = function(sender, index)
		turnObject(propsCreated[#propsCreated], mainMenu)
	end

	local moveSpeedcam = NativeUI.CreateItem(Translations[Config.Locale]['move'], '~b~')
	mainMenu:AddItem(moveSpeedcam)

	moveSpeedcam.Activated = function(sender, index)
		moveObject(propsCreated[#propsCreated], mainMenu)
	end

	local save = NativeUI.CreateItem(Translations[Config.Locale]['save'], '~b~')
	mainMenu:AddItem(save)

	save.Activated = function(sender, index)
		doNotify(Translations[Config.Locale]['saved'])

		if creatingNew then
			DeleteObject(propsCreated[#propsCreated])
			TriggerServerEvent('myRadarcontrol:saveToDatabase', currentLabel, currentSpeedcamLocation, currentMaxSpeed, currentRadius, currentSociety)
			-- sync is included in the event above
		else

			for k, v in pairs(Config.RadarControls) do
				if v.pos == speedCamData.pos then
					-- v.maxSpeed = currentMaxSpeed
					-- v.society = currentSociety
					-- v.name = currentLabel
					-- v.pos = currentSpeedcamLocation
					-- v.propPos = {currentSpeedcamLocation}
					-- v.flashDistance = currentRadius
					TriggerServerEvent('myRadarcontrol:editSpeedcam', currentLabel, currentSpeedcamLocation, currentMaxSpeed, currentRadius, currentSociety, speedCamData.pos)
					-- sync edit
					break
				end
			end

			

		end
		_menuPool:CloseAllMenus()
	end

	local delete = NativeUI.CreateItem(Translations[Config.Locale]['delete'], '~b~')
	mainMenu:AddItem(delete)

	delete.Activated = function(sender, index) 
		if creatingNew then
			DeleteObject(propsCreated[#propsCreated])
		else
			TriggerServerEvent('myRadarcontrol:deleteSpeedcam', speedCamData.pos)
			-- for k, v in pairs(Config.RadarControls) do
			-- 	if v.object == currentSpeedcam.object then
			-- 		table.remove(Config.RadarControls, k)
			-- 		-- sync remove 
			-- 	end
			-- end
			-- DeleteObject(currentSpeedcam.object)
			TriggerServerEvent('myRadarcontrol:syncDelete', currentSpeedcam.mobileID)
		end
		_menuPool:CloseAllMenus()
	end



	mainMenu:Visible(true)

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end


RegisterNetEvent('myRadarcontrol:syncSpeedcamEdit')
AddEventHandler('myRadarcontrol:syncSpeedcamEdit', function(label, position, maxSpeed, flashRange, society, oldPosition)

	for k, v in pairs(Config.RadarControls) do
		if v.pos.x == oldPosition.x and v.pos.y == oldPosition.y and v.pos.z == oldPosition.z then

			v.maxSpeed = maxSpeed
			v.society = society
			v.name = label
			v.pos = position
			v.propPos = {position}
			v.flashDistance = flashRange
	
			refreshRadars()
			break
		end
	end
	
	

end)


RegisterNetEvent('myRadarcontrol:syncNewSpeedcam')
AddEventHandler('myRadarcontrol:syncNewSpeedcam', function(label, position, maxSpeed_res, flashRange, society, radarID)
	table.insert(Config.RadarControls, {
		name = label
		, maxSpeed = maxSpeed_res
		, society = society
		, pos = position
		, propPos = {position}
		, flashDistance = flashRange
		, isMobile = true
		, mobileID = radarID
		, object = mobileRadarObj
	})
	
	refreshRadars()
end)

RegisterNetEvent('myRadarcontrol:syncDelete_cl')
AddEventHandler('myRadarcontrol:syncDelete_cl', function(objectID)
	for k, v in pairs(Config.RadarControls) do
		if v.mobileID == objectID then
			table.remove(Config.RadarControls, k)
			refreshRadars()
		end
	end
	DeleteObject(objectID)
end)

RegisterNetEvent('myRadarcontrol:createRadar')
AddEventHandler('myRadarcontrol:createRadar', function()

	if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == Config.policeJob or ESX.PlayerData.job.name == Config.policeJob2 then

		local playerPosition = {
			x = GetEntityCoords(PlayerPedId())[1],
			y = GetEntityCoords(PlayerPedId())[2],
			z = GetEntityCoords(PlayerPedId())[3],
			heading = GetEntityHeading(PlayerPedId())
		}
		
		local SCData = {
			label = Translations[Config.Locale]['mobile_speedcam'],
			pos = playerPosition,
		}
		if not isInVehicle(PlayerPedId()) then
			generateCreateMenu(SCData, true)
		end
	
	else
		doNotify(Translations[Config.Locale]['no_access'])
	end
end)

--[[RegisterCommand('createSpeedcam', function(source, args, rawCommand)
	if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == Config.policeJob then

		local playerPosition = {
			x = GetEntityCoords(PlayerPedId())[1],
			y = GetEntityCoords(PlayerPedId())[2],
			z = GetEntityCoords(PlayerPedId())[3],
			heading = GetEntityHeading(PlayerPedId())
		}
		
		local SCData = {
			label = Translations[Config.Locale]['mobile_speedcam'],
			pos = playerPosition,
		}
		if not isInVehicle(PlayerPedId()) then
			generateCreateMenu(SCData, true)
		end
	
	else
		doNotify(Translations[Config.Locale]['no_access'])
	end
end, false)

RegisterCommand('radar', function(source, args, rawCommand)
	if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == Config.policeJob then

		local playerPosition = {
			x = GetEntityCoords(PlayerPedId())[1],
			y = GetEntityCoords(PlayerPedId())[2],
			z = GetEntityCoords(PlayerPedId())[3],
			heading = GetEntityHeading(PlayerPedId())
		}
		
		local SCData = {
			label = Translations[Config.Locale]['mobile_speedcam'],
			pos = playerPosition,
		}
		if not isInVehicle(PlayerPedId()) then
			generateCreateMenu(SCData, true)
		end
	
	else
		doNotify(Translations[Config.Locale]['no_access'])
	end
end, false)]]--

RegisterNetEvent('myRadarcontrol:openBossmenu')
AddEventHandler('myRadarcontrol:openBossmenu', function()

	if Config.bossMenuRestricted then
		if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired or ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired2 or ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired3 or ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired4 then
			showProfitMenu()
		else
			doNotify(Translations[Config.Locale]['no_access'])
		end
	else
		showProfitMenu()
	end

end)

if Config.useSpeedcamCommand then
	RegisterCommand('speedcams', function(source, args, rawCommand)	
		if Config.bossMenuRestricted then
			if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired or ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired2 or ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired3 or ESX.PlayerData.job.grade_name == Config.bossMenuGradeRequired4 then
				showProfitMenu()
			else
				doNotify(Translations[Config.Locale]['no_access'])
			end
		else
			showProfitMenu()
		end
	end, false)
end

function createProp(position, PropCorrectZAxis, adjustHeading)

	local CorrectZAxis = PropCorrectZAxis or Config.PropCorrectZAxis
	RequestModel(Config.Prop)
	while not HasModelLoaded(Config.Prop) do
		Citizen.Wait(0)
	end
	--print('obj created')
	radar = CreateObject(Config.Prop, position.x, position.y, position.z - CorrectZAxis, false, true, true)
	--print('spawn at pos ' .. position.x)
	if adjustHeading then
		SetEntityHeading(radar, getNewHeading(position.heading))
	else
		SetEntityHeading(radar,position.heading)
	end
	
	FreezeEntityPosition(radar, true)

	table.insert(propsCreated, radar)
	return radar
end


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	for key, value in pairs(propsCreated) do
		DeleteObject(value)
	end 

	print('The resource ' .. resourceName .. ' was stopped.')
end)


function sendInvoice(fine, radarname,  yourspeed, maxSpeed, society)

	society = society or Config.defaultSociety

	local text = radarname
	local mph = "MP/h"

	if Config.UseKMH then 
		mph = "KM/h"
	end 

	text = text .. " (".. maxSpeed .. mph .. ") - "
	text = text .. " +" .. (yourspeed - maxSpeed) .. mph

	--text = 'Speedcam'

	if Config.Billing.okokBilling then 
		data = {
			invoice_value = fine,
			invoice_item = "Fine",
			society = society,
			society_name = "LSPD",
			target = GetPlayerServerId(PlayerId()),
			invoice_notes = "Speedcam fine",
		}
		TriggerServerEvent('okokBilling:CreateInvoice', data)
	elseif Config.Billing.myBilling then 
		TriggerServerEvent('esx_billing:sendBillDirect', GetPlayerServerId(PlayerId()), society ,text, fine)
	elseif Config.Billing.default then
		TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), society ,text, fine)
	elseif Config.Billing.Custom then 
		--here your custom code...
		TriggerServerEvent("myRadarcontrol:payFine", fine, society) -- default bill is directly paid.
	end 

end 

function turnObject(objectRes, menu)
    menu:Visible(false)

    AddTextEntry('text', 
    Translations[Config.Locale]['controls'] ..'~n~~' .. Config.Controls.turnright.name .. '~' .. Translations[Config.Locale]['turn_right'] .. '~n~~' 
        .. Config.Controls.turnleft.name .. '~' .. Translations[Config.Locale]['turn_left'] .. '~n~~' 
        .. Config.Controls.fast.name .. '~' .. Translations[Config.Locale]['turn_fast'] .. '~n~~' 
        .. Config.Controls.slow.name .. '~' .. Translations[Config.Locale]['turn_slow'] .. '~n~~' 
        .. Config.Controls.finish.name .. '~' .. Translations[Config.Locale]['back_to_menu'] .. '~n~~' 
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
			currentSpeedcamLocation.heading = GetEntityHeading(objectRes)
            menu:Visible(true)
            break
        end
    end
end

function moveObject(objectRes, menu)

    menu:Visible(false)
    AddTextEntry('text', 
    Translations[Config.Locale]['controls'] ..'~n~~' .. Config.Controls.moveright.name .. '~' .. Translations[Config.Locale]['move_right'] .. '~n~~' 
        .. Config.Controls.moveleft.name .. '~' .. Translations[Config.Locale]['move_left'] .. '~n~~' 
        .. Config.Controls.moveup.name .. '~' .. Translations[Config.Locale]['move_forward'] .. '~n~~' 
        .. Config.Controls.movedown.name .. '~' .. Translations[Config.Locale]['move_backwards'] .. '~n~~' 
        .. Config.Controls.fast.name .. '~' .. Translations[Config.Locale]['move_fast'] .. '~n~~' 
        .. Config.Controls.slow.name .. '~' .. Translations[Config.Locale]['move_slow'] .. '~n~~' 
        .. Config.Controls.finish.name .. '~' .. Translations[Config.Locale]['back_to_menu'] .. '~n~~' 
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
			currentSpeedcamLocation = {
				x = GetEntityCoords(objectRes)[1],
				y = GetEntityCoords(objectRes)[2],
				z = GetEntityCoords(objectRes)[3] + 6.9,
				heading = GetEntityHeading(objectRes),
			}
            break
        end
    end

end

RegisterNetEvent('myRadarcontrol:doCopNotify')
AddEventHandler('myRadarcontrol:doCopNotify', function(speedcamLabel, playername, fine)
	if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then 
		doNotify('~y~' .. playername .. ' ~s~was caught ~r~speeding~s~!\nSpeedcam: ~y~' .. speedcamLabel .. '\n~s~Fine: ~o~' .. fine .. '$')
	end
end)

function doNotify(notificationtext)
	if Config.notifications.BtwLouis then
		TriggerEvent('notifications', '#07b95e', '', notificationtext)
	elseif Config.notifications.DefaultFiveM then
		SetNotificationTextEntry('STRING')
		AddTextComponentString(notificationtext)
		DrawNotification(false, false)
	elseif Config.notifications.Custom then
		ESX.ShowNotification(notificationtext)								
		--here your custom code...
	end
end 

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function showPictureNotification(icon, msg, title, subtitle)
	--ESX.ShowNotification(msg)					  
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end

function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
	AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
	DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local displayResult = GetOnscreenKeyboardResult()
		return displayResult
	end
end

function checkIfJobBlacklisted()
	local retval = false

	for key, job in pairs(Config.JobsToIgnore) do 
		if job == ESX.PlayerData.job.name then 
			retval = true
			break
		end 
	end 

	if retval == true then 
		if Config.FlashJobsIfSirenOff and IsVehicleSirenOn(CurrentVehicle) == false then 
			retval = false
		end
	end 

	return retval
end 

function getVehicle(ped)
	return GetVehiclePedIsIn(ped, false)
end 

function isInVehicle(ped)
	return IsPedInAnyVehicle(ped)
end 

function isPlayerDriver(vehicle)
	return GetPedInVehicleSeat(CurrentVehicle, -1) == GetPlayerPed(-1)
end 

function getSpeed()
	if CurrentVehicle ~= nil then 
		local SpeedMultiplier = 1
		if Config.UseKMH == true then
			SpeedMultiplier = 3.6
		else
			SpeedMultiplier = 2.236936
		end

		return math.floor(GetEntitySpeed(CurrentVehicle) * SpeedMultiplier)
	else
		return 0
	end 
end 

function checkFine(maxSpeed, currentSpeed)

	local speedAbove = currentSpeed - maxSpeed
	local retval = 0

	for key, values in pairs(Config.prices) do 
		if values.limitFrom <= speedAbove and  (values.limitTo == nil or values.limitTo > speedAbove ) then 
			if values.price > 0 then 
				retval = values.price
			end 
			break
		end 
	end

	return retval
end 


function getNewHeading(heading)
	local retval = heading - Config.PropCorrectHeading
	if retval < 0 then 
		retval = 360 + retval
	end 
	return retval
end 


RegisterNetEvent('myRadarcontrol:startFlash')
AddEventHandler('myRadarcontrol:startFlash', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'start'})
end)   

RegisterNetEvent('myRadarcontrol:endFlash')
AddEventHandler('myRadarcontrol:endFlash', function()
    SendNUIMessage({type = 'end'})
end)
