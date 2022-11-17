ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mapbuilder:syncObject')
AddEventHandler('mapbuilder:syncObject', function(hash, loc, heading, freeze, createdBy, comment)
    print('sync ' .. hash .. loc .. heading)
    TriggerClientEvent('mapbuilder:spawnObject', -1, hash, loc, heading, freeze, createdBy, comment)
end)

RegisterServerEvent('mapbuilder:syncObjectRemove')
AddEventHandler('mapbuilder:syncObjectRemove', function(objectID, hash)
    TriggerClientEvent('mapbuilder:deleteObject', -1, objectID, hash)
end)

RegisterServerEvent('mapbuilder:saveToDatabase')
AddEventHandler('mapbuilder:saveToDatabase', function(hash, loc, heading, freeze, comment)

    local identifier = GetPlayerIdentifiers(source)[1]

    MySQL.Async.execute(
        'INSERT INTO mapbuilder (objectHash, locX, locY, locZ, heading, freeze, createdBy, comment) VALUES (@objectHash, @locX, @locY, @locZ, @heading, @freeze, @createdBy, @comment)', {
            ['@objectHash'] = hash, 
            ['@locX'] = loc.x,
            ['@locY'] = loc.y,
            ['@locZ'] = loc.z,
            ['@heading'] = heading,
            ['@freeze'] = freeze,
            ['@createdBy'] = identifier,
            ['@comment'] = comment,
        })

end)

RegisterServerEvent('mapbuilder:removeFromDatabase')
AddEventHandler('mapbuilder:removeFromDatabase', function(objectID, hash)
    MySQL.Async.execute(
        'DELETE FROM mapbuilder WHERE id = @id and objectHash = @objectHash', {
            ['@id'] = objectID, 
            ['@objectHash'] = hash,
        })
end)

RegisterServerEvent('mapbuilder:updateObject')
AddEventHandler('mapbuilder:updateObject', function(objectID, loc, heading, freeze)
    MySQL.Async.execute(
        'UPDATE mapbuilder SET locX = @locX, locY = @locY, locZ = @locZ, heading = @heading, freeze = @freeze WHERE id = @id', {
            ['@id'] = objectID, 
            ['@locX'] = loc.x,
            ['@locY'] = loc.y,
            ['@locZ'] = loc.z,
            ['@heading'] = heading,
            ['@freeze'] = freeze,
        })

    TriggerClientEvent('mapbuilder:updateObject', -1, objectID, loc, heading, freeze)
end)

-- no callback to avoid using ESX
RegisterServerEvent('mapbuilder:getObjects')
AddEventHandler('mapbuilder:getObjects', function()
    local _source = source

    MySQL.Async.fetchAll('SELECT * FROM mapbuilder', {},
    function(result)
        if #result > 0 then
            local steamID = GetPlayerIdentifiers(_source)[1]
            TriggerClientEvent('mapbuilder:receiveObjects', _source, result, steamID)
        end
    end
    )

end)

RegisterServerEvent('mapbuilder:removeMoney')
AddEventHandler('mapbuilder:removeMoney', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(amount)
end)

ESX.RegisterServerCallback('mapbuilder:getMoney', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getMoney())
  
end)

ESX.RegisterServerCallback('mapbuilder:getGroup', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
  
end)