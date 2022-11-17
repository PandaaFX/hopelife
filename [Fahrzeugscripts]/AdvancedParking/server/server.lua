
local SPAWN_TIMEOUT = 30000
local SPAWN_DISTANCE = 200

-- read all vehicles from the database
function CreateAndReadFromDB()
	-- auto-add table if not exists
	MySQL.Sync.execute(
		"CREATE TABLE IF NOT EXISTS `vehicle_parking` (" .. 
			"\n`id` varchar(16) NOT NULL, " .. 
			"\n`model` int(11) NOT NULL, " .. 
			"\n`status` text NOT NULL, " .. 
			"\n`tuning` text NOT NULL, " .. 
			"\n`stateBags` text NOT NULL, " .. 
			"\n`posX` float NOT NULL, " .. 
			"\n`posY` float NOT NULL, " .. 
			"\n`posZ` float NOT NULL, " .. 
			"\n`rotX` float NOT NULL, " .. 
			"\n`rotY` float NOT NULL, " .. 
			"\n`rotZ` float NOT NULL, " .. 
			"\n`lastUpdate` int(11) NOT NULL DEFAULT '0', " .. 
			"\nPRIMARY KEY (`id`)" .. 
		"\n)"
	)

	local rows = MySQL.Sync.fetchAll(
		"SELECT `id`, `model`, `status`, `tuning`, `stateBags`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `lastUpdate` " .. 
		"\nFROM `vehicle_parking`"
	)

	Log("Found %s saved vehicles in vehicle_parking.", #rows)

	for i, row in ipairs(rows) do
		local tune = json.decode(row.tuning)
		if (row.model ~= nil and tune[1] ~= nil) then
			savedVehicles[row.id] = {
				handle			= nil,
				model			= row.model,
				status			= json.decode(row.status),
				tuning			= tune,
				stateBags		= json.decode(row.stateBags),
				position		= vector3(row.posX, row.posY, row.posZ),
				rotation		= vector3(row.rotX, row.rotY, row.rotZ),
				lastUpdate		= row.lastUpdate,
				spawning		= false
			}
		else
			LogWarning("Vehicle \"%s\" does not have a model or plate associated with it. Deleting...", row.id)

			MySQL.Async.execute(
				"DELETE FROM `vehicle_parking` " .. 
				"WHERE `id` = @id", {
					['@id'] = row.id
				}
			)
		end
	end
end

-- deletes vehicles if they are in the world without being updated for too long
function CleanUp()
	local currentTime	= os.time()
	local threshold		= 3600 * Config.cleanUpThresholdTime
	local timeDiff		= os.difftime(currentTime, threshold)

	local toDelete = {}

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.lastUpdate < timeDiff or (Config.cleanUpExplodedVehicles and vehicleData.status[3] < -3999.0)) then
			table.insert(toDelete, id)
		end
	end

	for i, id in ipairs(toDelete) do
		if (savedVehicles[id].handle and DoesEntityExist(savedVehicles[id].handle)) then
			DeleteEntity(savedVehicles[id].handle)

			LogDebug("Deleted \"%s\" through cleanup.", id)
		end

		if (Config.storeOwnedVehiclesInGarage) then
			local isESX = GetResourceState("es_extended") == "started"
			local tableName	= isESX and "owned_vehicles" or "player_vehicles"
			local colName	= isESX and "stored" or "state"

			local plate = savedVehicles[id].tuning[1]:upper()
			MySQL.Async.execute(
				"UPDATE `" .. tableName .. "` SET `" .. colName .. "` = 1 " .. 
				"\nWHERE `plate` = @plate OR `plate` = @trimmedPlate", {
					['@plate'] = plate,
					['@trimmedPlate'] = Trim(plate)
				}
			)
		end

		savedVehicles[id] = nil
	end

	DeleteVehiclesFromDB(toDelete)

	Log("CleanUp complete. Deleted %s entries.", #toDelete)
end

-- add clean up tasks
if (Config.useCleanUpTask) then
	for i, time in ipairs(Config.cleanUpTimes) do
		AddTask(CleanUp, time.hour, time.minute)
	end
end

function StartMainLoop()
	-- main loop for spawning and updating vehicles
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(5000)

			if (#GetPlayers() > 0) then
				SpawnVehicles()
				UpdateVehicles()
			end
		end
	end)
end

MySQL.ready(function()
	-- get all vehicle data sets
	CreateAndReadFromDB()

	-- clean up vehicle data
	CleanUp()

	-- start the spawning/updating
	StartMainLoop()
end)



AddEventHandler("entityRemoved", function(entity)
	local id = Entity(entity).state.ap_id
	if (id == nil) then
		return
	end

	if (savedVehicles[id]) then
		savedVehicles[id].position	= GetEntityCoords(entity)
		savedVehicles[id].rotation	= GetEntityRotation(entity)
		savedVehicles[id].handle	= nil
		savedVehicles[id].spawning	= false
	end
end)

-- try spawning vehicles
function SpawnVehicles()
	for id, vehicleData in pairs(savedVehicles) do
		if (not vehicleData.spawning and vehicleData.handle == nil) then
			local loadedVehicle = TryGetLoadedVehicleFromPlate(vehicleData.tuning[1])
			if (loadedVehicle) then
				-- vehicle exists, add handle
				vehicleData.handle = loadedVehicle

				Entity(vehicleData.handle).state.ap_id = id

				LogDebug("Found vehicle \"%s\" at %s", id, RoundVector3(GetEntityCoords(vehicleData.handle), 2))
			elseif (GetClosestPlayer(vehicleData.position, SPAWN_DISTANCE)) then
				-- vehicle not found, spawn it when player is close
				Citizen.CreateThread(function()
					SpawnVehicle(id, vehicleData)
				end)
			end
		end
	end
end

-- spawn a vehicle from its data
function SpawnVehicle(id, vehicleData)
	if (vehicleData.model == nil) then
		return
	end

	vehicleData.spawning = true

	local vehicle = CreateVehicle(vehicleData.model, vehicleData.position, vehicleData.rotation.z, true, true)

	local timer = GetGameTimer()
	while (not DoesEntityExist(vehicle)) do
		Citizen.Wait(0)

		if (timer + SPAWN_TIMEOUT < GetGameTimer()) then
			-- timeout
			LogWarning("Hit timeout while spawning vehicle \"%s\".", id)

			return
		end
	end

	-- prevent NPCs in vehicles
	local ped = GetPedInVehicleSeat(vehicle, -1)
	if (ped and DoesEntityExist(ped) and not IsPedAPlayer(ped)) then
		LogDebug("Deleting an NPC that spawned in vehicle \"%s\"", id)

		DeleteEntity(ped)
	end

	SetEntityCoords(vehicle, vehicleData.position)
	SetEntityRotation(vehicle, vehicleData.rotation)

	SetVehicleNumberPlateText(vehicle, vehicleData.tuning[1])
	SetVehicleDoorsLocked(vehicle, vehicleData.status[7])

	-- apply state bags
	local state = Entity(vehicle).state

	state.ap_id		= id
	state.ap_data	= { vehicleData.tuning, vehicleData.status }

	for bagName, bagData in pairs(vehicleData.stateBags) do
		state:set(bagName, bagData, true)
	end

	vehicleData.handle = vehicle

	LogDebug("Creating vehicle \"%s\" at %s", id, vehicleData.position)
end

-- update vehicles
function UpdateVehicles()
	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.handle and DoesEntityExist(vehicleData.handle)) then
			TryUpdateVehicle(id)
		end
	end
end

-- check if update is necessary and update
function TryUpdateVehicle(id)
	if (IsAnyPlayerInsideVehicle(savedVehicles[id].handle) or Entity(savedVehicles[id].handle).state.isAttached) then
		return
	end

	local newPos = RoundVector3(GetEntityCoords(savedVehicles[id].handle), 2)
	local newRot = RoundVector3(GetEntityRotation(savedVehicles[id].handle), 2)

	local newLockStatus     = GetVehicleDoorLockStatus(savedVehicles[id].handle)
	local newEngineHealth   = math.floor(GetVehicleEngineHealth(savedVehicles[id].handle) * 10.0) * 0.1
	local newTankHealth     = math.floor(GetVehiclePetrolTankHealth(savedVehicles[id].handle) * 10.0) * 0.1

	local posChange				= Vector3DistFast(savedVehicles[id].position, newPos) > 1.0
	local rotChange				= GetRotationDifference(savedVehicles[id].rotation, newRot) > 15.0
	local lockChange			= false
	local engineHealthChange	= newEngineHealth + 5.0 < savedVehicles[id].status[3]
	local tankHealthChange		= newTankHealth + 5.0 < savedVehicles[id].status[4]

	if ((newLockStatus == 0 or newLockStatus == 1) and (savedVehicles[id].status[7] == 0 or savedVehicles[id].status[7] == 1)) then
		-- don't register change
	elseif (newLockStatus ~= savedVehicles[id].status[7]) then
		-- changed
		lockChange = true
	end

	if (posChange or rotChange or lockChange or engineHealthChange or tankHealthChange) then
		LogDebug("Reason for next update:")
		if (posChange) then				LogDebug("    - Position from %s to %s", savedVehicles[id].position, newPos)			end
		if (rotChange) then				LogDebug("    - Rotation from %s to %s", savedVehicles[id].rotation, newRot)			end
		if (lockChange) then			LogDebug("    - Lockstate from %s to %s", savedVehicles[id].status[7], newLockStatus)	end
		if (engineHealthChange) then	LogDebug("    - Engine from %s to %s", savedVehicles[id].status[3], newEngineHealth)	end
		if (tankHealthChange) then		LogDebug("    - Tank from %s to %s", savedVehicles[id].status[4], newTankHealth)		end

		savedVehicles[id].position = newPos
		savedVehicles[id].rotation = newRot

		savedVehicles[id].status[3] = newEngineHealth
		savedVehicles[id].status[4] = newTankHealth
		savedVehicles[id].status[7] = newLockStatus

		savedVehicles[id].lastUpdate = os.time()

		Entity(savedVehicles[id].handle).state.ap_data = { savedVehicles[id].tuning, savedVehicles[id].status }

		UpdateVehicleInDB(id)
	end
end

-- triggered from client side to either update or insert a vehicle
RegisterNetEvent("AP:updateVehicle", function(networkId, model, tuning, status)
	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (not DoesEntityExist(vehicle) or GetEntityRoutingBucket(vehicle) ~= 0) then
		return
	end

	local id = Entity(vehicle).state.ap_id
	if (id and savedVehicles[id]) then
		-- already exists
		savedVehicles[id].status		= status
		savedVehicles[id].tuning		= tuning
		savedVehicles[id].position		= RoundVector3(GetEntityCoords(vehicle), 2)
		savedVehicles[id].rotation		= RoundVector3(GetEntityRotation(vehicle), 2)
		savedVehicles[id].lastUpdate	= os.time()

		UpdateVehicleInDB(id)

		LogDebug("    Reason: Get in/out or manual update")
	else
		-- does not exist
		id = GetNewVehicleIdentifier()

		Entity(vehicle).state.ap_id = id

		savedVehicles[id] = {
			handle		= vehicle,
			model		= model,
			status		= status,
			tuning		= tuning,
			stateBags	= {},
			position	= RoundVector3(GetEntityCoords(vehicle), 2),
			rotation	= RoundVector3(GetEntityRotation(vehicle), 2),
			lastUpdate	= os.time(),
			spawning	= false
		}

		InsertVehicleInDB(id)
	end
end)

-- insert vehicle into database
function InsertVehicleInDB(id)
	assert(id ~= nil and type(id) == "string", "Parameter \"id\" must be a string!")

	LogDebug("Inserting new vehicle \"%s\" into database", id)

	MySQL.Async.execute(
		"INSERT INTO vehicle_parking (`id`, `model`, `status`, `tuning`, `stateBags`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `lastUpdate`) " .. 
		"\nVALUES (@id, @model, @status, @tuning, @stateBags, @posX, @posY, @posZ, @rotX, @rotY, @rotZ, @lastUpdate)", {
			["@id"]			= id,
			["@model"]		= savedVehicles[id].model,
			["@status"]		= json.encode(savedVehicles[id].status, { indent = true }),
			["@tuning"]		= json.encode(savedVehicles[id].tuning, { indent = true }),
			["@stateBags"]	= json.encode(savedVehicles[id].stateBags, { indent = true }),
			["@posX"]		= savedVehicles[id].position.x,
			["@posY"]		= savedVehicles[id].position.y,
			["@posZ"]		= savedVehicles[id].position.z,
			["@rotX"]		= savedVehicles[id].rotation.x,
			["@rotY"]		= savedVehicles[id].rotation.y,
			["@rotZ"]		= savedVehicles[id].rotation.z,
			["@lastUpdate"]	= savedVehicles[id].lastUpdate
		}
	)
end

-- update vehicle in database
function UpdateVehicleInDB(id)
	assert(id ~= nil and type(id) == "string", "Parameter \"id\" must be a string!")

	LogDebug("Updating vehicle \"%s\" in database", id)

	MySQL.Async.execute(
		"UPDATE `vehicle_parking` " .. 
		"\nSET `status` = @status, " .. 
			"\n`tuning` = @tuning, " .. 
			"\n`stateBags` = @stateBags, " .. 
			"\n`posX` = @posX, `posY` = @posY, `posZ` = @posZ, " .. 
			"\n`rotX` = @rotX, `rotY` = @rotY, `rotZ` = @rotZ, " .. 
			"\n`lastUpdate` = @lastUpdate " .. 
		"\nWHERE `id` = @id", {
			["@id"]			= id,
			["@status"]		= json.encode(savedVehicles[id].status, { indent = true }),
			["@tuning"]		= json.encode(savedVehicles[id].tuning, { indent = true }),
			["@stateBags"]	= json.encode(savedVehicles[id].stateBags, { indent = true }),
			["@posX"]		= savedVehicles[id].position.x,
			["@posY"]		= savedVehicles[id].position.y,
			["@posZ"]		= savedVehicles[id].position.z,
			["@rotX"]		= savedVehicles[id].rotation.x,
			["@rotY"]		= savedVehicles[id].rotation.y,
			["@rotZ"]		= savedVehicles[id].rotation.z,
			["@lastUpdate"] = savedVehicles[id].lastUpdate
		}
	)
end

-- delete vehicle(s) from database
function DeleteVehiclesFromDB(...)
	local idList = {...}

	if (type(idList[1]) == "table") then
		idList = idList[1]
	end
	if (#idList == 0) then
		return
	end

	local str = json.encode(idList)
	str = str:sub(2, str:len() - 1)

	MySQL.Async.execute(
		"DELETE FROM `vehicle_parking` " .. 
		"\nWHERE `id` IN (" .. str .. ")"
	)
end

AddStateBagChangeHandler("ap_spawned", nil, function(bagName, key, value, _unused, replicated)
	if (bagName:find("entity:")) then
		local entityIdString = bagName:gsub("entity:", "")
		local entityId = tonumber(entityIdString)
		local entity = NetworkGetEntityFromNetworkId(entityId)

		local id = Entity(entity).state.ap_id
		if (id and savedVehicles[id]) then
			savedVehicles[id].spawning = false

			LogDebug("Setting tuning and status successful for \"%s\"", id)

			if (DoesEntityExist(savedVehicles[id].handle)) then
				TriggerEvent("AP:vehicleSpawned", savedVehicles[id].handle)
				TriggerClientEvent("AP:vehicleSpawned", -1, NetworkGetNetworkIdFromEntity(savedVehicles[id].handle))
			end
		end
	end
end)

-- delete vehicles that are still being spawned before actually stopping the resource
AddEventHandler("onResourceStop", function(name)
	if (name ~= GetCurrentResourceName()) then
		return
	end

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.spawning and DoesEntityExist(vehicleData.handle)) then
			DeleteEntity(vehicleData.handle)
		end
	end
end)

-- loop to delete vehicles when using auto deleter
local AD = Config.autoDelete
if (AD.timer > 0) then
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(60000 * (AD.timer - AD.notificationTimes[1]))

			TriggerClientEvent("AP:showNotification", -1, AD.timeLeftNotification:format(AD.notificationTimes[1]))
			for i = 2, #AD.notificationTimes, 1 do
				Citizen.Wait(60000 * (AD.notificationTimes[i - 1] - AD.notificationTimes[i]))
				TriggerClientEvent("AP:showNotification", -1, AD.timeLeftNotification:format(AD.notificationTimes[i]))
			end
			Citizen.Wait(60000 * AD.notificationTimes[#AD.notificationTimes])

			TriggerClientEvent("AP:showNotification", -1, AD.deleteNotification)

			DeleteAllVehicles()
		end
	end)

	function DeleteAllVehicles()
		local time = GetGameTimer()

		local vehicles = GetAllVehicles()
		local deleted = 0
		local toDelete = {}

		for id, vehicleData in pairs(savedVehicles) do
			if (vehicleData.handle == nil) then
				table.insert(toDelete, id)

				savedVehicles[id] = nil
			end
		end

		for i, vehicle in ipairs(vehicles) do
			if (DoesEntityExist(vehicle) and not IsAnyPlayerInsideVehicle(vehicle)) then
				local closestPlayer, distance = GetClosestPlayerPed(GetEntityCoords(vehicle))
				if (closestPlayer == nil or distance > AD.distance) then
					local id = Entity(vehicle).state.ap_id
					if (id and savedVehicles[id]) then
						savedVehicles[id] = nil

						table.insert(toDelete, id)
					end

					DeleteEntity(vehicle)

					deleted = deleted + 1
				end
			end
		end

		DeleteVehiclesFromDB(toDelete)

		Log(string.format("Deleted %s/%s vehicles. Took %ssec", deleted, #vehicles, (GetGameTimer() - time) * 0.001))
	end
end

function DeleteVehicle(vehicle)
	if (not DoesEntityExist(vehicle)) then
		return
	end

	DeleteVehicleUsingData(Entity(vehicle).state.ap_id, NetworkGetNetworkIdFromEntity(vehicle), GetVehicleNumberPlateText(vehicle))
end
exports("DeleteVehicle", DeleteVehicle)

function DeleteVehicleUsingData(identifier, networkId, plate)
	if (identifier == nil and networkId == nil and plate == nil) then
		LogWarning("Tried to delete vehicle without \"identifier\", \"networkId\" and \"plate\"!")
		return
	end

	LogDebug("Trying to delete using identifier \"%s\", networkId \"%s\", plate \"%s\"", identifier, networkId, plate)

	if (identifier and DeleteVehicleUsingIdentifier(identifier)) then
		return
	end
	if (networkId and DeleteVehicleUsingNetworkId(networkId)) then
		return
	end
	if (plate and DeleteVehicleUsingPlate(plate)) then
		return
	end
end
exports("DeleteVehicleUsingData", DeleteVehicleUsingData)

-- delete vehicle from client side using identifier, network id or plate
RegisterNetEvent("AP:deleteVehicle", function(identifier, networkId, plate)
	DeleteVehicleUsingData(identifier, networkId, plate)
end)

-- delete vehicle using identifier
function DeleteVehicleUsingIdentifier(id)
	LogDebug("Trying to delete using identifier \"%s\"", id)

	if (savedVehicles[id]) then
		if (savedVehicles[id].handle and DoesEntityExist(savedVehicles[id].handle)) then
			DeleteEntity(savedVehicles[id].handle)
		end

		local result, error = pcall(DeleteVehiclesFromDB, id)
		if (not result) then
			LogError("Error occured while calling \"DeleteVehiclesFromDB\" inside \"DeleteVehicleUsingIdentifier\"!")
			LogError("Full error: %s", error)
		end

		savedVehicles[id] = nil

		return true
	end

	return false
end

-- delete vehicle using network id
function DeleteVehicleUsingNetworkId(networkId)
	LogDebug("Trying to delete using networkId \"%s\"", networkId)

	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (not DoesEntityExist(vehicle)) then
		return false
	end

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.handle == vehicle) then
			DeleteEntity(vehicle)

			DeleteVehiclesFromDB(id)

			savedVehicles[id] = nil

			return true
		end
	end

	DeleteEntity(vehicle)

	return true
end

-- delete vehicle using plate
function DeleteVehicleUsingPlate(plate)
	LogDebug("Trying to delete using plate \"%s\"", plate)

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.tuning[1] == plate or Trim(vehicleData.tuning[1]) == plate) then
			if (vehicleData.handle and DoesEntityExist(vehicleData.handle)) then
				DeleteEntity(vehicleData.handle)
			end

			DeleteVehiclesFromDB(id)

			savedVehicles[id] = nil

			return true
		end
	end

	local vehicle = TryGetLoadedVehicleFromPlate(plate)
	if (vehicle and DoesEntityExist(vehicle)) then
		DeleteEntity(vehicle)

		return true
	end

	return false
end

-- state bag change handler for detecting changes on a vehicle
--   auto updates in the database if the last update was too long ago
AddStateBagChangeHandler(nil, nil, function(bagName, key, value, _unused, replicated)
	if (key:find("ap_")) then
		return
	end

	if (bagName:find("entity")) then
		local entityIdString = bagName:gsub("entity:", "")
		local entityId = tonumber(entityIdString)
		local entity = NetworkGetEntityFromNetworkId(entityId)

		local id = Entity(entity).state.ap_id
		if (id and savedVehicles[id]) then
			if (savedVehicles[id].stateBags[key] == nil or not TableEquals(savedVehicles[id].stateBags[key], value)) then
				-- new state bag OR update
				savedVehicles[id].stateBags[key] = value

				-- only update after certain time has passed to prevent too many update queries
				local currentTime	= os.time()
				local threshold		= 30
				local timeDiff		= os.difftime(currentTime, threshold)
				if (savedVehicles[id].lastUpdate < timeDiff) then
					savedVehicles[id].lastUpdate = currentTime

					UpdateVehicleInDB(id)

					LogDebug("    Reason: Updating entity state bag \"%s\" for \"%s\"", key, id)
				end
			end
		end
	end
end)

-- getting a vehicle position using its plate
function GetVehiclePosition(plate)
	assert(plate ~= nil and type(plate) == "string", "Parameter \"plate\" must be a string!")

	plate = plate:upper()

	local vehicles = GetAllVehicles()
	for i, vehicle in ipairs(vehicles) do
		if (DoesEntityExist(vehicle)) then
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			if (plate == vehPlate or plate == Trim(vehPlate)) then
				return GetEntityCoords(vehicle)
			end
		end
	end

	for id, vehicleData in pairs(savedVehicles) do
		if (plate == vehicleData.tuning[1] or plate == Trim(vehicleData.tuning[1])) then
			return vehicleData.position
		end
	end

	return nil
end
exports("GetVehiclePosition", GetVehiclePosition)

-- getting vehicle positions using more than one plate
function GetVehiclePositions(plates)
	for i, plate in ipairs(plates) do
		assert(plate ~= nil and type(plate) == "string", "Parameter \"plates\" must only contain strings!")
		plate = plate:upper()
	end

	local platePositions = {}

	-- check all loaded vehicles first
	local vehicles = GetAllVehicles()
	for i, vehicle in ipairs(vehicles) do
		if (DoesEntityExist(vehicle)) then
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			local trimmedVehPlate = Trim(vehPlate)

			for j, plate in ipairs(plates) do
				if (plate == vehPlate or plate == trimmedVehPlate) then
					platePositions[plate] = GetEntityCoords(vehicle)

					break
				end
			end
		end
	end

	-- then search missing vehicles in APs saved vehicles
	for i, plate in ipairs(plates) do
		if (platePositions[plate] == nil) then
			for id, vehicleData in pairs(savedVehicles) do
				local trimmedVehPlate = Trim(vehicleData.tuning[1])

				if (plate == vehicleData.tuning[1] or plate == trimmedVehPlate) then
					platePositions[plate] = vehicleData.position

					break
				end
			end
		end
	end

	return platePositions
end
exports("GetVehiclePositions", GetVehiclePositions)

-- callbacks for client side getting of vehicle position(s)
local CB = exports["kimi_callbacks"]
CB:Register("AP:getVehiclePosition", function(source, plate)
	return GetVehiclePosition(plate)
end)
CB:Register("AP:getVehiclePositions", function(source, plates)
	return GetVehiclePositions(plates)
end)

-- callback when saving only owned vehicles
if (Config.saveOnlyOwnedVehicles) then
	CB:Register("AP:isOwned", function(source, plate)
		assert(plate ~= nil and type(plate) == "string", "Parameter \"plate\" must be a string!")

		plate = plate:upper()

		local tableName = (GetResourceState("es_extended") == "started") and "owned_vehicles" or "player_vehicles"
		local results = MySQL.Sync.fetchAll(
			"SELECT `plate` " .. 
			"FROM `" .. tableName .. "` " .. 
			"WHERE `plate` = @plate OR `plate` = @trimmedPlate", {
				['@plate']			= plate,
				['@trimmedPlate']	= Trim(plate)
			}
		)

		return #results > 0
	end)
end

-- command to delete ALL vehicles from the database table. Needs to be executed twice for security reason.
local deleteSavedVehicles = false
RegisterCommand("deleteSavedVehicles", function(source, args, raw)
	if (deleteSavedVehicles) then
		MySQL.Async.execute("DELETE FROM `vehicle_parking`")

		savedVehicles = {}

		Log("Deleted all vehicles from the vehicle_parking table.")
	else
		Log("Are you sure that you want to delete all vehicles from the parking list?\nIf yes, execute the command a second time!")
	end

	deleteSavedVehicles = not deleteSavedVehicles
end, true)

-- render entity scorched (trigger with networkId of the vehicle and false when repairing)
RegisterServerEvent("AP:renderScorched", function(networkId, scorched)
	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (DoesEntityExist(vehicle)) then
		TriggerClientEvent("AP:renderScorched", -1, networkId, scorched)
	end
end)



function UpdatePlate(networkId, newPlate, oldPlate)
	if (networkId == nil) then
		LogError("\"networkId\" was nil while trying to update a plate!")
		return
	end
	if (newPlate == nil or newPlate:len() > 8) then
		LogError("\"newPlate\" was nil or too long while trying to update a plate!")
		return
	end

	-- format plates
	newPlate = Trim(newPlate:upper())
	if (oldPlate) then
		oldPlate = Trim(oldPlate:upper())
	end

	-- change plate on vehicle
	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (DoesEntityExist(vehicle)) then
		SetVehicleNumberPlateText(vehicle, newPlate)

		local found = false
		while (not found) do
			Citizen.Wait(0)

			found = Trim(GetVehicleNumberPlateText(vehicle)) == newPlate
		end

		newPlate = GetVehicleNumberPlateText(vehicle)
	end

	-- search for plate
	for id, vehicleData in pairs(savedVehicles) do
		if (vehicle == vehicleData.handle) then
			local old = vehicleData.tuning[1]
			vehicleData.tuning[1] = newPlate

			UpdateVehicleInDB(id)

			LogDebug("    Reason: Updating plate from \"%s\" to \"%s\"", old, newPlate)

			return
		end
	end

	-- search for plate by using oldPlate
	if (oldPlate) then
		newPlate = FillPlateWithSpaces(newPlate)

		for id, vehicleData in pairs(vehicles) do
			if (Trim(vehicleData.tuning[1]) == oldPlate) then
				vehicleData.tuning[1] = newPlate

				UpdateVehicleInDB(id)

				LogDebug("    Reason: Updating plate from \"%s\" to \"%s\"", oldPlate, newPlate)

				return
			end
		end
	end

	LogDebug("No vehicle found to change plate to \"%s\" failed.", newPlate)
end
exports("UpdatePlate", UpdatePlate)

RegisterNetEvent("AP:updatePlate", function(networkId, newPlate)
	UpdatePlate(networkId, newPlate)
end)



-- prevent "ghost" vehicles that didn't spawn correctly
Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(10000)

		for id, vehicleData in pairs(savedVehicles) do
			if (not vehicleData.spawning and vehicleData.handle and DoesEntityExist(vehicleData.handle) and not IsAnyPlayerInsideVehicle(vehicleData.handle)) then
				if (vehicleData.tuning[1] ~= GetVehicleNumberPlateText(vehicleData.handle)) then
					LogDebug("Deleted ghost vehicle \"%s\"", id)

					DeleteEntity(vehicleData.handle)

					vehicleData.handle = nil
				end
			end
		end
	end
end)
