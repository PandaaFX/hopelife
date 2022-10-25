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
local burgerLeft

-- blips
Citizen.CreateThread(function()
	-- wait for job level
	while (jobLevel == nil) do
		print('Waiting for joblevel')
		Citizen.Wait(1000)
	end
	
	local blip = AddBlipForCoord(Config.Location[1].x, Config.Location[1].y, Config.Location[1].z)

	SetBlipSprite (blip, 52)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 81)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Translation[Config.Locale]['blip_title'])
	EndTextCommandSetBlipName(blip)
end)


AddEventHandler('burgerjob:JobIDChanged', function()
	print('JobID changed to: ' .. jobID)

	if jobID == 0 then
		--ClearCurrentMission()
		if DoesEntityExist(jobVehicle) then
			DeleteEntity(jobVehicle)
		end
		
	end

	if jobID ~= 0 then
		
		if DoesEntityExist(jobVehicle) then
			DeleteEntity(jobVehicle)
		end
		
		local vehicleModel = GetHashKey(Config.Jobs[jobID + 1].vehicleModel)
		RequestModel(vehicleModel)
		print('request model')
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
		TriggerServerEvent('burgerjob:getLevel')
		
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

				-- while jobID == 0 do
				-- 	Citizen.Wait(250)
				-- end
				
				
			end
			
			if jobID ~= 0 then
				
				if DoesBlipExist(JobBlip) then
					RemoveBlip(JobBlip)
				end

				jobNumber = GetRandomIntInRange(2, #Config.JobLocations[jobID])
				burgerLeft = 4
				print(burgerLeft)
				JobBlip = AddBlipForCoord(Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)

				SetBlipAsFriendly(JobBlip, 1)
				SetBlipColour(JobBlip, 81)
				SetBlipCategory(JobBlip, 3)
				SetBlipRoute(JobBlip,  true)

				local notificationflag = 0
				ShowNotification(Translation[Config.Locale]['start_route'])

				while jobID ~= 0 do
					Citizen.Wait(0)

					local playerPed     = PlayerPedId()
					local playerCoords  = GetEntityCoords(playerPed)
					local vehicle       = GetVehiclePedIsIn(playerPed,  true) 
					local vehiclespeed	= GetEntitySpeed(vehicle)
					
					if Config.JobLocations[jobID] ~= nil then
						if (GetDistanceBetweenCoords(playerCoords, Config.JobLocations[jobID][jobNumber].x, Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z, true) < 1.5) then
							if vehicle == jobVehicle then
								Wait(100)
							
								if jobNumber == 1 then
									ShowNotification(Translation[Config.Locale]['got_order'])
									burgerLeft = Config.Jobs[jobID+1].burgerStops
									jobNumber = GetRandomIntInRange(2, #Config.JobLocations[jobID])
									SetBlipCoords(JobBlip, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)
									SetBlipRoute(JobBlip,  true)
									ShowNotification(Translation[Config.Locale]['next_customer'])
								else
									ShowNotification(Translation[Config.Locale]['thanks'])
									Wait(800)
									local playerid = GetPlayerServerId(PlayerId())
									TriggerServerEvent('burgerjob:increase', playerid)
									jobLevel = jobLevel + 1
									TriggerServerEvent('hl_burgerjob:hl_payment:playerpayout_hl',  Config.Jobs[jobID + 1].payment)
								end		
	
								if jobNumber ~= nil and burgerLeft <= 0 then
									ShowNotification(Translation[Config.Locale]['get_new_supplies'])
									jobNumber = 1
									SetBlipCoords(JobBlip, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)
									SetBlipRoute(JobBlip,  true)
	
								else 
									jobNumber = GetRandomIntInRange(2, #Config.JobLocations[jobID])
									burgerLeft = burgerLeft - 1
									SetBlipCoords(JobBlip, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z)
									SetBlipRoute(JobBlip,  true)
									ShowNotification(Translation[Config.Locale]['next_customer'])
								end
							else 
								ShowNotification(Translation[Config.Locale]['wrong_vehicle'])
							end
						end
					else
						print('unable to fetch location for jobId' .. jobID)
					end
				end
			end
		end
	end)
end
--end)

Citizen.CreateThread(function()
    -- wait for job level

    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
    while true do
		Citizen.Wait(250)

		if jobID ~= 0 then
			Citizen.Wait(10)
			while jobID ~= 0 do
				Citizen.Wait(0)
				if Config.JobLocations[jobID] ~= nil then
					DrawMarker(27, Config.JobLocations[jobID][jobNumber].x , Config.JobLocations[jobID][jobNumber].y, Config.JobLocations[jobID][jobNumber].z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius*1.5, Config.Marker.radius*1.5, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)
				end
			end
		end

	end
end)

-- player loaded

RegisterNetEvent('burgerjob:getLevel')
AddEventHandler('burgerjob:getLevel', function(_jobLevel)
	jobLevel = _jobLevel
end)

-- main loop
Citizen.CreateThread(function()
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
    
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
        
		if isInMarkerMenu then
            showInfobar(Translation[Config.Locale]['openMenu'])
        end

        if (not isInMarkerMenu) then
            _menuPool:CloseAllMenus()
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
            if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 50.0) then
                DrawMarker(Config.Marker.id, v.x, v.y, v.z-0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius*2, Config.Marker.radius*2, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, Config.Marker.isRotating, false, false, false)
            end
        end
    end
end)

-- FUNCTIONS

function GenerateMenu()
	_menuPool = NativeUI.CreatePool()
	mainMenu = NativeUI.CreateMenu(Config.menuTitle, Config.menuSubtitle .. jobLevel)
	_menuPool:Add(mainMenu)
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
    mainMenu:Clear()
    
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

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	--print('Try to display message')

end

-- sync
Citizen.CreateThread(function()
    -- wait for job level
    while (jobLevel == nil) do
        Citizen.Wait(1000)
    end
	
	Citizen.Wait(5000)

	local prevJobID = jobID

	while true do
		Citizen.Wait(250)
		--print(prevJobID .. jobID)
		if prevJobID ~= jobID then
			TriggerEvent('burgerjob:JobIDChanged')
		end
		prevJobID = jobID
	end
end)
