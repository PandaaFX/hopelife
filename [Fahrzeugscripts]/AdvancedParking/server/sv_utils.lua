
-- returns if any player is inside a given vehicle
function IsAnyPlayerInsideVehicle(vehicle)
	local playerPeds = GetAllPlayerPeds()
	for i, playerPed in ipairs(playerPeds) do
		local veh = GetVehiclePedIsIn(playerPed, false)

		if (DoesEntityExist(veh) and veh == vehicle) then
			return true
		end
	end

	return false
end

-- return the id and distance of the closest player
function GetClosestPlayer(position, maxRadius)
	local closestDistance	= maxRadius and (maxRadius * maxRadius) or 1000000.0
	local closestPlayer		= nil
	local closestPos		= nil

	for i, player in ipairs(GetPlayers()) do
		if (GetPlayerRoutingBucket(player) == 0) then
			local ped = GetPlayerPed(player)
			if (DoesEntityExist(ped)) then
				local pos = GetEntityCoords(ped)
				local tempDistSquared = Vector3DistFast(position, pos)

				if (tempDistSquared < closestDistance) then
					closestDistance	= tempDistSquared
					closestPlayer	= player
					closestPos		= pos
				end
			end
		end
	end

	if (closestPos ~= nil) then
		closestDistance = Vector3Dist(position, closestPos)
	end

	return closestPlayer, closestDistance
end

-- returns all currently loaded playerpeds
function GetAllPlayerPeds()
	local playerPeds = {}

	local peds = GetAllPeds()
	for i, ped in ipairs(peds) do
		if (DoesEntityExist(ped) and IsPedAPlayer(ped)) then
			table.insert(playerPeds, ped)
		end
	end

	return playerPeds
end

-- return the ped of the closest player
function GetClosestPlayerPed(position, maxRadius)
	local closestDistance	= maxRadius and (maxRadius * maxRadius) or 1000000.0
	local closestPlayerPed	= nil
	local closestPos		= nil

	for i, playerPed in ipairs(GetAllPlayerPeds()) do
		local pos = GetEntityCoords(playerPed)
		local distanceSquared = Vector3DistFast(position, pos)

		if (distanceSquared < closestDistance) then
			closestDistance		= distanceSquared
			closestPlayerPed	= playerPed
			closestPos			= pos
		end
	end

	if (closestPos ~= nil) then
		closestDistance = Vector3Dist(position, closestPos)
	end

	return closestPlayerPed, closestDistance
end

-- Return an array with all identifiers - e.g. ids["license"] = license:xxxxxxxxxxxxxxxx
function GetPlayerIdentifiersSorted(playerServerId)
	local ids = {}

	local identifiers = GetPlayerIdentifiers(playerServerId)

	for k, identifier in pairs (identifiers) do
		local i, j = string.find(identifier, ":")
		local idType = string.sub(identifier, 1, i-1)

		ids[idType] = identifier
	end

	return ids
end

-- returns true if a player is active on the server with the specified license
function IsPlayerWithLicenseActive(license)
	local players = GetPlayers()
	for i, player in ipairs(players) do
		if (GetPlayerIdentifiersSorted(player)["license"] == license) then
			return true
		end
	end

	return false
end
