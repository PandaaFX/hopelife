GetQBCoreObject = function()
    local objectType = 1
    --------------------------    
    if objectType == 1 then
        return exports['qb-core']:GetCoreObject()
    end
    --------------------------
    if objectType == 2 then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent(Config.Events["QBCore:GetObject"], function(obj) QBCore = obj end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
    --------------------------    
    if objectType == 3 then
        return exports['qb-core']:GetSharedObject()
    end
    --------------------------    
end

CreateThread(function()
    if Config.Framework == Frameworks.ESX then
        ESX = nil
        TriggerEvent(Config.Events['esx:getSharedObject'], function(obj)
            ESX = obj
        end)
    elseif Config.Framework == Frameworks.QBCORE then
        QBCore = GetQBCoreObject()
        ESX = {}

        ESX.GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayer(source)
            xPlayer.identifier = qbPlayer.PlayerData.citizenid
            ---------
            xPlayer.job = {
                name = qbPlayer.PlayerData.job.name,
                label = qbPlayer.PlayerData.job.label,
                grade = {
                    name = qbPlayer.PlayerData.job.grade.name or "none",
                    level = qbPlayer.PlayerData.job.grade.level or -1,
                },
            }
            ---------
            xPlayer.getMoney = function()
                return qbPlayer.Functions.GetMoney("cash")
            end
            ---------
            xPlayer.getAccount = function(type)
                return {
                    money = qbPlayer.Functions.GetMoney(type)
                }
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money)
                qbPlayer.Functions.RemoveMoney(type, money)
            end
            ---------
            xPlayer.removeMoney = function(money)
                qbPlayer.Functions.RemoveMoney("cash", money)
            end

            return xPlayer
        end

        -- CUSTOM FRAMEWORK
        --
        -- Uncomment and edit the elseif below to use your own framework. Don't forget to add your framework to Frameworks array!
        -- https://documentation.rcore.cz/paid-resources/rcore_tattoos/framework

        -- elseif Config.Framework == Frameworks.YOUR_FRAMEWORK_NAME then
        --     -- copy content of QBCORE part and rewrite to your framework
        -- end

    else -- Default - if Config.Framework doesn't match with any frameworks above
        print('Framework-bridge: Wrong option in frameworks! Using framework fallback functions!')

        QBCore = {}
        ESX = {}

        ESX.GetPlayerFromId = function(source)
            local xPlayer = {}
            ---------
            xPlayer.job = {
                name = 'unemployed',
                label = 'unemployed',
                grade = {
                    name = 'none',
                    level = 0,
                },
            }
            ---------
            xPlayer.getMoney = function()
                print('Framework-bridge: Wrong option in frameworks! Returning that player can afford the tattoo.')
                return 1000000000
            end
            ---------
            xPlayer.removeMoney = function(money)
                print('Framework-bridge: Wrong option in frameworks! No money was removed from the player!')
            end

            return xPlayer
        end
    end
end)
