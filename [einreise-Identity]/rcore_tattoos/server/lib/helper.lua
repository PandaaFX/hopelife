function findPriceByName(name)
    for _, data in pairs(getTattooList()) do
        if data.name == name then
            return data.price
        end
    end
end

function findPriceByIdentifier(name)
    for _, data in pairs(getTattooList()) do
        if data.identifier == name then
            return data.price
        end
    end
end

--- Used to detect if player has enough money to afford `targetMoney` price with any account defined in Config.MoneyAccountTypes
--- @param player Player object to check money from
--- @param targetMoney price to compare player money with
--- @return type of account player can afford money with or nil if player does not have enough money
function whichAccountCanAfford(player, targetMoney)
    local accountTypes = Config.MoneyAccountTypes or {}

    for _, type in pairs(accountTypes) do
        local playerAccount = player.getAccount(type) or nil
        local playerMoney
        
        dbg.info('Checking if player has enough money in account "%s"', type)
        if playerAccount and playerAccount.money ~= nil and playerAccount.money >= 0 then
            playerMoney = playerAccount.money
            
            if playerMoney >= targetMoney then
                dbg.success('Player has enough money in account "%s"', type)
                return type
            end
        else
            dbg.error('Money account "%s" does not exist, please check Config.MoneyAccountTypes for non existing accounts', type)
        end

    end

    dbg.debug("Checked all accounts, player hasn't got enough money, returning :(")
end