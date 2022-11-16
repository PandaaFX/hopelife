local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

local selectedLocation = nil
local selectedCamera = nil
AddedLocations = {}
scaleformState = "UNLOADED"
changedCamera = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        if (GetDistanceBetweenCoords(playerCoords, 583.147278, 18.065935, 76.627808, false) < 2) then
            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um auf die Kameras zu zugreifen')
            if IsControlJustPressed(0, 38)then
                TriggerEvent('security:cctv', playerPed)
            end
        elseif (GetDistanceBetweenCoords(playerCoords, 2504.531982, -337.490112, 101.885742, false) < 2) then
            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um auf die Kameras zu zugreifen')
            if IsControlJustPressed(0, 38)then
                TriggerEvent('security:cctv', playerPed)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('security:cctv')
AddEventHandler('security:cctv', function()
	local ped = PlayerPedId()
	if Utils.HasPermission() then
		AddedLocations = {}
		local CameraMenu = xMenu.New("Städtische Kameras")
		local GenStoreMenu = CameraMenu:BindSubMenu("General Stores")		
		local BankMenu = CameraMenu:BindSubMenu("Banks")
		local OeffentlichMenu = CameraMenu:BindSubMenu("Place")

		for k, v in pairs(CCTV_Config.Cameras) do
			if v.type == "General Stores" then
				if AddedLocations[v.name] == nil then
					AddedLocations[v.name] = GenStoreMenu:BindSubMenu(v.name)
				end

				if AddedLocations[v.name] then
					AddedLocations[v.name]:BindButton(v.name .. " #" .. v.camera, function()
						selectedLocation = v.name
						selectedCamera = v.camera
						currentCamIndex = k
						Utils.RequestCamera(v.name, v.camera)
					end)
				end
			end

			if v.type == "Banks" then
				if AddedLocations[v.name] == nil then
					AddedLocations[v.name] = BankMenu:BindSubMenu(v.name)
				end

				if AddedLocations[v.name] then
					AddedLocations[v.name]:BindButton(v.name .. " #" .. v.camera, function()
						selectedLocation = v.name
						selectedCamera = v.camera
						currentCamIndex = k
						Utils.RequestCamera(v.name, v.camera)
					end)
				end
			end

			if v.type == "Place" then
				if AddedLocations[v.name] == nil then
					AddedLocations[v.name] = OeffentlichMenu:BindSubMenu(v.name)
				end

				if AddedLocations[v.name] then
					AddedLocations[v.name]:BindButton(v.name .. " #" .. v.camera, function()
						selectedLocation = v.name
						selectedCamera = v.camera
						currentCamIndex = k
						Utils.RequestCamera(v.name, v.camera)
					end)
				end
			end
		end

		CameraMenu:OpenMenu()
	else
		if CCTV_Config.ShowNoPerms then
			--Utils.Notification("[~y~LX Security~w~]\n\n~r~You don't have permission to do this")
		end
	end
end)

currentCamIndex = 0
switchingCam = false
inCam = false
cctvCam = 0
cameraScaleform = nil
controlsScaleform = nil
camFov = 110.0
local drawnControls = false

Citizen.CreateThread(function ()
	while true do
		Wait(0)

		if inCam then

			if IsDisabledControlJustPressed(0, 194) then -- Backspace
				Utils.CloseCamera()
				AddedLocations = {}
				if CCTV_Config.HideRadar then
					DisplayRadar(true)
				end

				if CCTV_Config.HideHUD then
					Utils.ToggleHUD(true)
				end
			end

			if currentCamIndex > 0 then
				if CCTV_Config.Cameras[currentCamIndex].canRotate then
					local rotation = GetCamRot(cctvCam, 2)

					if IsDisabledControlPressed(1, 108) then -- Num 4 (Rotate Left)
						SetCamRot(cctvCam, rotation.x, 0.0, rotation.z + 0.3, 2)
					--end
					end

					if IsDisabledControlPressed(1, 107) then -- Num 6 (Rotate Right)
						SetCamRot(cctvCam, rotation.x, 0.0, rotation.z - 0.3, 2)
					end

					if IsDisabledControlPressed(1, 111) then -- Num 8 (Up)
						if rotation.x <= 0.0 then
							SetCamRot(cctvCam, rotation.x + 0.3, 0.0, rotation.z, 2)
						end
					end

					if IsDisabledControlPressed(1, 110) then -- Num 5 (Down)
						if rotation.x <= 50.0 and rotation.x >= -88.0 then
							SetCamRot(cctvCam, rotation.x - 0.3, 0.0, rotation.z, 2)
						end
					end
				end

				if IsDisabledControlJustPressed(0, 175) then -- Next Camera
					switchingCam = true
					local AMOUNT_OF_CAMERAS = Utils.GetCamAmountByName(AddedLocations[selectedLocation].Name)
					if selectedCamera + 1 > AMOUNT_OF_CAMERAS then
						selectedCamera = 1
					else
						selectedCamera = selectedCamera + 1
					end

					Utils.ChangeCamera(selectedLocation, selectedCamera)
				end

				if IsDisabledControlJustPressed(0, 174) then -- Previous Camera
					switchingCam = true
					local AMOUNT_OF_CAMERAS = Utils.GetCamAmountByName(AddedLocations[selectedLocation].Name)
					if selectedCamera - 1 <= 0 then
						selectedCamera = AMOUNT_OF_CAMERAS
					else
						selectedCamera = selectedCamera - 1
					end
					
					Utils.ChangeCamera(selectedLocation, selectedCamera)
				end

				if IsDisabledControlJustPressed(0, 241) then -- Zoom In
					if camFov > -1.0 then
						camFov = camFov - 3.0
						SetCamFov(cctvCam, camFov)
					end
				end
				
				if IsDisabledControlJustPressed(0, 242) then -- Zoom Out
					if camFov < 110.0 then
						camFov = camFov + 3.0
						SetCamFov(cctvCam, camFov)
					end
				end
			end
		end

		-- Handle Camera Scaleform and Timecycle
		if inCam then
			local location = CCTV_Config.Cameras[currentCamIndex].location
			SetTimecycleModifier(CCTV_Config.TimecycleTypes[CCTV_Config.Cameras[currentCamIndex].cameraType])
			SetTimecycleModifierStrength(1.0)
			PushScaleformMovieFunction(cameraScaleform, "SET_ALT_FOV_HEADING")
			-- PushScaleformMovieFunctionParameterFloat(GetEntityCoords(location.w).z)
			PushScaleformMovieFunctionParameterFloat(location.w)
			PushScaleformMovieFunctionParameterFloat(1.0)
			PushScaleformMovieFunctionParameterFloat(GetCamRot(cctvCam, 2).z)
			PopScaleformMovieFunctionVoid()
			DrawScaleformMovieFullscreen(cameraScaleform, 255, 255, 255, 255)
			DisableAllControlActions(0)
		end

		-- Handle Controls Scaleform
		if inCam and scaleformState == "CAMERA_READY" then
			local buttonsMessage = {
				{name = "Exit", button = 194},
				{name = "Previous Camera", button = 174},
				{name = "Next Camera", button = 175},
				{name = "Zoom Out", button = 242},
				{name = "Zoom In", button = 241},
				{name = "Down", button = 112},
				{name = "Up", button = 111},
				{name = "Right", button = 109},
				{name = "Left", button = 108}
			}
			controlsScaleform = Utils.CreateInstructions("instructional_buttons", buttonsMessage)
			DrawScaleformMovieFullscreen(controlsScaleform, 255, 255, 255, 255, 0)
		end
	end
end)