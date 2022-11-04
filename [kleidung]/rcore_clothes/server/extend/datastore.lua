if type(Framework) == "table" then
    if Framework.ESX then
        Framework = "1"
    elseif Framework.QBCore then
        Framework = "2"
    end
end

if Framework == "1" then
    local ESX_
    TriggerEvent(Config.ESX or 'esx:getSharedObject', function(obj) ESX_ = obj end)

    function GetPlayerId(source)
        local xPlayer = ESX_.GetPlayerFromId(source)
        return xPlayer.identifier
    end

    function GetDataStore(source, dataStoreName, cb)
        local xPlayer = ESX_.GetPlayerFromId(source)
        TriggerEvent(Config.ESXCallbacks['esx_datastore:getDataStore'] or "esx_datastore:getDataStore", dataStoreName, xPlayer.identifier, cb)
    end
end

if Framework == "2" then
    local QBCore_ = Config.GetQBCoreObject()

    function GetPlayerId(source)
		local Player = QBCore_.Functions.GetPlayer(source)
        return Player.PlayerData.citizenid
    end
end
