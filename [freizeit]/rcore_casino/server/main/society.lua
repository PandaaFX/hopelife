function RemoveMoneyFromSociety(money, society)
    if Framework.Active == 2 then
        local moneyNow = GetMoneyFromSociety(society)
        if (moneyNow - money) < 0 then
            money = moneyNow
        end
        xpcall(function()
            local societyMoney = exports["qb-bossmenu"]:GetAccount(society)
            -- if societyMoney >= money then
            TriggerEvent("qb-bossmenu:server:removeAccountMoney", society, money)
            -- end
        end, function(error)
            local societyMoney = exports["qb-management"]:GetAccount(society)
            -- if societyMoney >= money then
            exports["qb-management"]:RemoveMoney(society, money)
            -- end
        end)
    end

    if Framework.Active == 1 then
        TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
            if account then
                -- if account.money >= money then
                account.removeMoney(money)
                -- end
            else
                print(
                    string.format("^1[%s][ERROR]^7 Society ^1'%s'^7 do not exists!", GetCurrentResourceName(), society))
            end
        end)
    end
end

function GiveMoneyToSociety(money, society)
    if Framework.Active == 2 then
        xpcall(function()
            exports["qb-management"]:AddMoney(society, money)
        end, function(error)
            TriggerEvent("qb-bossmenu:server:addAccountMoney", society, money)
        end)
    end

    if Framework.Active == 1 then
        TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
            if account then
                account.addMoney(money)
            else
                print(
                    string.format("^1[%s][ERROR]^7 Society ^1'%s'^7 do not exists!", GetCurrentResourceName(), society))
            end
        end)
    end
end
function GetMoneyFromSociety(society)
    local result = nil
    local promise = promise:new()

    if Framework.Active == 2 then
        xpcall(function()
            local societyMoney = exports["qb-bossmenu"]:GetAccount(society)
            result = societyMoney
            promise:resolve(result)
        end, function(error)
            local societyMoney = exports["qb-management"]:GetAccount(society)
            result = societyMoney
            promise:resolve(result)
        end)
    end

    if Framework.Active == 1 then
        TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
            if account then
                result = account.money
                promise:resolve(result)
            else
                print(
                    string.format("^1[%s][ERROR]^7 Society ^1'%s'^7 do not exists!", GetCurrentResourceName(), society))
                result = 0
                promise:resolve(result)
            end
        end)
    end

    Citizen.Await(promise)
    return result
end
