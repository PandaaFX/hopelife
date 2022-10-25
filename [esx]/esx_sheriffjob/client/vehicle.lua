


function StoreNearbyVehicle(playerCoords)
	local vehicles, plates, index = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}, {}

	if next(vehicles) then
		for i = 1, #vehicles do
			local vehicle = vehicles[i]
			
			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(vehicle) == 0 and IsVehicleSeatFree(vehicle, -1) then
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
				plates[#plates + 1] = plate
				index[plate] = vehicle
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('esx_policejob:storeNearbyVehicle', function(plate)
		if plate then
			local vehicleId = index[plate]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId)
			local isBusy = true

			CreateThread(function()
				BeginTextCommandBusyspinnerOn('STRING')
				AddTextComponentSubstringPlayerName(_U('garage_storing'))
				EndTextCommandBusyspinnerOn(4)

				while isBusy do
					Wait(100)
				end

				BusyspinnerOff()
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId) do
				Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for i = 1, #vehicles do
						local vehicle = vehicles[i]
						if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == plate then
							ESX.Game.DeleteVehicle(vehicle)
							break
						end
					end
				end
			end

			isBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, plates)
end


