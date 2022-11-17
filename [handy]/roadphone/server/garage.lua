ESX.RegisterServerCallback("roadphone:getCars", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return;
    end

    MySQL.query("SELECT * FROM owned_vehicles WHERE `owner` = @identifier and type = @type", {
        ['@identifier'] = xPlayer.identifier,
        ['@type'] = "car"
    }, function(result)
        local cachedvehicles = {}

        for i = 1, #result, 1 do
            table.insert(cachedvehicles, {
                plate = result[i].plate,
                vehicle = json.decode(result[i].vehicle),
                type = result[i].type,
                garage = result[i].garage,
                stored = result[i].stored
            })
        end

        cb(cachedvehicles)

    end)

end)

ESX.RegisterServerCallback('roadphone:loadVehicle', function(source, cb, plate)
    MySQL.query('SELECT * FROM owned_vehicles WHERE `plate` = @plate', {
        ['@plate'] = plate
    }, function(vehicle)
        cb(vehicle)
    end)
end)

ESX.RegisterServerCallback('roadphone:checkValetMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return;
    end

    if xPlayer.getAccount('bank').money > API.DeliveryCar then
        xPlayer.removeAccountMoney('bank', API.DeliveryCar)        
        TriggerEvent("roadphone:addBankTransaction", getNumberFromIdentifier(xPlayer.identifier), 0, "Car delivered", API.DeliveryCar)
        TriggerClientEvent("roadphone:sendNotification", source, {
            title = _U('garageapp'),
            sender = _U('garageonway', API.DeliveryCar),
            message = nil,
            img = "/public/html/static/img/icons/app/garage.png"
        })
        valetWebhook("9807270", "Valet", xPlayer.getName() .. " has his car delivered", "RoadPhone")
        cb(true)
        return;
    else
        TriggerClientEvent("roadphone:sendNotification", source, {
            title = _U('garageapp'),
            sender = _U('garagenomoney'),
            message = nil,
            img = "/public/html/static/img/icons/app/garage.png"
        })
        cb(false)
        return;
    end

end)
