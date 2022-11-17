function callCallbackSafely(cb, ...)
    if cb then
        local ok, err = pcall(cb, ...)
        if not ok then
          dbg.critical('Error in callback: %s', err)
        end
    else
        dbg.critical('Missing callback function!')
    end
end

AddEventHandler(triggerName('addPlayerTattoo'), function (playerId, tattooName, tattooIdentifier, expiration, opacity, cb)
    addPlayerTattoo(playerId, tattooName, tattooIdentifier, expiration, opacity)
    TriggerClientEvent(triggerName('receivePlayerData'), playerId, getPlayerData(playerId).tattoos)

    if savePlayerTattoos(playerId) then
        dbg.info('API EVENT: Added tattoo %s for player %s', tattooName, GetPlayerName(playerId))
        callCallbackSafely(cb, true)
    else
        dbg.critical('API EVENT: Failed to update player %s database with tattoo data!', GetPlayerName(playerId))
        callCallbackSafely(cb, false)
    end
end)

AddEventHandler(triggerName('removePlayerTattoo'), function (playerId, tattooIdentifier, cb)
    removePlayerTattoo(playerId, tattooIdentifier)
    TriggerClientEvent(triggerName('receivePlayerData'), playerId, getPlayerData(playerId).tattoos)

    if savePlayerTattoos(playerId) then
        dbg.info('API EVENT: Removed tattoo %s for player %s', tattooIdentifier, GetPlayerName(playerId))
        callCallbackSafely(cb, true)
    else
        dbg.critical('API EVENT: Failed to remove player %s tattoo!', GetPlayerName(playerId))
        callCallbackSafely(cb, false)
    end
end)

AddEventHandler(triggerName('buyTattoo'), function (playerId, tattooName, tattooIdentifier, hennaDuration, opacity, cb)
    local hennaInSeconds = false
    if hennaDuration then
        if type(hennaDuration) ~= 'boolean' then
            hennaInSeconds = hennaDuration * 86400
        end

        henna = hennaInSeconds and hennaInSeconds or Config.HennaTattooDuration
    end

    callCallbackSafely(cb, buyTattoo(playerId, false, tattooName, tattooIdentifier, henna or false, opacity))
end)

AddEventHandler(triggerName('getPlayerTattoos'), function (playerId, cb)
    callCallbackSafely(cb, getPlayerData(playerId).tattoos)
end)

AddEventHandler(triggerName('getTattooPriceByName'), function (tattooName, cb)
    callCallbackSafely(cb, findPriceByName(tattooName))
end)

AddEventHandler(triggerName('getTattooPriceByIdentifier'), function (tattooIdentifier, cb)
    callCallbackSafely(cb, findPriceByIdentifier(tattooIdentifier))
end)

RegisterNetEvent(triggerName('openTattooMenuForPlayer'))
AddEventHandler(triggerName('openTattooMenuForPlayer'), function (playerId, onlyPreview, partName, cb)
    local _source = source
    if playerId == nil and _source ~= nil and string.len(_source) >= 1 then
        playerId = _source
        dbg.info('openTattooMenuForPlayer: call from client, setting source id %s as playerId', _source)
    end

    if playerId and GetPlayerName(playerId) then
        TriggerClientEvent(triggerName('handleOpenMenu'), playerId, nil, onlyPreview, partName)
        dbg.info('Tattoo shop opened for player with id %s.', playerId)
        if cb then
            callCallbackSafely(cb, true)
        end
    else
        if playerId then
            dbg.critical('API EVENT: Player with id %s is not online!', playerId)
        else
            dbg.critical('API EVENT: Parameter playerId is missing!')
        end

        if cb then
            callCallbackSafely(cb, false)
        end
    end
end)