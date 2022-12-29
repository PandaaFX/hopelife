print("resource started")

RegisterNetEvent("baseevents:enteringVehicle")
AddEventHandler("baseevents:enteringVehicle", function(targetVehicle, vehicleSeat, vehicleDisplayName)
    TriggerClientEvent("antivehiclekick:enteringVehicle", source, targetVehicle, vehicleSeat, vehicleDisplayName)
end)