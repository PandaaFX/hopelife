

ESXEvent = "esx:getSharedObject"

ESX = nil

TriggerEvent(ESXEvent, function(obj) 
    ESX = obj 
end)


PayMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)
            return true
        elseif xPlayer.getAccount("bank").money >= amount then
            xPlayer.removeAccountMoney("bank", amount)
            return true
        end
    end

    return false
end


GetVehicles = function(source, garage, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    local vehicletype = Config.DefaultType
    if Config.Garages[garage] and Config.Garages[garage].vehicletype or Config.Garages[garage].vehicletype2 or Config.Garages[garage].vehicletype3 or Config.Garages[garage].specifiedJob then
        vehicletype = Config.Garages[garage].vehicletype
        vehicletype2 = Config.Garages[garage].vehicletype2
        vehicletype3 = Config.Garages[garage].vehicletype3
        specifiedJob = Config.Garages[garage].specifiedJob
    end

    if xPlayer and xPlayer.identifier then
        MySQL.Async.fetchAll("SELECT `vehicle`, `type`, `damages`, `garage`, `job`, `plate`, `stored` FROM `owned_vehicles` WHERE `owner` = @identifier", {
            ["@identifier"] = xPlayer.identifier,
        }, function(result)

            if result and #result > 0 then
                local to_return = {}
                for k, v in pairs(result) do
                    if not v.damages then v.damages = "{}" end
                    -- specifiedJob
                    if  v.type == vehicletype or v.type == vehicletype2 or v.type == vehicletype3 then

                            if (specifiedJob == nil and v.job == "") or (specifiedJob == nil and v.job == "civ") then
                                table.insert(to_return, v)
                            else
                                if v.job == specifiedJob then
                                    table.insert(to_return, v)
                                end
                            end


                
                    end
                end

                cb(to_return)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end


StoreVehicle = function(source, garage, damages, vehprops)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        MySQL.Async.fetchAll("SELECT `owner`, `vehicle` FROM `owned_vehicles` WHERE `plate` = @plate", {
            ["@plate"] = vehprops.plate,
        }, function(data)
            if data then data = data[1] end
            if data and data.owner == xPlayer.identifier then
                if json.decode(data.vehicle).model == vehprops.model then
                    MySQL.Async.execute("UPDATE `owned_vehicles` SET `vehicle`=@vehicle, `damages`=@damages, `garage`=@garage, `stored`=1 WHERE `plate`=@plate", {
                        ["@vehicle"] = json.encode(vehprops),
                        ["@damages"] = json.encode(damages),
                        ["@garage"] = garage,
                        ["@plate"] = vehprops.plate
                    })

                    TriggerClientEvent("loaf_garage:deleteStoredVehicle", xPlayer.source, vehprops.plate)
                else
                  --  print(data.owner .. " tried to store a vehicle with another model. Cheater?")
                end
            end
        end)
    end
end


TakeOutVehicle = function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        MySQL.Async.fetchScalar("SELECT `owner` FROM `owned_vehicles` WHERE `owner`=@identifier AND `plate`=@plate AND `stored`=1", {
            ["@identifier"] = xPlayer.identifier,
            ["@plate"] = plate,
        }, function(owner)
            if owner then
                MySQL.Async.execute("UPDATE `owned_vehicles` SET `stored`=0 WHERE `plate`=@plate", {
                    ["@plate"] = plate
                })
                cb(true)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end


ImpoundVehicle = function(plate, cb)
    if plate and type(plate) == "string" then
        MySQL.Async.fetchScalar("SELECT `plate` FROM `owned_vehicles` WHERE `plate`=@plate", {
            ["@plate"] = plate,
        }, function(result)
            if result and type(result) == "string" then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end

GetImpounded = function(source, cb, vehtype, coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        MySQL.Async.fetchAll("SELECT `vehicle`, `type`, `damages`, `garage`, `job`, `plate` FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored`=0", {
            ["@identifier"] = xPlayer.identifier,
        }, function(result)

            if result and #result > 0 then
                local to_return = {}
                for k, v in pairs(result) do
                    if not v.damages then v.damages = "{}" end
                    if coords == vector3(408.672516, -1625.485718, 29.279907) then
                        if v.type == vehtype.type1 or v.type == vehtype.type2 or v.type == vehtype.type3 then
                            table.insert(to_return, v)
                        end
                    elseif coords == vector3(-217.582413, 6201.600098, 31.487183) then
                            if v.type == vehtype.type1 or v.type == vehtype.type2 or v.type == vehtype.type3 then
                                table.insert(to_return, v)
                        end
                    elseif coords == vector3(-1615.52, -3137.48, 13.3) then
                        if v.type == vehtype.type4 then
                            table.insert(to_return, v)
                        end
                    elseif coords == vector3(-834.303284, -1402.602173, 1.000427) then
                        if v.type == vehtype.type5 then
                            table.insert(to_return, v)
                        end
                    end
                end

                cb(to_return)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end


RetrieveCar = function(source, plate, coords, heading)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        if PayMoney(source, Config.ImpoundPrice) then
            MySQL.Async.fetchAll("SELECT `vehicle`, `damages`, `garage`, `job`, `plate` FROM `owned_vehicles` WHERE `owner`=@identifier AND `stored`=0 AND `plate`=@plate", {
                ["@identifier"] = xPlayer.identifier,
                ["@plate"] = plate
            }, function(result)
                if result and result[1] then
                    TriggerClientEvent("loaf_garage:spawnImpoundedCar", source, coords, heading, result[1])
                end
            end)
        else
            xPlayer.showNotification(Strings["not_enough_money"])
        end
    end
end