---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz
local serverCallbacks = {}
local callbacksRequestsHistory = {}
local dbg = rdebug()

function registerCallback(cbName, callback)
    dbg.debug(string.format('register callback %s', cbName))
    serverCallbacks[cbName] = callback
end

RegisterNetEvent(triggerName('callCallback'))
AddEventHandler(triggerName('callCallback'), function(name, requestId, ...)
    local _source = source
    if Config.Debug then
        dbg.debug(string.format('trying to call %s callback', name))
    end

    if serverCallbacks[name] == nil then
        dbg.critical(string.format('trying to call %s callback but its doesnt exists!', name))
        return
    end

    callbacksRequestsHistory[requestId] = {
        name = name,
        source = _source,
    }

    local call = serverCallbacks[name]
    call(_source, function(...)
        TriggerClientEvent(triggerName('callback'), _source, requestId, ...)
    end, ...)
end)
