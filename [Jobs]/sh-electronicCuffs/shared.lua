if not IsDuplicityVersion() then --client
    if framework == 'qb' then
        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            TriggerServerEvent('sh-electronicCuffs:server:joined')
        end)
        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            TriggerServerEvent('sh-electronicCuffs:server:unloaded')
        end)
    elseif framework == 'esx' then
        RegisterNetEvent('esx:playerLoaded', function()
            TriggerServerEvent('sh-electronicCuffs:server:joined')
        end)
    end

    isPolice = function()
        if framework == 'esx' then
            local pData = ESX.GetPlayerData();
            if pData == {} then return end
            if pData.job.name == 'police' or pData.job.name == 'fib' or pData.job.name == 'lssd'  then return true else return false end
        elseif framework == 'qb' then
            local pData = QBCore.Functions.GetPlayerData();
            if not pData then return end
            if pData.job.name == 'police' or pData.job.name == 'fib'   then return true else return false end
        end
    end
else --server
    CreateThread(function()
        if framework == 'esx' then
            AddEventHandler('esx:playerLoaded', function(src, xPlayer)
                sh.sql.async.scalar('SELECT data FROM sh_electroniccuffs WHERE citizenId = @citizenId', { ['@citizenId'] = getCitizenID(src) }, function(result)
                    if result then
                        local data = json.decode(result)
                        xPlayer.set('electronic-cuffs', data)
                    end
                end)
            end)
        end
    end)

    getCitizenID = function(src)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            return xPlayer.getIdentifier()
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            return Player.PlayerData.citizenid
        end
    end

    getPlayerRPName = function(src)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            local firstName = xPlayer.get('firstName')
            local lastName = xPlayer.get('lastName')
            return firstName .. lastName
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    end

    removeItem = function(src, name, count)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            xPlayer.removeInventoryItem(name, count)
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            Player.Functions.RemoveItem(name, count)
        end
    end

    registerUsableItem = function(name, cb)
        if framework == 'esx' then
            CreateThread(function()
                while not ESX do
                    Wait(0)
                end

                ESX.RegisterUsableItem(name, cb)
            end)
        elseif framework == 'qb' then
            CreateThread(function()
                while not QBCore do
                    Wait(0)
                end

                QBCore.Functions.CreateUseableItem(name, cb)
            end)
        end
    end

    setCuffData = function(src, data)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            xPlayer.set('electronic-cuffs', data)
            sh.sql.async.scalar('SELECT data FROM sh_electroniccuffs WHERE citizenId = @citizenId', { ['@citizenId'] = getCitizenID(src) }, function(result)
                if result then
                    sh.sql.sync.update('UPDATE sh_electroniccuffs SET data = @data WHERE citizenId = @citizenId', { ['@data'] = json.encode(data), ['@citizenId'] = getCitizenID(src) })
                else
                    sh.sql.sync.insert('INSERT INTO sh_electroniccuffs (citizenId, data) VALUES (@citizenId, @data)', { ['@citizenId'] = getCitizenID(src), ['@data'] = json.encode(data) })
                end
            end)
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            Player.Functions.SetMetaData('electronic-cuffs', data)
        end
    end

    getCuffData = function(src)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            local data = xPlayer.get('electronic-cuffs')
            if not data then
                return false
            else
                data.src = src
                return data
            end
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            local data = Player.PlayerData.metadata['electronic-cuffs']
            if not data then
                return false
            else
                data.src = src
                return data
            end
        end
    end

    isCuffed = function(src)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            local data = xPlayer.get('electronic-cuffs')
            if not data then
                return false
            else
                return true
            end
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            local data = Player.PlayerData.metadata['electronic-cuffs']
            if not data then
                return false
            else
                return true
            end
        end
    end

    isPolice = function(src)
        if framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(src);
            if not xPlayer then return end
            if xPlayer.job.name == 'police' or xPlayer.job.name == 'fib' or xPlayer.job.name == 'lssd'  then return true else return false end
        elseif framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src);
            if not Player then return end
            if Player.PlayerData.job.name == 'police'  then return true else return false end
        end
    end

    -- -- If you are using esx and you see firstname or lastname error,
    -- -- add '@mysql-async/lib/MySQL.lua' or '@oxmysql/lib/MySQL.lua'
    -- -- depending on the sql script you are using above the server scripts section in fxmanifest and uncomment the following lines

    -- RegisterNetEvent('esx:playerLoaded')
    -- AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    --     local src = playerId
    --     local xPlayer = ESX.GetPlayerFromId(src);
    --     if not xPlayer then return end
    --     sh.sql.async.query('SELECT * FROM `users` WHERE `identifier` = @identifier', {
    --         ['@identifier'] = xPlayer.identifier
    --     }, function(result)
    --         if result and result[1] then
    --             xPlayer.setName(('%s %s'):format(result[1].firstname or 'unconfigured', result[1].lastname or 'unconfigured'))
    --             xPlayer.set('firstName', result[1].firstname or 'unconfigured')
    --             xPlayer.set('lastName', result[1].lastname or 'unconfigured')
    --             xPlayer.set('dateofbirth', result[1].dateofbirth or 'unconfigured')
    --             xPlayer.set('sex', result[1].sex or 'unconfigured')
    --             xPlayer.set('height', result[1].height or 'unconfigured')
    --         end
    --     end)
    -- end)
end
