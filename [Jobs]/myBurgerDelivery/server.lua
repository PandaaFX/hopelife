local joblevel = {}
local prevJoblevel = {}
local highestID = 0

ESX = nil

if Config.useESX then

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    RegisterServerEvent('hl_burgerjob:hl_payment:playerpayout_hl')
    AddEventHandler('hl_burgerjob:hl_payment:playerpayout_hl', function(value)

    local xPlayer        = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(value)
    TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['earned_money'] .. value .. Translation[Config.Locale]['earned_money2'])

    end)
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM user_jobs WHERE job = @job',
    {
        ['@job'] = Config.JobName
    },
    function (result)
        for i = 1, #result, 1 do
            joblevel[result[i].identifier] = result[i].joblevel
            prevJoblevel[result[i].identifier] = result[i].joblevel
        end
    end)
end)

AddEventHandler('playerDropped', function(reason)
    local _src = source
    local identifier = GetPlayerIdentifiers(_src)[1]
    if Config.useNewESX then
        for k, v in ipairs(GetPlayerIdentifiers(_src)) do
          if string.match(v, "license:") then
             identifier = string.gsub(v, "license:", "")
             break
          end
       end
    end

    if joblevel[identifier] ~= nil and prevJoblevel[identifier] ~= joblevel[identifier] then

        MySQL.Async.execute('UPDATE user_jobs SET joblevel = @joblevel WHERE identifier = @identifier AND job = @job',
        {
            ['@joblevel']   = joblevel[identifier],
            ['@identifier'] = identifier,
            ['@job']        = Config.JobName,
        })
        
        print(Config.JobName .. ': Joblevel of ' .. GetPlayerName(_src) .. ' was increased from ' .. prevJoblevel[identifier] .. ' to ' .. joblevel[identifier])
        prevJoblevel[identifier] = joblevel[identifier]
    end

end)

RegisterServerEvent('burgerjob:getLevel')
AddEventHandler('burgerjob:getLevel', function()
    local steamID = GetPlayerIdentifiers(source)[1]
	if Config.useNewESX then
        for k, v in ipairs(GetPlayerIdentifiers(source)) do
          if string.match(v, "license:") then
             steamID = string.gsub(v, "license:", "")
             break
          end
       end
    end


    if steamID ~= nil then 
        if joblevel[steamID] ~= nil then
            TriggerClientEvent('burgerjob:getLevel', source, joblevel[steamID])
        else
            joblevel[steamID] = 0

            TriggerClientEvent('burgerjob:getLevel', source, joblevel[steamID])

            MySQL.Async.execute('INSERT INTO user_jobs (identifier, job, joblevel) VALUES (@identifier, @job, @joblevel)',
            {
                ['@identifier'] = steamID,
                ['@job']		= Config.JobName,
                ['@joblevel']	= 0,
            })
            prevJoblevel[steamID] = 0
        end
    end
end)

RegisterServerEvent('burgerjob:increase')
AddEventHandler('burgerjob:increase', function()
    local steamID = GetPlayerIdentifiers(source)[1]
    if Config.useNewESX then
        for k, v in ipairs(GetPlayerIdentifiers(source)) do
          if string.match(v, "license:") then
             steamID = string.gsub(v, "license:", "")
             break
          end
       end
    end


    if steamID ~= nil then
        if joblevel[steamID] ~= nil then
            joblevel[steamID] = joblevel[steamID] + 1
        end
    end
end)
