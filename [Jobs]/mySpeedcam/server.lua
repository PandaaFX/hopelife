ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('myRadarcontrol:payFine')
AddEventHandler('myRadarcontrol:payFine', function(fine, society)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeAccountMoney(Config.moneyAccount, fine)
    
    TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        if account ~= nil then
            account.addMoney(fine)
        end
    end)
end)

RegisterServerEvent('myRadarcontrol:addProfit')
AddEventHandler('myRadarcontrol:addProfit', function(type, radarID, label, profit)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local userCharname = GetCharName(xPlayer.identifier)
   
    local dateString = os.date("%x")
	if Config.dateFormat == 'de' then
		dateString = os.date("%d.%m.%Y | %H:%M")
	else
		dateString = os.date("%x | %H:%M")
	end

    MySQL.Async.fetchAll('SELECT * FROM speedcams_profit WHERE (type = @type AND radarID = @radarID) LIMIT 1', {
        ['@type'] = type,
        ['@radarID'] = radarID,
    },
    function(result)
        if result ~= nil and  #result > 0 then
            MySQL.Async.execute(
                'UPDATE speedcams_profit SET totalProfit = @totalProfit, lastTime = @lastTime, lastProfit = @lastProfit, lastUser = @lastUser WHERE (type = @type AND radarID = @radarID)', {
                    ['@type'] = type, 
                    ['@radarID'] = radarID,
                    ['@label'] = label,
                    ['@totalProfit'] = result[1].totalProfit + profit,
                    ['@lastTime'] = dateString,
                    ['@lastProfit'] = profit,
                    ['@lastUser'] = userCharname,
                    
                })
        else
            --print(_source)
            createNewProfitEntry(type, radarID, label, profit, _source)
        end
        if Config.sendCopDispatch then
            TriggerClientEvent('myRadarcontrol:doCopNotify', -1, label, userCharname, profit)
        end
    end
    )

end)


function createNewProfitEntry(type, radarID, label, profit, userSource)
    --print(userSource)
    local xPlayer = ESX.GetPlayerFromId(userSource)
    local userCharname = GetCharName(xPlayer.identifier)

    local dateString = os.date("%x")
	if Config.dateFormat == 'de' then
		dateString = os.date("%d.%m.%Y | %H:%M")
	else
		dateString = os.date("%x | %H:%M")
	end

    MySQL.Async.execute(
        'INSERT INTO speedcams_profit (type, radarID, label, totalProfit, lastTime, lastProfit, lastUser) VALUES (@type, @radarID, @label, @totalProfit, @lastTime, @lastProfit, @lastUser)', {
            ['@type'] = type, 
            ['@radarID'] = radarID,
            ['@label'] = label,
            ['@totalProfit'] = profit,
            ['@lastTime'] = dateString,
            ['@lastProfit'] = profit,
            ['@lastUser'] = userCharname,
            
        })

end

function GetCharName(identifier)
    local doing = true 
    local charname = 'Unknown Unknown'

    MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier LIMIT 1',
    {
      ['@identifier'] = identifier,
    },
      function(res)
        charname = res[1].firstname .. ' ' .. res[1].lastname
        doing = false
      end
    )

    while doing do
        Citizen.Wait(0)
    end

    return charname
end


function saveToDatabase(label, position, maxSpeed, flashRange, society)
    MySQL.Async.execute(
        'INSERT INTO speedcams (label, maxSpeed, flashRange, positionX, positionY, positionZ, heading, society) VALUES (@label, @maxSpeed, @flashRange, @positionX, @positionY, @positionZ, @heading, @society)', {
            ['@label'] = label, 
            ['@maxSpeed'] = maxSpeed,
            ['@flashRange'] = flashRange,
            ['@positionX'] = position.x,
            ['@positionY'] = position.y,
            ['@positionZ'] = position.z,
            ['@heading'] = position.heading,
            ['@society'] = society,
        }, 
        function(res)

            MySQL.Async.fetchAll('SELECT id FROM speedcams WHERE positionX = @posX AND positionY = @posY LIMIT 1', {
                ['posX'] = position.x,
                ['posY'] = position.y,
            },
            function(result)
                TriggerClientEvent('myRadarcontrol:syncNewSpeedcam', -1, label, position, maxSpeed, flashRange, society, result[1].id)
            end)

        end)

    
end

function editSpeedcam(label, position, maxSpeed, flashRange, society, oldPosition)
    MySQL.Async.execute(
        'UPDATE speedcams SET label = @label, maxSpeed = @maxSpeed, flashRange = @flashRange, society = @society, positionX = @positionX, positionY = @positionY, positionZ = @positionZ, heading = @heading WHERE (positionX = @oldPosX AND positionY = @oldPosY AND positionZ = @oldPosZ)', {
            ['@label'] = label,
            ['@maxSpeed'] = maxSpeed,
            ['@flashRange'] = flashRange,
            ['@society'] = society,
            ['@positionX'] = position.x,
            ['@positionY'] = position.y,
            ['@positionZ'] = position.z,
            ['@heading'] = position.heading,
            ['@oldPosX'] = oldPosition.x,
            ['@oldPosY'] = oldPosition.y,
            ['@oldPosZ'] = oldPosition.z,
        })

    TriggerClientEvent('myRadarcontrol:syncSpeedcamEdit', -1, label, position, maxSpeed, flashRange, society, oldPosition)
end

function deleteSpeedcam(oldPosition)
    MySQL.Async.execute(
        'DELETE FROM speedcams WHERE positionX = @oldPosX AND positionY = @oldPosY AND positionZ = @oldPosZ LIMIT 1', {
            ['@oldPosX'] = oldPosition.x,
            ['@oldPosY'] = oldPosition.y,
            ['@oldPosZ'] = oldPosition.z,
        })
end

ESX.RegisterServerCallback('myRadarcontrol:getRadarProfits', function(source, cb)

	MySQL.Async.fetchAll('SELECT * FROM speedcams_profit', {},
    function(result)
        cb(result)
    end
    )

end)

ESX.RegisterServerCallback('myRadarcontrol:getMobileRadars', function(source, cb)

	MySQL.Async.fetchAll('SELECT * FROM speedcams', {},
    function(result)
        cb(result)
    end
    )

end)

ESX.RegisterServerCallback('myRadarcontrol:getJob', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        cb(xPlayer.job.name, xPlayer.job.grade_name)
    end
end)