ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('lappen', function(source)
    local src = source
    TriggerClientEvent('murtaza:clean', src)
end)