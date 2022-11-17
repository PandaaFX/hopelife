
local CB = exports["kimi_callbacks"]

local activeTrackers = {}

local CS = Config.Strings

if (NativeUI == nil) then
	print("^1[ERROR] NativeUI was not properly initialized! Make sure to install NativeUI and start it before this resource!")
	return
end
local menuPool = NativeUI.CreatePool()
local trackerMenu = NativeUI.CreateMenu(CS.trackerMenuTitle, CS.trackerMenuDesc)

Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(0)

		if (menuPool:IsAnyMenuOpen()) then
			menuPool:ProcessMenus()
		end

		if (Config.menuButton and Config.useESX and IsControlJustPressed(0, Config.menuButton)) then
			GenerateMenu()
			trackerMenu:Visible(not trackerMenu:Visible())
		end
	end
end)



RegisterNetEvent("VT:position")
AddEventHandler("VT:position", function(plate, position)
	if (activeTrackers[plate] == nil) then
		Log("Starting tracker for " .. plate)

		-- add blip
		local blipHandle = AddBlipForCoord(position.x, position.y, 0.0)
		
        SetBlipSprite(blipHandle, 523)
        SetBlipColour(blipHandle, 0)
        
        SetBlipScale(blipHandle, 1.0)
        SetBlipDisplay(blipHandle, 2)
        SetBlipAsShortRange(blipHandle, false)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(plate)
        EndTextCommandSetBlipName(blipHandle)

		activeTrackers[plate] = {
			blip		= blipHandle,
			currPos		= position,
			startPos	= position
		}
	else
		activeTrackers[plate].currPos = position

		Citizen.CreateThread(function()
			local timer = GetGameTimer()
			while (timer + Config.lerpTime > GetGameTimer()) do
				if (activeTrackers[plate] == nil) then
					return
				end

				local lerped = LerpVector2(activeTrackers[plate].startPos, activeTrackers[plate].currPos, (GetGameTimer() - timer) / Config.lerpTime)
				SetBlipCoords(activeTrackers[plate].blip, lerped.x, lerped.y, 0.0)
				
				Citizen.Wait(0)
			end

			activeTrackers[plate].startPos = activeTrackers[plate].currPos
			SetBlipCoords(activeTrackers[plate].blip, activeTrackers[plate].currPos.x, activeTrackers[plate].currPos.y, 0.0)

			local vehicle = TryGetVehicleFromPlate(plate)
			if (DoesEntityExist(vehicle)) then
				TriggerServerEvent("VT:suspendTracker", plate)

				Log("Suspending tracker for " .. plate)

				while (DoesEntityExist(vehicle) and activeTrackers[plate]) do
					local pos = GetEntityCoords(vehicle)
					activeTrackers[plate].currPos = vector2(pos.x, pos.y)
					activeTrackers[plate].startPos = activeTrackers[plate].currPos
					SetBlipCoords(activeTrackers[plate].blip, pos.x, pos.y, 0.0)
					
					Citizen.Wait(0)
				end
				
				Log("Restarting tracker for " .. plate)

				TriggerServerEvent("VT:restartTracker", plate)
			end
		end)
	end
end)

RegisterNetEvent("VT:vehicleDoesNotExist")
AddEventHandler("VT:vehicleDoesNotExist", function(plate)
	if (activeTrackers[plate]) then
		RemoveBlip(activeTrackers[plate].blip)
		
		activeTrackers[plate] = nil
		
		Log(plate .. " does not exist anymore. Stopping tracker...")
	end
end)



function GenerateMenu()
	trackerMenu:Clear()

	trackerMenu = NativeUI.CreateMenu(CS.trackerMenuTitle, CS.trackerMenuDesc)
	menuPool:Add(trackerMenu)

	local submenuTrackers	= menuPool:AddSubMenu(trackerMenu, CS.activeTrackersTitle, CS.activeTrackersDesc)
	local submenuVehicles	= menuPool:AddSubMenu(trackerMenu, CS.ownedVehiclesTitle, CS.ownedVehiclesDesc)
	--local submenuPolice		= menuPool:AddSubMenu(trackerMenu, "Police Tracker", "")

	for plate, tracker in pairs(activeTrackers) do
		local itemTracker = NativeUI.CreateItem(plate, CS.stopTrackerDesc)
		submenuTrackers:AddItem(itemTracker)
	end
	submenuTrackers.OnItemSelect = function(menu, item, index)
		local plate = item.Text._Text
		local success = CB:Trigger("VT:stopTracker", plate)
		if (success) then
			Log("Stopped tracking " .. plate)

			Notification(string.format(CS.stopTrackerNotif, plate))

			if (activeTrackers[success]) then
				RemoveBlip(activeTrackers[success].blip)
				activeTrackers[success] = nil
			end

			local count = 0
			for plate, tracker in pairs(activeTrackers) do
				count = count + 1
			end

			menuPool:CloseAllMenus()
		else
			Notification(string.format(CS.noActiveTrackerNotif, plate))

			Log(plate .. " has no active tracker...")
		end
	end

	local ownedVehicles = CB:Trigger("VT:getOwnedVehicles")
	for i, vehicle in ipairs(ownedVehicles) do
		local name = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model))
		if (name == "NULL") then
			name = GetDisplayNameFromVehicleModel(vehicle.model)
		end
		local itemVehicle = NativeUI.CreateItem(name .. " " .. vehicle.plate, CS.startTrackerDesc)
		submenuVehicles:AddItem(itemVehicle)
	end
	submenuVehicles.OnItemSelect = function(menu, item, index)
		local plate = ownedVehicles[index].plate
		
		local success = CB:Trigger("VT:startTracker", plate)
		if (success) then
			Notification(string.format(CS.startTrackerNotif, plate))

			Log("Started tracking " .. plate)
		else
			Notification(string.format(CS.trackingFailedNotif, plate))

			Log(plate .. " could not be tracked.")
		end
	end

	menuPool:ControlDisablingEnabled(false)
	menuPool:MouseControlsEnabled(false)

	menuPool:RefreshIndex()
end

function TryGetVehicleFromPlate(plate)
	local vehicles = GetAllVehicles()

	for i, vehicle in ipairs(vehicles) do
		if (DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub("^%s*(.-)%s*$", "%1") == plate) then
			return vehicle
		end
	end

	return nil
end

function LerpVector2(v1, v2, factor)
	return vector2(Lerp(v1.x, v2.x, factor), Lerp(v1.y, v2.y, factor))
end
function Lerp(f1, f2, factor)
	return f1 + (f2 - f1) * factor
end

function Notification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(text)
	return DrawNotification(false, true)
end

function Log(text)
	if (Config.isDebug) then
		print(text)
	end
end

-- Returns all loaded vehicles on client side
function GetAllVehicles()
    local vehicles = {}
    
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end
    
    return vehicles
end
-- getting all vehicles
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}



if (Config.useESX) then
	RegisterCommand(Config.menuCommand, function(source, args, raw)
		GenerateMenu()
		trackerMenu:Visible(not trackerMenu:Visible())
	end, false)
end
