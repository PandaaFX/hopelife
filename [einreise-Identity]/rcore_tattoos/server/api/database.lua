local playerCache = {}

function loadPlayerFromCache(playerId, identifier, cleanCache)
    if playerId then
        dbg.info('Getting player %s from cache', playerId)
        if not identifier then
            identifier = getPlayerIdentifier(playerId)
            if not identifier then return end
        end

        if cleanCache then
            playerCache[identifier] = nil
        end

        if playerCache[identifier] == nil then
            loadPlayerData(playerId, identifier)
        else 
            setPlayerData(playerId, playerCache[identifier])
            TriggerClientEvent(triggerName('receivePlayerData'), playerId, playerCache[identifier].tattoos)
        end
    end
end

function getPlayerFromCache(playerId, identifier)
    if playerId then
        if not identifier then
            identifier = getPlayerIdentifier(playerId)
            if not identifier then return end
        end
        
        if playerCache[identifier] == nil then
            loadPlayerFromCache(playerId, identifier)
        end
        
        return playerCache[identifier]
    end
end

function loadPlayerData(playerId, identifier)
    if playerId then
        dbg.info('Loading data of player with id %s', playerId)

        if not identifier then
            identifier = getPlayerIdentifier(playerId)
            if not identifier then return end
        end

        MySQL.Async.fetchAll('SELECT * FROM rcore_tattoos WHERE identifier = @id', {
            ['@id'] = identifier,
        }, function(result)
            if result == nil then
                dbg.critical('=== Import database file! ===')
                dbg.critical('=== Import database file! ===')
                dbg.critical('=== Import database file! ===')
                return
            end

            local tattoos = {}
            if result[1] ~= nil then
                tattoos = json.decode(result[1].tattoos)
            end

            for id, tatData in pairs(tattoos) do
                if tatData.identifier == nil then
                    dbg.info('Player %s has old format of tattoo - trying to migrate', identifier)
                    local tatDataLoaded = foundTattooByName(tatData.name)
                    if tatDataLoaded then
                        local tatIdent = tatDataLoaded.hashMale..'-'..tatDataLoaded.hashFemale
                        tatData.identifier = tatIdent

                        tattoos[tatIdent] = tatData
                        tattoos[id] = nil
                    else
                        dbg.info('Tattoo data cannot be found, removing tattoo from player data')
                        tattoos[id] = nil
                    end
                end
            end

            local playerData = {
                identifier = identifier,
                tattoos = tattoos
            }

            playerCache[identifier] = playerData
            setPlayerData(playerId, playerData)

            TriggerClientEvent(triggerName('receivePlayerData'), playerId, tattoos)
        end)
    else
        dbg.error('Failed loading tattoos from db for player id: ' .. playerId)
    end
end

function savePlayerTattoos(id)
    local playerData = getPlayerData(id)

    if playerData == nil then
        dbg.critical("Could not find player %s in cached local storage", id)
        return
    end

    local identifier = getPlayerIdentifier(id)
    if identifier == nil then
        dbg.critical('Cannot found identifier for player %s', id)
        return
    end

    return MySQL.Sync.execute('REPLACE INTO rcore_tattoos (tattoos, identifier) VALUES (@tattoos, @id)', {
        ['tattoos'] = json.encode(playerData.tattoos),
        ['id'] = playerData.identifier,
    })
end

