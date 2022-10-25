local function getPlayerIdentifierRaw(_source)
    for _, identifier in pairs(GetPlayerIdentifiers(_source)) do
        if string.find(identifier, Config.LicenseType) then
            if Config.LicenseWithoutPrefix then
                return string.gsub(identifier, Config.LicenseType..':', "")
            end
            return identifier
        end
    end

    dbg.critical('Cannot found player identifier!')
    return nil
end

function getPlayerIdentifier(_source)
    if Config.Framework == Frameworks.ESX then
        if ESX then
            local xPlayer = ESX.GetPlayerFromId(_source)
            if xPlayer then
                dbg.info('Used xPlayer %s', xPlayer.identifier)
                return xPlayer.identifier
            end
        end
        return getPlayerIdentifierRaw(_source)
    elseif Config.Framework == Frameworks.QBCORE then
        if QBCore then
            --Using server/lib/frameworkBridge.lua
            local qbCore = QBCore.Functions.GetPlayer(_source)
            if qbCore then
                dbg.info('Used citizen %s', qbCore.PlayerData.citizenid)
                return qbCore.PlayerData.citizenid
            end
        end
    end

    return getPlayerIdentifierRaw(_source)
end
