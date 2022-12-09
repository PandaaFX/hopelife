RegisterCommand("+-+vehinfo", function(source, args)
    print(GetDisplayNameFromVehicleModel(tonumber(args[1])))
end)