
ESX = nil
if (Config.useESX) then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local CB = exports["kimi_callbacks"]

local activeTrackers = {}

-- start tracking
CB:Register("VT:startTracker", function(source, _plate)
	local src = source

	return StartTracker(src, _plate)
end)

-- stop tracking
CB:Register("VT:stopTracker", function(source, _plate)
	local src = source

	return StopTracker(src, _plate)
end)

-- get owned vehicles
CB:Register("VT:getOwnedVehicles", function(source)
	return GetPlayerVehicles(source)
end)

-- stop tracker, but keep saved
RegisterServerEvent("VT:suspendTracker")
AddEventHandler("VT:suspendTracker", function(plate)
	local src = source

	if (activeTrackers[src] and activeTrackers[src][plate]) then
		Log("Suspending tracker for " .. plate)
		activeTrackers[src][plate].isSuspended = true
	end
end)
-- restart tracker again
RegisterServerEvent("VT:restartTracker")
AddEventHandler("VT:restartTracker", function(plate)
	local src = source

	if (activeTrackers[src] and activeTrackers[src][plate]) then
		Log("Restarting tracker for " .. plate)
		activeTrackers[src][plate].isSuspended = false
	end
end)

-- player disconnected, remove trackers
AddEventHandler("playerDropped", function(disconnectReason)
	Log("Stopping all trackers for " .. source)
	activeTrackers[source] = nil
end)



function StartTracker(playerId, plate)
	if (plate == nil or type(plate) ~= "string") then
		print("^1[ERROR] \"plate\" was nil or not a string when starting tracker!")
		return
	end
	
	local plate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()
	
	Log("Starting tracker for " .. plate)

	if (GetResourceState("AdvancedParking") == "started") then
		local pos = exports["AdvancedParking"]:GetVehiclePosition(plate)
		if (pos) then
			-- vehicle exists, start tracking

			if (activeTrackers[playerId] == nil) then
				activeTrackers[playerId] = {}
			end
			activeTrackers[playerId][plate] = {
				position	= pos,
				isSuspended	= false
			}
			
			-- send position to player once
			TriggerClientEvent("VT:position", playerId, plate, vector2(pos.x, pos.y))

			Citizen.CreateThread(function()
				while (true) do
					Citizen.Wait(Config.syncInterval)

					if (activeTrackers[playerId] == nil or activeTrackers[playerId][plate] == nil) then
						return
					end

					if (not activeTrackers[playerId][plate].isSuspended) then
						local position = exports["AdvancedParking"]:GetVehiclePosition(plate)
						if (position) then
							position = vector2(position.x, position.y)
							if (not Vector2EqualTolerance(position, activeTrackers[playerId][plate].position, 2.5)) then
								activeTrackers[playerId][plate].position = position

								-- send position to player
								TriggerClientEvent("VT:position", playerId, plate, position)
							end
						else
							-- vehicle does not exist anymore
							TriggerClientEvent("VT:vehicleDoesNotExist", playerId, plate)
							Log("Stopped tracker for " .. plate .. ". Vehicle does not exist anymore!")
							return
						end
					end
				end
			end)
		else
			-- vehicle does not exist
			return false
		end
	else
		-- no AdvancedParking, look for vehicle using just onesync
		local vehicle = TryGetVehicleFromPlate(plate)
		if (DoesEntityExist(vehicle)) then
			local pos = GetEntityCoords(vehicle)

			if (activeTrackers[playerId] == nil) then
				activeTrackers[playerId] = {}
			end
			activeTrackers[playerId][plate] = {
				position	= vector2(pos.x, pos.y),
				isSuspended	= false
			}
			
			-- send position to player once
			TriggerClientEvent("VT:position", playerId, plate, vector2(pos.x, pos.y))
			
			Citizen.CreateThread(function()
				while (true) do
					Citizen.Wait(Config.syncInterval)

					if (activeTrackers[playerId] == nil or activeTrackers[playerId][plate] == nil) then
						return
					end

					if (not activeTrackers[playerId][plate].isSuspended) then
						if (not DoesEntityExist(vehicle)) then
							-- vehicle does not exist anymore
							TriggerClientEvent("VT:vehicleDoesNotExist", playerId, plate)
							Log("Stopped tracker for " .. plate .. ". Vehicle does not exist anymore!")
							return
						end

						local position = GetEntityCoords(vehicle)
						position = vector2(position.x, position.y)
						if (not Vector2EqualTolerance(position, activeTrackers[playerId][plate].position, 2.5)) then
							activeTrackers[playerId][plate].position = position

							-- send position to player
							TriggerClientEvent("VT:position", playerId, plate, position)
						end
					end
				end
			end)
		else
			return false
		end
	end
	
	return true
end

function StopTracker(playerId, plate)
	if (plate == nil or type(plate) ~= "string") then
		print("^1[ERROR] \"plate\" was nil or not a string when stopping tracker!")
		return
	end
	
	local plate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()
	
	Log("Stopping tracker for " .. plate)

	if (activeTrackers[playerId] and activeTrackers[playerId][plate]) then
		activeTrackers[playerId][plate] = nil

		return plate
	end

	return false
end



-- get all owned vehicles from player
function GetPlayerVehicles(playerId)
    if (playerId == nil) then
		print("^1[ERROR] Parameter \"playerId\" was nil while triggering server export \"GetOwnedVehicles\"!")
		return
	end

    local vehicles = {}

	local playerData = ESX.GetPlayerFromId(playerId)
    if (playerData) then
        local results = MySQL.Sync.fetchAll("SELECT plate, vehicle FROM owned_vehicles WHERE owner = @owner", {
            ["@owner"] = playerData.identifier
        })
        
        for i = 1, #results, 1 do
            table.insert(vehicles, {
                plate = results[i].plate,
                model = json.decode(results[i].vehicle).model
            })
        end
    else
        print("^1[ERROR] \"playerData\" was nil while getting owned vehicles for id " .. tostring(playerId))
    end

    return vehicles
end

function Vector2EqualTolerance(v1, v2, tolerance)
	local difference = vector2(v1.x - v2.x, v1.y - v2.y)

	if (math.abs(difference.x) > tolerance or math.abs(difference.y) > tolerance) then
		return false
	end

	return true
end

function TryGetVehicleFromPlate(plate)
	local vehicles = GetAllVehicles()

	for i, vehicle in ipairs(vehicles) do
		if (DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub("^%s*(.-)%s*$", "%1"):upper() == plate) then
			return vehicle
		end
	end

	return nil
end

function Log(text)
	if (Config.isDebug) then
		print(text)
	end
end
