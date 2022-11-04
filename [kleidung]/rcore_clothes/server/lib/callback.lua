---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz
local serverCallbacks = {}
local callbacksRequestsHistory = {}

function registerCallback(cbName, callback)
    serverCallbacks[cbName] = callback
end

RegisterNetEvent(triggerName('callCallback'))
AddEventHandler(triggerName('callCallback'), function(name, requestId, source, ...)
    if serverCallbacks[name] == nil then
        print(string.format('[rcore] trying to call %s callback but its doesnt exists!', name))
        return
    end
    callbacksRequestsHistory[requestId] = {
        name = name,
        source = source,
    }
    local call = serverCallbacks[name]
    call(source, function(...)
        TriggerClientEvent(triggerName('callback'), source, requestId, ...)
    end, ...)
end)
