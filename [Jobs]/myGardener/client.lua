if Config.useESX then
	ESX = nil

	Citizen.CreateThread(function()
		while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		end
		
	end)
end

local currentLocation = {}
local isInMarkerMenu    = false
local jobID = 0
local jobLevel = nil
local jobVehicle = nil
local jobNumber
local JobBlip
local burgerGPS = false
local CurrentCustomer           = {}
local CurrentCustomerBlip       = nil
local LastCustomer 				= {}
local burgerLeft

Citizen.CreateThread(function()
	-- wait for job level
	while (jobLevel == nil) do
		Citizen.Wait(1000)
	end
	
  local blip = AddBlipForCoord(Config.Location[1].x, Config.Location[1].y, Config.Location[1].z)

  SetBlipSprite (blip, 109)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 1.0)
  SetBlipColour (blip, 2)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(Translation[Config.Locale]['blip_title'])
  EndTextCommandSetBlipName(blip)
end)


function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

AddEventHandler('gardenerjob:JobIDChanged', function()
	print('JobID changed to: ' .. jobID)

	if jobID == 0 or jobID == 1 then
		if DoesEntityExist(jobVehicle) then
			DeleteEntity(jobVehicle)
		end
		
	end

	if jobID == 2 then
		
		if DoesEntityExist(jobVehicle) then
			DeleteEntity(jobVehicle)
		end

		local vehicleModel = GetHashKey('mower')
		RequestModel(vehicleModel)

		while not HasModelLoaded(vehicleModel) do
			Citizen.Wait(0)
		end

		jobVehicle = CreateVehicle(vehicleModel, Config.VehicleSpawnLocation.x, Config.VehicleSpawnLocation.y, Config.VehicleSpawnLocation.z, Config.VehicleSpawnLocation.rot, true, false)
		SetVehicleOnGroundProperly(jobVehicle)
		SetPedIntoVehicle(PlayerPedId(), jobVehicle, - 1)
		SetModelAsNoLongerNeeded(vehicleModel)
		SetVehicleDirtLevel(jobVehicle, 0.0)
		
	end


end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		startMainThread()
	end
end)

Citizen.CreateThread(function()
	if Config.useESX then
		RegisterNetEvent('esx:playerLoaded')
		AddEventHandler('esx:playerLoaded', function(xPlayer)
			startMainThread()
		end)
	else
		startMainThread()
	end
end)


function startMainThread()
	Citizen.CreateThread(function()
		-- get level from server
		TriggerServerEvent('gardenerjob:getLevel')
		
		-- wait for job level
		while (jobLevel == nil) do
			Citizen.Wait(1000)
		end
		
		while true do

			Citizen.Wait(250)

			if jobID == 0 then

				if DoesBlipExist(JobBlip) then
					RemoveBlip(JobBlip)
				end

				--[[
				while jobID == 0 do
					Citizen.Wait(250)
				end
				--]]
				
				
			end
			
			if jobID ~= 0 then
				
				if DoesBlipExist(JobBlip) then
					RemoveBlip(JobBlip)
				end

				jobNumber = GetRandomIntInRange(2, #Config.JobLocations[jobID])
				stopsLeft = Config.Jobs[jobID + 1].gardenerStops
				JobBlip = AddBlipForCoord(Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)

				SetBlipAsFriendly(JobBlip, 1)
				SetBlipColour(JobBlip, 2)
				SetBlipCategory(JobBlip, 3)
				SetBlipRoute(JobBlip,  true)

				local notificationflag = 0
				TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['message_title'],Translation[Config.Locale]['message_subtitle'], Translation[Config.Locale]['start_route'], 'CHAR_PROPERTY_GOLF_CLUB')

				while jobID ~= 0 do
					Citizen.Wait(0)

					local playerPed     = PlayerPedId()
					local playerCoords  = GetEntityCoords(playerPed)
					local vehicle       = GetVehiclePedIsIn(playerPed,  true) 
					local vehiclespeed	= GetEntitySpeed(vehicle)
					
					if Config.JobLocations[jobID] ~= nil then
						if (GetDistanceBetweenCoords(playerCoords, Config.JobLocations[jobID][jobNumber].x, Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z, true) < 1.5) then
							if not DoesEntityExist(jobVehicle) or vehicle == jobVehicle then
								Wait(100)
							
								if jobNumber == 1 then
									ShowNotification(Translation[Config.Locale]['next_stop'])
									stopsLeft = Config.Jobs[jobID + 1].gardenerStops
									jobNumber = GetRandomIntInRange(2, #Config.JobLocations[jobID])
									SetBlipCoords(JobBlip, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)
									SetBlipRoute(JobBlip,  true)
								else
									if jobID == 1 then
										TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, true)
										Wait(9000)
										ClearPedTasksImmediately(PlayerPedId())
									else
										Wait(800)
									end
									
									local playerid = GetPlayerServerId(PlayerId())
									TriggerServerEvent('gardenerjob:increase', playerid)
									jobLevel = jobLevel + 1
									TriggerServerEvent('gardenerjob:payment',  Config.Jobs[jobID + 1].payment)
								end		
	
								if jobNumber ~= nil and stopsLeft <= 0 then
									ShowNotification(Translation[Config.Locale]['return'])
									jobNumber = 1
									SetBlipCoords(JobBlip, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)
									SetBlipRoute(JobBlip,  true)
	
								else 
									jobNumber = GetRandomIntInRange(2, #Config.JobLocations[jobID])
									stopsLeft = stopsLeft - 1
									SetBlipCoords(JobBlip, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)
									SetBlipRoute(JobBlip,  true)
	
								end
								
							else
								ShowNotification(Translation[Config.Locale]['wrong_vehicle'])
							end
						end
					end
				end
			end
		end
	end)
end

Citizen.CreateThread(function()
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
    while true do
		Citizen.Wait(250)
		while jobID == 0 do
			Citizen.Wait(250)
		end

		if jobID ~= 0 then
			Citizen.Wait(10)
			while jobID ~= 0 do
				Citizen.Wait(0)
				DrawMarker(27, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius*1.5, Config.Marker.radius*1.5, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)
			end
		end

	end
end)


RegisterNetEvent('gardenerjob:getLevel')
AddEventHandler('gardenerjob:getLevel', function(_jobLevel)
	jobLevel = _jobLevel
end)

-- main loop
Citizen.CreateThread(function()
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
    local playerID = GetPlayerServerId(PlayerId())
    Citizen.Wait(3000)
    
    -- generate menu once
    GenerateMenu(mainMenu)
    
    -- start loop
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        local playerPed = PlayerPedId()
        
        if isInMarkerMenu and IsControlJustPressed(1, 51) then
			GenerateMenu(mainMenu)
            mainMenu:Visible(not mainMenu:Visible())
        end
        
        if (not isInMarkerMenu) then
            _menuPool:CloseAllMenus()
        end
        
        -- show interaction prompts
        if isInMarkerMenu == true then
            SetTextComponentFormat('STRING')
            AddTextComponentString(Translation[Config.Locale]['openMenu'])
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        end
    end
end)

-- check if player is in a marker
Citizen.CreateThread(function()
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
    while true do
        Citizen.Wait(20)
        local playerPed     = PlayerPedId()
        local playerCoords  = GetEntityCoords(playerPed)
            
        for k, v in pairs(Config.Location) do
            -- in marker garage menu?
            if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < Config.Marker.radius) then		
                isInMarkerMenu = true
                currentLocation = v
                break
            else
                isInMarkerMenu = false
                currentLocation = {}
            end
        end
    end
end)



-- draw markers
Citizen.CreateThread(function() 
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Location) do
            if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 100.0) then
                DrawMarker(Config.Marker.id, v.x, v.y, v.z-0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius*2, Config.Marker.radius*2, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, Config.Marker.isRotating, false, false, false)
            end
        end
    end
end)

--------------------------------------------------
---------------------- MENU ----------------------
--------------------------------------------------

-- generate the main menu
function GenerateMenu()
	_menuPool = NativeUI.CreatePool()
	mainMenu = NativeUI.CreateMenu(Config.menuTitle, Config.menuSubtitle .. jobLevel)
	_menuPool:Add(mainMenu)
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
    mainMenu:Clear()
    
    -- show vehicles
    for i=1, #Config.Jobs, 1 do
		local vehicleName = Config.Jobs[i].name
		local vehicleDescription = ''
		if jobLevel < Config.Jobs[i].minimumLevel then
			vehicleName = '~c~' .. vehicleName
			vehicleDescription = Translation[Config.Locale]['neededLevel'] .. Config.Jobs[i].minimumLevel
		end
        local vehicle = NativeUI.CreateItem(vehicleName, vehicleDescription)
        mainMenu:AddItem(vehicle)
        
        vehicle.Activated = function(ParentMenu, SelectedItem)
			if jobLevel >= Config.Jobs[i].minimumLevel then
				jobID = Config.Jobs[i].id
				_menuPool:CloseAllMenus()
			end
        end
    end
    _menuPool:RefreshIndex()
end

Citizen.CreateThread(function()
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
	Citizen.Wait(5000)
	local prevJobID = jobID

	while true do
		Citizen.Wait(250)
		if prevJobID ~= jobID then
			TriggerEvent('gardenerjob:JobIDChanged')
		end
		prevJobID = jobID
	end
end)